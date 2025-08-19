#!/bin/bash

# exam.sh - Terminal-based Exam System using Shell Script

clear
echo "------------------------------------"
echo "     Welcome to Exam System"
echo "------------------------------------"

# Ask for user name
read -p "Enter your name: " username
timestamp=$(date +"%Y-%m-%d %H:%M:%S")
score=0
total=0

# File paths
questions_file="questions.txt"
answers_file="answers.txt"
log_file="results.log"

# Check if questions and answers files exist
if [[ ! -f "$questions_file" || ! -f "$answers_file" ]]; then
    echo "Error: Required files (questions.txt / answers.txt) not found!"
    exit 1
fi

# Read both files line by line
paste "$questions_file" "$answers_file" | while IFS=$'\t' read -r question correct_answer
do
    echo ""
    echo "$question"
    read -p "Your answer: " user_answer

    if [[ "$user_answer" == "$correct_answer" ]]; then
        echo "✅ Correct!"
        ((score++))
    else
        echo "❌ Wrong! Correct answer is: $correct_answer"
    fi

    ((total++))
done

# Display final result
echo ""
echo "------------------------------------"
echo "Exam completed!"
echo "User: $username"
echo "Score: $score / $total"
echo "Date: $timestamp"
echo "------------------------------------"

# Save result to log file
echo "$timestamp - $username - Score: $score/$total" >> "$log_file"

