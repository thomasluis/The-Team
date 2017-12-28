require 'google/cloud/translate'

TRANSLATOR = Google::Cloud::Translate.new project: "central-diagram-189014", keyfile: './service-account.json'
