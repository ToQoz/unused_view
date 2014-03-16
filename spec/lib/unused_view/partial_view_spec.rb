# -*- coding: utf-8 -*-

require 'spec_helper'

describe UnusedView::PartialView do
  include FakeFS::SpecHelpers

  class TestController < ApplicationController
    def new
    end
  end

  describe '#find_all' do
    let!(:views) {
      [
        Rails.root.join('app/views/test/new.html.erb').to_s.tap { |path|
          FileUtils.mkdir_p(File.dirname(path)) unless File.directory? File.dirname(path)
          File.open(path, 'w+') { |f|
            f.write <<-EOS
              <% render "piyo" %>'
              <% render partial: "shared/hogessu" %>
            EOS
          }
        }
      ]
    }

    let!(:partials) {
      [
        Rails.root.join('app/views/test/_piyo.html.erb').to_s.tap { |path|
          FileUtils.mkdir_p(File.dirname(path)) unless File.directory? File.dirname(path)
          File.open(path, 'w+') { |f|
            f.write <<-EOS
              <% render "piyopiyo" %>
            EOS
          }
        },
        Rails.root.join('app/views/test/_piyopiyo.html.erb').to_s.tap { |path|
          FileUtils.mkdir_p(File.dirname(path)) unless File.directory? File.dirname(path)
          FileUtils.touch path
        },
        Rails.root.join('app/views/shared/_hogessu.html.erb').to_s.tap { |path|
          FileUtils.mkdir_p(File.dirname(path)) unless File.directory? File.dirname(path)
          FileUtils.touch path
        }
      ]
    }

    let!(:unused_partials) {
      [
        Rails.root.join('app/views/test/_unused.html.erb').to_s.tap { |path|
          FileUtils.mkdir_p(File.dirname(path)) unless File.directory? File.dirname(path)
          FileUtils.touch path
        }
      ]
    }

    it {
      partials.each do |partial|
        expect(described_class.new(views).find_all).to include(partial)
      end

      expect(described_class.new(views).find_all).not_to include(unused_partials)
    }
  end
end
