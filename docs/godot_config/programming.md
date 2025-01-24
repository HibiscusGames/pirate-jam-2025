# Programming setup

## Editor Config

### Set more specific types for autocompletion

This uses `StringName` and `NodePath` instead of `String` for GDScript autocompletion to enable more specific type checking and better editor integration.

1. Open Godot and go to `Editor -> Editor Settings`
2. Navigate to `Text Editor -> Completion`
3. Enable `Add String Name Literals` and `Add Node Path Literals`

![fig1.1: Set more specific types for autocompletion](.attachments/programming_fig1.1.png)

### Debug server (Optional)

This is not needed when editing GDScript files directly in Godot.

1. Open Godot and go to `Editor -> Editor Settings`
2. Navigate to `Network -> Language Server`
3. Enable `Show Native Symbols in Editor` and `Use Thread`

![fig1.2: Debug server settings](.attachments/programming_fig1.2.png)

### External IDE (Optional)

This is not needed when editing GDScript files directly in Godot.

1. Open Godot and go to `Editor -> Editor Settings`
2. Navigate to `Text Editor -> External`
3. Set `Use External Editor` to `On`, `Exec Path` to your editor of choice (ex: `codium` for VSCodium)
4. (Optional) Set `Exec Args` to what your IDE requires to open a file.

![fig1.3: External IDE settings](.attachments/programming_fig1.3.png)
