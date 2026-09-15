# ivxlabs/homebrew-tap

Homebrew packages for [ivx research](https://github.com/ivxlabs) products.

```sh
brew tap ivxlabs/tap
```

## Packages

| Package | Kind | What it is |
| --- | --- | --- |
| `ivx-ai-chat` | cask | Chat UI for any LLM endpoint. No account, no backend, no telemetry |
| `ivx-bridge` | formula | Loopback CORS bridge: lets a browser reach endpoints that do not speak CORS |

### ivxai Chat

```sh
brew install --cask ivx-ai-chat
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
brew install --cask --no-quarantine ivx-ai-chat
```

### ivx-bridge

The bridge is built into ivxai Chat, so you only need this if you want the
CORS bypass on its own. It forwards to the endpoint you name and nowhere else;
`--verbose` logs one line per request — method, host, status — and never
headers or bodies.

```sh
brew install ivx-bridge
brew services start ivx-bridge   # keeps it running, and again at login
```

macOS only: the download is a universal Mach-O binary. On Linux, build the
crate from source instead.

## About the contents

Everything under `Casks/` and `Formula/` is generated. Each product repository
owns the template for its own package and pushes the rendered file here from CI
when a release is published — for the two above, that is
`packaging/homebrew/` and `.github/workflows/homebrew.yml` in
[ivxlabs/ivxai-app](https://github.com/ivxlabs/ivxai-app).

Edit the template in the product repository, not the file here, or the next
release will overwrite your change.

To add a product, have its release workflow write its own file into this repo;
nothing here needs to know about it in advance.
