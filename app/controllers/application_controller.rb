class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  # Google Translate API

  project_id = "central-diagram-189014"

  # require "google/cloud/translate"

  @translate = Google::Cloud::Translate.new project: project_id
end
