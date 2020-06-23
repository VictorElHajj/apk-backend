class Collector
    def initialize(downloader, extractor, importer, writer)
        @downloader = downloader
        @extractor = extractor
        @importer = importer
        @writer = writer
    end

    def run 
        puts ""
        puts Time.now
        file = @downloader.download 'https://www.systembolaget.se/api/assortment/products/xml'
        data = @extractor.extract file 
        imported_data = @importer.import data
        @writer.write(imported_data)
        puts ""
    end
end