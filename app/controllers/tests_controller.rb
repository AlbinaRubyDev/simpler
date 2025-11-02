class TestsController < Simpler::Controller

  def index
    headers['Content-Type'] = 'text/plain'
    @time = Time.now
  end

  def create
    status 201
  end

  def show
    @id = params["id"]
    status 200
  end

end
