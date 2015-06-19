require_relative '../../lib/file_mq'
require_relative 'hooks'

Given(/^that the file MQ is initialised$/) do
  FileUtils.rm_rf('file_mq_store')
  @file_mq = FileMQ.new('file_mq_store')
end

Given(/^a topic is created$/) do
  @channel=@file_mq.create_channel
  @topic = @channel.topic('test_topic')
end

Given(/^a client is listening to the topic$/) do
  @queue = @channel.queue
  @queue.bind(@topic)
end

Given(/^multiple clients are listening to the topic$/) do
  @queue1 = @channel.queue
  @queue2 = @channel.queue
  @queue1.bind(@topic)
  @queue2.bind(@topic)
end

When(/^I publish a message to the topic$/) do
  @topic.publish('hello world!')
end

Then(/^the client must receive the message$/) do
  content = @queue.pop
  expect(content).to eq('hello world!')
end

Then(/^every client must receive the message$/) do
  content1 = @queue1.pop
  content2 = @queue2.pop
  expect(content1).to eq('hello world!')
  expect(content2).to eq('hello world!')
end
