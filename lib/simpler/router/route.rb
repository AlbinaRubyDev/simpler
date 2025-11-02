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
        @method == method && @regex.match(path)
      end

      def params_for(path)
        @regex.match(path)&.named_captures || {}
      end

      private

      def build_regex(path)
        pattern = path.gsub(/:\w+/, '(?<id>[0-9]+)')
        Regexp.new("^#{pattern}$")
      end
    end
  end
end
