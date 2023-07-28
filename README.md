# npmv

nvm wrapper

---

```bash
npmv [node_version] [npm_commands]
#    ^ version is optional
```

### Example:
```bash
npmv 18 run build # run with node version 18

npmv run build # run with current node version
```

### Auto install
If a version explicit is specified, it will be installed if not already present.

#### with package.json

You can specify in your "package.json" which node version to use for your project.
Add the following to your "package.json":

```JSON
"engines": {
    "node": "18"
}
```
