# DADI Flip Vehicle Script with ox_target

A modern and lightweight FiveM script that allows players to flip overturned vehicles using any framework, ox_lib, and ox_target integration.

## 🚗 Features

- ✅ **Complete ox_target integration**: Intuitive interaction using "third-eye" system
- ✅ **Automatic detection**: Only shows option when vehicle is actually flipped
- ✅ **Safety checks**: Verifies no players inside vehicle before flipping
- ✅ **JSON configuration**: Easy customization without touching code
- ✅ **Multi-language support**: Locale system using JSON format
- ✅ **Optimized performance**: Efficient for high-population servers

## 📋 Requirements

- **FiveM Server**
- **QBox Framework** (qbx_core)
- **ox_lib** (v3.0.0 or higher)
- **ox_target** (v1.0.0 or higher)

## 🔧 Installation

1. **Download the script** and place it in your `resources` folder

2. **Add to your `server.cfg`**:
   ```cfg
   ensure dadi_flip
   ```

3. **Ensure dependencies are loaded in correct order**:
   ```cfg
   ensure ox_lib
   ensure ox_target
   ensure dadi_flip
   ```

## ⚙️ Configuration

### Configuration Parameters

| Parameter | Type | Description | Default Value |
|-----------|------|-------------|---------------|
| `flipingTime` | number | Animation duration in milliseconds | `15000` |
| `maxDistance` | number | Maximum interaction distance | `2` |
| `minFlipAngle` | number | Minimum angle to detect flipped vehicle | `75.0` |
| `allowFlipWithPlayers` | boolean | Allow flipping with players inside | `false` |
| `targetLabel` | string | Text displayed in ox_target | `"Flip Vehicle"` |
| `targetIcon` | string | FontAwesome icon for ox_target | `"fa-solid fa-car-crash"` |

## 🌐 Localization

The script supports multiple languages using JSON files. Currently available:

- 🇪🇸 **Spanish** (`es.json`)
- 🇺🇸 **English** (`en.json`)

### Adding New Languages

1. Create a new JSON file in the `locales/` folder (e.g., `fr.json`)
2. Copy the structure from existing locale files
3. Translate the values
4. Update the language loading in `client.lua`

## 🎮 Usage

### For Players
1. **Find a flipped vehicle** on the map
2. **Approach the vehicle** (within configured distance)
3. **Aim at the vehicle** with ox_target (eye/third-eye)
4. **Select "Flip Vehicle"** from the menu
5. **Wait** for the animation to complete

### For Developers

#### Available Exports

```lua
-- Modern method (recommended)
exports['your-script']:FlipVehicle(vehicleEntity, skipProgressBar)

-- Legacy method (deprecated)
exports['your-script']:flipVehicle(vehicleEntity, skipProgressBar)
```

## 🚀 How It Works

1. **Detection System**: Continuously monitors vehicle roll and pitch angles
2. **Safety Checks**: Ensures no players are inside before allowing flip
3. **ox_target Integration**: Dynamically shows/hides target option based on vehicle state
4. **Progress Bar**: Uses ox_lib progress bar with cancelable animation
5. **Notification System**: Integrated with QBox notification system

## 🔧 Advanced Configuration

### Safety Features

- **Player Detection**: Prevents flipping vehicles with players inside
- **Distance Validation**: Ensures player is close enough to interact
- **Angle Calculation**: Accurate detection of overturned vehicles
- **Resource Cleanup**: Automatically removes target options on resource stop

### Performance Optimizations

- **Conditional Targeting**: Only processes when vehicle is actually flipped
- **Efficient Calculations**: Minimal computational overhead
- **Memory Management**: Proper cleanup and resource management

## 🤝 Contributing

1. **Fork** the repository
2. **Create** a feature branch
3. **Commit** your changes
4. **Push** to the branch
5. **Create** a Pull Request

### Contribution Guidelines

- Follow existing code style
- Add comments for complex logic
- Test thoroughly before submitting
- Update documentation if needed

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🐛 Support & Issues

- **Issues**: Use GitHub Issues for bug reports
- **Feature Requests**: Use GitHub Issues with enhancement label
- **Questions**: Join our Discord community

## 💎 Credits

- **Overextended** - For ox_lib and ox_target
- **Contributors** - Thanks to all contributors

## 🔄 Changelog

### v1.0.1
- remove qbox dependence
- change notify system to ox_lib notify

### v1.0.0
- Initial release
- ox_target integration
- JSON configuration system
- Multi-language support

---

**Made with ❤️ for the FiveM community**