# Android Device Setup Guide for Samad Nursing Home App

## Prerequisites
- Android device with Android 5.0 (API level 21) or higher
- USB cable for device connection
- Flutter SDK installed on your computer

## Step 1: Enable Developer Options

1. **Open Settings** on your Android device
2. **Scroll down** and tap on **"About phone"** or **"About device"**
3. **Find "Build number"** (may be under "Software information")
4. **Tap "Build number" 7 times** quickly
5. You'll see a message saying **"You are now a developer!"**

## Step 2: Enable USB Debugging

1. **Go back** to main Settings
2. **Look for "Developer options"** (usually near the bottom)
3. **Tap on "Developer options"**
4. **Find "USB debugging"** and **toggle it ON**
5. **Accept** the warning dialog that appears

## Step 3: Connect Your Device

1. **Connect** your Android device to your computer using a USB cable
2. **Select "File Transfer" or "MTP"** when prompted on your device
3. **Allow USB debugging** when the popup appears on your device
4. **Check "Always allow from this computer"** for future connections

## Step 4: Verify Connection

Open terminal/command prompt and run:
```bash
flutter devices
```

You should see your device listed. Example output:
```
Android SDK built for x86 • emulator-5554 • android-x86    • Android 10 (API 29) (emulator)
SM G973F                  • RZ8M802WY0X   • android-arm64  • Android 11 (API 30)
```

## Step 5: Run the App

### Option A: Direct Run (Recommended)
```bash
flutter run
```

### Option B: Build and Install APK
```bash
# Build debug APK
flutter build apk --debug

# Install on connected device
flutter install
```

### Option C: Use the Build Script
```bash
./build_and_run.sh
```

## Troubleshooting

### Device Not Detected
- **Try different USB cable** (some cables are charge-only)
- **Try different USB port** on your computer
- **Restart ADB**: `flutter doctor` then try again
- **Revoke USB debugging authorizations** in Developer Options, then reconnect

### Build Errors
- **Run flutter clean**: `flutter clean && flutter pub get`
- **Check Flutter doctor**: `flutter doctor -v`
- **Update Flutter**: `flutter upgrade`

### App Crashes on Launch
- **Check device logs**: `flutter logs`
- **Ensure device has enough storage** (at least 100MB free)
- **Close other apps** to free up memory

### Permission Issues
- **Grant all requested permissions** when the app first launches
- **Check app permissions** in device Settings > Apps > Samad Nursing Home

## Expected App Behavior

### First Launch
1. **Landing page** with hospital logo and welcome message
2. **Language toggle** (English/Hindi) in top right
3. **"Get Started" button** with glow animation

### After Login (Demo Mode)
1. **Bottom navigation** with 4 tabs: Home, Doctors, Services, Profile
2. **Glass morphism design** with blue gradient background
3. **Smooth animations** throughout the app

### Key Features to Test
- ✅ **Navigation** between tabs
- ✅ **Language switching** (EN ⟷ Hindi)
- ✅ **Appointment booking** (opens WhatsApp)
- ✅ **Profile editing** and data persistence
- ✅ **Responsive design** on your device screen

## Performance Tips

- **Close background apps** for better performance
- **Ensure stable internet connection** for Google Fonts
- **Allow location access** if prompted (for better user experience)
- **Keep device charged** during testing

## Next Steps After Successful Installation

1. **Test all navigation flows**
2. **Try appointment booking** (will open WhatsApp)
3. **Switch languages** to test localization
4. **Edit profile** to test data persistence
5. **Check responsive design** by rotating device

If you encounter any issues, check the logs with `flutter logs` and refer to the troubleshooting section above.