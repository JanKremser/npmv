# “oh my nvm!

“oh my nvm!” is an nvm wrapper for easier use of different Node.js versions. 

---

## Setup
Clone this repository and run:
```bash
cd src
./setup.sh
```

Add this line to your .bashrc file:
```bash
export PATH=$PATH:~/.local/bin/
```

### Node Example:
```bash
nodev [node_version] [node_commands]
#    ^ version is optional
```

```bash
nodev 18 ./test.js # run with node version 18

nodev ./test.js # run with current node version
```

### NPM Example:
```bash
npmv [node_version] [npm_commands]
#    ^ version is optional
```

```bash
npmv 18 run build # run with node version 18

npmv run build # run with current node version
```

### Auto install
If a version explicit is specified, it will be installed if not already present.

### with package.json
You can specify in your "package.json" which node version to use for your project.
Add the following to your "package.json":

```JSON
"engines": {
    "node": "18"
}
```
