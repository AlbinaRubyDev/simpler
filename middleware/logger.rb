require 'logger'

class AppLogger
  
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    message = collect(env, status, headers)
    @logger.info(message)
    [status, headers, body]
  end

  private

  def collect(env, status, headers)
    request = Rack::Request.new(env)
    [request_line(request), handler_line(env), parameters_line(request.params), response_line(status, headers, env)].join("\n")
  end

  def request_line(request)
    "#{"\n"}Request: #{request.request_method} #{request.fullpath}"
  end

  def handler_line(env)
    "Handler: #{env['simpler.controller'].class}##{env['simpler.action']}"
  end

  def parameters_line(params)
    "Parameters: #{params}"
  end

  def response_line(status, headers, env)
    "Response: #{status} [#{headers['Content-Type']}] #{env['simpler.controller']&.name}/#{env['simpler.action']}.html.erb"
  end

end
