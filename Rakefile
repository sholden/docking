# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.


require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

if ENV['CI']
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = ['-f', 'JUnit' ' -o', "#{ENV['CI_REPORTS']}/specs/results.xml"]
  end
end
