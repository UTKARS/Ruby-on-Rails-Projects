namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Story Death",
                         :email => "s@mail.ru",
                         :password => "111111",
                         :password_confirmation => "111111")
    admin.toggle!(:admin)

			50.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@rails.org"
      password  = "222222"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
   		 end
			User.all(:limit => 6).each do |user|
      30.times do
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end
  end
end
