# FileMQ
[![Circle CI](https://circleci.com/gh/m1ckr1sk/FileMQ.svg?style=svg)](https://circleci.com/gh/m1ckr1sk/FileMQ)
[![Gem Version](https://badge.fury.io/rb/file_mq.svg)](https://badge.fury.io/rb/file_mq)

File based messaging library written in Ruby. The system is intended to be  simple development substitute that could be swapped in in place of a more robust messaging system

## Design
The design is simple and based on many of the popular messaging systems. The FileMQ class sets the root of the system.  This can then be used to create channels to communicate on.  These channels have topics and queues.  Topics can be posted to and the messages are then added to the queues that are bound to them.  


