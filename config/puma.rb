#!/usr/bin/env puma

environment 'production'
rails_root = '/home/trainees2013_h2_2/trainees2013_h2_2'
port       = '5080'
daemonize  false

pidfile         rails_root + '/tmp/pids/puma.pid'
state_path      rails_root + '/tmp/pids/puma.state'
stdout_redirect rails_root + '/log/stdout', 
                rails_root + '/log/stderr', true
bind "tcp://0.0.0.0:#{port}"
