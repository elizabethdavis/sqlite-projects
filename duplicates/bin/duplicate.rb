require 'sinatra'
require 'sqlite3'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

get '/' do
    return 'Hello world'
end

get '/hello/' do 
    erb :hello_form
end

post '/hello/' do
    greeting = params[:greeting] || "Hi There"
    name = params[:name] || "Nobody"
    erb :index, :locals => {'greeting' => greeting, 'name' => name}
end

get '/hello-database/' do 
    erb :hello_form
end 

post '/hello-database/' do
    greeting = params[:greeting] || "Hi There"
    name = params[:name] || "Nobody"
    erb :index, :locals => {'greeting' => greeting, 'name' => name}

    begin
    	db = SQLite3::Database.open "users.db"
    	db.execute "CREATE TABLE IF NOT EXISTS People(Id INTEGER PRIMARY KEY, 
        Name TEXT, Greeting TEXT)"

        val = db.get_first_value "SELECT name from People where Name = '#{name}'"

        if (val)
            puts "Name already exists in the database!"

        else
            db.execute( "INSERT INTO People (Name, Greeting) VALUES('#{name}', '#{greeting}')")
            puts "Your data has been entered into the database!"
        end

    rescue SQLite3::Exception => e 
    
    puts "Exception occurred"
    puts e
    
	ensure
	    db.close if db
	end
end

