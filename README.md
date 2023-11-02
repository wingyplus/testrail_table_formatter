# TestrailTableFormatter

My personal tool to help escape from TestRail table format hell.

## Building 

Building the escript:

```shell
$ mix escript.build
```

The `testrail_format` binary will be presented. 

## Usage

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

