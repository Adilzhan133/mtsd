# Robot Framework DemoBlaze Automation Project

## Project Structure
```
demoblaze-automation/
│
├── tests/
│   └── authentication_tests.robot
│
├── resources/
│   ├── common_keywords.robot
│   └── locators.robot
│
├── requirements.txt
└── README.md
```



## README.md
# DemoBlaze Automation Test Suite

## Prerequisites
- Python 3.8+
- pip

## Setup
1. Clone the repository
2. Create a virtual environment:
   ```
   python -m venv venv
   source venv/bin/activate  # On Windows use `venv\Scripts\activate`
   ```
3. Install dependencies:
   ```
   pip install -r requirements.txt
   ```

## Running Tests
```
robot tests/authentication_tests.robot
```

## Additional Configuration
- Supports Chrome by default
- Can configure browser and other settings in the test suite
```

## Installation and Execution Notes
1. Install dependencies: `pip install -r requirements.txt`
2. Install WebDriver: 
   - For Chrome: `webdriver-manager install chrome`
3. Run tests: `robot tests/authentication_tests.robot`
```# test-automation
