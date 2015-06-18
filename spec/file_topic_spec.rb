require_relative '../lib/file_topic'

describe 'FileTopic' do
  it 'should create a topic from a channel location and a topic name' do
    #arrange
    channel_location = 'channel_location'
    topic_name = 'topic_name'

    #act
    topic = FileTopic.new(channel_location, topic_name)

    #assert
    expect(File).to exist(channel_location + '/' + topic_name)
  end

  it 'should allow messages to be published to a topic' do
    #arrange
    channel_location = 'channel_location'
    FileUtils.rm_rf(channel_location)
    topic_name = 'topic_name'
    topic = FileTopic.new(channel_location, topic_name)
    queue = FileQueue.new
    queue.bind(topic)
    queue_location = topic.topic_location + '/' + queue.queue_name

    #act
    topic.publish('hello world')

    #assert
    expect(File).to exist(queue_location)
    message_array = []
    messages = Dir[queue_location+'/*']
    messages.each do |message_file|
      message_array << File.read(message_file).chomp
    end
    expect(message_array).to include('hello world')
  end
end