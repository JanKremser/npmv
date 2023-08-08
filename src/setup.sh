#!/bin/bash

COMMANDS_LIST=( "node" "npm" "npx" )

for (( i=0; i<${#COMMANDS_LIST[@]}; i++ ));
do
  cat <<EOF > $(pwd)/${COMMANDS_LIST[$i]}.v.sh
#!/bin/bash
$(pwd)/main.sh "${COMMANDS_LIST[$i]}" "\${*}"
EOF

  chmod +x $(pwd)/${COMMANDS_LIST[$i]}.v.sh
  ln -sf "$(pwd)/${COMMANDS_LIST[$i]}.v.sh" ~/.local/bin/${COMMANDS_LIST[$i]}v

  echo "created ${COMMANDS_LIST[$i]}v link"
done
