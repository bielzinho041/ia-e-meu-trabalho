const passwordInput = document.getElementById("password");
const generateBtn = document.getElementById("generateBtn");
const copyBtn = document.getElementById("copyBtn");

const lengthSlider = document.getElementById("length");
const lengthValue = document.getElementById("lengthValue");

const uppercase = document.getElementById("uppercase");
const lowercase = document.getElementById("lowercase");
const numbers = document.getElementById("numbers");
const symbols = document.getElementById("symbols");

const strengthBar = document.getElementById("strengthBar");
const strengthText = document.getElementById("strengthText");

lengthSlider.addEventListener("input", () => {
    lengthValue.textContent = lengthSlider.value;
});

function generatePassword() {

    let chars = "";

    if (uppercase.checked)
        chars += "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    if (lowercase.checked)
        chars += "abcdefghijklmnopqrstuvwxyz";

    if (numbers.checked)
        chars += "0123456789";

    if (symbols.checked)
        chars += "!@#$%&*()_-+=<>?/{}[]";

    if (!chars) {
        alert("Selecione pelo menos uma opção.");
        return;
    }

    const length = parseInt(lengthSlider.value);

    const randomValues = new Uint32Array(length);

    crypto.getRandomValues(randomValues);

    let password = "";

    for (let i = 0; i < length; i++) {
        password += chars[randomValues[i] % chars.length];
    }

    passwordInput.value = password;

    checkStrength(password);
}

function checkStrength(password) {

    let score = 0;

    if (password.length >= 12) score++;
    if (password.length >= 16) score++;

    if (/[A-Z]/.test(password)) score++;
    if (/[a-z]/.test(password)) score++;
    if (/[0-9]/.test(password)) score++;
    if (/[^A-Za-z0-9]/.test(password)) score++;

    if (score <= 2) {
        strengthBar.style.width = "25%";
        strengthBar.style.background = "#dc2626";
        strengthText.textContent = "Fraca";
    }
    else if (score <= 4) {
        strengthBar.style.width = "50%";
        strengthBar.style.background = "#f59e0b";
        strengthText.textContent = "Média";
    }
    else if (score <= 5) {
        strengthBar.style.width = "75%";
        strengthBar.style.background = "#84cc16";
        strengthText.textContent = "Forte";
    }
    else {
        strengthBar.style.width = "100%";
        strengthBar.style.background = "#16a34a";
        strengthText.textContent = "Muito Forte";
    }
}

generateBtn.addEventListener("click", generatePassword);

copyBtn.addEventListener("click", async () => {

    if (!passwordInput.value) return;

    await navigator.clipboard.writeText(
        passwordInput.value
    );

    copyBtn.textContent = "Copiado!";

    setTimeout(() => {
        copyBtn.textContent = "Copiar";
    }, 2000);
});

generatePassword();
