require 'fileutils'
require_relative 'file_topic'
require 'securerandom'

class FileQueue
  def initialize
    @queue_name = SecureRandom.hex(20).to_s
  end
  
  def queue_name
    return @queue_name
  end
  
  def bind(file_topic)
    @queue_location = file_topic.topic_location + '/' + @queue_name
    FileUtils.mkdir_p file_topic.topic_location + '/' + @queue_name
  end
  
  def pop
    files_sorted_by_time = Dir[@queue_location + '/*'].sort_by{ |f| File.mtime(f) }
    message = File.read(files_sorted_by_time[0]).chomp
    File.delete(files_sorted_by_time[0])
    return message
  end
end