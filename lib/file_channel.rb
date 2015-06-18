require_relative 'file_queue'
require_relative 'file_topic'
require 'securerandom'

class FileChannel
  def initialize(root_location)
    @channel_name = SecureRandom.hex(20).to_s
    @channel_location = root_location + '/' + @channel_name

    FileUtils.mkdir_p @channel_location
    @topics = Hash.new
  end

  def channel_name
    return @channel_name
  end

  def topic(topic_name)
    @topics[topic_name] = FileTopic.new(@channel_location, topic_name)
  end

  def queue
    return FileQueue.new
  end

end