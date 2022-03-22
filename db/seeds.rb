# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Powder.create(name: '巴豆', pin_yin: 'ba dou', price_bulk: 3.1, price_retail: 5.5, qty_init: 10, qty_inport: 0, qty_export: 0, location:'12a', comment: nil)
Powder.create(name: '天麻', pin_yin: 'tian ma', price_retail: 3.3, price_bulk: 2.2, location: '12a', qty_init: 10, qty_inport:0, qty_export: 0,)
Powder.create(name: '人参', pin_yin: 'ren shen', price_retail: 5.3, price_bulk: 3.3, location: '12b', qty_init: 10, qty_inport:0, qty_export: 0,)
Powder.create(name: '黄柏', pin_yin: 'huang bo(chuan)', price_retail: 4, price_bulk: 1.2, location: '12f',qty_init: 10, qty_inport:0, qty_export: 0,)
