require_relative '../lib/file_message'
describe 'file message' do
  it 'should create a message with a name' do
    #arrange
    #act
    file_message = FileMessage.new('file_message_name')
    
    #assert
    expect(file_message).to_not be_nil
    expect(file_message.message_name).to eq('file_message_name')
  end
  
  it 'should write a file message to a queue location containing a message' do
      #arrange
      file_message = FileMessage.new('file_message_name')
      FileUtils.mkdir_p('queue_location')
      
      #act
      file_message.write_message('queue_location','test message!')
      
      #assert
      expect(File).to exist('queue_location/file_message_name')
      expect(File.read('queue_location/file_message_name').chomp).to eq('test message!')
    end
end