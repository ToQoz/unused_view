require 'unused_view/railtie'
require 'unused_view/view'
require 'unused_view/layout'
require 'unused_view/partial_view'
require 'unused_view/target_files'

module UnusedView
  extend self

  def find_all(base_path)
    controllers = ApplicationController.descendants.map(&:new)
    views = View.new(controllers).find_all + Layout.new(controllers).find_all
    TargetFiles.new(base_path).all - views - PartialView.new(views).find_all
  end
end
