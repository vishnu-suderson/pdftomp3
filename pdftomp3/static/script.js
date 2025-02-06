document.addEventListener("keydown", function(event) {
    if (event.key === "j") {
        recognition.start();
        listening = true;
        console.log("Voice assistant started...");
    } else if (event.key === "f") {
        recognition.stop();
        listening = false;
        console.log("Voice assistant stopped...");
    }
});

const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
let listening = false;

if (typeof SpeechRecognition === "undefined") {
    console.log("Your browser doesn't support Speech API. Please download the latest Chrome version.");
}

const recognition = new SpeechRecognition();
recognition.continuous = true;
recognition.interimResults = true;

recognition.onresult = event => {
    const current = event.resultIndex;
    const recognitionResult = event.results[current];
    const recognitionText = recognitionResult[0].transcript.trim();
   
    if (recognitionResult.isFinal) {
        console.log(`Processing: ${recognitionText}`);
        const response = processCommand(recognitionText);
        console.log(`Assistant: ${response}`);
        speak(response); // Speak the response
    } else {
        console.log(`Listening: ${recognitionText}`);
    }
};

function processCommand(input) {
    let text = input.toLowerCase().trim();
    let response = null;

    // Mapping voice commands to Django URLs
    const routes = {
        "dashboard": "/Dashboard",
        "upload file": "/upload",
        "open upload window": "/upload",  // Added related command for opening upload
        "play audio": "/play/47/",  // Adjust ID dynamically if needed
        "list mp3 files": "/mp3files/",
        "progress": "/progress",
        "show progress": "/progressing",
        "preview pdf": "/preview/47/",  // Adjust ID dynamically if needed
        "convert to voice": "/Voice/1/",  // Adjust ID dynamically if needed
        "list files": "/files/",
        "download mp3": "/download/1/",  // Adjust ID dynamically if needed
        "profile": "/profile",
        "settings": "/settings/",
        "toggle dark mode": "/toggle-dark-mode/",
        "edit profile": "/edit-profile/",
        "delete mp3": "/delete_mp3/1/",  // Adjust ID dynamically if needed
        "send otp": "/send-otp/",
        "verify login": "/verify/",
        "verify otp": "/verify-otp/",
        "delete profile": "/profile-delete/",
        "reset password": "/reset-password/"
    };

    for (const command in routes) {
        if (text.includes(command)) {
            response = `Redirecting to ${command}...`;
            window.location.href = routes[command];
            return response;
        }
    }

    // Added additional responses for more interactions
    if (text.includes("hello") || text === "hi" || text.includes("hey")) {
        response = "Hello! How can I assist you today?";
    } else if (text.includes("yourname")) {
        response = "My name is Sonya, your voice assistant.";
    } else if (text.includes("howareyou") || text.includes("whatsup")) {
        response = "I'm doing great! How about you?";
    } else if (text.includes("whattimeisit")) {
        response = `The current time is ${new Date().toLocaleTimeString()}`;
    } else if (text.includes("joke")) {
        const jokes = ["Why don’t skeletons fight each other? They don’t have the guts.", 
                       "What do you call fake spaghetti? An impasta!", 
                       "Why did the scarecrow win an award? Because he was outstanding in his field!"];
        response = getRandomItem(jokes);
    } else if (text.includes("flip") && text.includes("coin")) {
        response = Math.random() < 0.5 ? "It's Heads!" : "It's Tails!";
    } else if (text.includes("bye") || text.includes("stop")) {
        response = "Goodbye! Have a great day!";
        recognition.stop();
        listening = false;
    } else if (text.includes("open upload window") || text.includes("open file upload") || text.includes("start upload")) {
        response = "Opening the upload window...";
        window.location.href = "/upload";
    } else {
        response = `I couldn't understand that.`;
    }

    return response;
}

// Utility function for random joke selection
function getRandomItem(array) {
    const randomIndex = Math.floor(Math.random() * array.length);
    return array[randomIndex];
}

// Function to make the assistant speak
function speak(text) {
    const speech = new SpeechSynthesisUtterance(text);
    speech.lang = "en-US"; // You can change the language as needed
    window.speechSynthesis.speak(speech);
}
