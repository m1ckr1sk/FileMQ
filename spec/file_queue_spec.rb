require_relative '../lib/file_queue'

describe 'FileQueue' do
  it 'should create a queue with a unique name' do
    #arrange
    #act
    queue = FileQueue.new
    queue1 = FileQueue.new

    #assert
    expect(queue.queue_name).to_not eq(queue1.queue_name)
  end

  it 'should allow binding to a topic' do
    #arrange
    channel_location = 'test_channel'
    FileUtils.rm_rf(channel_location)
    queue = FileQueue.new
    file_topic = FileTopic.new(channel_location,'test_topic')

    #act
    queue.bind(file_topic)

    #assert
    expect(File).to  exist(file_topic.topic_location + '/' + queue.queue_name)
  end

  it 'should pop messages from the queue' do
    #arrange
    channel_location = 'test_channel'
    FileUtils.rm_rf(channel_location)
    queue = FileQueue.new
    file_topic = FileTopic.new(channel_location,'test_topic')
    queue.bind(file_topic)
    message_location = file_topic.topic_location + '/' + queue.queue_name + '/test_message.tst'
    File.open(message_location, 'w') do |file|
      file.puts 'test_message'
    end

    #act
    content = queue.pop

    #assert
    expect(content).to eq('test_message')
    expect(File).to_not exist(message_location)
  end

  it 'should pop the oldest message from the queue first' do
    #arrange
    channel_location = 'test_channel'
    FileUtils.rm_rf(channel_location)
    queue = FileQueue.new
    file_topic = FileTopic.new(channel_location,'test_topic')
    queue.bind(file_topic)

    message_location_oldest = file_topic.topic_location + '/' + queue.queue_name + '/test_message_oldest.tst'
    File.open(message_location_oldest, 'w') do |file|
      file.puts 'test_message_oldest'
    end

    sleep(5)
    
    message_location_newest = file_topic.topic_location + '/' + queue.queue_name + '/test_message_newest.tst'
    File.open(message_location_newest, 'w') do |file|
      file.puts 'test_message_newest'
    end

    #act
    content = queue.pop

    #assert
    expect(content).to eq('test_message_oldest')
    expect(File).to_not exist(message_location_oldest)
    expect(File).to exist(message_location_newest)
  end
end
