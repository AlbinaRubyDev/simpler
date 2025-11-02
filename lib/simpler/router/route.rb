module Simpler
  class Router
    class Route

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @regex = build_regex(path)
      end

      def match?(method, path)
        #@method == method && path.match(@path)
        return false unless @method == method
        !!(@regex.match(path))
        #binding.irb
      end

      def build_regex(path)
        pattern = path.gsub('^\/tests\/(?<id>[0-9]+)$')
        Regexp.new("^#{pattern}$")
      end
    end
  end
end
