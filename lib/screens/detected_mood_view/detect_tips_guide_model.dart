// create an hashmap of tips and guidance for each mood


import 'package:flutter/material.dart';

const Map<String, Map<String, dynamic>> moodGuidance = {
  'anger': {
    'title': 'Feeling Angry?',
    'tips': [
      'Take deep breaths (inhale for 4 seconds, hold for 4, exhale for 6)',
      'Remove yourself from the situation temporarily',
      'Express your feelings calmly using "I" statements',
      'Try physical activity to release tension',
      'Practice progressive muscle relaxation'
    ],
    'color': Colors.red,
    'icon': Icons.whatshot,
  },
  'disgust': {
    'title': 'Feeling Disgusted?',
    'tips': [
      'Identify what specifically is causing this feeling',
      'Try to reframe the situation objectively',
      'Practice mindfulness to stay present',
      'Express your boundaries clearly',
      'Engage in cleansing activities (like organizing your space)'
    ],
    'color': Colors.green,
    'icon': Icons.sick,
  },
  'fear': {
    'title': 'Feeling Anxious/Fearful?',
    'tips': [
      'Ground yourself with the 5-4-3-2-1 technique',
      'Challenge catastrophic thinking with evidence',
      'Practice gradual exposure to what scares you',
      'Create a safety plan for worst-case scenarios',
      'Try journaling about your fears'
    ],
    'color': Colors.purple,
    'icon': Icons.warning,
  },
  'joy': {
    'title': 'Feeling Joyful!',
    'tips': [
      'Savor and prolong this positive emotion',
      'Share your happiness with others',
      'Express gratitude for what brought you joy',
      'Engage in activities that maintain this mood',
      'Create positive memories to look back on'
    ],
    'color': Colors.yellow,
    'icon': Icons.emoji_emotions,
  },
  'neutral': {
    'title': 'Feeling Neutral',
    'tips': [
      'This is a great time for reflection',
      'Consider trying something new',
      'Practice mindfulness of your current state',
      'Check in with your physical needs (hunger, sleep, etc.)',
      'Use this calm state for decision making'
    ],
    'color': Colors.grey,
    'icon': Icons.psychology,
  },
  'sadness': {
    'title': 'Feeling Sad?',
    'tips': [
      'Allow yourself to feel without judgment',
      'Reach out to supportive people',
      'Engage in comforting activities',
      'Practice self-compassion',
      'Consider if this sadness has a message for you'
    ],
    'color': Colors.blue,
    'icon': Icons.sentiment_dissatisfied,
  },
  'surprise': {
    'title': 'Feeling Surprised?',
    'tips': [
      'Take a moment to process what happened',
      'Determine if this is a positive or negative surprise',
      'For negative surprises: practice coping strategies',
      'For positive surprises: savor the moment',
      'Reflect on how this affects your expectations'
    ],
    'color': Colors.orange,
    'icon': Icons.celebration,
  },
};