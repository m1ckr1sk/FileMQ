require 'fileutils'

require_relative '../lib/file_channel'

describe 'FileChannel' do
  it 'should create a channel at a root location' do
    #arrange
    root_location = './channel_root'
    FileUtils.rm_rf(root_location)

    #act
    channel = FileChannel.new(root_location)

    #assert
    directory_count = 0
    Dir.glob(root_location + '/*').select do |f|
      if File.directory? f
        directory_count += 1
      end
    end
    expect(directory_count).to eq(1)
  end

  it 'should create a channel at a root location with a unique name' do
    #arrange
    root_location = './channel_root'
    FileUtils.rm_rf(root_location)

    #act
    channel = FileChannel.new(root_location)
    channel2 = FileChannel.new(root_location)

    #assert
    expect(channel.channel_name).to_not eq(channel2.channel_name)
  end

  it 'should allow creation of a topic' do
    #arrange
    root_location = './channel_root'
    FileUtils.rm_rf(root_location)
    channel = FileChannel.new(root_location)

    #act
    topic = channel.topic('topic_name')

    #assert
    expect(topic).to_not be_nil
  end
  
  it 'should allow creation of a queue' do
      #arrange
      root_location = './channel_root'
      FileUtils.rm_rf(root_location)
      channel = FileChannel.new(root_location)
  
      #act
      queue = channel.queue
  
      #assert
      expect(queue).to_not be_nil
    end


end