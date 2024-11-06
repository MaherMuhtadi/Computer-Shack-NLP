# Computer Shack Natural Language Processor

This repository contains a natural language processing (NLP) program written in Eclipse Prolog, designed to query information about products in a computer store. The program leverages a knowledge base that includes details about various products, their availability, pricing, ratings, and shipping locations. It can process natural language queries to provide information about the products in stock, their attributes, and where they are available.

## Features

- **Knowledge Base**: A database of products, their prices, ratings, and stock levels at various locations.
- **Lexicon**: A set of rules to interpret and process natural language constructs, such as adjectives, nouns, and prepositions, in the context of the product knowledge base.
- **Parser**: A Prolog-based parser that can analyze and extract information from natural language queries and map them to the knowledge base for answers.
- **Queries**: Supports a wide range of queries including:
  - Product availability at specific locations.
  - Product ratings and price comparisons.
  - Shipping options for different locations.
  - Stock levels of products at different stores.

## Knowledge Base Structure

The knowledge base is composed of several predicates:

- **product(Name, Brand, Type, Price, Rating)**: Represents a product with its name, brand, type (e.g., tablet, laptop), price, and rating.
- **inStock(Product, Store, Quantity)**: Indicates the quantity of a product available at a specific store.
- **location(Store, City)**: Specifies the location of a store in a city.
- **canShip(Product, City)**: States if a product can be shipped to a given city.

Example data entries:
```prolog
product(galaxy_tab_10, samsung, tablet, 599, 4.7).
inStock(galaxy_tab_10, square_one_computer_shack, 25).
location(square_one_computer_shack, toronto).
canShip(galaxy_tab_10, toronto).
```

## Lexicon

The lexicon allows the program to understand various components of a sentence:

- **Articles**: `a`, `an`, `any`.
- **Adjectives**: Descriptive words like `rated`, `highly_rated`, `cheap`, and `expensive` that apply to products.
- **Common Nouns**: Words related to products, like `price`, `rating`, `stock`, and `store`.
- **Proper Nouns**: Names of products, stores, and cities.
- **Prepositions**: Words like `of`, `in`, `at`, `between`, and `with` that help specify relationships between objects.

## Example Queries

The program can answer a variety of questions such as:

1. "What is the price of the Galaxy Tab 10?"
2. "Which stores have the X1 Carbon in stock?"
3. "Is there a MacBook Pro available in Montreal?"
4. "Can the Odyssey monitor be shipped to Toronto?"
5. "Find me a product with a rating between 4 and 5."

## Installation

To run the program:

1. Clone the repository:
   ```bash
   git clone https://github.com/MaherMuhtadi/Computer-Shack-NLP.git
   ```

2. Install Eclipse Prolog (or any compatible Prolog environment).

3. Load the `.pl` file in Eclipse Prolog or another Prolog environment.

4. Query the system using natural language queries. For example:
   ```prolog
   ?- what([what, is, the, price, of, the, galaxy_tab_10], Ref).
   ```
