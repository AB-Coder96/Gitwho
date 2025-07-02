# gitwho – Git Author Manager

`gitwho.ps1` is a tiny, self‑contained PowerShell script that lets you **switch the global Git author (user.name / user.email)** on any Windows box that multiple developers share.

---

## ✨ Features

* Simple interactive menu with colour highlighting.
* Marks the **currently active** author with `*`.
* Add new profiles from within the tool – no manual JSON edits.
* Zero install: **copy the script into your repo and run `./gitwho.ps1`.**
* Profiles stored system‑wide in `C:\ProgramData\git-who\profiles.json` so every repo & shell sees the same list.

---

## Quick start

```powershell
# inside your project folder
curl -o gitwho.ps1 https://raw.githubusercontent.com/<you>/gitwho/main/gitwho.ps1

./gitwho.ps1      # launch the menu
```

On first run the tool creates an empty profile store. Use **A** (Add) to create your first profile; the author is immediately switched.

> **Note:** if PowerShell blocks the script, set your execution policy once:
>
> ```powershell
> Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
> ```

---

## Command reference

| Command | What it does |
|---------|--------------|
| `gitwho` | Interactive menu (Select / Add / Quit) |
| `gitwho alice` | Fast‑switch to profile `alice` |
| `gitwho -List` | List all profiles and highlight the active one |

Selecting a profile runs:

```powershell
git config --global user.name  "<Name>"
git config --global user.email "<Email>"
```

so every subsequent commit uses that identity until you switch again.

---

## Profile file format

```json
{
  "alice": { "name": "Alice Smith", "email": "alice@example.com" },
  "bob"  : { "name": "Bob Chen",   "email": "bob@example.com"   }
}
```

The file is created and maintained automatically by the script. You can edit it manually if you like, just keep the structure.

---

## License

MIT – see **LICENSE** for details.

---

## Contributing

Issues and PRs are welcome. Please keep the script dependency‑free so it remains a single‑file drop‑in tool.
