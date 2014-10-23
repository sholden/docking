#!/usr/bin/env ruby
require 'logger'
require 'ipaddr'

logger = Logger.new(STDOUT)

logger.info 'Starting boot2docker...'
Process.wait(fork { exec('boot2docker uo') } )

vm_ip = `boot2docker ip`[IPAddr::RE_IPV4ADDRLIKE]
if vm_ip
  logger.info "Docker running at #{vm_ip}"
else
    raise "Couldn't find IP"
end

ENV['DOCKER_CERT_PATH']= "#{Dir.home}/.boot2docker/certs/boot2docker-vm"
ENV['DOCKER_TLS_VERIFY']='1'
ENV['DOCKER_HOST']= "tcp://#{vm_ip}:2376"

logger.info 'Starting fig...'
fig_pid = fork { exec('fig up') }

running = true
#trap('INT') { running = false }
while running
  sleep 1
end

logger.info 'Shutting down...'

logger.info 'Stopping fig...'
Process.kill('INT', fig_pid)
Process.wait(fig_pid)
