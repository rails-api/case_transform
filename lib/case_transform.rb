# frozen_string_literal: true

require 'case_transform/version'
require 'thermite/config'
require 'fiddle'

ruby_dir = File.dirname(File.dirname(__FILE__))
ext_dir =  ruby_dir + '/ext/case_transform'
config = Thermite::Config.new(cargo_project_path: ext_dir, ruby_project_path: ruby_dir)
# Do I have to use fiddle? :-\
library = Fiddle.dlopen(config.ruby_extension_path)
func = Fiddle::Function.new(
  library['initialize_case_transform'],
  [], Fiddle::TYPE_VOIDP
)
func.call
