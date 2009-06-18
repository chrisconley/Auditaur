desc "Audit your app for security, performance, and monitoring tools/best practices"
task :audit => :environment do
  
  ExceptionNotifier.exists?
  AssetBundler.exists?
  AttrAccessible.exists? #railscasts, http://railspikes.com/2008/9/22/is-your-rails-application-safe-from-mass-assignment
  SqlInjection.exists? #railscasts
  Analytics.exists? #(Google Analytics, Crazy Egg)
  #Tools::PerformanceTools.exist? (New Relic RPM, ruby_prof, query_analyzer plugin, metric_fu, etc)
  #Security::CrossSiteScripting? railscasts
  #DataIntegrity::UniqueIndices? http://blog.insoshi.com/2008/06/26/working-around-the-validates_uniqueness_of-bug-in-ruby-on-rails/
  #DataIntegrity::ForeignKey?
  #Misc::ConsoleLog?
  #go through yslow
  #ab testing http://github.com/paulmars/seven_minute_abs/tree/master
end

#http://guides.rubyonrails.org/security.html
#https://peepcode.com/products/rails-code-review-pdf
#http://umlatte.backpackit.com/pages/1589303