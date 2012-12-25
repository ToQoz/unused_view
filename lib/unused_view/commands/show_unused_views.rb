# -*- coding: utf-8 -*-

CC.define_command('show-unused-views') do |c|
  c.description "Show unused views list"
  c.group "UnusedView"
  c.options do |opts|
    opt.banner unindent <<-USAGE
      Usage: show-unused-views [PATH]

      Show unused views list
    USAGE
  end
  c.process do
    Rails.application.eager_load!
    puts UnusedView.find_all(Rails.root.join('app').join('views'))
  end
end
