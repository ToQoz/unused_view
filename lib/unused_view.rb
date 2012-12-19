require 'unused_view/railtie'

module UnusedView
  extend self

  def find_all(base_path)
    Rails.application.instance_eval do
      used_views = ApplicationController.descendants.reduce([]) do |views, controller_class|
        controller = controller_class.new
        views + UnusedView.find_views(controller).compact + [ UnusedView.find_layout(controller) ].compact
      end.map(&:identifier).uniq

      ApplicationController.view_paths.reduce([]) do |unused_views, view_path|
        unused_views + Dir.glob(File.join(view_path, '**/[a-zA-Z]*')).select do |f|
          File.file?(f) && used_views.exclude?(f) && f[%r{^#{base_path}}]
        end
      end
    end
  end

  def find_views(controller)
    controller.action_methods.map do |action|
      controller.lookup_context.find(action, controller._prefixes) rescue nil
    end
  end

  def find_layout(controller)
    name = layout_name(controller)
    if name
      controller.lookup_context.find(name, 'layouts') rescue nil
    end
  end

  def layout_name(controller)
    name = controller.send(:_layout) rescue nil
    case name
    when String
      name
    when ActionView::Template
      File.basename(name.identifier).split('.').first
    end
  end
end
