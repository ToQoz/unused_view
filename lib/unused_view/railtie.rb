module UnusedView
  class Railtie < Rails::Railtie
    rake_tasks do
      load "unused_view/tasks.rake"
    end

    console do
      require "unused_view/commands"
    end
  end
end
