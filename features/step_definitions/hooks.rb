After('@cleanup') do
  @file_mq.close
end