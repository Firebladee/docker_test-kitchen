# frozen_string_literal: true

require 'serverspec'
require 'docker-api'

describe 'Dockerfile' do
  image = Docker::Image.build_from_dir('.')
  set :os, family: :redhat
  set :backend, :docker
  set :docker_image, image.id

  # describe package('systemd') do
  #   it { should be_installed }
  # end
end
