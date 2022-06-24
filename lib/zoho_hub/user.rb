# frozen_string_literal: true

require 'zoho_hub/with_connection'
require 'zoho_hub/with_attributes'

module ZohoHub
  class User
    include WithConnection
    include WithAttributes

    REQUEST_PATH = 'users'

    attributes :country, :current_shift, :microsoft, :state, :fax, :zip,
               :profile, :full_name, :phone, :status, :role, :city, :street, :id,
               :first_name, :email, :mobile, :last_name, :category

    def self.all(type = "AllUsers")
      users = all_json_for(type)
      users.map { |json| new(json) }
    end

    def self.find(id)
      response = get(File.join(REQUEST_PATH, id))
      return nil unless response

      users = response[:users]
      users.map { |json| new(json) }.first
    end

    def self.all_json_for(type)
      response = get(REQUEST_PATH, type: type)
      response[:users]
    end

    def initialize(json = {})
      attributes.each { |attr| send("#{attr}=", json[attr]) }
    end
  end
end
