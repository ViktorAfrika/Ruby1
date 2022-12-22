# імпорт вбудованих бібліотек 
require 'open-uri'
require 'byebug'
require 'nokogiri'
require 'csv'
require 'json'
# імпорт написаного класу 
require_relative "main_application.rb"


class Cart
    @@items = []

    # методи класу
    # додати об'єкт item в масив 
    def self.add_item(item)
        @@items.push(item)
    end

    # отримати всі items
    def self.get_items()
        @@items
    end

    # передається об'єкт application з якого беруться шляхи до файлів
    # зберегти в csv 
    def self.save_to_csv(application)
        path_csv = application.path_csv
        items = Cart.get_items()
        begin  
            File.new(path_csv, "w")

            CSV.open(path_csv, "w", headers: ['price', 'title', 'availability', 'product_code', 'images', 'link'], write_headers: true) do |csv|
                items.each do |product|
                    csv << [product.price, product.title, product.availability, product.product_code, product.images, product.link]
                end
            end

            puts "writing in the csv file"
        rescue StandardError => e
            puts "Ooops.. Some error with writing to csv file"
            puts e.message

        end
    end

    # зберегти в json
    def self.save_to_json(application)
        path_json = application.path_json
        items = Cart.get_items()

        begin 
            File.new(path_json, "w")

            File.open(path_json, "w") do |json|
                items.each do |product|
                    temp_hash = {
                        "price" => product.price,
                        "title" => product.title,
                        "availability" => product.availability,
                        "product_code" => product.product_code, 
                        "images" => product.images, 
                        "link" => product.link
                    }
                    json.write(JSON.pretty_generate(temp_hash))
                end
            end
            puts "writing in the json file"
        
        rescue StandardError => e
            puts "Ooops.. Some error with writing to json file"
            puts e.message
        end
    end
end