# -*- coding: utf-8 -*-

module UnusedView
  class PartialView
    PATTERN = {
      render: %r{\brender\s*(?:\(\s*)?},
      partial: %r{:partial\s*=>\s*|partial:\s*},
      filename: %r{[\w/]+?},
      extention: %r{\.\w+}
    }

    def initialize(views)
      @views = views
    end

    def find_all
      @views.reduce([]) do |sum, view|
        used_partials_by_view = File.open(view) { |f| f.read.split("\n") }.map do |line|
          if line =~ %r[(?:#{PATTERN[:partial]}|#{PATTERN[:render]})(['"])/?(#{PATTERN[:filename]})#{PATTERN[:extention]}*\1]
            $2 # virtual path. e.g. articles/form
          end
        end.compact.map do |vpath|
          File.class_eval do
            if vpath.index('/')
              path = ApplicationController.view_paths.map do |view_path|
                File.join(view_path.to_s, vpath)
              end.select { |f| File.exists?(File.dirname(f)) }.first || vpath
            else
              path = view
            end
            filename = "_#{basename(vpath)}.#{basename(view).split('.')[1..-1].join('.')}"
            expand_path(join(dirname(path), filename)).to_s
          end
        end
        sum + used_partials_by_view
      end.uniq
    end
  end
end
