# shtash

shtash is a more convenient way to manage git stashes.

It does so by allowing you to name your stashes and keeping them independent from each other.

## Usage:

### list

`shtash list` will list the current list of available stashes:

```
$ shtash list
caching-work
hotfix
pairing-with-bob
```

### save

`shtash save` will take all your currently modified files and store them in the named stash
if a stash with that name already exists, you will be prompted to overwrite it or cancel

### replace

`shtash replace` is the same as `save` but will overwrite an existing stash without prompting

### apply

`shtash apply $name` will take the given stash by name and bring all its changes to the current work. 
