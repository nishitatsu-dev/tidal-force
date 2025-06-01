# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if Rails.env.development?

  # User.create!(
  #   email: "test@test.com",
  #   password: "testtest"
  # )

  Record.create!(
    [
      { recorded_at: Time.zone.parse("#{Date.today.strftime("%Y-%m-%d")} 06:00 +0900"), column_0: 1.0, column_1: 2.0, column_2: 3.0, column_3: 4.0, column_4: 5.0, column_5: 6.0, memo: "Sample memo", user_id: 1 },
      { recorded_at: Time.zone.parse("#{Date.today.strftime("%Y-%m-%d")} 07:00 +0900"), column_0: 1.0, column_1: 2.0, column_2: 3.0, column_3: 4.0, column_4: 5.0, column_5: 6.0, memo: "Sample memo", user_id: 1 },
      { recorded_at: Time.zone.parse("#{Date.today.strftime("%Y-%m-%d")} 08:00 +0900"), column_0: 1.0, column_1: 2.0, column_2: 3.0, column_3: 4.0, column_4: 5.0, column_5: 6.0, memo: "Sample memo", user_id: 1 },
      { recorded_at: Time.zone.parse("#{Date.today.strftime("%Y-%m-%d")} 16:00 +0900"), column_0: 1.0, column_1: 2.0, column_2: 3.0, column_3: 4.0, column_4: 5.0, column_5: 6.0, memo: "Sample memo", user_id: 1 },
      { recorded_at: Time.zone.parse("#{Date.today.strftime("%Y-%m-%d")} 17:00 +0900"), column_0: 1.0, column_1: 2.0, column_2: 3.0, column_3: 4.0, column_4: 5.0, column_5: 6.0, memo: "Sample memo", user_id: 1 },
      { recorded_at: Time.zone.parse("#{Date.today.strftime("%Y-%m-%d")} 18:00 +0900"), column_0: 1.0, column_1: 2.0, column_2: 3.0, column_3: 4.0, column_4: 5.0, column_5: 6.0, memo: "Sample memo", user_id: 1 }
    ]
  )
end
