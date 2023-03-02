# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
require "open-uri"

# Create seller user
seller = User.create!(
  email: 'seller@example.com',
  password: 'password',
  full_name: 'John Doe',
  address: '123 Main St',
  seller: true
)

# Create buyer user
buyer = User.create!(
  email: 'buyer@example.com',
  password: 'password',
  full_name: 'Jane Smith',
  address: '456 Oak Ave',
  seller: false
)

# Create products for seller
product1 = seller.products.create!(
  name: 'Yeezy Saltcore',
  description: 'Perfectas condiciones',
  price: 100.0,
  stock: 10,
  brand: 'Adidas',
  size: '10',
  color: 'Azul'
)

file = URI.open('https://res.cloudinary.com/dcfoaujd5/image/upload/v1677697991/development/adidas-yeezy-boost-350-v2-salt-hq2060-store-list-1_sgjujb.jpg')
product1.photo.attach(io: file, filename: "p1.png", content_type: "image/jpg")
#Cambiar atrribute photo for heroku!!!! Danger

product2 = seller.products.create!(
  name: 'Yeezy Bred',
  description: 'Estado DS',
  price: 20.0,
  stock: 50,
  brand: 'Adidas',
  size: '11',
  color: 'Negro'
)
file = URI.open('https://res.cloudinary.com/dcfoaujd5/image/upload/v1677697983/development/94407_01.jpg_wqotlw.jpg')
product2.photo.attach(io: file, filename: "p2.png", content_type: "image/jpg")

product3 = seller.products.create!(
  name: 'Jordans',
  description: 'Como nuevas!',
  price: 10.0,
  stock: 50,
  brand: 'Nike',
  size: '9',
  color: 'Rojo'
)
file = URI.open('https://res.cloudinary.com/dcfoaujd5/image/upload/v1677697973/development/DQ8426_060_P2_dcuqei.jpg')
product3.photo.attach(io: file, filename: "p3.png", content_type: "image/jpg")
