require 'securerandom'
require_relative 'file_queue'
require_relative 'file_topic'

# FileChannel - channel to hold queues and topics
class FileChannel
  attr_reader :channel_name

  def initialize(root_location)
    @channel_name = SecureRandom.hex(20).to_s
    @channel_location = root_location + '/' + @channel_name

    FileUtils.mkdir_p @channel_location
    @topics = {}
  end

  def topic(topic_name)
    @topics[topic_name] = FileTopic.new(@channel_location, topic_name)
  end
  
  
  #BREAK ME NOW!!!!

  def queue
    FileQueue.new
  end
end
