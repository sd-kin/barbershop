require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'


get '/login' do
  erb :login
 
end

post '/login' do


redirrect '/'

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

file=File.open"public/list.txt", "a"
file<<"#{@name} wont to visit you at #{@date}, phon  number - #{@phone}. Your barber is #{@barber} and color - #{@color}\n"
file.close
erb "Waiting for you" 
end