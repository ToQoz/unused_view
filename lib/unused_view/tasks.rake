desc "Show all unused views"
task :load_controllers => :environment do
  puts "# Loading code in search of controllers"
  Rails.application.eager_load!
end

task :unused_views, [ :path ] => :load_controllers do |task, args|
  base_path = Rails.root.join('app').join('views').join(args[:path] || "")
  puts "# Unused Views"
  unused_views = UnusedView.find_all(base_path)
  puts unused_views
end
