# If you do not have OpenSSL installed, update
# the following line to use "http://" instead
source 'https://rubygems.org'

# Specify your gem's dependencies in middleman-importmap.gemspec
gemspec

group :development do
  gem 'rake'
  gem 'rdoc'
  gem 'yard'

  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'solargraph', require: false
end

group :development, :test do
  gem 'cucumber'
  gem 'aruba'
  gem 'rspec'
end
