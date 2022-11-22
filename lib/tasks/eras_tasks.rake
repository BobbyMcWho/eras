# desc "Explaining what the task does"
# task :eras do
#   # Task goes here
# end
task default: [:test, "standard:fix"]

task :tailwind_engine_watch do
  require 'tailwindcss-rails'
  # NOTE: tailwindcss-rails is an engine
  system "#{Tailwindcss::Engine.root.join("exe/tailwindcss")} \
         -i #{Eras::Engine.root.join("app/assets/stylesheets/application.tailwind.css")} \
         -o #{Eras::Engine.root.join("app/assets/builds/eras.css")} \
         -c #{Eras::Engine.root.join("config/tailwind.config.js")} \
         --minify -w"
end
