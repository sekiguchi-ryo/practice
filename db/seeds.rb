# メインのサンプルユーザーを1人作成する
# User.create!(name:  "Example User",
#              email: "example@railstutorial.org",
#              password:   "foobar")

User.create!(name: "Admin", email: "admin@example.com", password: "admin1234", admin: true)

User.create!(name: "sekiguchi", email: "sekiguchi@example.com", password: "test1234")

User.create!(name: "test", email: "test@example.com", password: "test1234")

Setting.create!(mode: true,
                api: 10,
                ip_black_list: "192.168.100.1",
                ip_white_list: "192.168.1.1",
                contact_email_address: "sekiguchi.ryo@omura.co.jp")