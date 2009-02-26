namespace :radiant do
  namespace :extensions do
    namespace :truncate do
      
      desc "Runs the migration of the Truncate extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          TruncateExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          TruncateExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Truncate to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[TruncateExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(TruncateExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
