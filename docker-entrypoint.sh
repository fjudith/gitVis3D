#! /bin/sh

set -e

NEO4J_SERVER=${NEO4J_SERVER:-'http://neo4j:7474'}
NEO4J_USERNAME=${NEO4J_USERNAME:-'neo4j'}
NEO4J_PASSWORD=${NEO4J_PASSWORD:-'neo4j'}

sed -i "s#bolt\:\/\/localhost#${NEO4J_SERVER}#g" routes/getdata.js
sed -i "s#\"neo4j\"\,#\"${NEO4J_USERNAME}\"\,#g" routes/getdata.js
sed -i "s#\"djdi44ss99\"#\"${NEO4J_PASSWORD}\"#g" routes/getdata.js

sed -i "s#\"http\:\/\/localhost\:7474\"#\"${NEO4J_SERVER}\"#g" cypherVis3DWebServer8080.js
sed -i "s#\"<<account\sid\sfor\sneo4j>>\"#\"${NEO4J_USERNAME}\"#g" cypherVis3DWebServer8080.js
sed -i "s#\"<<password\sfor\sneo4j>>\"#\"${NEO4J_PASSWORD}\"#g" cypherVis3DWebServer8080.js

echo "Node debug:        ${NODE_DEBUG}"
echo "Node environmnet:  ${NODE_ENV}"
echo "Working directory: $(pwd)"
echo "Executing command: $@"

exec "$@"