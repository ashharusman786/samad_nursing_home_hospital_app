#!/bin/bash

echo "🏥 Samad Nursing Home - Flutter Android Build Script"
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

print_status "Checking Flutter doctor..."
flutter doctor

print_status "Cleaning previous builds..."
flutter clean
cd android && ./gradlew clean && cd ..

print_status "Getting dependencies..."
flutter pub get

print_status "Checking connected devices..."
flutter devices

print_status "Building APK (debug)..."
flutter build apk --debug

if [ $? -eq 0 ]; then
    print_success "Build completed successfully!"
    print_status "APK location: build/app/outputs/flutter-apk/app-debug.apk"
    
    echo ""
    print_status "To install on connected device, run:"
    echo "flutter install"
    echo ""
    print_status "To run directly on device, run:"
    echo "flutter run"
else
    print_error "Build failed! Check the error messages above."
    exit 1
fi