require 'fileutils'
require_relative 'file_channel'

# FileMQ - main class and entry point to application
class FileMQ
  def initialize(root_folder)
    @root_folder = root_folder
    FileUtils.mkdir_p @root_folder
  end

  def create_channel
    FileChannel.new(@root_folder)
  end

  def close
    FileUtils.rm_rf(@root_folder)
  end
end
