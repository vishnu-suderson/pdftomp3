document.addEventListener('DOMContentLoaded', () => {
    class VoiceAssistant {
        constructor() {
            this.SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
            this.listening = false;
            this.recognition = null;
            this.lastCommand = '';
            this.initializeAssistant();
        }

        initializeAssistant() {
            if (typeof this.SpeechRecognition === "undefined") {
                console.error("Speech Recognition not supported. Please use Chrome.");
                return;
            }
            this.setupRecognition();
            this.setupKeyboardControls();
        }

        setupRecognition() {
            this.recognition = new this.SpeechRecognition();
            this.recognition.continuous = true;
            this.recognition.interimResults = true;
            this.recognition.lang = 'en-US';

            this.recognition.onstart = () => {
                this.listening = true;
                console.log("Voice assistant activated");
                this.speak("Voice assistant ready");
            };

            this.recognition.onend = () => {
                this.listening = false;
                console.log("Voice assistant deactivated");
            };

            this.recognition.onerror = (event) => {
                const errorMessages = {
                    'no-speech': 'No speech detected. Please try again.',
                    'audio-capture': 'Microphone not found.',
                    'not-allowed': 'Microphone access denied.',
                    'network': 'Network error occurred.',
                    'aborted': 'Listening stopped.',
                    'service-not-allowed': 'Speech service not allowed.'
                };
                console.error('Recognition error:', errorMessages[event.error] || event.error);
                this.speak(errorMessages[event.error] || "An error occurred");
            };

            this.recognition.onresult = (event) => {
                const current = event.resultIndex;
                const recognitionResult = event.results[current];
                const recognitionText = recognitionResult[0].transcript.trim();

                if (recognitionResult.isFinal) {
                    console.log(`Processing: ${recognitionText}`);
                    const response = this.processCommand(recognitionText);
                    console.log(`Assistant: ${response}`);
                    this.speak(response);
                    this.lastCommand = recognitionText;
                }
            };
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

        // Normalize text by converting to lowercase, removing punctuation and extra spaces.
        normalizeText(text) {
            return text.toLowerCase()
                .replace(/[.,\/#!$%\^&\*;:{}=\-_`~()]/g, "")
                .replace(/\s+/g, " ")
                .trim();
        }

        // Simplified matching: if the recognized text includes the normalized pattern (or its singular form), it's a match.
        findBestMatch(text, patterns) {
            text = this.normalizeText(text);
            for (const pattern of patterns) {
                const normalizedPattern = this.normalizeText(pattern);
                if (text.includes(normalizedPattern) ||
                    text.includes(normalizedPattern.replace(/s$/, ''))) {
                    console.log(`Matched pattern: "${pattern}" in text: "${text}"`);
                    return true;
                }
            }
            return false;
        }

        processCommand(text) {
            text = this.normalizeText(text);

            // Navigation commands with enhanced patterns
            const routes = {
                'dashboard': ['dashboard', 'control panel', 'main screen'],
                'upload': ['upload', 'upload file', 'add file'],
                'profile': ['profile', 'my profile', 'user profile'],
                'settings': ['settings', 'options', 'preferences'],
                'files': ['file', 'files', 'all files', 'file list'],
                'mp3files': ['mp3 file', 'mp3 files', 'music file', 'music files', 'audio file', 'audio files'],
                'editprofile': ['edit profile', 'modify profile', 'change profile']
            };

            // Check navigation commands
            for (const [page, patterns] of Object.entries(routes)) {
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
                    console.log(`Navigation command matched for page: ${page}`);
                    window.location.href = `/${page.replace(' ', '-')}`;
                    return `Navigating to ${page}`;
                }
            }

            // Audio file commands with enhanced patterns
            const audioCommands = {
                list: ['list audio files', 'show audio files', 'what audio files', 'show mp3 files', 
                      'display audio files', 'what music files', 'show music', 'list music'],
                play: ['play', 'start', 'open audio', 'listen to', 'play audio', 'start playing'],
                delete: ['delete', 'remove audio', 'remove file', 'delete audio']
            };

            if (this.findBestMatch(text, audioCommands.list)) {
                return this.listAudioFiles();
            }

            if (audioCommands.play.some(cmd => this.normalizeText(text).includes(this.normalizeText(cmd)))) {
                return this.selectAudioFile(text);
            }

            if (audioCommands.delete.some(cmd => this.normalizeText(text).includes(this.normalizeText(cmd)))) {
                return this.deleteAudioFile(text);
            }

            // Enhanced click command detection
            const clickPatterns = ['click', 'select', 'choose', 'press', 'tap', 'push', 'hit'];
            if (clickPatterns.some(pattern => this.normalizeText(text).includes(pattern))) {
                return this.handleElementInteraction(text);
            }

            // Handle "show my files" command
            if (this.findBestMatch(text, ['show my files', 'list my files', 'display my files'])) {
                return this.listFiles();
            }

            // Handle "what's the time" command
            if (this.findBestMatch(text, ["what's the time", "what time is it", "tell me the time"])) {
                const currentTime = new Date().toLocaleTimeString();
                return `The time is ${currentTime}`;
            }

            // Basic commands with more variations
            const basicCommands = {
                'hello': ['hello', 'hi', 'hey', 'greetings'],
                'bye': ['bye', 'goodbye', 'see you', 'end', 'quit'],
                'stop': ['stop listening', 'stop voice', 'end voice control']
            };

            for (const [command, patterns] of Object.entries(basicCommands)) {
                if (this.findBestMatch(text, patterns)) {
                    if (command === 'bye' || command === 'stop') {
                        this.stopListening();
                        return 'Goodbye! Voice control deactivated.';
                    }
                    return `Hello! How can I help you?`;
                }
            }

            // Repeat last command
            if (text.includes('repeat') || text.includes('say again')) {
                if (this.lastCommand) {
                    return this.processCommand(this.lastCommand);
                }
            }

            return "I didn't understand that command. Try saying 'hello' or 'list audio files'";
        }

        listAudioFiles() {
            const audioElements = document.querySelectorAll(".card-body h6, li[data-audio-file], .audio-file, .mp3-file");
            if (audioElements.length === 0) {
                return "No audio files found in the current page";
            }
            const fileNames = Array.from(audioElements)
                .map(el => el.innerText || el.getAttribute('data-audio-file'))
                .filter(name => name);
            if (fileNames.length === 0) {
                return "No audio files found";
            }
            return "Available audio files: " + fileNames.join(", ");
        }

        listFiles() {
            const fileElements = document.querySelectorAll(".file-item, [data-file], .file-list li");
            if (fileElements.length === 0) {
                return "No files found in the current page";
            }
            const fileNames = Array.from(fileElements)
                .map(el => el.innerText || el.getAttribute('data-file'))
                .filter(name => name);
            if (fileNames.length === 0) {
                return "No files found";
            }
            return "Your files: " + fileNames.join(", ");
        }

        selectAudioFile(command) {
            const audioElements = document.querySelectorAll(".card-body h6, li[data-audio-file], .audio-file, .mp3-file");
            let found = false;
            audioElements.forEach(element => {
                const fileName = (element.innerText || element.getAttribute('data-audio-file') || '').toLowerCase();
                if (command.includes(fileName) ||
                    command.includes(fileName.replace(/s$/, ''))) {
                    const clickTarget = element.closest(".card")?.querySelector("a") ||
                                         element.querySelector("a") ||
                                         element.closest("a") ||
                                         element;
                    clickTarget.click();
                    found = true;
                }
            });
            return found ? "Playing audio" : "I couldn't find that audio file. Please try again or say 'list audio files'";
        }

        deleteAudioFile(command) {
            const audioElements = document.querySelectorAll(".card-body h6, li[data-audio-file], .audio-file, .mp3-file");
            let found = false;
            audioElements.forEach(element => {
                const fileName = (element.innerText || element.getAttribute('data-audio-file') || '').toLowerCase();
                if (command.includes(fileName) ||
                    command.includes(fileName.replace(/s$/, ''))) {
                    const deleteButton = element.closest(".card")?.querySelector("[data-delete]") ||
                                         element.querySelector("[data-delete]") ||
                                         element.closest("[data-delete]");
                    if (deleteButton) {
                        deleteButton.click();
                        found = true;
                    }
                }
            });
            return found ? "File deleted" : "I couldn't find that file or the delete button. Please try again.";
        }

        handleElementInteraction(text) {
            const elements = document.querySelectorAll('button, a, input[type="submit"], [role="button"], [data-clickable]');
            const words = text.split(' ').filter(word => word.length > 2);
            for (const element of elements) {
                const elementText = (element.textContent || element.value || element.getAttribute('aria-label') || '').toLowerCase();
                if (words.some(word => elementText.includes(word))) {
                    element.click();
                    return `Clicked ${elementText}`;
                }
            }
            return "I couldn't find that element. Please try again with a different command.";
        }

        speak(text) {
            const speech = new SpeechSynthesisUtterance(text);
            speech.lang = "en-US";
            speech.rate = 1.0;
            speech.pitch = 1.0;
            speech.volume = 1.0;
            window.speechSynthesis.speak(speech);
        }

        startListening() {
            if (!this.listening && this.recognition) {
                this.recognition.start();
            }
        }

        stopListening() {
            if (this.listening && this.recognition) {
                this.recognition.stop();
            }
        }
    }

    // Initialize the voice assistant
    const assistant = new VoiceAssistant();
});
