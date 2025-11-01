require 'logger'

class AppLogger
  
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    message = collect(env)
    @logger.info(message)
    [status, headers, body]
  end

  private

  def collect(env)
    request = Rack::Request.new(env)
    [request_line(request), handler_line(env), parameters_line, response_line].join("\n")
  end

  def request_line(request)
    "#{"\n"}Request: #{request.request_method} #{request.fullpath}"
  end

  def handler_line(env)
    "Handler: #{env['simpler.controller'].class}##{env['simpler.action']}"
  end

  def parameters_line
    "Parameters: "
  end

  def response_line
    "Response: тлько это попадает?"
  end

end
