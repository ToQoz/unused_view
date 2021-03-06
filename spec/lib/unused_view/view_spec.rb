# -*- coding: utf-8 -*-

require 'spec_helper'

describe UnusedView::View do
  include FakeFS::SpecHelpers

  class TestController < ApplicationController
    def new
    end
  end
  class TestTestController < ApplicationController
    def create
    end
  end

  describe '#find_all' do
    let(:views) {
      [
        Rails.root.join('app/views/test/new.html.erb').to_s,
        Rails.root.join('app/views/test_test/create.html.erb').to_s
      ]
    }
    let(:unused_views) { [ Rails.root.join('app/views/test/edit.html.erb').to_s ] }
    before(:each) do
      views.each do |v|
        FileUtils.mkdir_p(File.dirname(v)) unless File.directory? File.dirname(v)
        FileUtils.touch v
      end
      unused_views.each do |v|
        FileUtils.mkdir_p(File.dirname(v)) unless File.directory? File.dirname(v)
        FileUtils.touch v
      end
    end

    it {
      described_class.new([ TestController.new, TestTestController.new ]).find_all.should eq(views)
    }
  end
end
