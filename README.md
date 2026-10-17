# ivxlabs/homebrew-tap

Homebrew packages for [ivx research](https://github.com/ivxlabs) products.

```sh
brew tap ivxlabs/tap
```

## Packages

| Package | Kind | What it is |
| --- | --- | --- |
| `ivxai-chat` | cask | Chat UI for any LLM endpoint. No account, no backend, no telemetry |
| `ivxai-bridge` | formula | Loopback CORS bridge: lets a browser reach endpoints that do not speak CORS |
| `viper` | formula | Analysis engine for Difflicit: writes up the changes between two versions as diffmd |

### ivx/ai Chat

```sh
brew install --cask ivxai-chat
```

One page in a browser, wrapped in a native window. No account, no backend, no
analytics, no telemetry, and no third-party scripts or fonts loaded at runtime
— the release build fails CI if any third-party origin appears in the bundle.
Your chats stay on your machine, and the only outbound traffic is to the LLM
endpoint you point it at.

The build is not signed or notarised, so macOS refuses it on first launch.
Either right-click the app and choose Open, or install without the quarantine
flag in the first place:

```sh
brew install --cask --no-quarantine ivxai-chat
```

### ivxai-bridge

The bridge is built into ivx/ai Chat, so you only need this if you want the
CORS bypass on its own. It forwards to the endpoint you name and nowhere else;
`--verbose` logs one line per request — method, host, status — and never
headers or bodies.

```sh
brew install ivxai-bridge
brew services start ivxai-bridge   # keeps it running, and again at login
```

macOS only: the download is a universal Mach-O binary. On Linux, build the
crate from source instead.

### Viper

```sh
brew install viper
viper old/libfoo new/libfoo -o analysis.diffmd   # two files or folders
git diff v1.0 v1.1 | viper --patch -             # a patch you already have
```

An analysis engine for [Difflicit](https://github.com/ivxlabs/difflicit): give
it two versions of something — files, folders, binaries — and it writes up
what changed between them as diffmd, Markdown with the patches in it. It works
on its own, and Difflicit finds it on your PATH: pick **Viper** as the engine
when you Analyze. Binaries are compared function by function with radare2
(`brew install radare2`). MIT-licensed, so you can build your own engine on it.

macOS (universal) and Linux (x86-64). Docs:
[ivx.run/docs/difflicit/viper](https://ivx.run/docs/difflicit/viper/).

## About the contents

Everything under `Casks/` and `Formula/` is generated. Each product repository
owns the template for its own package and pushes the rendered file here from CI
when a release is published, from `packaging/homebrew/` and
`.github/workflows/homebrew.yml`: in
[ivxlabs/ivxai-app](https://github.com/ivxlabs/ivxai-app) for ivx/ai Chat and
the bridge, and in [ivxlabs/viper](https://github.com/ivxlabs/viper) for Viper.

Edit the template in the product repository, not the file here, or the next
release will overwrite your change.

To add a product, have its release workflow write its own file into this repo;
nothing here needs to know about it in advance.
