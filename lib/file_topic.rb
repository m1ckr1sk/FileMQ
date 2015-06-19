require 'fileutils'

# FileTopic - a topic to post messages to that queues can listen to
class FileTopic
  attr_reader :topic_location
  def initialize(channel_location, topic_name)
    @topic_location = channel_location + '/' + topic_name
    FileUtils.mkdir_p @topic_location
  end

  def publish(message)
    message_file = FileMessage.new SecureRandom.hex(20).to_s + '.msg'
    Dir.glob(@topic_location + '/*').select do |queue_location|
      next unless File.directory? queue_location
      message_file.write_message(queue_location, message)
    end
  end
end
