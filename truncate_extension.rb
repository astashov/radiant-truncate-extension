require 'application_controller'

class TruncateExtension < Radiant::Extension
  version "0.1"
  description "Adds truncate tag to Radiant for truncating data within the tag"
  
  define_routes do |map|
  end
  
  def activate
    Page.send :include, TruncateTags
  end
  
  def deactivate
  end
  
end