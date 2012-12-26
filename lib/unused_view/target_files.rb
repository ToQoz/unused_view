# -*- coding: utf-8 -*-

module UnusedView
  class TargetFiles
    def initialize(path)
      @path = path
    end

    def all
      views + partial_views
    end

    def views
      ApplicationController.view_paths.reduce([]) do |sum, view_path|
        sum + Dir[File.join(view_path, '**/[a-zA-Z]*')].select { |f| File.file?(f) && f[%r{^#{@path}}] }
      end
    end

    def partial_views
      ApplicationController.view_paths.reduce([]) do |sum, view_path|
        sum + Dir[File.join(view_path, '**/_*')].select { |f| File.file?(f) && f[%r{^#{@path}}] }
      end
    end
  end
end
