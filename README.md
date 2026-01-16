# 🌱 COCOA-SENSE

Aplikasi monitoring dan deteksi buah kakao berbasis IoT dan AI untuk meningkatkan produktivitas perkebunan kakao.

## 📱 Status Fitur

### ✅ Fitur yang Sudah Berfungsi Penuh

#### 1. **Splash Screen**
- Animasi fade & scale logo
- Auto navigate ke Welcome Screen (3 detik)
- Loading indicator

#### 2. **Welcome Screen**
- Rotated logo container dengan gradient
- Deskripsi aplikasi
- Tombol "Mulai Aplikasi" navigasi ke Main Screen

#### 3. **Home Dashboard**
- Status kebun (nama, jumlah pohon, buah, kesehatan)
- Info capaian panen dan HOK terpakai
- Card deteksi AI
- Sensor realtime (suhu udara dengan chart)
- **3 Deteksi Terkini** dengan preview image dan status
- AppBar dengan logo dan notifikasi

#### 4. **Google Maps**
- Integrasi Google Maps
- GPS tracking realtime
- Animated marker movement (smooth transition)
- Accuracy circle
- Share location via WhatsApp
- Open in Google Maps
- Draggable bottom sheet dengan info lokasi

#### 5. **Camera Scanner**
- Live camera preview
- Permission handling (camera)
- Capture photo langsung dari preview
- Pick image from gallery
- Flash toggle (on/off)
- Animated scanning line
- Corner frame indicators

#### 6. **Photo Result Screen**
- Preview foto fullscreen
- Tombol retake (foto ulang)
- Tombol analisis AI (navigasi ke loading screen)
- Tombol simpan ke galeri (placeholder)

#### 7. **AI Detection (Gemini AI) ✨ NEW**
- **Loading Screen** dengan Lottie animation
- 6-step progress indicator dengan estimasi waktu
- Integrasi **Google Gemini 2.0 Flash**
- Deteksi status buah (Sehat/Sakit)
- Identifikasi penyakit kakao
- Analisis kematangan buah
- Penilaian kualitas
- Rekomendasi treatment
- Confidence score
- Auto-save ke history

#### 8. **Detection History ✨ NEW**
- List semua riwayat deteksi
- Detail view per deteksi
- Delete individual/all history
- Pull-to-refresh
- Local storage dengan SharedPreferences
- Max 50 history items
- Floating Action Button dengan Lottie animation
- Recent detection card di home (3 terbaru)

#### 9. **IoT Monitoring**
- Dashboard monitoring sistem
- Real-time sensor data (pH tanah, intensitas cahaya)
- Auto-update data setiap 3 detik
- Status sensor list
- Quick actions (refresh, export, analytics)
- AppBar konsisten dengan Home

#### 10. **Profile Screen**
- Header dengan foto profil
- Info user (nama, fakultas, program)
- Statistik (scan count, land count, level)
- Menu list (pengaturan, bantuan, dll)
- AppBar dengan logo dan notifikasi

#### 11. **Navigation**
- Bottom Navigation Bar dengan 5 tabs
- Floating Action Button (Camera) di tengah
- History FAB di kanan bawah
- Rounded top corners
- GetX routing

### ⏳ Fitur yang Belum Berfungsi (Placeholder)

#### 1. **IoT Integration**
- Koneksi ke sensor fisik
- Real-time data dari hardware
- *Status: Menggunakan dummy data, perlu API backend*

#### 2. **Data Export**
- Export data sensor ke CSV/Excel
- *Status: Button ready, perlu implementasi*

#### 3. **Save to Gallery**
- Simpan foto hasil capture ke galeri
- *Status: Button ready, perlu implementasi*

#### 4. **User Authentication**
- Login/Register
- Profile management
- *Status: Menggunakan data static*

#### 5. **Notifications**
- Push notifications
- Alert sistem
- *Status: Icon ready, belum diimplementasi*

## 🛠️ Tech Stack

### Framework & State Management
- **Flutter**: 3.8.1+
- **Dart SDK**: 3.8.1+
- **GetX**: 4.6.6 (State Management & Routing)

### AI & Animation
- **google_generative_ai**: 0.2.2 - Gemini AI integration
- **lottie**: 3.1.0 - Lottie animations
- **http**: 1.1.0 - HTTP requests

### Dependencies (Implemented)
- **google_maps_flutter**: 2.5.0 - Maps integration
- **geolocator**: 10.1.0 - GPS location
- **permission_handler**: 11.0.1 - Runtime permissions
- **camera**: 0.10.5+5 - Camera access
- **image_picker**: 1.0.4 - Gallery picker
- **share_plus**: 7.2.1 - Share functionality
- **url_launcher**: 6.2.2 - Open external URLs
- **shared_preferences**: 2.2.2 - Local storage
- **intl**: 0.18.1 - Date formatting

### Dependencies (Declared, Not Implemented)
- **dio**: 5.4.0 - HTTP client
- **connectivity_plus**: 5.0.2 - Network status

## 📁 Project Structure

```
lib/
├── controllers/              # GetX Controllers
│   ├── camera_controller.dart
│   ├── main_controller.dart
│   ├── map_controller.dart
│   ├── monitoring_controller.dart
│   └── detection_history_controller.dart  # NEW
├── models/                   # Data Models
│   └── detection_result.dart             # NEW
├── services/                 # Services
│   ├── gemini_ai_service.dart            # NEW
│   └── detection_history_service.dart    # NEW
├── routes/                   # App Routes
│   └── app_routes.dart
├── screen/                   # UI Screens
│   ├── splash_screen.dart
│   ├── welcome_screen.dart
│   ├── main_screen.dart
│   ├── home_screen.dart
│   ├── map_screen.dart
│   ├── camera_scan_screen.dart
│   ├── photo_result_screen.dart
│   ├── ai_detection_loading_screen.dart  # NEW
│   ├── ai_result_screen.dart             # NEW
│   ├── detection_history_screen.dart     # NEW
│   ├── detection_detail_screen.dart      # NEW
│   ├── monitoring_screen.dart
│   ├── profile_screen.dart
│   └── widget/              # Reusable Widgets
│       ├── card/
│       │   ├── recent_detection_card.dart  # NEW
│       │   └── ...
│       ├── ai_loading_dialog.dart          # NEW
│       ├── history_floating_button.dart    # NEW
│       ├── map_screen_helpers.dart
│       ├── monitoring_widgets.dart
│       └── profile_*.dart
└── main.dart                # Entry Point
```

## 🚀 Setup & Installation

### Prerequisites
- Flutter SDK 3.8.1 or higher
- Dart SDK 3.8.1 or higher
- Android Studio / VS Code
- Android SDK (untuk Android)
- Xcode (untuk iOS)
- Physical Device atau Emulator
- **Google Gemini API Key** (untuk AI detection)

### Step-by-Step Installation

#### 1. Clone Repository
```bash
git clone https://github.com/YOUR_USERNAME/cocoa_sense.git
cd cocoa_sense
```

#### 2. Install Dependencies
```bash
flutter pub get
```

#### 3. Setup Google Gemini API Key ✨

**Cara Mendapatkan API Key:**

1. **Buka Google AI Studio**
   - Kunjungi: https://aistudio.google.com/app/apikey
   - Login dengan akun Google Anda

2. **Create API Key**
   - Klik tombol **"Create API Key"**
   - Pilih project Google Cloud (atau buat baru)
   - Copy API Key yang dihasilkan

3. **Tambahkan ke Aplikasi**
   
   Edit file `lib/services/gemini_ai_service.dart`:
   ```dart
   class GeminiAIService {
     static const String _apiKey = 'YOUR_GEMINI_API_KEY_HERE'; // Ganti dengan API key Anda
     // ...
   }
   ```

**Catatan Penting:**
- API Key Gemini **GRATIS** untuk penggunaan personal
- Rate limit: 60 requests per minute
- Jangan commit API key ke repository public
- Untuk production, gunakan environment variables

**Alternatif (Environment Variables):**
```dart
// Gunakan flutter_dotenv atau environment variables
static const String _apiKey = String.fromEnvironment('GEMINI_API_KEY');
```

#### 4. Setup Google Maps API Key

**Dapatkan API Key:**
1. Buka [Google Cloud Console](https://console.cloud.google.com/)
2. Buat project baru atau pilih existing project
3. Enable **Maps SDK for Android** dan **Maps SDK for iOS**
4. Buat credentials (API Key)
5. (Optional) Restrict API key untuk keamanan

**Android Setup:**

Edit `android/app/src/main/AndroidManifest.xml`:
```xml
<application>
    <meta-data
        android:name="com.google.android.geo.API_KEY"
        android:value="YOUR_GOOGLE_MAPS_API_KEY_HERE"/>
</application>
```

**iOS Setup:**

Edit `ios/Runner/AppDelegate.swift`:
```swift
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("YOUR_GOOGLE_MAPS_API_KEY_HERE")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

#### 5. Add Assets

Pastikan assets ada di folder yang benar:
```
assets/
├── OIP.png                    # Logo aplikasi
└── animations/
    ├── AI.json                # Lottie animation untuk AI loading
    └── History.json           # Lottie animation untuk history FAB
```

#### 6. Verify Permissions

**Android** - `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera" android:required="false" />
```

**iOS** - `ios/Runner/Info.plist`:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Aplikasi memerlukan akses lokasi untuk fitur peta</string>
<key>NSCameraUsageDescription</key>
<string>Aplikasi memerlukan akses kamera untuk scan buah kakao</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Aplikasi memerlukan akses galeri untuk memilih foto</string>
```

#### 7. Run Application

```bash
# Check connected devices
flutter devices

# Run on connected device
flutter run

# Run in release mode
flutter run --release
```

## 🎮 Alur Aplikasi (User Flow)

```
┌─────────────────┐
│  Splash Screen  │ (3 detik, auto navigate)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Welcome Screen  │ (Tombol "Mulai Aplikasi")
└────────┬────────┘
         │
         ▼
┌──────────────────────────────────────────────────────┐
│              Main Screen (Bottom Nav)                │
│  ┌──────────────────────────────────────────────┐   │
│  │  Home: 3 Recent Detections + Sensor Data    │   │
│  └──────────────────────────────────────────────┘   │
├─────────┬─────────┬─────────┬──────────────┬────────┤
│  Home   │   Map   │ Camera  │  Monitoring  │ Profile│
│         │         │  (FAB)  │              │        │
└─────────┴─────────┴────┬────┴──────────────┴────────┘
                         │
                         ▼
              ┌──────────────────────┐
              │  Camera Scan Screen  │
              │  - Live Preview      │
              │  - Capture Photo     │
              │  - Pick from Gallery │
              └──────────┬───────────┘
                         │
                         ▼
              ┌──────────────────────┐
              │ Photo Result Screen  │
              │  - Preview           │
              │  - Retake            │
              │  - [Analisis AI]     │◄─── Klik ini
              └──────────┬───────────┘
                         │
                         ▼
              ┌──────────────────────────┐
              │ AI Detection Loading     │
              │  - Lottie Animation      │
              │  - 6 Step Progress       │
              │  - Gemini AI Processing  │
              │  - ~5-7 seconds          │
              └──────────┬───────────────┘
                         │
                         ▼
              ┌──────────────────────────┐
              │   AI Result Screen       │
              │  - Status (Sehat/Sakit)  │
              │  - Confidence Score      │
              │  - Disease Detection     │
              │  - Ripeness Analysis     │
              │  - Quality Assessment    │
              │  - Recommendations       │
              │  - Auto-save to History  │
              └──────────┬───────────────┘
                         │
                         ├─► [Scan Ulang] → Camera
                         └─► [Ke Beranda] → Home

┌──────────────────────────────────────────────────────┐
│           History Floating Button (FAB)              │
│  - Positioned: bottom-right                          │
│  - Lottie animation                                  │
│  - Click → Detection History Screen                  │
└──────────────────────────────────────────────────────┘
                         │
                         ▼
              ┌──────────────────────────┐
              │ Detection History Screen │
              │  - List all detections   │
              │  - Pull to refresh       │
              │  - Delete individual     │
              │  - Delete all            │
              │  - Click item → Detail   │
              └──────────┬───────────────┘
                         │
                         ▼
              ┌──────────────────────────┐
              │ Detection Detail Screen  │
              │  - Full image preview    │
              │  - Complete analysis     │
              │  - All recommendations   │
              │  - Timestamp             │
              └──────────────────────────┘
```

### Detail Flow per Fitur:

#### 1. **AI Detection Flow** ✨
```
Camera → Capture/Pick → Photo Result → [Analisis AI]
   ↓
AI Loading Screen (5-7s)
   ├─ Step 1: Memproses gambar (0.8s)
   ├─ Step 2: Gemini analyzing (1.5s)
   ├─ Step 3: Detecting condition (1.2s)
   ├─ Step 4: Identifying disease (1.0s)
   ├─ Step 5: Analyzing ripeness (0.8s)
   └─ Step 6: Finalizing (0.4s)
   ↓
AI Result Screen
   ├─ Status: Sehat/Sakit/Error
   ├─ Confidence: 0-100%
   ├─ Disease: Nama penyakit (jika ada)
   ├─ Ripeness: Mentah/Setengah Matang/Matang/Terlalu Matang
   ├─ Quality: Baik/Sedang/Buruk
   └─ Recommendations: List saran treatment
   ↓
Auto-save to History (max 50 items)
```

#### 2. **History Management Flow** ✨
```
Home Screen
   ├─ Recent Detection Card (3 terbaru)
   │    └─ Click → Detection Detail Screen (direct)
   │
   └─ History FAB (bottom-right)
        └─ Click → Detection History Screen
             ├─ View all history
             ├─ Pull to refresh
             ├─ Delete individual (swipe/icon)
             ├─ Delete all (top-right icon)
             └─ Click item → Detection Detail Screen
```

#### 3. **Camera Flow**
- Tap FAB Camera → Request permission → Camera preview
- Capture photo → Photo Result Screen
- Pick gallery → Photo Result Screen
- Photo Result: Analisis AI / Retake

#### 4. **Map Flow**
- Auto request location permission
- Show current location dengan animated marker
- Bottom sheet: Info lokasi, Share, Open in Google Maps

#### 5. **Monitoring Flow**
- Auto-update sensor data setiap 3 detik
- Refresh manual, Export data, View analytics

## 🤖 Gemini AI Detection Details

### Model Information
- **Model**: Gemini 2.0 Flash Experimental
- **Provider**: Google AI
- **Response Format**: JSON
- **Timeout**: 30 seconds
- **Max Retries**: 1

### Detection Capabilities
1. **Status Detection**
   - Sehat (Healthy)
   - Sakit (Diseased)
   - Error (Invalid image)

2. **Disease Identification**
   - Black Pod Disease
   - Vascular Streak Dieback
   - Cocoa Pod Borer
   - Phytophthora
   - Dan penyakit lainnya

3. **Ripeness Analysis**
   - Mentah (Unripe)
   - Setengah Matang (Half-ripe)
   - Matang (Ripe)
   - Terlalu Matang (Overripe)

4. **Quality Assessment**
   - Baik (Good)
   - Sedang (Medium)
   - Buruk (Poor)

5. **Recommendations**
   - Treatment suggestions
   - Preventive measures
   - Harvesting advice

### API Response Example
```json
{
  "status": "Sakit",
  "confidence": 87.5,
  "disease": "Black Pod Disease",
  "ripeness": "Setengah Matang",
  "quality": "Sedang",
  "recommendations": [
    "Segera pisahkan buah yang terinfeksi",
    "Aplikasikan fungisida berbahan tembaga",
    "Tingkatkan drainase kebun"
  ]
}
```

## 🔧 Troubleshooting

### AI Detection Error
1. **"Gagal menganalisis"**
   - Pastikan API Key Gemini sudah benar
   - Check koneksi internet
   - Pastikan image file valid

2. **"Timeout"**
   - Koneksi internet lambat
   - Coba lagi dengan koneksi lebih stabil
   - Reduce image size jika terlalu besar

3. **"Invalid API Key"**
   - Verifikasi API key di `gemini_ai_service.dart`
   - Pastikan API key aktif di Google AI Studio
   - Check rate limit (60 req/min)

### Camera tidak muncul / Loading terus
1. Pastikan permission CAMERA sudah ditambahkan di AndroidManifest.xml
2. Uninstall app dari device
3. Run ulang: `flutter run`
4. Allow permission saat diminta

### Google Maps tidak muncul
1. Pastikan API Key sudah benar
2. Enable Maps SDK for Android/iOS di Google Cloud Console
3. Check billing account aktif
4. Restart app

### Lottie Animation tidak muncul
1. Pastikan file `AI.json` dan `History.json` ada di `assets/animations/`
2. Check `pubspec.yaml` sudah include assets
3. Run `flutter pub get`
4. Restart app

### History tidak tersimpan
1. Check SharedPreferences permission
2. Clear app data dan coba lagi
3. Check storage space device

### Build error
```bash
flutter clean
flutter pub get
flutter run
```

## 📦 Build APK untuk Production

### Build APK (Android)

#### 1. Build APK Standard
```bash
flutter build apk
```
Hasil: `build/app/outputs/flutter-apk/app-release.apk`

#### 2. Build APK Split per ABI (Ukuran lebih kecil)
```bash
flutter build apk --split-per-abi
```
Hasil:
- `app-armeabi-v7a-release.apk` (ARM 32-bit)
- `app-arm64-v8a-release.apk` (ARM 64-bit)
- `app-x86_64-release.apk` (x86 64-bit)

#### 3. Build APK dengan Obfuscation (Keamanan)
```bash
flutter build apk --obfuscate --split-debug-info=build/app/outputs/symbols
```

### Checklist Sebelum Build Production

- [ ] Update version di `pubspec.yaml` (version: 1.0.0+1)
- [ ] **Ganti Gemini API Key dengan production key**
- [ ] Pastikan Google Maps API Key sudah benar
- [ ] Test semua fitur di release mode: `flutter run --release`
- [ ] Test AI detection dengan berbagai kondisi
- [ ] Test history save/load/delete
- [ ] Remove debug code dan print statements
- [ ] Update app icon di `android/app/src/main/res/mipmap-*/`
- [ ] Update app name di `android/app/src/main/AndroidManifest.xml`
- [ ] Check permissions di AndroidManifest.xml
- [ ] Build dan test APK sebelum distribute

## 🚧 Roadmap / TODO

### Completed ✅
- [x] Integrasi Gemini AI untuk deteksi buah kakao
- [x] Detection history dengan local storage
- [x] Recent detection card di home
- [x] Lottie animations untuk loading & FAB
- [x] Complete AI result screen dengan recommendations

### High Priority
- [ ] Backend API untuk sync history ke cloud
- [ ] Implementasi save to gallery
- [ ] User authentication (login/register)
- [ ] Offline mode untuk AI (TensorFlow Lite)

### Medium Priority
- [ ] Export detection history ke PDF/Excel
- [ ] Push notifications untuk reminder
- [ ] Multi-language support (EN/ID)
- [ ] Dark mode

### Low Priority
- [ ] Tutorial/onboarding
- [ ] Analytics dashboard
- [ ] Report generation
- [ ] Social sharing features

## 🤝 Contributing

1. Fork the project
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License.

## 👥 Team

**IPB University 2026**
- Fakultas Pertanian
- Program Studi Agronomi

## 📞 Contact

For questions or support, please contact:
- Email: nagarasatria104@gmail.com
- No Telp : 082116927632

## 🙏 Acknowledgments

- **Google Gemini AI** - For powerful AI detection capabilities
- **Lottie Files** - For beautiful animations
- **Flutter Community** - For amazing packages and support

---

**Version:** 1.0.0  
**Status:** Production Ready (AI Integrated) ✅  
**Last Updated:** January 2025  
**Flutter Version:** 3.8.1+  
**Minimum SDK:** Android 21+ / iOS 12+  
**AI Model:** Gemini 2.0 Flash Experimental
