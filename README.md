# TestrailTableFormatter

My personal tool to help escape from TestRail table format hell.

## Building 

Building the escript:

```shell
$ mix escript.build
$ mix escript.install
```

The `testrail_format` binary will be presented. 

## Usage

### Formatting the file

The command accept the filename as a first argument:

```shell
$ cat test.tbl
|| a |b|c
||d| e   |f
$ testrail_format test.tbl
|| a | b | c
|| d | e | f

```

To edit inplace, add `-w` (or `--write`) during call the command.

### Using standard input (stdin)

This program can also support formatting code via standard input. The benefit is that 
it can integrate with the editors that pass a buffer into a program via this channel. To 
use it, add `-i` option during call a program:

```shell
$ cat test.tbl
|| a |b|c
||d| e   |f
$ testrail_format -i < test.tbl
|| a | b | c
|| d | e | f

```
