# Career Quest - A Career Exploration Game

## Overview
Career Quest is an educational game designed for the FBLA 2025-2026 Computer Game & Simulation Programming competition. Players explore different career paths through interactive mini-worlds, completing challenges that showcase what each profession involves.

## Game Concept
Players journey through four distinct career worlds:
1. **Software Developer** - Code, debug, and solve programming challenges
2. **Healthcare Professional** - Diagnose patients and make medical decisions
3. **Teacher/Educator** - Create lessons and manage classrooms
4. **Business Manager** - Lead teams and make strategic decisions

## Features
- **Multiple Career Paths**: 4 unique career worlds with 3 challenges each
- **Skill-Based Challenges**: 12 total challenges testing career-specific skills
- **Multiple Outcomes**: Scores and performance feedback based on player choices
- **Progress Tracking**: Track completion and scores across all careers
- **Intuitive UX**: Clear navigation, instructions, and accessible design
- **Educational Value**: Learn about different careers through hands-on experience

## Technical Implementation

### Technologies Used
- **Game Engine**: Godot 4.5
- **Programming Language**: GDScript
- **Platform**: Cross-platform (Windows, Mac, Web Browser)
- **Architecture**: Modular scene-based design

### Project Structure
```
rise-of-wealth/
├── scenes/
│   ├── career_quest/
│   │   ├── career_quest_title.tscn     # Main title screen
│   │   └── career_hub.tscn             # Career selection hub
│   └── careers/
│       ├── software_developer.tscn     # Software Dev career world
│       ├── healthcare.tscn             # Healthcare career world
│       ├── teacher.tscn                # Teacher career world
│       ├── business_manager.tscn       # Business Manager career world
│       └── challenges/                 # Individual challenge scenes
├── scripts/
│   └── autoload/
│       └── game_manager.gd             # Global game state manager
└── project.godot                        # Godot project configuration
```

### Game Architecture

#### GameManager (Autoload)
- Tracks player progress across all careers
- Stores completion status and scores
- Manages game state globally
- Provides progress percentage calculations

#### Career Worlds
Each career world follows a consistent structure:
- Introduction panel explaining the career
- Sequential challenge system (3 challenges per career)
- Results panel showing final score and skills gained
- Return to hub functionality

#### Challenge System
Each challenge:
- Presents a scenario relevant to the career
- Offers interactive choices or problem-solving tasks
- Provides immediate feedback
- Awards scores based on performance (0-100 points)
- Emits completion signal to progress to next challenge

### Design Decisions

#### Why GDScript?
GDScript is Godot's native language, providing:
- Tight integration with the engine
- Easy-to-understand syntax
- Rapid development capabilities
- No external dependencies

#### Why Scene-Based Architecture?
Modular scenes allow:
- Easy maintenance and updates
- Reusable components
- Clear separation of concerns
- Simplified testing

#### Why Web Export?
HTML5 export provides:
- Maximum cross-platform compatibility
- No installation required
- Works on Windows, Mac, and mobile browsers
- Easy distribution and accessibility

## Game Rules

### Career Completion
- Complete all 3 challenges in a career world
- Earn a final score (average of challenge scores)
- Career marked as completed in the hub
- Can replay completed careers

### Scoring System
- Each challenge awards 0-100 points
- Final career score is the average of 3 challenges
- Bonus points for speed in timed challenges
- Penalties for incorrect choices

### Multiple Outcomes
- Scores above 80: "Excellent" performance
- Scores 60-79: "Good" performance  
- Scores below 60: "Keep practicing" feedback
- Different feedback messages based on choices made

## Controls
- **Mouse Click**: Select options and interact with UI
- **Arrow Keys/WASD**: Navigate (if applicable)
- **ESC**: Pause/return to menu (if applicable)

## User Experience Features

### Accessibility
- Clear, readable fonts (size 18-32)
- High contrast color schemes
- Intuitive button layouts
- Text-based feedback for all actions
- No time pressure (except specific timed challenges)

### Visual Design
- Consistent color themes for each career
- Clear visual hierarchy
- Professional UI layout
- Distinct visual identity per career world

### Navigation
- Title screen with clear options
- Career hub showing progress
- Linear progression through challenges
- Easy return to hub from any career

## Educational Value

### Software Developer Career
**Skills Learned:**
- Code debugging and error detection
- Algorithm analysis and complexity
- Software development workflow
- Test-driven development principles

### Healthcare Professional Career
**Skills Learned:**
- Patient diagnosis from symptoms
- Treatment planning
- Emergency medical response
- Medical decision-making

### Teacher/Educator Career
**Skills Learned:**
- Effective lesson planning
- Classroom management strategies
- Student engagement techniques
- Educational best practices

### Business Manager Career
**Skills Learned:**
- Strategic business thinking
- Team leadership and motivation
- Budget and resource management
- Data-driven decision making

## How to Play

1. **Start**: Launch the game and click "Start Adventure"
2. **Choose**: Select a career from the Career Hub
3. **Learn**: Read the career introduction
4. **Challenge**: Complete each of the 3 challenges
5. **Score**: View your results and skills gained
6. **Continue**: Return to hub and try another career
7. **Complete**: Finish all 4 careers to see overall progress

## Security Considerations
- No user data collection
- No external network requests (except for web export asset loading)
- No file system access beyond game assets
- Clean, auditable code
- No external dependencies or libraries

## Game Bugs - Known Issues
None identified. All challenge paths tested and functional.

## Future Enhancements (Post-Competition)
- Additional career paths
- More challenges per career
- Multiplayer comparison mode
- Achievement system
- Save/load game progress
- Sound effects and music
- Animated visuals
- Difficulty levels

## Development Team
Created for FBLA 2025-2026 Computer Game & Simulation Programming Competition

## Credits
- **Game Engine**: Godot Engine 4.5 (MIT License)
- **Programming**: GDScript
- **Design**: Original work for FBLA competition
- **Topic Partner**: code.org

## License
This project is created for educational purposes as part of the FBLA competition.

---

**Ready to explore careers? Start your Career Quest today!**
