class String
  def ucfirst
    self[0,1].capitalize + self[1..-1]
  end
  
  def dcfirst
    self[0,1].downcase + self[1..-1]
  end
end

module Ruboss4Ruby
  module Configuration
    APP_ROOT = defined?(RAILS_ROOT) ? RAILS_ROOT : defined?(Merb) ? Merb.root : File.expand_path(".")

    def extract_names(project = nil)
      if project
        project_name = project.camelcase.gsub(/\s/, '')
        project_name_downcase = project_name.downcase
      else
        project_name = APP_ROOT.split("/").last.camelcase.gsub(/\s/, '')
        project_name_downcase = project_name.downcase
      end
      
      begin      
        config = YAML.load(File.open("#{APP_ROOT}/config/ruboss.yml"))
        base_package = config['base-package'] || project_name_downcase
        base_folder = base_package.gsub('.', '/').gsub(/\s/, '')
        controller_name = config['controller-name'] || "ApplicationController"
      rescue
        base_folder = base_package = project_name_downcase
        controller_name = "ApplicationController"
      end
      [project_name, project_name_downcase, controller_name, base_package, base_folder]
    end

    def list_as_files(dir_name)
      Dir.entries(dir_name).grep(/\.as$/).map { |name| name.sub(/\.as$/, "") }.join(", ")
    end

    def list_mxml_files(dir_name)
      Dir.entries(dir_name).grep(/\.mxml$/).map { |name| name.sub(/\.mxml$/, "") }
    end
  end
end