# gitwho

> **gitwho** is a single‑file PowerShell CLI for quickly switching the global Git author ( `user.name` / `user.email` ) on a shared Windows machine.

---

## ✨ Features

* Interactive, colourised menu (win‑acme style).
* Marks the **current** author with `*`.
* Add new profiles in‑tool – no JSON editing required.
* Zero install: copy `gitwho.ps1` next to your repo and run `./gitwho`.
* Optional extras: add to `PATH`, or build a standalone EXE with **ps2exe**.

---

## 📦 Quick start (no install)

```powershell
# inside any folder
curl -o gitwho.ps1 https://raw.githubusercontent.com/<you>/gitwho/main/gitwho.ps1

./gitwho.ps1   # launch the menu
```

First run will create an empty profile store at:

```
C:\ProgramData\git-who\profiles.json
```

Use **A** (Add) to create your first profile.

> **Execution policy:** if PowerShell refuses to run the script, enable local scripts once per user:
>
> ```powershell
> Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
> ```

### Optional conveniences

| Why | One‑liner |
|-----|-----------|
| Run from anywhere | `Copy-Item gitwho.ps1 "$env:ProgramFiles\Git\usr\bin"` |
| Stand‑alone EXE   | `Install‑Module ps2exe -Scope CurrentUser`  → `ps2exe gitwho.ps1 gitwho.exe` |

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
