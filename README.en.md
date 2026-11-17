# Orgânicos — Online Supermarket

**Language / Idioma:** [🇵🇹 Português](README.md) | **🇬🇧 English**

**E-commerce web application developed with PHP, MySQL, JavaScript, HTML and CSS.**

This project simulates an online supermarket: visitors can browse and search products, register an account, manage their shopping cart, place orders and view their order history. It also includes an administration panel for managing products, users and orders.

It was developed as a learning project and a demonstration of **full-stack web development** skills, with a particular focus on **PHP, relational databases, web security, external service integration and automated deployment**.

**[Live demo](https://abarrosk.rf.gd/)** · **[Source code](https://github.com/Abarrosk/supermercado_virtual_final)**

> **Note:** This is a demonstration application, not a commercial online store. It does not process real payments.

---

## Table of contents

1. [Application features](#application-features)
2. [Technologies and libraries](#technologies-and-libraries)
3. [Web security](#web-security)
4. [Object-oriented programming and design patterns](#object-oriented-programming-and-design-patterns)
5. [Other programming concepts](#other-programming-concepts)
6. [Database](#database)
7. [External service integration](#external-service-integration)
8. [Architecture and project structure](#architecture-and-project-structure)
9. [Automated deployment](#automated-deployment)
10. [Running locally](#running-locally)
11. [Known limitations and future improvements](#known-limitations-and-future-improvements)

## Application features

### Product catalogue and search

- Dynamic display of products retrieved from a MySQL database.
- Products organised by category.
- Search by product name using `LIKE` and parameterised queries.
- **Best-selling**, **featured**, **popular**, **recent** and **random** product listings based on the corresponding database fields.
- Category filters and an option to display all results.
- Promotions with discounted prices, discount percentages and expiry dates.
- Product cards generated through a reusable PHP function.
- Responsive interface and product carousels.

**Main files:** [`inc/products.php`](inc/products.php), [`inc/search.php`](inc/search.php), [`inc/render_card.php`](inc/render_card.php), [`homepage.php`](homepage.php) and [`comprar.php`](comprar.php).

### Authentication and customer area

- User registration, including field validation and duplicate-email checks.
- Email-and-password authentication.
- PHP session management and logout.
- Viewing and updating personal information.
- Password changes requiring verification of the current password.
- Order history for authenticated users.
- Distinction between standard and administrator accounts.

**Main files:** [`inc/auth.php`](inc/auth.php), [`login.php`](login.php), [`registar.php`](registar.php) and [`userProfile.php`](userProfile.php).

### Shopping cart, checkout and orders

- Adding products to the cart and increasing quantities of existing items.
- Removing items and clearing the shopping cart.
- Shopping cart state stored in `$_SESSION`.
- Calculation of subtotals, discounts and order totals.
- Asynchronous JavaScript requests to update values in the interface.
- Stock availability checks at checkout.
- Validation of billing information, including email, address and date of birth.
- Shipping cost calculation based on estimated distance.
- Storage of orders and their line items in the database.
- **SQL transactions** when creating orders, including `commit()` and `rollBack()`.
- Order history linked to the authenticated customer account.

**Main files:** [`inc/cart.php`](inc/cart.php), [`inc/orders.php`](inc/orders.php), [`checkout.php`](checkout.php), [`js/checkout.js`](js/checkout.js) and [`api/`](api/).

### Administration panel

Access restricted to administrator accounts, with features including:

- Listing, creating, editing and deleting products, subject to existing constraints.
- Managing product categories, prices, promotions, dates and stock information.
- Uploading and associating product images.
- Generating readable slugs and checking their uniqueness.
- Listing and searching users using several fields.
- Logically disabling standard user accounts (**soft delete**).
- Viewing and searching orders.
- Viewing order items and other order details.

**Main files:** [`admin_dashboard.php`](admin_dashboard.php) and the [`admin/`](admin/) directory.

---

## Technologies and libraries

| Area | Technologies | Purpose |
| --- | --- | --- |
| Backend | **PHP** | Application logic, authentication, sessions, forms and orders |
| Database | **MySQL / MariaDB** | Relational storage of products, users and orders |
| Data access | **PDO** | Database connections and parameterised SQL queries |
| Frontend | **HTML5, CSS3, JavaScript** | Structure, presentation and interactivity |
| Responsive UI | **Bootstrap 5** | Grid system, components, forms, modals and tooltips |
| JavaScript libraries | **jQuery, Swiper.js 9** | UI manipulation and carousels |
| Icons | **Font Awesome, Boxicons, Material Design Icons, SVG** | Interface graphics |
| Asynchronous communication | **Fetch API, JSON** | Communication between the browser and PHP endpoints |
| External services | **PHP cURL, Nominatim / OpenStreetMap** | Address geocoding |
| Version control | **Git and GitHub** | Source control and project history |
| Deployment | **GitHub Actions, FTPS, InfinityFree** | Automated application deployment |

> The application uses **plain PHP, without Laravel or Symfony**. Bootstrap is the frontend framework; PDO, jQuery and Swiper are libraries or specialised programming interfaces.

## Web security

The project implements several security measures, demonstrating important web application security concepts. **These measures do not constitute a security audit or a guarantee that the application is free of vulnerabilities.**

| Measure | Implementation | Reference |
| --- | --- | --- |
| **SQL injection mitigation** | Parameterised queries with `PDO::prepare()` and `execute()`; emulated prepared statements disabled | [`inc/db.php`](inc/db.php), [`inc/auth.php`](inc/auth.php), [`inc/search.php`](inc/search.php) |
| **XSS mitigation** | HTML output escaping through `htmlspecialchars()` and the `e()` helper function | [`config/bootstrap.php`](config/bootstrap.php) |
| **CSRF protection** | Tokens generated with `random_bytes()`, included in forms and verified using `hash_equals()` | [`inc/csrf.php`](inc/csrf.php) |
| **Password protection** | `password_hash()` and `password_verify()`; Argon2id where available, with a configured fallback | [`inc/auth.php`](inc/auth.php) |
| **Session security** | `HttpOnly`, `SameSite=Lax`, strict session mode and `Secure` for HTTPS; session ID regeneration after authentication | [`inc/security.php`](inc/security.php), [`inc/auth.php`](inc/auth.php) |
| **Content Security Policy (CSP)** | Policy restricting allowed sources and use of nonces for selected scripts | [`inc/security.php`](inc/security.php) |
| **HTTP security headers** | `X-Content-Type-Options`, `X-Frame-Options` and `Referrer-Policy` | [`config/bootstrap.php`](config/bootstrap.php) |
| **Access control** | Authentication and administrator-role checks before access to the dashboard | [`inc/auth.php`](inc/auth.php), [`admin_dashboard.php`](admin_dashboard.php) |
| **Login attempt limiting** | Basic, session-based limiting of failed login and password-change attempts | [`inc/auth.php`](inc/auth.php) |
| **Server-side validation** | Required fields, emails, formats, permissions and checkout data are validated | [`registar.php`](registar.php), [`userProfile.php`](userProfile.php), [`checkout.php`](checkout.php) |
| **Private configuration** | Database credentials kept in a separate file excluded from Git | [`inc/db.php`](inc/db.php), [`.gitignore`](.gitignore) |

**Examples:**

- Protected forms include `csrf_field()`; the server uses `csrf_verify()` to reject invalid tokens.
- User-supplied values are bound to SQL query parameters instead of being concatenated into SQL statements.
- Dashboard access requires authentication and an `is_admin` check.
- Passwords are stored as hashes rather than plaintext.

## Object-oriented programming and design patterns

### Object-oriented PHP

The [`Auth`](inc/auth.php) class centralises authentication-related operations and demonstrates:

- Defining a **class** and its **methods**.
- **Public** and **private** methods.
- **Static** methods and internal calls using `self::`.
- **Encapsulation** of related operations, such as login, registration, logout and password changes.
- **Parameter and return types**, including nullable types (`?array`).
- **Exceptions** (`InvalidArgumentException`, `RuntimeException`) and handling them with `try/catch`.

The application also uses PHP-provided objects, particularly `PDO`, `DateTime` and `DateTimeImmutable`.

> The project demonstrates OOP concepts, but **it is not presented as a fully object-oriented architecture**. No custom implementations of inheritance, polymorphism or interfaces were identified.

### Patterns and code organisation

- **Singleton-like approach:** the `db()` function uses a local `static` variable to reuse a `PDO` instance within a request instead of repeatedly opening database connections. This resembles Singleton behaviour but is not the classic class-based Singleton pattern.
- **Post/Redirect/Get (PRG):** several POST operations finish with a redirect, reducing accidental form resubmission.
- **Separation of concerns:** dedicated modules for authentication, database access, shopping cart, orders, search, security and shipping.
- **Reusable components:** the `render_card_produto()` function provides consistent product-card rendering across pages.

## Other programming concepts

### PHP

- Custom functions, code reuse and argument passing.
- Optional parameters, default values and return types.
- `declare(strict_types=1)` in selected modules.
- Associative and multidimensional arrays.
- Iteration with `foreach` and `while`, plus conditional statements.
- Anonymous functions and **arrow functions** (`fn`).
- Array operations such as `array_filter()`, `array_column()`, `array_sum()` and `array_fill()`.
- Regular expressions using `preg_match()`, `preg_replace()` and `preg_split()`.
- Name normalisation and slug generation.
- Date operations and comparisons with `DateTime` and `DateTimeImmutable`.
- Currency and date formatting.
- Input validation through `filter_var()` and `FILTER_VALIDATE_EMAIL`.
- Exceptions, error handling and HTTP response codes (`403`, `405`, `419`, `429`, among others).
- HTTP redirects, sessions and PHP superglobals (`$_GET`, `$_POST`, `$_SESSION`, `$_FILES`).
- Modular includes with `require` and `require_once`.

**Regarding recursion:** no function calling itself was identified in the analysed code. Unique slug generation uses a `while` loop (**iteration**, not recursion).

### JavaScript

- **DOM manipulation** with `querySelector()`, `querySelectorAll()` and content updates.
- Event handling with `addEventListener()` and `event.preventDefault()`.
- Code initialisation after `DOMContentLoaded`.
- Form validation and interactions.
- Asynchronous **`fetch()`** requests, with promises handled through `.then()` and `.catch()`.
- Sending data and parsing **JSON** responses.
- Updating order totals and shipping costs without reloading the whole page.
- Anonymous functions, **callbacks** and `forEach()`.
- Code isolation using an **IIFE** in [`js/homepage.js`](js/homepage.js).
- Responsive carousel configuration with **Swiper.js**.

## Database

The application uses a relational database with the following entities:

| Table | Responsibility |
| --- | --- |
| `utilizadores` | Accounts, contact information, authentication and permissions |
| `categorias` | Product classification |
| `produtos` | Products, prices, promotions and stock |
| `encomendas` | Order-level information |
| `encomendas_itens` | Order line items and quantities |

**SQL concepts demonstrated:**

- Relational modelling and entity relationships.
- Primary keys, foreign keys and referential integrity.
- `UNIQUE` constraints, indexes and `AUTO_INCREMENT`.
- **CRUD** operations: `INSERT`, `SELECT`, `UPDATE` and `DELETE`.
- `INNER JOIN` / `JOIN` and `LEFT JOIN` queries.
- Searching with `LIKE`, sorting with `ORDER BY` and limiting results with `LIMIT`.
- SQL functions and expressions including `COUNT()`, `COALESCE()`, `CONCAT()` and `RAND()`.
- Query pagination with `LIMIT` and `OFFSET`.
- Parameterised queries with positional (`?`) and named (`:name`) placeholders.
- **Transactions** using `beginTransaction()`, `commit()` and `rollBack()`.
- User **soft deletion** through the `is_deleted` field.
- `utf8mb4` encoding for database connections and tables.

The [`organicos.sql`](organicos.sql) file contains the database schema and demonstration data.

## External service integration

Shipping cost estimation is implemented in [`inc/shipping.php`](inc/shipping.php):

1. The address is sent to the **Nominatim** geocoding service, associated with OpenStreetMap.
2. PHP **cURL** sends the HTTP request.
3. The **JSON** response is parsed to obtain latitude and longitude.
4. The estimated distance is calculated using the **Haversine formula**.
5. Shipping rules are applied: **free within 30 km**, plus **€2 per additional 5 km block**.
6. The checkout can request a new estimate through the **Fetch API**, dynamically updating the displayed shipping cost.

Geocoding depends on an external service. The calculated distance is geographical and **does not necessarily represent driving distance**.

## Architecture and project structure

```text
supermercado_virtual_final/
├── .github/
│   └── workflows/
│       └── deploy.yml        # Automated deployment
├── admin/                    # Administration sections
│   ├── section_orders.php
│   ├── section_products.php
│   └── section_users.php
├── api/                      # PHP endpoints for asynchronous requests
│   ├── cart_add.php
│   ├── cart_clear.php
│   ├── cart_remove.php
│   └── shipping_quote.php
├── config/
│   └── bootstrap.php        # Initialisation, security and helpers
├── inc/                      # Reusable PHP modules
│   ├── auth.php
│   ├── cart.php
│   ├── csrf.php
│   ├── db.php
│   ├── orders.php
│   ├── products.php
│   ├── render_card.php
│   ├── search.php
│   ├── security.php
│   └── shipping.php
├── css/                      # Stylesheets
├── js/                       # JavaScript scripts
├── images/                   # Images and icons
├── fonts/                    # Font files
├── admin_dashboard.php
├── checkout.php
├── comprar.php
├── homepage.php
├── login.php
├── logout.php
├── registar.php
├── userProfile.php
├── organicos.sql
├── README.md                  # Portuguese version
└── README.en.md               # English version
```

The application follows a **modular, primarily procedural PHP structure with an authentication class**. It is not a complete MVC architecture.

## Automated deployment

The [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml) file configures automated deployment through **GitHub Actions**:

1. A `push` to the `main` branch triggers deployment; the workflow can also be run manually.
2. `actions/checkout` retrieves the repository contents.
3. `SamKirkland/FTP-Deploy-Action` uploads application files over **FTPS** to InfinityFree.
4. Access credentials are supplied through **GitHub Secrets**.
5. Private configuration, SQL files and other excluded resources are not uploaded by the automated process.

**Note:** Images are currently excluded from the FTPS workflow and managed directly on the hosting service. This workflow automates **deployment**, but it does not run automated tests.

## Running locally

### Requirements

- PHP 8 or later, with the extensions required by the application, including `pdo_mysql`, `mbstring` and `curl`.
- MySQL or MariaDB.
- A PHP-compatible web server, or PHP's built-in development server.

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/Abarrosk/supermercado_virtual_final.git
   cd supermercado_virtual_final
   ```

2. Create a MySQL database and import [`organicos.sql`](organicos.sql), which contains the schema and demonstration data.

3. Create the private `config/db.private.php` file containing local database credentials:

   ```php
   <?php
   return [
       'host'     => '127.0.0.1',
       'port'     => 3306,
       'database' => 'organicos',
       'username' => 'LOCAL_USERNAME',
       'password' => 'LOCAL_PASSWORD',
   ];
   ```

   This file is listed in `.gitignore` and **must not be committed to GitHub**.

4. Start the development server from the project root:

   ```bash
   php -S localhost:8000
   ```

5. Open [http://localhost:8000/homepage.php](http://localhost:8000/homepage.php).

> Access to the administration panel requires an administrator account. No credentials are published for the public demonstration.

## Known limitations and future improvements

This is a demonstration project. Some features have been intentionally simplified or are beyond the scope of this version:

- **Payments:** Payment methods are shown in the UI, but no real financial transactions are processed.
- **Password recovery:** Email-based account recovery has not been implemented.
- **Geocoding:** Depends on Nominatim availability; error handling when the external service fails could be improved.
- **Inventory and orders:** Stock updates and consistency between current prices and order line-item values are areas for improvement.
- **Uploaded file security:** More rigorous validation of image types and contents in the administration panel is planned.
- **Automated tests:** There is currently no unit or integration test suite.

---

**Project objective:** apply and demonstrate skills in web development, PHP and JavaScript programming, relational database modelling, security and automated deployment in a functional e-commerce application.
