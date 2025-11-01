class EmptyController < Simpler::Controller
  def not_found
    status 404
  end
end
