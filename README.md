# gentoo

My Gentoo overlay

## Installation

* emerge layman

```
$ sudo emerge app-portage/layman
```

* add the repository to your local list

```
$ sudo layman -o https://raw.github.com/mdontu/gentoo/master/repositories.xml -f -a Mihai-s-Gentoo-overlay
```

You can find more information [here](https://wiki.gentoo.org/wiki/Layman).
