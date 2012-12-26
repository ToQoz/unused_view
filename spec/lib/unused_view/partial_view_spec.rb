# -*- coding: utf-8 -*-

require 'spec_helper'

describe UnusedView::PartialView do
  include FakeFS::SpecHelpers

  class TestController < ApplicationController
    def new
    end
  end

  describe '#find_all' do
    let(:views) { [ Rails.root.join('app/views/test/new.html.erb').to_s ] }
    let(:partials) {
      [ Rails.root.join('app/views/test/_piyo.html.erb').to_s ]
    }
    let(:unused_partials) {
      [ Rails.root.join('app/views/test/_unused.html.erb').to_s ]
    }
    before(:each) do
      views.each do |v|
        FileUtils.mkdir_p(File.dirname(v)) unless File.directory? File.dirname(v)
        File.open(v, 'w+') { |f|
          f.write '<% render "piyo" %>'
        }
      end
      partials.each do |v|
        FileUtils.mkdir_p(File.dirname(v)) unless File.directory? File.dirname(v)
        FileUtils.touch v
      end
      unused_partials.each do |v|
        FileUtils.mkdir_p(File.dirname(v)) unless File.directory? File.dirname(v)
        FileUtils.touch v
      end
    end
    it {
      described_class.new(views).find_all.should eq(partials)
    }
  end
end
