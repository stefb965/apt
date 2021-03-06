#
# Cookbook:: apt_test
# Recipe:: cacher
#
# Copyright:: 2013-2016, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.default['apt']['cacher_dir'] = '/tmp/apt-cacher'
node.default['apt']['cacher_port'] = '9876'
node.default['apt']['cacher_interface'] = 'eth0'
node.default['apt']['cacher_client']['cacher_server'] = {
  host: 'localhost',
  port: 9876,
  proxy_ssl: true,
  cache_bypass: {
    'download.oracle.com' => 'https',
    'nginx.org' => 'https',
  },
}

include_recipe 'apt_test::base'

include_recipe 'apt::cacher-ng'
include_recipe 'apt::cacher-client'

# install a small, innocuous application to verify this works
package 'colordiff'
