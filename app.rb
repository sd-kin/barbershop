require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'







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

post '/visit' do
@name=params[:name]
@phone=params[:phone]
@date=params[:date]

parameters = {name: 'input name', phone: 'input phone', date: 'input date'}
parameters.each do |key, value|
if params[key] =='' then @error=parameters[key] end
end 

file=File.open"public/list.txt", "a"
file<<"#{@name} wont to visit you at #{@date}, phon  number - #{@phone}\n"
file.close
erb :visit
end