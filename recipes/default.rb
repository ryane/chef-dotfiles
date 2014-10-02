#
# Cookbook Name:: dotfiles
# Recipe:: default
#
# Copyright 2014, Ryan Eschinger
#
# All rights reserved
#

# heavily inspired by (copied from) http://nickcharlton.net/posts/test-environments-with-vagrant-and-chef.html

include_recipe 'git'

%w(vim tmux zsh).each do |pkg|
  package pkg
end

home_dir = "/home/#{node['dotfiles']['user']}"

# setup oh-my-zsh
git "#{home_dir}/.oh-my-zsh" do
  repository 'git://github.com/robbyrussell/oh-my-zsh.git'
  reference 'master'
  user node['dotfiles']['user']
  group node['dotfiles']['group']
  action :checkout
end

# sync dotfiles
git "#{home_dir}/dotfiles" do
  repository "https://github.com/ryane/dotfiles.git"
  reference "master"
  user node['dotfiles']['user']
  group node['dotfiles']['group']
  action :sync
end

# setup dotfiles
bash "setup_dotfiles" do
  cwd "#{home_dir}/dotfiles"
  user node['dotfiles']['user']
  group node['dotfiles']['group']
  environment "HOME" => home_dir
  code "./install.sh --skip-bundle"
end

# setup vim tomorrow theme
bash "setup_tomorrow_theme" do
  cwd "#{home_dir}/dotfiles"
  user node['dotfiles']['user']
  group node['dotfiles']['group']
  environment "HOME" => home_dir
  code "./install-tomorrow-theme.sh"
end

# setup vundle
bash "create_vundle_directory" do
  cwd "#{home_dir}"
  user node['dotfiles']['user']
  group node['dotfiles']['group']
  environment "HOME" => home_dir
  code "mkdir -p .vim/bundle"
end

git "#{home_dir}/.vim/bundle/vundle" do
  repository 'https://github.com/gmarik/vundle.git'
  reference 'master'
  user node['dotfiles']['user']
  group node['dotfiles']['group']
  action :checkout
end

# install vim plugins
bash "run_vundle_install" do
  cwd "#{home_dir}/dotfiles"
  user node['dotfiles']['user']
  group node['dotfiles']['group']
  environment "HOME" => home_dir
  code "vim -e +BundleInstall +qall || true"
end

# setup emacs
git "#{home_dir}/.emacs.d" do
  repository 'https://github.com/ryane/.emacs.d.git'
  reference 'master'
  user node['dotfiles']['user']
  group node['dotfiles']['group']
  enable_submodules true
  action :checkout
end

# set shell to zsh
user node['dotfiles']['user'] do
  action :modify
  shell '/bin/zsh'
end
