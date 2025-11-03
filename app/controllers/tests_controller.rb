class TestsController < Simpler::Controller

  def index
    @time = Time.now
    headers['Content-Type'] = 'text/plain'
    render plain: "Hello, World! time: #{@time}"
  end

  def create
    status 201
  end

  def show
    @id = params["id"]
    status 200
  end

end
