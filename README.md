# Crazy Scrap

Welcome to this project created as part of **The Hacking Project (THP)** bootcamp.
The goal is to master web scraping techniques using the Nokogiri gem, by parsing HTML documents to extract structured data from various websites.

## Prerequisites

* Ruby (version 3.0 or higher recommended)
* Bundler

## Installation

1.  **Clone the repository** (if you haven't already):
    ```bash
    git clone <your-github-link>
    cd le_scrappeur_fou
    ```

2.  **Install the gems**:
    ```bash
    bundle install
    ```
    *This project uses `nokogiri` for parsing HTML, `open-uri` for HTTP requests, and `rspec` for testing.*

---

## Usage

The project is divided into 3 independent scripts located in the `lib/` folder.

### 1. Dark Trader (Crypto Scraper)
A bot capable of retrieving the names and prices of cryptocurrencies from CoinMarketCap.
* **Technique:** Uses specific XPath selectors to target table rows (`tr`) and cells (`td`) to extract clean symbols and prices, handling HTML structure variations.
* **Command:**
    ```bash
    ruby lib/dark_trader.rb
    ```

### 2. Mairie Christmas (Townhall Emails)
A bot that retrieves the email addresses of all town halls in the Val d'Oise department.
* **Technique:**
    * **Two-step scraping:** First, it collects all town URLs from the main listing. Second, it visits each URL to scrape the specific email address.
    * **XPath filtering:** Uses specific filters (`//td`) to avoid retrieving hidden system code instead of the actual email.
* **Command:**
    ```bash
    ruby lib/mairie_christmas.rb
    ```

### 3. Dear Deputy (Bonus)
A bot that retrieves the first name, last name, and email address of French deputies from NosDeputes.fr.
* **Technique:**
    * **Data Cleaning:** Splits full name strings into distinct first and last names.
    * **User Experience:** Implements a real-time progress bar using `print` and carriage returns (`\r`) to visualize the scraping status.
* **Command:**
    ```bash
    ruby lib/cher_depute.rb
    ```

---

## Testing

Tests are implemented using **RSpec** to ensure data integrity and format consistency.

* **Optimization:** The tests use `before(:all)` to run the scraping process only once per test file, preventing infinite loops and reducing test duration.
* **Running the tests:**
    ```bash
    # To run all tests
    rspec

    # To run a specific test
    rspec spec/cher_depute_spec.rb
    ```

## Configuration

* **Rate Limiting:** By default, the scripts might be configured to scrape only the first 10 entries (`.first(10)`) to facilitate quick testing and debugging. To scrape the full datasets, simply remove this method in the respective loops inside the `lib/` files.

## Author

*Valentin Chéron*

*The Hacking Project 2026*
