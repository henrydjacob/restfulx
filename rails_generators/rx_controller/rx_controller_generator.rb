require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'restfulx') if !defined?(RestfulX)

class RxControllerGenerator < Rails::Generator::Base
  include RestfulX::Configuration
  
  attr_reader :project_name, 
              :flex_project_name, 
              :base_package, 
              :base_folder, 
              :command_controller_name,
              :model_names, 
              :command_names,
              :flex_root

  def initialize(runtime_args, runtime_options = {})
    super
    @project_name, @flex_project_name, @command_controller_name, @base_package, @base_folder, 
      @flex_root = extract_names
      
    puts "flex_root: #{@flex_root}"
    puts "base_folder: #{@base_folder}"
    
    @model_names = list_as_files("#{@flex_root}/#{@base_folder}/models")
    @command_names = list_as_files("#{@flex_root}/#{@base_folder}/commands")
  end

  def manifest
    record do |m|      
      m.template 'controller.as.erb', File.join("#{@flex_root}/#{@base_folder}/controllers", 
        "#{@command_controller_name}.as")
    end
  end
end
