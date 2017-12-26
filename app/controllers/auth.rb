
# require "google/cloud/storage"

# If you don't specify credentials when constructing the client, the client
# library will look for credentials in the environment.
# storage = Google::Cloud::Storage.new project: project_id

# Make an authenticated API request
# storage.buckets.each do |bucket|
#   puts bucket.name
# end

puts "works"

# Imports the Google Cloud client library
require "google/cloud/translate"
# Your Google Cloud Platform project ID
project_id = "central-diagram-189014"
# Instantiates a client
translate = Google::Cloud::Translate.new project: project_id

# The text to translate
text = "Hello, world!"
# The target language
target = "tr"
# Translates some text into language you specify
translation = translate.translate text, to: target

puts "Text: #{text}"
puts "Translation: #{translation}"
