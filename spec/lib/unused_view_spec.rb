# -*- coding: utf-8 -*-
require 'spec_helper'

describe UnusedView do
  before do
    described_class::View.any_instance.stub(:find_all).and_return(%W{foo})
    described_class::Layout.any_instance.stub(:find_all).and_return(%W{lay_foo})
    described_class::PartialView.any_instance.stub(:find_all).and_return(%W{par_foo})
    described_class::TargetFiles.any_instance.stub(:all).
      and_return(%W{foo bar lay_foo lay_bar par_foo par_bar})
  end
  it {
    described_class.find_all(Rails.root).should eq(%W{bar lay_bar par_bar})
  }
end
