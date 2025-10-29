# Career Quest - Export Guide

## Exporting the Game for Competition

The game needs to be playable on Windows 10, Mac OS, or a web browser. This guide explains how to export Career Quest using Godot Engine.

## Prerequisites

1. **Godot Engine 4.5**: Download from https://godotengine.org/download
2. **Export Templates**: Download matching templates for your Godot version
3. **Project Files**: This repository with all game files

## Opening the Project

1. Launch Godot Engine
2. Click "Import"
3. Navigate to `/rise-of-wealth/project.godot`
4. Click "Import & Edit"
5. Wait for initial import to complete

## Installing Export Templates

1. In Godot, go to **Editor → Manage Export Templates**
2. Click "Download and Install"
3. Wait for templates to download
4. Close the templates window

## Exporting for Web (HTML5) - Recommended

Web export provides maximum compatibility and ease of distribution.

### Steps:

1. Go to **Project → Export**
2. Click "Add..." and select "Web"
3. Configure export settings:
   - **Export Path**: Choose where to save (e.g., `exports/web/index.html`)
   - **Custom HTML Shell**: Use default
   - **Head Include**: Leave empty
4. Click "Export Project"
5. Choose a folder for the export
6. Name the file `index.html`
7. Click "Save"

### Testing Web Export:

You need a local web server to test HTML5 exports. Options:

**Option 1 - Python:**
```bash
cd exports/web
python3 -m http.server 8000
```
Then open http://localhost:8000 in your browser

**Option 2 - VS Code:**
Install "Live Server" extension, right-click `index.html`, select "Open with Live Server"

**Option 3 - Upload:**
Upload to any web hosting service (GitHub Pages, Netlify, etc.)

### Web Export Files:

The web export creates:
- `index.html` - Main HTML file
- `index.pck` - Game data and assets  
- `index.wasm` - WebAssembly runtime
- `index.js` - JavaScript loader

Upload all these files together.

## Exporting for Windows

### Steps:

1. Go to **Project → Export**
2. Click "Add..." and select "Windows Desktop"
3. Configure export settings:
   - **Export Path**: `exports/windows/CareerQuest.exe`
   - **Runnable**: Check ✓
   - **Embed PCK**: Check ✓ (recommended)
4. Click "Export Project"
5. Choose save location
6. Click "Save"

### Testing:
- Navigate to export folder
- Double-click `CareerQuest.exe`
- Game should launch

## Exporting for Mac

### Steps:

1. Go to **Project → Export**
2. Click "Add..." and select "Mac OSX"
3. Configure export settings:
   - **Export Path**: `exports/mac/CareerQuest.app`
   - **Code Signing**: Optional (required for distribution)
4. Click "Export Project"
5. Choose save location
6. Click "Save"

### Note:
Mac exports created on Windows/Linux may need to be re-signed or built on a Mac for full compatibility.

## For Competition Presentation

### Recommended Approach:

**Option 1 - Web Browser (Easiest):**
1. Export for Web
2. Upload to a reliable hosting service
3. Access via URL during presentation
4. Works on any device with a browser
5. No installation needed

**Option 2 - Native Application:**
1. Export for your presentation device's OS
2. Install on presentation laptop
3. Test before competition
4. Have backup device ready

**Option 3 - Direct from Godot:**
1. Bring laptop with Godot installed
2. Open project in Godot
3. Click "Play" button during presentation
4. Most reliable but requires Godot installation

## Competition Day Checklist

- [ ] Export game in chosen format
- [ ] Test export on presentation device
- [ ] Create backup on USB drive
- [ ] Test with projector connection (finals)
- [ ] Have offline version (no internet required)
- [ ] Verify all 4 careers load correctly
- [ ] Complete one full career path to test
- [ ] Check GameManager is saving progress

## Export Settings for Optimal Performance

### Recommended Settings:

**Display:**
- Resolution: 1280x720 (default)
- Window Mode: Windowed
- Stretch Mode: canvas_items (already set)

**Quality:**
- Keep current settings (already optimized)

**File Size:**
- Web export: ~10-20 MB (typical)
- Windows export: ~30-50 MB
- Mac export: ~40-60 MB

## Troubleshooting

### "Export templates not found"
- Download templates from Editor → Manage Export Templates

### "Scene could not be loaded"
- Ensure all .tscn files are included
- Check .import folder is present

### "GameManager not found"
- Verify autoload is configured in project.godot
- Check autoload path: `*res://scripts/autoload/game_manager.gd`

### Web export shows black screen
- Check browser console for errors
- Test with local server (not file:// protocol)
- Try different browser (Chrome recommended)

### Game runs slow in web browser
- Normal for first load (WebAssembly compilation)
- Should be smooth after initial load
- Test on target presentation device

## Build Script (Optional)

For automated builds, create a script:

```bash
#!/bin/bash
# build.sh - Build all export variants

GODOT="/path/to/godot"
PROJECT="/path/to/rise-of-wealth/project.godot"

# Web
$GODOT --headless --export-release "Web" "exports/web/index.html" $PROJECT

# Windows  
$GODOT --headless --export-release "Windows Desktop" "exports/windows/CareerQuest.exe" $PROJECT

# Mac
$GODOT --headless --export-release "Mac OSX" "exports/mac/CareerQuest.app" $PROJECT

echo "Exports complete!"
```

Make executable: `chmod +x build.sh`
Run: `./build.sh`

## Final Notes

- **Always test** exports before competition day
- **Have backups** on multiple devices
- **Internet not required** - game runs offline
- **No external dependencies** - completely self-contained
- **Cross-platform** - works on Windows, Mac, Web

## Support

If you encounter issues:
1. Check Godot documentation: https://docs.godotengine.org/
2. Verify all scene files are present
3. Check project.godot configuration
4. Test in Godot editor first before exporting

Good luck with your export and presentation!
