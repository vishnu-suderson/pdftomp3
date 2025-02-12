/* class VoiceAssistant {
    constructor() {
        this.speechRecognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
        this.speechRecognition.continuous = false;
        this.speechRecognition.interimResults = false;
        this.speechRecognition.lang = 'en-US';
        this.speechRecognition.onresult = (event) => this.handleResult(event);
    }

    startListening() {
        this.speechRecognition.start();
    }

    stopListening() {
        this.speechRecognition.stop();
    }

    handleResult(event) {
        const transcript = event.results[0][0].transcript.toLowerCase().trim();
        console.log("Recognized text:", transcript);
        this.processCommand(transcript);
    }
    setupKeyboardControls() {
        document.addEventListener("keydown", (event) => {
            if (event.key === "j") {
                this.startListening();
            } else if (event.key === "f") {
                this.stopListening();
            }
        });
    }

    normalizeText(text) {
        return text.toLowerCase().trim();
    }

    findBestMatch(input, commands) {
        return commands.some(command => input.includes(command));
    }

    processCommand(text) {
        text = this.normalizeText(text);

        // 1️⃣ First, handle non-navigation commands:
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

        // 2️⃣ If no specific command matched, check navigation commands:
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
}
 */