# gitwho

> **gitwho** is a single‑file PowerShell CLI for quickly switching the global Git author ( `user.name` / `user.email` ) on a shared Windows machine.

---

## ✨ Features

* Interactive, colourised menu.
* Marks the **current** author with `*`.
* Add new profiles in‑tool – no JSON editing required.
* Zero install: copy `gitwho.ps1` next to your repo and run `./gitwho`.
* Optional extras: add to `PATH`, or build a standalone EXE with **ps2exe**.

---

## 📦 Quick start

Copy **gitwho.ps1** into any Git repository (or a folder already on your `PATH`) and run:

```powershell
./gitwho.ps1
```

The first run creates `C:\ProgramData\git-who\profiles.json`. Use **A** (Add) in the menu to add profiles.

> **Execution policy** – if PowerShell blocks the script:
> ```powershell
> Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
> ```

---

## 🚀 Usage

| Command | What it does |
|---------|--------------|
| `gitwho` | Interactive menu (Select / Add / Quit) |
| `gitwho alice` | Fast‑switch to profile `alice` |
| `gitwho -List` | Show all profiles and highlight the active one |

When you select or switch, the tool runs:

```powershell
git config --global user.name  "<Name>"
git config --global user.email "<Email>"
```

so every commit you make after that carries the chosen identity.

---

## 🗄 Profile store format

```json
{
  "alice": { "name": "Alice Smith", "email": "alice@example.com" },
  "bob"  : { "name": "Bob Chen",   "email": "bob@example.com"   }
}
```

The file is created automatically; you rarely need to touch it.

---

## 📝 License

MIT – see **LICENSE**.

---

## 🤝 Contributing

PRs welcome! Please keep new dependencies to a minimum so the script stays drop‑in simple.
