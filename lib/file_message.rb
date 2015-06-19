# FileMessage - simple class to write a message
class FileMessage
  attr_reader :message_name
  def initialize(message_name)
    @message_name = message_name
  end

  def write_message(queue_location, message)
    File.open(queue_location + '/' + @message_name, 'w') do |file|
      file.puts message
    end
  end
end
