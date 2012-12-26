# -*- coding: utf-8 -*-

module UnusedView
  class Layout
    def initialize(controllers)
      @controllers = controllers
    end

    def find_all
      @controllers.reduce([]) do |layouts, controller|
        if _name = name(controller)
          begin
            layouts << controller.lookup_context.find(_name, 'layouts')
          rescue
            layouts
          end
        else
          layouts
        end
      end.uniq.compact.map(&:identifier)
    end

    def name(controller)
      _name = controller.send(:_layout) rescue nil
      case _name
      when String
        _name
      when ActionView::Template
        File.basename(_name.identifier).split('.').first
      end
    end
  end
end
