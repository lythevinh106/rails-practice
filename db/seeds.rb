# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'prettyprint'
Category.destroy_all
categories = []
for i in 0..4
  categories << {
    id: i + 1,
    name: "category #{i}",
    is_active: true,
  }
end
Category.create!([categories])
"Created #{Category.count} category"

# product section

# pp categories[0]
# pp categories[(categories.length - 1)][id].to_s + "-------------"

Product.destroy_all
# products = []
# for i in 0..6
#   products << {
#     title: "product #{i}",
#     description: "product desc #{i}",
#     image: "https://giaysneaker.store/media/catalog/product/cache/47d66d3609f727ab73c995561c27d006/n/i/nike-sb-force-58-prm-l-white-dh7505-101-0.png",
#     price: rand(100..9999),
#     category_id: rand((categories[0][:id])...categories[(categories.length - 1)][:id])
#
#   }
# end
# Product.create!([products])

# Category.destroy_all
# categories = []
# for i in 0..4
#   categories << {
#     id: i + 1,
#     name: "category #{i}",
#     is_active: true,
#   }
# end
# Category.create!([categories])
# "Created #{Category.count} category"

# d0 id: nil, order_date: Fri, 03 May 2024 03:02:23.264982000 UTC +00:00, created_at: nil, updated_at: nil, user_id: nil, status: "pending">

# "Created #{Product.count} products"