# Converts XML string into list of article hashes.

require "nokogiri"

class Extractor
    def extract(file)
        print "Extracting values... "
        apk_xml = Nokogiri::XML(file)
        apk_list = []
        apk_xml.xpath('//artikel').each do |article|
            article_hash = Hash.new()
            article.children.each do |row|
                sym = row.node_name.downcase.to_sym
                article_hash[sym] = CONVERTERS.fetch(sym, PARSE_STRING).(row.content)
            end
            apk_list << article_hash
        end
        print "done\n"
        return apk_list
    end

    private

    PARSE_ABV     = -> (x) {x.delete('%').to_f/100}
    PARSE_FLOAT   = -> (x) {x.to_f}
    PARSE_INTEGER = -> (x) {x.to_i}
    PARSE_STRING  = -> (x) {x}

    CONVERTERS = {
        alkoholhalt: PARSE_ABV,
        artikelid: PARSE_INTEGER,
        prisinklmoms: PARSE_FLOAT,
        pant: PARSE_FLOAT,
        volymiml: PARSE_FLOAT,
    }
end