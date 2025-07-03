# MyScoop

A custom Scoop bucket for Windows. Scoop is a command-line installer for Windows, making it easy to install, update, and manage software. This repository contains custom or curated app manifests for use with Scoop.

---

## Table of Contents

- [What is Scoop?](#what-is-scoop)
- [Installation](#installation)
- [Adding This Bucket](#adding-this-bucket)
- [Basic Usage](#basic-usage)
- [Tips and Tricks](#tips-and-tricks)
- [Nuances & Best Practices](#nuances--best-practices)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [References & Further Reading](#references--further-reading)

---

## What is Scoop?

[Scoop](https://scoop.sh/) is a command-line package manager for Windows. It installs programs in user-writable directories, making management easy and avoiding permission issues. Scoop is especially great for developers and power users who want to automate or script software installations.

**Key features:**
- Installs apps without admin rights (by default).
- Manages apps in a clean, isolated directory structure.
- Supports multiple "buckets" (collections of app manifests).
- Installs portable and CLI applications, as well as some GUI apps.
- Makes updating, uninstalling, and managing dependencies simple.

---

## Installation

Open PowerShell (as your user, not as administrator) and run:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
```

> **Note:** `irm` is short for `Invoke-RestMethod`. The script will install Scoop in your user profile.

---

## Adding This Bucket

To use the apps from this repo, add the bucket:

```powershell
scoop bucket add myscoop https://github.com/Wateraga/MyScoop
```

Replace `myscoop` with your preferred bucket name if desired.

---

## Basic Usage

### Search for Apps

```powershell
scoop search <keyword>
```

### Install an App

```powershell
scoop install <app>
```

### Uninstall an App

```powershell
scoop uninstall <app>
```

### Update Scoop and All Apps

```powershell
scoop update
scoop update *
```

### List Installed Apps

```powershell
scoop list
```

### Get Info About an App

```powershell
scoop info <app>
```

---

## Tips and Tricks

- **No admin rights needed:** By default, Scoop installs to your user profile (`~/scoop`), so you don’t need admin rights unless you want to install system-wide.
- **Scoop shims:** When you install a program, Scoop creates a “shim” (shortcut) in `~/scoop/shims` and adds this folder to your `PATH`.
- **Multiple buckets:** You can add other buckets for more apps:
  ```powershell
  scoop bucket add extras
  scoop bucket add versions
  ```
- **Installing GUI apps:** Scoop can also install some GUI apps (from the `extras` bucket).
- **Checking for outdated apps:** Run `scoop status` to see which apps need updating.
- **Cache management:** To clear old downloads and free up disk space:
  ```powershell
  scoop cache rm *
  ```
- **Rollback:** If an update breaks something, rollback:
  ```powershell
  scoop rollback <app>
  ```
- **Portable versions:** Many Scoop apps are portable by default—no registry changes, so you can move or remove them easily.

---

## Nuances & Best Practices

- **Execution Policy:** You may need to set your PowerShell execution policy to allow Scoop scripts:
  ```powershell
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```
- **Proxy support:** If you’re behind a proxy, configure it:
  ```powershell
  $env:SCOOP_PROXY = 'http://proxy:port'
  ```
- **Resetting Scoop:** If you encounter issues, you can reset an app:
  ```powershell
  scoop reset <app>
  ```
- **Environment variables:** Some apps may require you to restart your shell or log out/in for environment changes to take effect.
- **System-wide installation:** For system-wide installs, run Scoop as Administrator and use the `--global` flag:
  ```powershell
  scoop install --global <app>
  ```
- **Custom manifests:** You can install directly from a manifest file:
  ```powershell
  scoop install path\to\manifest.json
  ```
- **Dependencies:** Scoop handles dependencies for most apps automatically.

---

## Troubleshooting

- **Path issues:** Make sure `~/scoop/shims` is in your `PATH`. Restart PowerShell if needed.
- **Antivirus false positives:** Some antivirus programs may flag Scoop shims or downloads; whitelist the Scoop directory if needed.
- **Corrupt installs:** Try `scoop uninstall <app>` then `scoop install <app>` again.
- **Network errors:** Check your firewall/proxy settings and run `scoop update` to refresh.

---

## Contributing

Contributions are welcome! To add or improve manifests, fork the repo and submit a pull request.

---

## References & Further Reading

- [Scoop Official Website](https://scoop.sh/)
- [How to Install and Use the Scoop Windows Package Manager](https://adamtheautomator.com/scoop-windows/)
- [How to use Scoop on Windows 11/10](https://umatechnology.org/how-to-use-scoop-package-management-tool-on-windows-11-10/)
- [CommandMasters Scoop Guide](https://commandmasters.com/commands/scoop-windows/)
- [Talent500 Scoop Guide](https://talent500.com/blog/how-to-install-and-use-the-scoop-windows-package-manager/)

---

*Created and maintained by [Wateraga](https://github.com/Wateraga)*
