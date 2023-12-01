# frozen_string_literal: true

source "https://rubygems.org"
gemspec

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem "jekyll", ENV["JEKYLL_VERSION"] if ENV["JEKYLL_VERSION"]
gem "kramdown-parser-gfm" if ENV["JEKYLL_VERSION"] == "~> 3.9"

group :jekyll_plugins do
  gem "jekyll-last-modified-at"
end