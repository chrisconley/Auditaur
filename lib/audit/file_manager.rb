module FileManager
  class << self
    def models
      rb_files_in('models')
    end
    
    def ar_models
      models.reject{|f| !File.read(f).match('ActiveRecord::Base')}
    end
    
    def controllers
      rb_files_in('controllers')
    end
    
    def application_controller
      File.join(Audit.app_root, 'app', 'controllers', 'application_controller.rb')
    end
    
    def helpers
      rb_files_in('helpers')
    end
    
    def views
      files_in('views')
    end
    
    def layouts
      files_in('views/layouts')
    end
    
    def entire_app
      files_in('')
    end
    
    def rb_files_in(folder)
      files_in(folder, '*.rb')
    end
    
    def files_in(folder, matcher = '*.*')
      orig_dir = Dir.pwd
      Dir.chdir(File.join(Audit.app_root, 'app', folder))
      working_dir = Dir.pwd
      files = Dir.glob(File.join("**", matcher))
      Dir.chdir(orig_dir)
      files.map {|f| File.join(working_dir, f)}
    end
  end
end