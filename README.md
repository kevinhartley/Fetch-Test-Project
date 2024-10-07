# Fetch-Test-Project

# Steps to Run the App

- This project allows the user to fetch all meals from a desert category from themealdb.com and displays the results alphabetically.
- It is built around async await and uses @MainActors in the viewmodels to handle thread management.
- Though not part of the requirements, I implemented the ability to search for items even if they are not part of the deserts category.
- You are able to see the details of items you search for and see their food category, ingredients, instructions, region of food, as well as an optional video of the food item you'd like to make.

# Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

- I prioritized use of async await tasks, actors, and proper dependency injection.

# Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

- A couple hours a day over a weekend.

# Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

- List vs ForEach, and I opted to use ForEach. I also opted to use @MainActor for the ViewModel as I feel this is still pretty common for people to be using.

# Weakest Part of the Project: What do you think is the weakest part of your project?

- Probably navigation due to not using NaviagionController. I think that abstracting navigation away from the view is a great thing to do for future scalability.

# External Code and Dependencies: Did you use any external code, libraries, or dependencies?

- No I did not.

# Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

- I hope you enjoy seeing my use of view abstraction as well as use of GeometryReader in the UI, and my use of generic decodable loading in the DataProvider.
