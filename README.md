<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Twitter Clone with UIKit</title>
    <style>
        img {
            width: 23%;
            margin-right: 1%;
            margin-bottom: 1%;
        }
        .image-container {
            display: flex;
            flex-wrap: wrap;
        }
    </style>
</head>
<body>

<h1>Twitter Clone with UIKit</h1>

<p>This project is an attempt to clone Twitter's UI using UIKit, following the MVVM (Model-View-ViewModel) architecture. Firebase is used for authentication and data storage, although the focus remains on UI replication rather than complete functionality.</p>

<h2>Architecture</h2>
<ul>
    <li><strong>MVVM (Model-View-ViewModel)</strong>: The application is structured using the MVVM pattern to separate concerns and promote a clean architecture.</li>
    <li><strong>Firebase</strong>: Integrated for authentication (login and registration) and data storage.</li>
    <li><strong>Combine</strong>: Utilized to handle asynchronous operations, such as network requests and Firebase interactions, making the code cleaner and more readable.</li>
</ul>

<h2>Implemented Screens</h2>
<ul>
    <li>Login ✅</li>
    <li>Register ✅</li>
    <li>Home ✅</li>
    <li>Search ✅</li>
    <li>Profile ✅</li>
    <li>Tweet Creation ✅</li>
    <li>Onboarding ✅</li>
</ul>

<h2>Screenshots</h2>
<div class="image-container">
    <img src="https://github.com/user-attachments/assets/ba7063bb-c8de-4e5a-b095-f815eb7a723c" alt="Onboarding">
    <img src="https://github.com/user-attachments/assets/1f509c74-8960-488e-a935-7887f2a8bdb8" alt="Create Your Account">
    <img src="https://github.com/user-attachments/assets/841dfd9b-c288-4093-bd81-27b28ca05e06" alt="Fill Data">
    <img src="https://github.com/user-attachments/assets/184a6617-fc8b-4cde-b2e1-4722cd105663" alt="Login">
</div>
<div class="image-container">
    <img src="https://github.com/user-attachments/assets/327a4003-e36d-497b-9b8d-3ebc0dd6e69f" alt="Home">
    <img src="https://github.com/user-attachments/assets/c09d9ca6-937c-44ea-ac41-8b5e5403016b" alt="Tweet">
    <img src="https://github.com/user-attachments/assets/711e0fec-bd66-4a49-8323-9abe62273d09" alt="Profile">
    <img src="https://github.com/user-attachments/assets/72a6bce8-5844-4713-aed4-024152a26443" alt="Search">
</div>
<div class="image-container">
    <img src="https://github.com/user-attachments/assets/b176ebc8-83eb-405f-8f03-2715e20acab9" alt="Search Profile">
</div>

<h2>Future Enhancements</h2>
<p>Consider adding more functionality to closely replicate Twitter’s features and improve user interaction.</p>

</body>
</html>
