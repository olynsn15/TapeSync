# TapeSync 📼
### Final Project Mobile Cloud Computing LAB

**TapeSync** is a Flutter-based mobile application that allows users to explore and purchase movies. Users can browse a wide selection of films based on genre, view detailed information about each movie, and purchase their favorite titles—all in one place.
<br><br>

## Features
- **Secure user authentication with login and registration functionality**, implemented using JWT tokens for safe and reliable session management
- **Browse movies by genre** (Action, Comedy, Romance, Horror, Thriller, Family, and more)  
- **Detailed movie pages** showing rating, synopsis, and price  
- **Shopping cart and basket management** to add, update, or remove movie selections      
- **Admin dashboard** for managing movies shown to user's page 
- Built with **Flutter (Dart)** for the frontend, **Node.js + MySQL** for the backend  
- Designed for a **seamless, mobile-first user experience**  
<br><br>

## Tech Stack
![MySQL](https://img.shields.io/badge/MySQL-4479A1?logo=mysql&logoColor=fff)
![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=fff)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?logo=dart&logoColor=white)
<br><br>

## Project Structure
```
Kelompok 3 - Project MCC/
├── .DS_Store
├── app_movies/
│   ├── .gitignore
│   ├── .metadata
│   ├── analysis_options.yaml
│   ├── android/
│   ├── ios/
│   ├── lib/
│   │   ├── api/
│   │   │   └── api.dart
│   │   ├── components/
│   │   │   ├── button.dart
│   │   │   ├── card_list_item.dart
│   │   │   ├── card_list_user.dart
│   │   │   ├── checkout_total.dart
│   │   │   ├── list_card_basket.dart
│   │   │   ├── outlined_text.dart
│   │   │   ├── payment_options.dart
│   │   │   ├── popup_form.dart
│   │   │   ├── product_card.dart
│   │   │   ├── square_title.dart
│   │   │   ├── summary_card.dart
│   │   │   ├── textfields.dart
│   │   │   └── video_card_widget.dart
│   │   ├── Genres/
│   │   │   ├── action.dart
│   │   │   ├── all_movies.dart
│   │   │   ├── comedy.dart
│   │   │   ├── family_movies.dart
│   │   │   ├── horror.dart
│   │   │   ├── romance.dart
│   │   │   └── thriller.dart
│   │   ├── helper/
│   │   │   ├── auth_service.dart
│   │   │   └── toast.dart
│   │   ├── main.dart
│   │   ├── models/
│   │   │   ├── admin.dart
│   │   │   ├── googleAPI.dart
│   │   │   ├── purchase.dart
│   │   │   ├── tapes.dart
│   │   │   └── user.dart
│   │   ├── pages/
│   │   │   ├── admin_page.dart
│   │   │   ├── basket_page.dart
│   │   │   ├── cart_tapes.dart
│   │   │   ├── checkout_page.dart
│   │   │   ├── detail_checkout.dart
│   │   │   ├── detail_page.dart
│   │   │   ├── home_page.dart
│   │   │   ├── insert_admin.dart
│   │   │   ├── insert_product.dart
│   │   │   ├── login_page.dart
│   │   │   ├── main_page.dart
│   │   │   ├── payment.dart
│   │   │   ├── register_page.dart
│   │   │   ├── thankyou_card.dart
│   │   │   └── welcome_page.dart
│   │   └── shared/
│   │       └── theme.dart
│   ├── linux/
│   ├── macos/
│   ├── package-lock.json
│   ├── package.json
│   ├── pubspec.lock
│   ├── pubspec.yaml
│   ├── README.md
│   ├── test/
│   │   └── widget_test.dart
│   ├── web/
│   └── windows/
├── app_tape_backend/
│   ├── .DS_Store
│   ├── .env
│   ├── app.js
│   ├── assets/
│   │   ├── .DS_Store
│   ├── bin/
│   │   └── www
│   ├── database/
│   │   └── connection.js
│   ├── package-lock.json
│   ├── package.json
│   ├── public/
│   │   ├── .DS_Store
│   │   ├── index.html
│   │   └── stylesheets/
│   │       └── style.css
│   └── routes/
│       ├── admin.js
│       ├── index.js
│       ├── tapes.js
│       └── users.js
├── Documentation External_Group 3.pdf
├── Kelompok 3 - Project MCC/
└── MySql/
    └── video_tape.sql
```
<br>

## Notes
```
- Integrated Google Account sign-in through the Google API for seamless user authentication

- Assets used :
Fonts : Afacad (via Google Fonts (https://fonts.google.com))
Images : IMP Awards (http://www.impawards.com/)

TapeSync is a semester-long final group project developed for the Mobile Cloud Computing LAB course
```
<br><br>
