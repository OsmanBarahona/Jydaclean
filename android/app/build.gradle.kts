plugins {
    id 'com.android.application'
    id 'kotlin-android'
    // este plugin es necesario para que Firebase lea el google-services.json
    id 'com.google.gms.google-services'
}

android {
    namespace "com.example.jydaclean"
    compileSdk 34

    defaultConfig {
        applicationId "com.example.jydaclean"
        minSdk 23
        targetSdk 34
        versionCode 1
        versionName "1.0"

        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro"
        }
    }
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib:1.9.0"
    implementation 'androidx.core:core-ktx:1.12.0'
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'com.google.android.material:material:1.9.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.4'

    // Firebase BOM (maneja versiones automáticamente)
    implementation platform('com.google.firebase:firebase-bom:33.5.1')

    // Dependencias base de Firebase (elige según lo que uses)
    implementation 'com.google.firebase:firebase-analytics'
    implementation 'com.google.firebase:firebase-auth'
    implementation 'com.google.firebase:firebase-firestore'
    implementation 'com.google.firebase:firebase-storage'

    testImplementation 'junit:junit:4.13.2'
    androidTestImplementation 'androidx.test.ext:junit:1.1.5'
    androidTestImplementation 'androidx.test.espresso:espresso-core:3.5.1'
}
