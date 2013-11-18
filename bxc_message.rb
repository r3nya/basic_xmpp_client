#!/bin/env ruby

require 'xmpp4r'
require 'yaml'

config = YAML.load_file('config.yml')
username = config['from']['jid']
password = config['from']['password']

jid = Jabber::JID.new(username)
client = Jabber::Client.new(jid)

client.connect
client.auth(password)

mainthread = Thread.current

client.send(Jabber::Presence.new.set_status("Hello! My local time at #{Time.now}"))

message = Jabber::Message.new(config['to']['jid'], "Hola amigo!")
message.type = :chat
client.send(message)

Thread.stop
client.close