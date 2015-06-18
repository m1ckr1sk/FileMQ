require 'fileutils'
require_relative 'file_channel'

class FileMQ
  def initialize(root_folder)
    @root_folder = root_folder
    FileUtils.mkdir_p @root_folder
   end
  
  def create_channel
    return FileChannel.new(@root_folder)
  end
end