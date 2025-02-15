### Settings

Add this repo as a **pluginrepos** option in the **~/.config/micro/settings.json** file (it is necessary to restart the micro after this change):

```json
{
	"pluginrepos": [
		"https://notabug.org/dustdfg/micro-mdtree/raw/master/repo.json"
	]
}
```

### Install

In your micro editor press **Ctrl-e** and run command:

```
> plugin install mdtree
```

or run in your shell

```sh
micro -plugin install mdtree
```


### License

License under **MIT** license
