# Parallax Skeleton Schema

The Skeleton Schema is the foundational schema for the Parallax framework. It provides a clean, minimal base for developing new gamemodes, schemas, or roleplaying experiences using the Parallax modular structure.

---

## 🚧 Purpose

This schema exists to:

- Serve as a starting point for custom schemas
- Demonstrate Parallax's schema structure and conventions

---

## ⚙️ Schema Definition (`sh_schema.lua`)

```lua
SCHEMA.Name = "Skeleton"
SCHEMA.Description = "A prototype schema for the Parallax framework."
SCHEMA.Author = "Riggs"

ow.util:LoadFolder("meta")
ow.util:LoadFolder("hooks")
ow.util:LoadFolder("derma")
````

This file defines basic information and loading behavior.

---

## 🧱 Getting Started

1. **Clone the repo** or copy the `parallax-skeleton` directory into your `gamemodes` folder.
2. Rename the folder and schema metadata as needed.
3. Begin adding and modifying your content: factions, items, modules, etc.
4. Start your server with `+gamemode "parallax-example"`.

---

## ✅ Features

* Clean separation of logic (client/server/shared)
* Built-in example schema file

---

## 📌 Tips

* Use the `modules` folder for optional content or features.
* Follow Parallax's formatting and documentation rules (K\&R style, LDoc compliant).

---

## 📄 License

This schema is part of the [Parallax Framework](https://github.com/Parallax-Framework) and is MIT licensed.
