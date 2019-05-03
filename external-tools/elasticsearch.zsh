# {{{ File header. #############################################################
#                                                                              #
# File informations:                                                           #
# - Name:    external-tools/elasticsearch.zsh                                  #
# - Summary: Support for elasticsearch.                                        #
# - Authors:                                                                   #
#   - Alessandro Molari <molari.alessandro@gmail.com> (alem0lars)              #
#                                                                              #
# Project informations:                                                        #
#   - Homepage:        https://github.com/alem0lars/zsh-external-tools         #
#   - Getting started: see README.md in the project root folder                #
#                                                                              #
# License: Apache v2.0 (see below)                                             #
#                                                                              #
################################################################################
#                                                                              #
# Licensed to the Apache Software Foundation (ASF) under one more contributor  #
# license agreements.  See the NOTICE file distributed with this work for      #
# additional information regarding copyright ownership. The ASF licenses this  #
# file to you under the Apache License, Version 2.0 (the "License"); you may   #
# not use this file except in compliance with the License.                     #
# You may obtain a copy of the License at                                      #
#                                                                              #
#   http://www.apache.org/licenses/LICENSE-2.0                                 #
#                                                                              #
# Unless required by applicable law or agreed to in writing, software          #
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT    #
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.             #
# See the License for the specific language governing permissions and          #
# limitations under the License.                                               #
#                                                                              #
# }}} ##########################################################################


if [ $commands[elasticsearch] ]; then

  abbrev-alias es-cluster-info="http -j GET localhost:9200/_cluster/health?pretty"
  abbrev-alias es-cluster-explain-allocation="http -j GET localhost:9200/_cluster/allocation/explain?pretty"

  abbrev-alias es-index-delete="http -j DELETE 'localhost:9200/*'"
  abbrev-alias es-index-list="http -j GET 'localhost:9200/_cat/indices/*?v&s=index'"

  abbrev-alias es-shard-list-unassigned="http -j GET localhost:9200/_cat/shards?h=index,shard,prirep,state,unassigned.reason | grep UNASSIGNED"

  abbrev-alias es-snapshotrepo-create="http -j PUT localhost:9200/_snapshot/my-snapshot-repo type=fs settings={\"location\": \"/my/repo/snapshot/location\"}"
  abbrev-alias es-snapshot-create="http -j PUT localhost:9200/_snapshot/my-snapshot-repo/snapshot=`date +%s`?wait_for_completion=true"

fi


# vim: set filetype=zsh :
