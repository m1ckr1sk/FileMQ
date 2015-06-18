require 'fileutils'
require 'securerandom'

require_relative 'file_topic'

# FileQueue - simple queue to bind to a topic and pop messages
class FileQueue
  attr_reader :queue_name

  def initialize
    @queue_name = SecureRandom.hex(20).to_s
  end

  def bind(file_topic)
    @queue_location = file_topic.topic_location + '/' + @queue_name
    FileUtils.mkdir_p file_topic.topic_location + '/' + @queue_name
  end

  def pop
    files_sorted_by_time = Dir[@queue_location + '/*'].sort_by do |f|
      File.mtime(f)
    end
    message = File.read(files_sorted_by_time[0]).chomp
    File.delete(files_sorted_by_time[0])
    message
  end
end
