# Parallax Skeleton Schema

The Skeleton Schema is the foundational schema for the Parallax framework. It provides a clean, minimal base for developing new gamemodes, schemas, or roleplaying experiences using the Parallax modular structure.

---

## 🚧 Purpose

This schema exists to:

- Serve as a starting point for custom schemas
- Demonstrate Parallax's schema structure and conventions
- Provide working examples of schema and module initialization

---

## ⚙️ Schema System

The schema system handles all startup logic:

- Loads and validates `schema/boot.lua`
- Registers global `SCHEMA` table
- Loads schema subfolders like:
  - `libraries/shared`, `libraries/server`, `libraries/client`
  - `factions/`, `classes/`, `items/`, `system/`, `ui/`, `net/`
- Loads optional config per map from `schema/config/maps/<map>.lua`
- Fires hooks: `PreInitializeSchema`, `PostInitializeSchema`, `PreInitializeMapConfig`, `PostInitializeMapConfig`

**Example `boot.lua`:**

```lua
SCHEMA.Name = "Skeleton"
SCHEMA.Description = "A prototype schema for the Parallax framework."
SCHEMA.Author = "Riggs"
```

**Example structure:**

```
gamemodes/
└── parallax-skeleton/
    ├── schema/
    │   ├── boot.lua
    │   ├── factions/
    │   ├── classes/
    │   ├── items/
    │   ├── config/
    │   └── ...
```

---

## 🧩 Module System

Parallax supports a modular structure that lets you break your schema into reusable features. Whether it's a chat system, logging framework, or UI extension — modules make your code cleaner and easier to manage.

### ✅ What Modules Support

Modules are loaded from the `/modules` folder and support two formats:

* **Folder-based modules** using a `boot.lua` file as the entry point
* **Single-file modules** with names like `sh_example.lua`, `sv_logger.lua`, or `cl_ui.lua`

When loading, the system automatically includes:

* Common logic folders like:

  * `libraries/shared`, `libraries/client`, `libraries/server`, `libraries/external`
* Core content folders:

  * `factions/`, `classes/`, `system/`, `meta/`, `hooks/`, `net/`, `languages/`, `config/`, `ui/`, `items/`, `entities/`
* Pre/Post initialization hooks:

  * `PreInitializeModules`, `PreInitializeModule`, `PostInitializeModule`, `PostInitializeModules`

---

### 📁 Folder-based Module Example

If your feature needs multiple files or folders, use a structured format like this:

```
modules/
└── logging/
    ├── boot.lua
    ├── system/
    ├── hooks/
    ├── ui/
    └── libraries/external/
```

**Example `boot.lua`:**

```lua
MODULE.Name = "Logging"
MODULE.Description = "Logs player actions and events."
MODULE.Author = "Riggs"

function MODULE:Initialized()
    ax.util:Print("Logging system is now active.")
end
```

Once placed inside `modules/`, this module is picked up automatically.

---

### 📄 Single-file Module Example

For small features, just drop a file in the `modules/` directory:

```
modules/sh_announcer.lua
```

```lua
MODULE.Name = "Announcer"
MODULE.Description = "Lets admins broadcast messages."

function MODULE:Broadcast(msg)
    for _, ply in ipairs(player.GetAll()) do
        ply:ChatPrint("[ANNOUNCEMENT] " .. msg)
    end
end
```

No folders required. Just prefix with `sh_`, `sv_`, or `cl_` depending on the file's purpose.

---

## 🧱 Getting Started

### 1. Install the Schema

Place the schema in:

```
/garrysmod/gamemodes/parallax-skeleton/
```

Or rename it to your own:

```
/garrysmod/gamemodes/parallax-your-schema/
```

Update `schema/boot.lua` to reflect your schema’s metadata.

---

### 2. Add Content

You can start expanding your schema with:

- `schema/factions/` — define Combine, Scientists, etc.
- `schema/items/` — flashlight, medkits, etc.
- `schema/classes/` — ranks, jobs, etc.
- `schema/config/maps/d1_trainstation_01.lua` — per-map logic

---

### 3. Add Modules

Modules go in `/modules/` and can include:

- A `sh_module.lua` file defining metadata and logic
- Optional folders like `ui/` and `entities/`

---

### 4. Launch Your Server

Start with:

```
+gamemode parallax-your-schema
```

Make sure the folder name matches the gamemode name.

---

## ✅ Features

- Full schema bootstrapping
- Automatic module loading
- Clean separation of logic
- Supports map-specific configuration
- Shared, client, and server folder loading

---

## 📌 Tips

- Use `ax.util:LoadFolder(path)` for bulk folder includes
- Use `ax.util:Print()` for debug logging
- All modules are registered in `ax.module.stored`

---

## 📄 License

This schema is part of the [Parallax Framework](https://github.com/Parallax-Framework) and is MIT licensed.
