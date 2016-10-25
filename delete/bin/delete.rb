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
        db.execute( "INSERT INTO People (Name, Greeting) VALUES('#{name}', '#{greeting}')")
    puts "Your data has been entered into the database!"

    rescue SQLite3::Exception => e 
    
    puts "Exception occurred"
    puts e
    
	ensure
	    db.close if db
	end
end

get '/:id/delete/' do 
    @note = params[:id]
    @title = "Confirm deletion of note '#{@note}'"
    erb :delete
end 

post '/:id/delete/' do
    greeting = params[:greeting] || "Hi There"
    name = params[:name] || "Nobody"
    erb :index, :locals => {'greeting' => greeting, 'name' => name}

    begin
        db = SQLite3::Database.open "users.db"
        db.execute "CREATE TABLE IF NOT EXISTS People(Id INTEGER PRIMARY KEY, 
        Name TEXT, Greeting TEXT)"

    rescue SQLite3::Exception => e 
    
    puts "Exception occurred"
    puts e
    
    ensure
        db.close if db
    end
end

## delete route
delete '/:id/' do
 n = params[:id]
 ### delete code, database execute, etc.
 db = SQLite3::Database.open "users.db"
 db.execute "DELETE FROM People WHERE Id = '#{n}'"
    puts "Your data has been deleted from the database!"
end