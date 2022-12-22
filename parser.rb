# імпорт бібліотек 
require 'nokogiri'
require 'faraday'
# імпорт нашого класу 
require_relative "item.rb"

# клас для парсингу 
class Parser
    attr_accessor :headers
    # заголовки http запиту
    headers = {"user-agent": "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Mobile Safari/537.36"}
    # метод для парсингу однієї сторінки по посиланню
    def parse_item(link=nil)
        # якщо посилання порожнє то повертаємо nil
        if link == nil
            return nil
        end
        # відправка get запиту
        response = Faraday.get(link, @headers)
        # якщо код відповіді не 200(тобто ок) повертаємо nil
        if (response.status != 200)
            puts "resp in not 200"
            return nil
        end
        # парсимо документ
        doc = Nokogiri::HTML(response.body)
        # використовуємо пошук по xpath, мову запитів до xml елементів сторінки
        # заголовк
        title = doc.xpath("//h1[@class=\"product_name\"]").text
        # ціна
        price = doc.xpath("//meta[@itemprop=\"price\"]").attribute("content").text
        # наявність
        availability = doc.xpath("//div[@class=\"product_availability_status instock-status\"]").text
        # код продукту
        product_code = doc.xpath("//div[@class=\"product_id\"]").text
        # посилання на картинки
        images = doc.xpath("//div[@class=\"product_image-wrap\"]").xpath("//img[@class=\"lazy-interaction\"]")
        image_links = []
        for image in images
            image_links.append(image.attribute("src").to_s())
        end
        # cтворюємо новий item і повертаємо його
        item = Item.new(price, title, availability, product_code, image_links, link)
        return item
    end
end
