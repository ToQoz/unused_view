module UnusedView
  class Railtie < Rails::Railtie
    rake_tasks do
      load "unused_view/tasks.rake"
    end
  end
end
