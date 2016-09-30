#!/usr/bin/ruby
#Inserts 1000 lines into a database

require 'sqlite3'

begin
    
    db = SQLite3::Database.open "onethousand.db"
    
    db.execute "CREATE TABLE Friends(Id INTEGER PRIMARY KEY, Name TEXT)"
    
    stm = db.prepare "INSERT INTO Friends(Name) VALUES ('Elizabeth')" 

    
    1.upto(1000) do |row|
        row = stm.execute 
    end
           
rescue SQLite3::Exception => e 
    
    puts "Exception occurred"
    puts e
    
ensure
    stm.close if stm
    db.close if db
end