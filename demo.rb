# імпорт написаних класів
require_relative "parser.rb"
require_relative "main_application.rb"
require_relative "cart.rb"
require_relative "item_container.rb"

# створення об'єкту з налаштуваннями програми вказуючи шлях для файлів csv та json
application = MainApplication.new(path_csv='./products.csv', path_json='./products.json', os='Windows')
# створення об'єкту парсера
parser = Parser.new()
# парсинг однієї сторінки передаючи посилання на товар
# сайт для парсингу - мойо
item1 = parser.parse_item(link="https://www.moyo.ua/ua/noutbuk_acer_aspire_3_a315-34_nx_he3eu_05c_/512435.html")
# вивід товару
puts item1
puts
# додавання товару в масив  
Cart.add_item(item1)
# парсинг іншого товару
item2 = parser.parse_item(link="https://www.moyo.ua/ua/stiralnaya_mashina_beko_wue6511xsw/452462.html")
# вивід
puts item2
# додавання в масив 
Cart.add_item(item2)

# збереження в файли json та csv
Cart.save_to_csv(application)
Cart.save_to_json(application)

# робота з контейнерами, працює не до кінця правильно, не знаходить методи 
"""
cart = Cart.new()
ItemContainer.included(cart)
cart.add_item(item1)
"""


