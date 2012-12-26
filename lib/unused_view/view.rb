# -*- coding: utf-8 -*-

module UnusedView
  class View
    def initialize(controllers)
      @controllers = controllers
    end

    def find_all
      @controllers.reduce([]) do |views, controller|
        views + controller.action_methods.map do |action|
          controller.lookup_context.find(action, controller._prefixes) rescue nil
        end
      end.uniq.compact.map(&:identifier)
    end
  end
end
