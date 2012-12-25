task :load_controllers => :environment do
  Rails.application.eager_load!
end

desc "Show all unused views"
task :unused_views, [ :path ] => :load_controllers do |task, args|
  base_path = Rails.root.join('app').join('views').join(args[:path] || "")
  unused_views = UnusedView.find_all(base_path)
  puts unused_views
end
