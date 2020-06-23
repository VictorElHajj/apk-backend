require 'sinatra'

post '/ping' do
    params.keys.map do |p|
        puts "Param: " + p
    end
    puts "200"
end