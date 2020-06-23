# Uses the extracted info to create or update the sqlite database. 

require "sqlite3"
require_relative "writer"

class Importer
    def import apk_list
        print "Importing values... "
        series = []
        apk_list.map do |article|
            price = (article.fetch(:prisinklmoms, 0) + article.fetch(:pant, 0)).round(1)
            volume = article.fetch(:volymiml, "")
            abv = article[:alkoholhalt].round(3)
            series << {
                id:            article[:artikelid],
                name:          article.fetch(:namn, "") + " " + article.fetch(:namn2, ""),
                price:         price,
                volume:        volume,
                type:          article.fetch(:varugrupp, ""),
                style:         article.fetch(:stil, ""),
                abv:           abv,
                availability:  article[:sortiment],
                apk: ((abv*volume)/price).round(3),
            }
        end
        puts "done"
        series
    end
end