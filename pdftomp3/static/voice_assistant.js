class VoiceAssistant {
    constructor() {
        // Initialize speech recognition
        this.speechRecognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
        this.speechRecognition.continuous = false;
        this.speechRecognition.interimResults = false;
        this.speechRecognition.lang = 'en-US';
        this.speechRecognition.onresult = (event) => this.handleResult(event);

        // Initialize speech synthesis
        this.synth = window.speechSynthesis;

        // Command synonyms for natural language understanding
        this.commandSynonyms = {
            play: ['play', 'start', 'listen to', 'open'],
            preview: ['preview', 'view', 'open', 'show'],
            delete: ['delete', 'remove', 'trash'],
            convert: ['convert', 'change', 'transform'],
            next: ['next', 'forward', 'go next'],
            previous: ['previous', 'backwards', 'go previous'],
            back: ['back', 'go back', 'return'],
            goTo: ['go to', 'navigate to', 'open', 'show', 'take me to'],
            list: ['list', 'show', 'what are', 'display'],
            help: ['help', 'commands', 'what can I do']
        };

        // Page mappings for navigation
        this.urlMappings = {
            'Dashboard': ['dashboard', 'home', 'main'],
            'upload': ['upload', 'upload page'],
            'mp3files': ['mp3 files', 'audio', 'music'],
            'pdffiles': ['pdf files', 'pdfs', 'documents'],
            'files': ['files', 'all files'],
            'profile': ['profile', 'my profile'],
            'settings': ['settings', 'options', 'preferences']
        };

        // Bind keypress events to start/stop listening
        this.bindKeyPressEvents();
    }

    bindKeyPressEvents() {
        document.addEventListener('keydown', (event) => {
            if (event.key.toLowerCase() === 'j') this.startListening();
            if (event.key.toLowerCase() === 'f') this.stopListening();
        });
    }

    startListening() {
        console.log("Voice assistant started...");
        this.speak("Listening...");
        this.speechRecognition.start();
    }

    stopListening() {
        console.log("Voice assistant stopped.");
        this.speak("Stopped.");
        this.speechRecognition.stop();
    }

    handleResult(event) {
        const transcript = event.results[0][0].transcript.toLowerCase().trim();
        console.log("Heard:", transcript);
        const response = this.processCommand(transcript);
        this.speak(response);
    }

    speak(text) {
        if (this.synth.speaking) return;
        const utterance = new SpeechSynthesisUtterance(text);
        utterance.lang = "en-US";
        this.synth.speak(utterance);
    }

    processCommand(text) {
        // Help command
        if (this.matchesCommand(text, this.commandSynonyms.help)) {
            return this.getHelpMessage();
        }

        // Navigation to pages
        for (const [page, aliases] of Object.entries(this.urlMappings)) {
            const goToPatterns = aliases.flatMap(alias =>
                this.commandSynonyms.goTo.map(cmd => `${cmd} ${alias}`)
            );
            if (this.matchesCommand(text, goToPatterns)) {
                window.location.href = `/${page}`;
                return `Going to ${page}.`;
            }
        }

        // List files (audio or PDF)
        if (this.matchesCommand(text, [...this.commandSynonyms.list, 'audio files', 'mp3 files'])) {
            return this.listFiles('audio');
        }
        if (this.matchesCommand(text, [...this.commandSynonyms.list, 'pdf files', 'documents'])) {
            return this.listFiles('pdf');
        }

        const openMatch = text.match(/open (one|two|three|four|five|six|seven|eight)/);
        if (openMatch) {
            const numbers = {
                "one": 1, "two": 2, "three": 3, "four": 4,
                "five": 5, "six": 6, "seven": 7, "eight": 8
            };
            const count = numbers[openMatch[1]];
            return this.openMultipleFiles(count);
        }

        // File operations (play, preview, delete, convert)
        const fileName = this.extractFileName(text);
        if (fileName) {
            if (this.matchesCommand(text, this.commandSynonyms.play)) {
                return this.handleFileAction(fileName, 'play');
            }
            if (this.matchesCommand(text, this.commandSynonyms.preview)) {
                return this.handleFileAction(fileName, 'preview');
            }
            if (this.matchesCommand(text, this.commandSynonyms.delete)) {
                return this.handleFileAction(fileName, 'delete');
            }
            if (this.matchesCommand(text, this.commandSynonyms.convert)) {
                return this.handleConvert(fileName);
            }
        }

        // Navigation commands (next, previous, back)
        if (this.matchesCommand(text, this.commandSynonyms.next)) {
            return this.navigate('next');
        }
        if (this.matchesCommand(text, this.commandSynonyms.previous)) {
            return this.navigate('previous');
        }
        if (this.matchesCommand(text, this.commandSynonyms.back)) {
            return this.navigate('back');
        }

        // Utility commands
        if (this.matchesCommand(text, ['toggle dark mode', 'dark mode'])) {
           document.documentElement.setAttribute(
            "data-theme",
            document.documentElement.getAttribute("data-theme") === "light" ? "dark" : "light"
        );
            return "Dark mode toggled.";
        }

        return "Sorry, I didn’t understand. Try 'list audio files', 'play song.mp3', 'go to profile', or say 'help' for more options.";
    }

    matchesCommand(text, commands) {
        return commands.some(cmd => new RegExp(`\\b${cmd}\\b`, 'i').test(text));
    }

    extractFileName(text) {
        const match = text.match(/(\w+\.(mp3|pdf))/i);
        return match ? match[0].toLowerCase() : null;
    }

    listFiles(type) {
        const sectionId = type === 'audio' ? 'audioFiles' : 'PdfFiles';
        const pageName = type === 'audio' ? 'mp3 files' : 'pdf files';
        const section = document.getElementById(sectionId);
        console.log(sectionId, pageName,section);
         if (!section) {
            return `Please go to the ${pageName} page first. Say 'go to ${pageName}'.`;
        } 

        const files = Array.from(section.querySelectorAll('.card h6')).map(el => el.innerText);
        if (files.length === 0) {
            return `No ${type} files found.`;
        }
        return `You have the following ${type} files: ${files.join(", ")}`;
    }

    handleFileAction(fileName, action) {
        const isAudio = fileName.endsWith('.mp3');
        const sectionId = isAudio ? 'audioFiles' : 'PdfFiles';
        const section = document.getElementById(sectionId);

         if (!section) {
            const pageName = isAudio ? 'mp3 files' : 'pdf files';
            return `Please go to the ${pageName} page first. Say 'go to ${pageName}'.`;
        }

        const files = Array.from(section.querySelectorAll('.card h6'));
        const target = files.find(el => el.innerText.toLowerCase().includes(fileName));

        if (!target) {
            return `File "${fileName}" not found on this page.`;
        }

        const card = target.closest('.card');
        if (action === 'play' && isAudio) {
            const link = card.querySelector('a');
            if (link) {
                link.click();
                return `Playing ${fileName}.`;
            }
        } else if (action === 'preview' && !isAudio) {
            const link = card.querySelector('a');
            if (link) {
                link.click();
                return `Previewing ${fileName}.`;
            }
        } else if (action === 'delete') {
            const deleteBtn = card.querySelector('.delete-btn');
            if (deleteBtn) {
                deleteBtn.click();
                return `Deleted ${fileName}.`;
            }
        }

        return `Cannot ${action} ${fileName}.`;
    }

    handleConvert(fileName) {
        // Placeholder for conversion logic
        console.log(`Converting ${fileName}...`);
        return `Converting ${fileName}. This feature is under development.`;
    }

    navigate(direction) {
        const buttons = {
            next: document.querySelector('[id*="next"], [class*="next"]'),
            previous: document.querySelector('[id*="prev"], [class*="prev"]'),
            back: document.querySelector('[id*="back"], [class*="back"]')
        };

        if (buttons[direction] && buttons[direction].tagName === 'BUTTON') {
            buttons[direction].click();
            return `${direction.charAt(0).toUpperCase() + direction.slice(1)} clicked.`;
        }

        if (direction === 'back') {
            window.history.back();
            return "Going back.";
        }

        return `No ${direction} button found on this page.`;
    }

    getHelpMessage() {
        return "Here are some commands you can use: " +
            "'list audio files', 'list pdf files', 'play song.mp3', 'preview document.pdf', " +
            "'delete file.mp3', 'convert file.pdf', 'go to profile', 'go to settings', " +
            "'next', 'previous', 'back', 'toggle dark mode'. You can also say 'help' for assistance.";
    }

openMultipleFiles(count) {
    let section = document.getElementById("audioFiles") || document.getElementById("PdfFiles");
    if (!section) return "Please go to the Audio or PDF files page first.";

    const links = Array.from(section.querySelectorAll(".card a")).slice(0, count);
    if (links.length === 0) return "No files found to open.";

    links.forEach(link => window.open(link.href)); // Opens files in new tabs
    return `Opening ${links.length} file(s).`;
}

}

// Start the assistant
const assistant = new VoiceAssistant();