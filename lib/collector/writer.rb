# SQLite writing abstraction.

require 'sqlite3'

class Writer
    def initialize path
        @db = SQLite3::Database.new path
        @db.execute_batch <<~SQL
        DROP TABLE IF EXISTS apk;
        CREATE TABLE IF NOT EXISTS apk (
            id           INTEGER PRIMARY KEY,
            apk          REAL,
            art_name     TEXT,
            price        REAL,
            volume       REAL,
            art_type     TEXT,
            art_style    TEXT,
            abv          REAL,
            availability TEXT
        );
        CREATE TABLE IF NOT EXISTS apk_metadata (
            id          INTEGER PRIMARY KEY,
            name        TEXT
        );
        SQL
    end

    def write data
        print "Writing to db... "
        insert = @db.prepare <<~SQL
            INSERT INTO apk (id, apk, art_name, price, volume, art_type, art_style, abv, availability)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);
        SQL
        @db.transaction
        data.each do |r| 
            insert.execute(r[:id], r[:apk], r[:name], r[:price], r[:volume], r[:type], r[:style], r[:abv], r[:availability])
        end
        @db.commit
        puts "done"
        @db
    end
end