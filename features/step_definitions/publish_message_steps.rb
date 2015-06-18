require_relative '../../lib/file_mq'

Given(/^that the file MQ is initialised$/) do
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

When(/^I publish a message to the topic$/) do
  @topic.publish('hello world!')
end

Then(/^the client must receive the message$/) do
  content = @queue.pop
  expect(content).to eq('hello world!')
end
