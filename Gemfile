# Edit this Gemfile to bundle your application's specific requirements
# if you choose to customize the file_manager
#source 'http://gemcutter.org'
#source "http://gems.github.com"
source 'http://rubygems.org'

gem "rails", "3.0.3"
gem "sqlite3-ruby", '1.2.5', :require => "sqlite3"
gem "authlogic", :git => "git://github.com/voxxit/authlogic.git"
gem "devise"
gem "cancan"
gem "faker"
gem "populator"
gem "aws-s3", :require => "aws/s3"
gem "haml"
gem "right_aws"
gem "rack"
# gem "mysql"
gem "will_paginate", ">= 3.0.pre2"
gem "erubis"
gem "string_to_editor"
gem "launchy"
gem "spork"
gem "paperclip"
gem "validation_reflection"

group :development do
  gem "ruby-debug19", :require => "ruby-debug", :group => :development
end

group :test do
  gem "shoulda"
  gem "factory_girl_rails", ">= 1.0"
  gem "cucumber-rails", ">= 0.3.2"
  gem "database_cleaner"
  gem "rspec", ">= 2.0.0"
  gem "rspec-expectations", ">= 2.0.0"
  gem "rspec-rails", ">= 2.0.0"
  gem "webrat", :git => "http://github.com/kalv/webrat.git"
end
