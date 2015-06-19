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
    FileUtils.mkdir_p @queue_location
  end

  def pop
    latest_message = latest_message_file
    message_content = File.read(latest_message).chomp
    File.delete(latest_message)
    message_content
  end

  def latest_message_file
    files_sorted_by_time = Dir[@queue_location + '/*'].sort_by do |file|
      File.mtime(file)
    end
    files_sorted_by_time[0]
  end
end
