# GovMatch
GovMatch is a matching platform for employees of the Swiss government. It seeks to connect people from different locations, break up local and departmental structures, and ultimately enable coworkers to network more efficiently than ever before. This project was developed in a 30-hour period as part of the #GovTechHack24 hackathon. The main component is an iOS application that can be extended with a DjangoRestAPI to allow a permanent storage of user data on a central server. 

## Preview
In many cases, images are much more expressive than words. The following images serve as a demo of our implementation progress.
<div style="display: grid; grid-template-columns: repeat(2, 1fr); grid-gap: 20px; justify-content: center; text-align: center;">
  <div>
    <img width="300" alt="preview-1" src="https://github.com/Luca-Wiehe/govtech_hackathon_24/assets/85710000/713cb781-5ee2-41d9-8f34-8b5c87f44f91">
    <br>
    <em>Screenshot 1: Uniquely identifying government workers using the AdminDirectory API.</em>
  </div>
  <br>
  <div><img width="300" alt="preview-2" src="https://github.com/Luca-Wiehe/govtech_hackathon_24/assets/85710000/66b86701-0b96-416f-a219-07b99cfc4e63">
    <br>
    <em>Screenshot 2: Improving the matching experience using ChatGPT-powered questionnaires</em>
  </div>
  <br>
  <div>
    <img width="300" alt="image" src="https://github.com/Luca-Wiehe/govtech_hackathon_24/assets/85710000/94114ac9-6c3a-4719-83a4-26519914d47d">
    <br>
    <em>Screenshot 3: Working in a new city? Filters let you connect easily.</em>
  </div>
  <br>
  <div><img width="300" alt="Screenshot 2024-03-15 at 09 00 09" src="https://github.com/Luca-Wiehe/govtech_hackathon_24/assets/85710000/a644cb20-78e5-48db-bd9c-65ef984ed449">
    <br>
    <em>Screenshot 4: Seemless Outlook Calendar integration to not forget about your meetings</em>
  </div>

## Project Description
### Motivation for Application
In large organizations, it is almost unavoidable to have redundancies of responsibilities and tasks. In some cases, this overlap of responsibilities is intended - with a minor overlap it is much more likely that people understand each other's view points. In other cases, these similar tasks are far spread across an organization, making it almost impossible to efficiently find another person to ask questions. Knowing about the existence of people with specific skills is therefore an important asset in business contexts, and also for the government. Motivated by the fact that people with diverse backgrounds will not find each other easily, GovMatch seeks to meet this business requirement.

### Choice of Tech Stack
When launching a new tool, it is important that new users can adapt the application effortlessly. iOS is the most popular operating system in Switzerland, resulting in a low threshold for new users to try the application. Additionally, Apple is known for its high security standards which is particularly relevant in the context of confidential data or conversations that may take place between users. For these reasons, we decided to use Swift - Apple's programming language for its own operating systems - to implement GovMatch. 

### Repository Structure
+ `govtech_hackathonApp`: Launches the application
+ `ContentView.swift`: Main View of the app. Starting point of all navigation actions
+ `HomeView.swift`: Starting point for TabViews, i.e. Matching, Calendar, Profile

`/Models/`: Contains objects and data structures that are used throughout the application
+ `Person.swift`: Data structure to manage user's attributes

`/Assets/`: Contains permanent resources (e.g. images, color schemes etc.)

`/StateManagement/`: Contains objects that need to be globally accessible
+ `ProfileInformationManager.swift`: Global storage for user data (should be stored on a separate server in the future)
+ `TimeManager.swift`: Global storage for preferred meeting times and MeetingData
+ `NavigationController.swift`: Global state to manage navigation hierarchy

`/LoginContents/`: User Authentication
+ `StartView.swift`: Landing page with button to connect to AdminDirectory
+ `GrantAccessView.swift`: Verifies that users give access to their AdminDirectory

`/MatchingContents/`: Matching Logic
+ `MatchView.swift`: View to select matching criteria
+ `SwipeView.swift`: View to look for potential business matches

`/ProfileContents/`: Profile Information
+ `PersonalInformationView.swift`: Collects information such as interests and skills
+ `TimePreferencesView.swift`: Allows user select their preferred times for certain MeetingTypes
+ `ChatbotView.swift`: Extracts additional information about the student
+ `ProfileView.swift`: Displays buttons to let users adjust their profile

+ `CalendarView.swift`: CSS Styles for UI Components and UI Pages

### Technical Requirements
From a developer's perspective, there are a few technical requirements that need to be met to further implement the application
+ Apple's development environment XCode and the corresponding CommandlineTools need to be installed
+ SwiftOpenAI (package for OpenAI API support in Swift)
+ OpenAI API key (to be pasted inside `ChatbotView.swift`)

## Software Architecture
