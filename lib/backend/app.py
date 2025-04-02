import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.preprocessing import LabelEncoder
from fuzzywuzzy import fuzz
from fuzzywuzzy import process
from tensorflow.keras.models import load_model
from flask import Flask, request, jsonify
import re

# Load the trained model
model = load_model('smishing_chatbot_model.h5')

# Load the vectorizer and label encoder used for training
vectorizer = TfidfVectorizer()
label_encoder = LabelEncoder()

# Recreate the original dataset and vectorizer from the training code (you may want to save these as well)
data = {
    "Question": [
        "What is smishing?",
        "How can I detect smishing?",
        "What should I do if I receive a smishing message?",
        "What are some signs of smishing?",
        "Can smishing be harmful?",
        "How can I protect myself from smishing attacks?",
        "What does a typical smishing message look like?"
    ],
    "Answer": [
        "Smishing is a type of phishing attack that uses SMS messages to deceive people into revealing personal information.",
        "Look for signs like suspicious links, urgent language, and requests for personal information. Don't click on unknown links.",
        "If you receive a smishing message, do not respond, click on any links, or share any personal information. Report it to your carrier.",
        "Common signs include unexpected messages asking for personal details, unfamiliar links, and messages from unknown numbers.",
        "Yes, smishing can be harmful. It can lead to identity theft, financial loss, and other security risks.",
        "You can protect yourself by avoiding suspicious links, verifying the sender, and keeping your phone's security settings up-to-date.",
        "Smishing messages often include urgent messages claiming you've won something or need to act immediately. They may also contain links to fake websites."
    ]
}

df = pd.DataFrame(data)
vectorizer.fit(df["Question"])
label_encoder.fit(df["Answer"])

# Function for fuzzy matching
def get_best_match_with_fuzzy(user_input, threshold=50):
    best_match = process.extractOne(user_input, df["Question"], scorer=fuzz.ratio)
    if best_match and best_match[1] > threshold:
        return df["Answer"][df["Question"] == best_match[0]].values[0]
    return None

# Neural network prediction with confidence check
def get_best_match_nn(user_input, confidence_threshold=0.5):
    input_vector = vectorizer.transform([user_input]).toarray()
    predictions = model.predict(input_vector, verbose=0)
    confidence = predictions.max()
    if confidence < confidence_threshold:
        return None
    return label_encoder.inverse_transform([predictions.argmax()])[0]

# Combined response logic with custom rules for specific keywords
def combined_response(user_input):
    # Define a regular expression for detecting greetings
    greeting_pattern = r'\b(hi|hello|hey|greetings|helo|hy|howdy|hlo)\b'

    # Check for greetings like "hi", "hello", "hey", and their variations
    if re.search(greeting_pattern, user_input.lower()):
        return "Hello! Ask me anything or type 'exit' to quit."

    # Check for specific short-term responses like "smishing" and "harmful"
    if 'smishing' in user_input.lower():
        return "Smishing is a type of phishing attack that uses SMS messages to deceive people into revealing personal information."
    if 'harmful' in user_input.lower():
        return "Yes, smishing can be harmful. It can lead to identity theft, financial loss, and other security risks."

    # Fuzzy matching for the rest
    fuzzy_answer = get_best_match_with_fuzzy(user_input)
    if fuzzy_answer:
        return fuzzy_answer

    # Neural network prediction
    nn_answer = get_best_match_nn(user_input)
    if nn_answer:
        return nn_answer

    return "I don't understand that. Could you clarify?"

# Create Flask application
app = Flask(__name__)

@app.route("/chat", methods=["POST"])
def chat():
    user_input = request.json.get("message", "")
    
    if not user_input:
        return jsonify({"error": "No input provided"}), 400
    
    # Get response using the combined logic
    response = combined_response(user_input)
    
    return jsonify({"response": response})

# Run the Flask server
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
