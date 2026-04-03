# config/boot.rb

# ===============================
# Patch for Ruby 3.4 CGI issue
# Fixes "uninitialized class variable @@accept_charset"
require 'cgi'
class CGI
  unless defined?(@@accept_charset)
    @@accept_charset = nil
  end
end
# ===============================

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.
