/* class VoiceAssistant {
    constructor() {
        this.speechRecognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
        this.speechRecognition.continuous = false;
        this.speechRecognition.interimResults = false;
        this.speechRecognition.lang = 'en-US';
        this.speechRecognition.onresult = (event) => this.handleResult(event);
        
        this.synth = window.speechSynthesis; // Initialize speech synthesis

        // Bind keypress events
        this.bindKeyPressEvents();
    }

    bindKeyPressEvents() {
        document.addEventListener('keydown', (event) => {
            if (event.key.toLowerCase() === 'j') {
                this.startListening();
            }
            if (event.key.toLowerCase() === 'f') {
                this.stopListening();
            }
        });
    }

    startListening() {
        console.log("Voice assistant started...");
        this.speak("Voice assistant started.");
        this.speechRecognition.start();
    }

    stopListening() {
        console.log("Voice assistant stopped.");
        this.speak("Voice assistant stopped.");
        this.speechRecognition.stop();
    }

    handleResult(event) {
        const transcript = event.results[0][0].transcript.toLowerCase().trim();
        console.log("Recognized text:", transcript);
        const response = this.processCommand(transcript);
        if (response) {
            this.speak(response);
        }
    }

    speak(text) {
        if (this.synth.speaking) {
            console.log("Already speaking...");
            return;
        }
        const utterance = new SpeechSynthesisUtterance(text);
        utterance.lang = "en-US";
        this.synth.speak(utterance);
    }

    normalizeText(text) {
        return text.toLowerCase().trim();
    }

    findBestMatch(input, commands) {
        return commands.some(command => input.includes(command));
    }

    processCommand(text) {
        text = this.normalizeText(text);

        // 🔹 Handle non-navigation commands
        if (this.findBestMatch(text, ['click back button', 'go back', 'back'])) {
            window.history.back();
            return "Going back to the previous page.";
        }

        if (this.findBestMatch(text, ['list audio files', 'show audio files', 'what audio files'])) {
            return this.listAudioFiles();
        }

        if (this.findBestMatch(text, ['play', 'start'])) {
            return this.playAudioFile(text);
        }

        if (this.findBestMatch(text, ['delete', 'remove'])) {
            return this.deleteAudioFile(text);
        }

        if (this.findBestMatch(text, ['toggle dark mode', 'dark mode', 'enable dark mode', 'disable dark mode'])) {
            this.toggleDarkMode();
            return "Toggling dark mode.";
        }

        // 🔹 Handle navigation commands
        const urlMappings = {
            'Dashboard': ['dashboard', 'main page', 'control panel', 'home'],
            'upload': ['upload', 'upload file', 'add file'],
            'mp3files': ['mp3 files', 'audio files', 'music files'],
            'pdffiles': ['pdf files', 'pdf documents'],
            'files': ['files', 'all files', 'file list'],
            'profile': ['profile', 'my profile', 'user profile'],
            'settings': ['settings', 'options', 'preferences'],
            'edit-profile': ['edit profile', 'modify profile', 'change profile'],
            'delete': ['delete profile', 'remove profile']
        };

        for (const [page, patterns] of Object.entries(urlMappings)) {
            const navigationPatterns = patterns.flatMap(pattern => [
                `go to ${pattern}`,
                `open ${pattern}`,
                `show ${pattern}`,
                `navigate to ${pattern}`,
                `take me to ${pattern}`,
                `move to ${pattern}`,
                `switch to ${pattern}`,
                pattern
            ]);

            if (this.findBestMatch(text, navigationPatterns)) {
                window.location.href = `/${page}`;
                return `Navigating to ${page}`;
            }
        }

        return "I didn't understand that command. Try saying 'go to dashboard' or 'list audio files'.";
    }

    // 🔹 Toggle Dark Mode Feature
    toggleDarkMode() {
        document.body.classList.toggle("dark-mode");
        console.log("Dark mode toggled.");
    }

    // 🔹 Improved methods for handling files
    listAudioFiles() {
        const audioFiles = ['song1.mp3', 'song2.mp3', 'podcast1.mp3']; // Simulated file list
        if (audioFiles.length === 0) {
            return "No audio files found.";
        }
        console.log("Audio files:", audioFiles.join(", "));
        return `You have the following audio files: ${audioFiles.join(", ")}`;
    }

    playAudioFile(text) {
        console.log("Playing an audio file based on:", text);
        return "Playing the requested audio file.";
    }

    deleteAudioFile(text) {
        console.log("Deleting an audio file based on:", text);
        return "Deleted the requested audio file.";
    }
}

// Initialize the voice assistant
const assistant = new VoiceAssistant();
 */