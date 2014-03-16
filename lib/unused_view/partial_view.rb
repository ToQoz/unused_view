# -*- coding: utf-8 -*-

module UnusedView
  class PartialView
    class UnresolvePartial < StandardError; end

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
      r = _find_all

      if r.count > 0
        r + PartialView.new(r).find_all
      else
        r
      end
    end

    def _find_all
      @views.reduce([]) do |sum, view|
        used_partials_by_view = File.open(view) { |f| f.read.split("\n") }.map do |line|
          if line =~ %r[(?:#{PATTERN[:partial]}|#{PATTERN[:render]})(['"])/?(#{PATTERN[:filename]})#{PATTERN[:extention]}*\1]
            $2 # virtual path. e.g. articles/form
          end
        end.compact.map do |partial|
          resolve view, partial
        end

        sum + used_partials_by_view
      end.uniq
    end

    def resolve view, partial
      ext = File.basename(view).split('.')[1..-1].join('.') # foo.html.erb -> html.erb

      view_paths = [File.dirname(view)] + default_view_paths.map(&:to_s)

      r = view_paths.
        map { |view_path| File.join(view_path.to_s, File.dirname(partial), "_#{File.basename(partial)}.#{ext}") }.
        detect { |f| File.exists?(f) }

      raise UnresolvePartial.new("#{partial} in #{view}") unless r
      File.expand_path(r).to_s
    end

    def default_view_paths
      ApplicationController.view_paths
    end
  end
end
