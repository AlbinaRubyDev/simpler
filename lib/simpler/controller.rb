require 'rack'
require_relative 'view'

module Simpler
  class Controller

    attr_reader :name, :request, :response

    def initialize(env, route_params = {})
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
      @route_params = route_params
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      set_default_headers
      send(action)
      write_response unless action == "not_found"

      @response.finish
    end

    private

    def status(code)
      @response.status = code
    end

    def headers
      @response.headers
    end

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      return unless @response.body.empty?

      body = render_body
      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def params
      @route_params.merge(@request.params)
    end

    def render(template)
      if template.is_a?(Hash) && template[:plain]
        @response.write(template[:plain])
      else
        @request.env['simpler.template'] = template
      end
    end

  end
end
