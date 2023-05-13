# Sphere

Sphere is a browser proxy application, that can register different handlers for http/https URI schemes, similar to how [Android apps can register to be the default app for just specific https URLs](https://developer.android.com/guide/topics/manifest/data-element#path) with `android:pathAdvancedPattern`.

It works by registering sphere as the default browser, which just acts as a proxy that delegates to the correct final application via rules given in a configuration file.

The configuration file is located at `~/.config/sphere/config` and has a very simple syntax `<rule_regex> <handler>`. The file is parsed from top to bottom and the first line where `<rule_regex>` matches the given URL, will cause the corresponding `<handler>` to be executed.

# Example

The following example will configure Chromium as the default browser, while opening Spotify links directly in the [Spotify desktop application](https://github.com/kpcyrd/spotify-launcher):

```
^https://open.spotify.com/(artist|album|track|search)/[[:alnum:]]+\??.*$ spotify-launcher
.* chromium
```

Note that the rules are tried from top to bottom, so the default browser should usually come last with a Regex that matches everything.

# Installation

Arch Linux users can simply install the [sphere-git](https://aur.archlinux.org/packages/sphere-git) package.

To build from source, clone the repo and run:

```bash
cabal build
cabal install
```
