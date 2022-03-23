require 'zoho_hub/response'
require 'zoho_hub/with_connection'

module ZohoHub
  class Coql
    include WithConnection

    # CRM Object Query Language path
    COQL_REQUEST_PATH = "coql"

    attr_reader :klass, :all_pages

    def initialize(klass, query, all_pages)
      @klass = klass
      @query = query
      @all_pages = all_pages
      @records = []
      @offset = 0
    end

    def call
      body = post(COQL_REQUEST_PATH, select_query: query)
      response = build_response(body)

      info = response.info
      data = response.nil? ? [] : response.data

      return data.map { |json| klass.new(json) } unless all_pages

      @records += data.map { |json| klass.new(json) }

      unless info[:more_records].nil?
        @offset += 200
        @records + call
      end

      @records
    end

    private

    def query
      @query + " LIMIT 200 OFFSET #{@offset}"
    end

    def build_response(body)
      response = Response.new(body)

      raise InternalError, response.msg if response.internal_error?
      raise InvalidQuery, response.msg if response.invalid_query?
      raise SyntaxError, response.msg if response.syntax_error?

      response
    end
  end
end
