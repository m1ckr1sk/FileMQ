require 'fileutils'

require_relative '../lib/file_mq'

describe 'FileMQ' do
  it 'should initialise a new instance of file mq at a specific location' do
    #arrange
    file_location = './file_mq_store'
    FileUtils.rm_rf(file_location)

    #act
    file_mq = FileMQ.new file_location

    #assert
    expect(File).to exist(file_location)
  end

  it 'should initialise a new instance of file mq at a different location' do
    #arrange
    file_location_new = './file_mq_store_2'
    FileUtils.rm_rf(file_location_new)

    #act
    file_mq = FileMQ.new file_location_new

    #assert
    expect(File).to exist(file_location_new)
  end

  it 'should allow creation of a channel' do
    #arrange
    file_location = './file_mq_store'
    FileUtils.rm_rf(file_location)
    file_mq = FileMQ.new file_location

    #act
    channel = file_mq.create_channel

    #assert
    expect(channel).to_not be_nil
  end
  
  it 'should clear down its message store on close' do
      #arrange
      file_location = './file_mq_store'
      FileUtils.rm_rf(file_location)
      file_mq = FileMQ.new file_location
  
      #act
      file_mq.close
  
      #assert
      expect(File).to_not exist(file_location)
    end
end