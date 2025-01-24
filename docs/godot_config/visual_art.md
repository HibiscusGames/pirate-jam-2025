# Visual Art

## Editor settings

### 3D Art

#### 3D Import settings

1. Open Godot and go to `Editor -> Editor Settings`
2. Navigate to `FileSystem -> Import`
3. Set the `Blender Path` to your Blender installation path.
4. (Optional) Set the RPC Port and RPC Server uptime if you've changed the default values in blender.
5. (Optional) Set the `FBX2glTF` path to your FBX2glTF installation path. But consider just using the `glTF 2.0` format instead as [recommended by Godot](https://godotengine.org/fbx-import/).

![fig1.1: 3D Import settings](.attachments/visual_art_fig1.1.png)

### 2D Art

TBD...

### Lighting

#### Open image denoise

Godot can use the Intel Open Image Denoise program to denoise lightmaps, increasing the quality of the lighting.

1. Open Godot and go to `Editor -> Editor Settings`
2. Navigate to `FileSystem -> Tools`
3. Set the `OIDN Denoise Path` to your Open Image Denoise installation path. [Get OIDN from their website](https://www.openimagedenoise.org/downloads.html)

![fig3.1: Open Image Denoise settings](.attachments/visual_art_fig3.1.png)
