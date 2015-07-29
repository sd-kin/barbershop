require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'
require 'sqlite3'

configure do
db=get_db
db.execute 'CREATE TABLE IF NOT EXISTS "users"
				("id" INTEGER PRIMARY KEY AUTOINCREMENT,
				"username" TEXT,
				"phone" TEXT,
				"datestamp" TEXT,
				"barber" TEXT,
				"color" TEXT
				)'
end

get '/login' do
  erb :login
 
end

post '/login' do


redirrect '/'

end

get '/showusers' do
  db=get_db
  @all_rows=[]
  db.execute'SELECT * FROM users' do |row|
  @all_rows<<row || 'fuckin nothing'
  end
  
  erb :showusers
 
end


get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
erb :about
end

get '/visit' do
erb :visit
end

get '/contacts' do
erb :contacts
end

post '/contacts' do
@email=params[:email]
@message=params[:message]
errors={email: 'email', message: 'message'}
@error= errors.select{|k,v| params[k]==''}.values.join(", ") + ' is empty'
@error='' if @error==' is empty'
 unless @error=='' then return erb :contacts end

 Pony.mail({
  :to => 'sd-kin@rambler.ru',
  :via => :smtp,
  :from => @email,
  :body => @message,
  :via_options => {
    :address              => 'smtp.gmail.com',
    :port                 => '587',
    :enable_starttls_auto => true,
    :user_name            => 'nahuiblia',
    :password             => 'teamPASS77',
    :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
    :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
  } 
})
 erb "Message #{@message} sent by #{@email}"
end

post '/visit' do
@name=params[:name]
@phone=params[:phone]
@date=params[:date]
@barber=params[:barber]
@color=params[:color]



parameters = {name: 'input name', phone: 'input phone', date: 'input date'}
@error= parameters.select{|k,v| params[k]==''}.values.join(", ") 
 unless @error=='' then return erb :visit end
@values = []
@values<<@name<<@phone<<@date<<@barber<<@color
 db = get_db 
 db.execute 'insert into users (username, phone, datestamp, barber, color) values(?, ?, ?, ?, ?)',@values
file=File.open"public/list.txt", "a"
file<<"#{@name} wont to visit you at #{@date}, phon  number - #{@phone}. Your barber is #{@barber} and color - #{@color}\n"
file.close
erb "Waiting for you" 
end

def get_db 
return SQLite3::Database.new 'database.db'
end