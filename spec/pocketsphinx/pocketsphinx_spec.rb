#!/usr/bin/env ruby

require 'spec_helper'

# base_vars:
#   PYTHON_VERSION_MAJOR: '3'
#   PYTHON_VERSION: '3.5'
#   GSTREAMER: '1.0'
#   USER: 'pi'
#   USER_HOME: '/home/pi'
#   LANGUAGE_ID: 1473
#   GITHUB_BRANCH: "master"
#   GITHUB_REPO_NAME: "scarlett_os"
#   GITHUB_REPO_ORG: "bossjones"
#
# virtualenv_vars:
#   MAIN_DIR: "{{ base_vars.USER_HOME }}/dev/bossjones-github/{{ base_vars.GITHUB_REPO_NAME }}"
#   VIRT_ROOT: "{{ base_vars.USER_HOME }}/.virtualenvs/{{ base_vars.GITHUB_REPO_NAME }}"
#
# build_vars:
#   PKG_CONFIG_PATH: "{{ virtualenv_vars.VIRT_ROOT }}/lib/pkgconfig"
#   LD_LIBRARY_PATH: "{{ virtualenv_vars.VIRT_ROOT }}/lib"
#   GST_PLUGIN_PATH: "{{ virtualenv_vars.VIRT_ROOT }}/lib/gstreamer-{{ base_vars.GSTREAMER }}"
#
# scarlett_vars:
#   SCARLETT_CONFIG: "{{ virtualenv_vars.MAIN_DIR }}/tests/fixtures/.scarlett"
#   SCARLETT_HMM: "{{ virtualenv_vars.MAIN_DIR }}/.virtualenvs/{{ base_vars.GITHUB_REPO_NAME }}/share/pocketsphinx/model/en-us/en-us"
#   SCARLETT_LM: "{{ virtualenv_vars.MAIN_DIR }}/tests/fixtures/lm/{{ base_vars.LANGUAGE_ID }}.lm"
#   SCARLETT_DICT: "{{ virtualenv_vars.MAIN_DIR }}/tests/fixtures/dict/{{ base_vars.LANGUAGE_ID }}.dic"

python_version = '3.5'
python_version_major = '3'
gstreamer_version = '1.0'
user = 'pi'
user_home = "/home/#{user}"
language_id = '1473'
github_ranch = 'master'
github_repo_org = 'bossjones'
repo_name = 'scarlett_os'
venv_site_pkgs_folder = "/home/#{user}/.virtualenvs/#{repo_name}/lib/python#{python_version}/site-packages"
venv_site_pkgs_pocketsphinx_folder = "/home/#{user}/.virtualenvs/#{repo_name}/lib/python#{python_version}/site-packages/pocketsphinx"
venv_site_pkgs_sphinxbase_folder = "/home/#{user}/.virtualenvs/#{repo_name}/lib/python#{python_version}/site-packages/sphinxbase"
venv_lib_pkgconfig_folder = "/home/#{user}/.virtualenvs/#{repo_name}/lib/pkgconfig"
venv_lib_folder = "/home/#{user}/.virtualenvs/#{repo_name}/lib"
venv_lib_gstreamer_folder = "/home/#{user}/.virtualenvs/#{repo_name}/lib/gstreamer-#{gstreamer_version}"

describe 'pocketsphinx_setup' do
  it "creates /home/#{user}/dev/bossjones-github/#{repo_name}/sphinxbase" do
    expect(file("/home/#{user}/dev/bossjones-github/#{repo_name}/sphinxbase")).to be_directory
    expect(file("/home/#{user}/dev/bossjones-github/#{repo_name}/sphinxbase")).to be_mode('755')
    expect(file("/home/#{user}/dev/bossjones-github/#{repo_name}/sphinxbase")).to be_owned_by user.to_s
    expect(file("/home/#{user}/dev/bossjones-github/#{repo_name}/sphinxbase")).to be_grouped_into user.to_s
  end

  it 'creates /home/#{user}/dev/bossjones-github/#{repo_name}/pocketsphinx' do
    expect(file("/home/#{user}/dev/bossjones-github/#{repo_name}/pocketsphinx")).to be_directory
    expect(file("/home/#{user}/dev/bossjones-github/#{repo_name}/pocketsphinx")).to be_mode('755')
    expect(file("/home/#{user}/dev/bossjones-github/#{repo_name}/pocketsphinx")).to be_owned_by user.to_s
    expect(file("/home/#{user}/dev/bossjones-github/#{repo_name}/pocketsphinx")).to be_grouped_into user.to_s
  end
end

describe "content of #{venv_lib_folder} directory" do
  %w(pkgconfig gstreamer-1.0).each do |pkg|
    it "expect directory #{venv_lib_folder}/#{pkg}" do
      expect(file("#{venv_lib_folder}/#{pkg}")).to be_directory
    end
  end

  %w(libpocketsphinx.a libpocketsphinx.la libpocketsphinx.so.3.0.0 libsphinxad.a libsphinxad.la libsphinxad.so.3.0.0 libsphinxbase.a libsphinxbase.la libsphinxbase.so.3.0.0).each do |pkg|
    it "expect directory #{venv_lib_folder}/#{pkg}" do
      expect(file("#{venv_lib_folder}/#{pkg}")).to exist
    end
  end

  %w(libpocketsphinx.so libpocketsphinx.so.3 libsphinxad.so libsphinxad.so.3 libsphinxbase.so libsphinxbase.so.3).each do |pkg|
    it "expect directory #{venv_lib_folder}/#{pkg}" do
      expect(file("#{venv_lib_folder}/#{pkg}")).to be_symlink
    end
  end
end

describe "content of #{venv_site_pkgs_folder} directory" do
  %w(pocketsphinx sphinxbase).each do |pkg|
    it "expect directory #{venv_site_pkgs_folder}/#{pkg}" do
      expect(file("#{venv_site_pkgs_folder}/#{pkg}")).to be_directory
    end
  end

  %w(gi).each do |pkg|
    it "expect directory #{venv_site_pkgs_folder}/#{pkg}" do
      expect(file("#{venv_site_pkgs_folder}/#{pkg}")).to be_linked_to("/usr/lib/python#{python_version}/dist-packages/#{pkg}")
    end
  end
end

# __init__.py _pocketsphinx.a _pocketsphinx.la* pocketsphinx.py _pocketsphinx.so _pocketsphinx.so.0 _pocketsphinx.so.0.0.0*

describe "content of #{venv_site_pkgs_pocketsphinx_folder} directory" do
  %w(__init__.py _pocketsphinx.a _pocketsphinx.la* pocketsphinx.py _pocketsphinx.so _pocketsphinx.so.0 _pocketsphinx.so.0.0.0*).each do |pkg|
    it "expect directory #{venv_site_pkgs_pocketsphinx_folder}/#{pkg}" do
      expect(file("#{venv_site_pkgs_pocketsphinx_folder}/#{pkg}")).to exist
    end
  end

  %w(_pocketsphinx.so _pocketsphinx.so.0).each do |pkg|
    it "expect directory #{venv_site_pkgs_pocketsphinx_folder}/#{pkg}" do
      expect(file("#{venv_site_pkgs_pocketsphinx_folder}/#{pkg}")).to be_symlink
    end
  end
end

describe "content of #{venv_site_pkgs_sphinxbase_folder} directory" do
  %w(__init__.pyo __init__.pyc __init__.py _sphinxbase.a _sphinxbase.la _sphinxbase.so.0.0.0 sphinxbase.pyo sphinxbase.pyc sphinxbase.py).each do |pkg|
    it "expect directory #{venv_site_pkgs_sphinxbase_folder}/#{pkg}" do
      expect(file("#{venv_site_pkgs_sphinxbase_folder}/#{pkg}")).to exist
    end
  end

  %w(_sphinxbase.so _sphinxbase.so.0).each do |pkg|
    it "expect directory #{venv_site_pkgs_sphinxbase_folder}/#{pkg}" do
      expect(file("#{venv_site_pkgs_sphinxbase_folder}/#{pkg}")).to be_symlink
    end
  end
end

describe "content of #{venv_lib_pkgconfig_folder} directory" do
  %w(pocketsphinx.pc sphinxbase.pc).each do |pkg|
    it "expect directory #{venv_lib_pkgconfig_folder}/#{pkg}" do
      expect(file("#{venv_lib_pkgconfig_folder}/#{pkg}")).to exist
    end
  end
end

# make sure gst-espeak plugin is compiled correctly
describe "content of #{venv_lib_gstreamer_folder} directory" do
  it "expect directory #{venv_lib_gstreamer_folder}" do
    expect(file(venv_lib_gstreamer_folder.to_s)).to be_directory
  end

  %w(libgstespeak.la libgstespeak.so libgstpocketsphinx.a libgstpocketsphinx.la libgstpocketsphinx.so).each do |pkg|
    it "expect directory #{venv_lib_gstreamer_folder}/#{pkg}" do
      expect(file("#{venv_lib_gstreamer_folder}/#{pkg}")).to exist
    end
  end
end
