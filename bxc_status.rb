#!/bin/env ruby

require 'xmpp4r'
require 'yaml'

config = YAML.load_file('config.yml')
username = config['from']['jid']
password = config['from']['passwaord']


jid = Jabber::JID.new(username)
client = Jabber::Client.new(jid)

client.connect
client.auth(password)

mainthread = Thread.current

client.send(Jabber::Presence.new.set_status("Hello! My local time at #{Time.now}"))

Thread.stop
client.close