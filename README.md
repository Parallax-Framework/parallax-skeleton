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

The module system loads optional logic from `/modules`.

### Supports:
- Folder modules with a `sh_module.lua` file
- Single-file modules with `sh_`, `sv_`, or `cl_` prefixes
- Derma panels and entities inside each module
- Hooks: `PreInitializeModules`, `PreInitializeModule`, `PostInitializeModule`, `PostInitializeModules`

**Folder-based module:**

```
modules/
└── security/
    ├── sh_module.lua
    ├── ui/
    └── entities/
```

```lua
MODULE.Name = "Security Systems"
MODULE.Description = "Adds security terminals and cameras."
MODULE.Author = "Riggs"

function MODULE:Initialized()
    print("Security module loaded.")
end
```

**Single-file module:**

```
modules/sh_chat.lua
```

```lua
MODULE.Name = "Chat System"
MODULE.Description = "Basic announcement system."

function MODULE:Broadcast(msg)
    for _, v in ipairs(player.GetAll()) do
        v:ChatPrint("[ANNOUNCEMENT] " .. msg)
    end
end
```

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
- Use `MODULE = nil` after every module definition to avoid leaking data
- All modules are registered in `ax.module.stored`

---

## 📄 License

This schema is part of the [Parallax Framework](https://github.com/Parallax-Framework) and is MIT licensed.
