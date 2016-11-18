#! /bin/bash

[ -z "${MANIFEST}" ] && echo MANIFEST undefined && exit 1

eval "cat <<EOF
$(<${MANIFEST})
EOF
" >manifest.json 2>/dev/null
