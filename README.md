<br />
<p align="center"><img src="./assets/images/app_logo.png" height="150"></p>

# Helpzz
#### Helpzz is a E-Commerce mobile application designed to be used in a community where anyone can register and see items added under Buy & Sell by others and also, can add new items under Buy & Sell.

## Demo
#### The build version of application can be [downloaded from here](https://drive.google.com/file/d/1GuIB_97dN8bCFZmVZGzEqEgVgtsgpSBt/view?usp=sharing).

## 🧩 Main Features
#### <ul><li>Nudity detection in images uploaded under Buy & Sell</li><li>Iteractive UI Screens</li><li>Separate categories under Buy & Sell</li></ul>

## 📖 Pages
#### <ul><li>Splash Screen</li><li>Login & Signup Screens</li><li>Homepage Screen</li><li>Buy/Sell Item form page</li></ul>

## 💻 TechStack Used
#### <ul><li>Flutter (for application/frontend)</li><li>Node.js & Express.js (for backend)</li><li>MongoDB (As primary database)</li></ul>

## 💻 APIs used
#### <ul><li>[DeepAI's nudity detection API](https://deepai.org/machine-learning-model/nsfw-detector)</li><li>Cloudinary Image upload API</li></ul>

## 🍁 Backend Services
- Follow [this link](https://github.com/Kunalpal215/helpzz_backend) to the repository.
- The backend service has been deployed on [heroku](https://dashboard.heroku.com/)

## Setting up project on your machine ⚙️
- [Follow this guide](https://swciitg.notion.site/Day-1-f6ea19b1d7ff410e8ec03683772f4cd0) to setup Android Studio & Flutter SDK on your machine

## 🎪 Running application
```
- Run "dart pub get" command to download all the dependencies used in this project.

- To run the application on a Physical device/Virtual Emulator use command "flutter run" at the root of this project's directory.

```
#

# 🖼️ Some glimpse of the App
<img src="https://res.cloudinary.com/kunalpal215/image/upload/v1667710959/Screenshot_20221106-102752_1_m4itmg.jpg" width="50%"> 
<img src="https://res.cloudinary.com/kunalpal215/image/upload/v1667710980/Screenshot_20221106-102759_1_baitat.jpg" width="50%">
<img src="https://res.cloudinary.com/kunalpal215/image/upload/v1667711004/Screenshot_20221106-102825_1_bzfwr8.jpg" width="50%">
<img src="https://res.cloudinary.com/kunalpal215/image/upload/v1667711025/Screenshot_20221106-102853_1_ushhhj.jpg" width="50%">

#

# Why Flutter over React.js 🤔 ?
- Although, in assignment It was mentioned to use some frontend framework like React.js still, I chose to build a mobile application using Flutter as I have more experience working with Flutter compared to React.js. Although, I have worked with React.js on several projects but have less worked with designing complex screens.

# 🎨 Design

- I choose Node.js & Express.js for building backend APIs and have used various npm packages.
- Followed [MVC (Model View Controller) Architecture](https://www.w3schools.in/mvc-architecture) for separtion of different components and scaling can be done easily and [best practices](https://github.com/goldbergyoni/nodebestpractices) on backend.
- Used [MongoDB's Atlas](https://www.mongodb.com/cloud/atlas/lp/try4?utm_source=bing&utm_campaign=search_bs_pl_evergreen_atlas_core_prosp-brand_gic-null_apac-in_ps-all_desktop_eng_lead&utm_term=mongodb%20atlas&utm_medium=cpc_paid_search&utm_ad=e&utm_ad_campaign_id=415204524&adgroup=1208363748749217&msclkid=469ecde79b84176ced50ae8523e6cc01) database which is a very popular & scalable database in market.
- Followed proper [folder structure & best practices](https://www.geeksforgeeks.org/flutter-file-structure/) to develop different components on application side.
- Why built separate backend service instead of integrating services like [Firebase](https://firebase.google.com/) ?
    - Integrating Firebase SDK in Flutter causes the app to perform slow compared to directly making API requests to your server.
    - Also, now application & backend's code remain separated and development can be done easily, scaling application & backend side.
    - Most modern applications follow same practice of separating their different services.
- Used [Provider](https://pub.dev/packages/provider) package for State Managment in the application. integrating it gives:
    - reduced boilerplate over a new class every time.
    - simplified allocation/disposal of resources.
    - increased scalability for classes with a listening mechanism that grows exponentially in complexity (such as ChangeNotifier, which is O(N) for dispatching notifications).
- Login/Signup APIs: Tokens like Access & Refresh tokens are used for proper connection between user, server side and avoid chances of token fishing by hackers but due to time constraint, in this project, a 'security-key' header is passed with every API call to avoid unauthorized access.
- Image upload & Nudity detection: Although, both functionalities could have been implemented on application side but, added them on server side to avoid load on user's device of making extra API calls and also, [Sharp Package](https://www.npmjs.com/package/sharp) has been used to compress the uploaded images efficiently and it is better than packages available on pub.dev in performance.

# 🧛 Regrets
- I should have used Typescript instead of Javascript in backend because of various advantages.
- If time would have persisted then, I would have implemented full proof Authentication flow as mentioned before.
- For allowing only registered users to create buy/sell entries, I could have implemented biometric registration in the app and confirming the same before form submission.

# 🐛 Bug Reporting
#### Feel free to [open an issue](https://github.com/Kunalpal215/helpzz/issues) on GitHub if you find any bug.

<br />

# ⭐ Feature Suggestion
#### Feel free to [open an issue](https://github.com/Kunalpal215/helpzz/issues) on GitHub if you have feature idea to be added 🙌.

```
Submitted by:
Name: Kunal Pal
College: IIT Guwahati
Roll no: 200104048
Course & year: B.Tech 3rd year

Thanks for visiting my repository 😊!! Please give a star ⭐ if you liked my project.
```
