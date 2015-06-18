require 'fileutils'

class FileTopic
  def initialize(channel_location, topic_name)
    @topic_location = channel_location + '/' + topic_name
    FileUtils.mkdir_p @topic_location
  end

  def topic_location
    @topic_location
  end
  
  def publish(message)
    message_id = SecureRandom.hex(20).to_s
    Dir.glob(@topic_location + '/*').select do |queue_location| 
      if File.directory? queue_location
        File.open(queue_location + '/' + SecureRandom.hex(20).to_s + '.msg', 'w') do | file|
          file.puts message
        end
      end
    end
  end
end