# Downloads a file. In the future it will retry if download fails with exponential backoff up to some max tries.

require "net/http"
require "uri"

class Downloader

    def initialize(max_attempts: 0, backoff: 0)
        @max_attempts = max_attempts
        @backoff = backoff
    end

    def download(file_uri)
        uri = URI.parse(file_uri)
        @http = Net::HTTP.new(uri.host, uri.port)
        @http.use_ssl = true
        @request = Net::HTTP::Get.new(uri.request_uri)
        print "Downloading #{file_uri}... "
        attempt(0)
    end

    private

    def attempt(attempt)
        if attempt > 0 then sleep(2 ** attempt * @backoff) end
        if attempt > @max_attempts then raise Exception.new("download failed after max attempts: #{@max_attempts}") end
        begin
            response = @http.request(@request)
            if response.code == "200"
                print "done\n"
                return response.body
            else
                raise StandardError.new(response.code)
            end
        rescue Errno::ETIMEDOUT => e
            puts "Connection timed out... retrying with backoff #{2 ** attempt * @backoff}s"
            attempt += 1
            attempt(attempt)
            retry
        rescue StandardError => e
            puts "Connection returned #{e.message}... retrying with backoff #{2 ** attempt * @backoff}s"
            attempt += 1
            attempt(attempt)
            retry
        end
    end
end