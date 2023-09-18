# Cash Register App
This repository contains the solution to the Cash Register Challenge, a simple application that calculates the total price of items in a shopping cart while applying various pricing rules. The challenge involves creating a flexible and maintainable codebase that can handle different pricing scenarios for specific products.
A brief description of what this project is about.

## Prerequisites

- Ruby 2.6.0
- RSpec gem for running tests

## Approach

I followed a Test-Driven Development (TDD) approach to build this solution. Here's a brief overview of the modules:

- **Product Module**
  - Handles the product details and pricing.
  - Validates the input and ensures product code, name and price are valid.

- **Cart Module**
  - Manages the cart, allowing adding products and calculating the total price.
  - Applies pricing rules based on predefined conditions.

- **Pricing Rules**
  - Contains methods to apply various pricing rules based on product codes.

- **Checkout Module**
  - Utilizes the Cart to scan items and calculate the total price with discounts.

## Test Data

The test data used for verification are:

1. Basket: GR1,GR1, Expected Total Price: 3.11€
2. Basket: SR1,SR1,GR1,SR1, Expected Total Price: 16.61€
3. Basket: GR1,CF1,SR1,CF1,CF1, Expected Total Price: 30.57€

These test cases are covered in the `checkout_spec.rb` file.

## Unit Tests

In addition to the provided test data, there are comprehensive unit tests for the Product and Cart modules, ensuring the correctness of the implemented logic.

## Usage

- Run the tests Execute `rspec` using RSpec to ensure the correctness of the implementation.
- Execute `main.rb` to use a simple CLI that allows adding predefined products to a cart, checking out, and calculating the total price.

