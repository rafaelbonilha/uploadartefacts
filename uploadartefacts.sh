#!/bin/bash
# Para executar o script basta executar o comando abaixo
# ./uploadartefacts.sh -u usuario -p senha -r nexusrepositoriourl
while getopts ":r:u:p:" opt; do
	case $opt in
		r) REPO_URL="http://nexus-sul.mapfre.net/repository/tronweb_test-releases/"
		;;
		u) USERNAME="admin"
		;;
		p) PASSWORD="admin"
		;;
	esac
done

find . -type f -not -path './mavenimport\.sh*' -not -path '*/\.*' -not -path '*/\^archetype\-catalog\.xml*' -not -path '*/\^maven\-metadata\-local*\.xml' -not -path '*/\^maven\-metadata\-deployment*\.xml' | sed "s|^\./||" | xargs -I '{}' curl -u "$USERNAME:$PASSWORD" -X PUT -v -T {} ${REPO_URL}/{} ;