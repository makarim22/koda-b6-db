``` mermaid
erDiagram
    USER ||--o{ ORDER : "places"
    USER ||--o{ CART : "has"
    PRODUCT ||--o{ CART : "added_to"
    PRODUCT ||--o{ ORDER_PRODUCT : "contains"
    ORDER ||--o{ ORDER_PRODUCT : "includes"
    ORDER ||--|| PAYMENT : "has"
    ORDER ||--|| SHIPPING : "has"

    USER {
        int id PK
        string fullname
        string email
        string password
        string address
        string phone
        string profileImage
    }

    PRODUCT {
        int id PK
        string product_name
        decimal price
        text description
        string photo
        string product_size
        int stock
        decimal originalPrice
    }

    ORDER {
        string id PK
        int customer_id FK
        datetime order_date
        decimal subtotal
        decimal tax
        decimal delivery_fee
        decimal total
        string status
        datetime created_at
    }

    ORDER_PRODUCT {
        string order_id PK,FK
        int product_id PK,FK
        int quantity
        string size
        string temperature
        decimal price
        decimal originalPrice
        decimal totalPrice
    }

    CART {
        int id PK
        int customerId FK
        int product_id FK
        int quantity
        string size
        string temperature
        datetime timestamp
    }

    PAYMENT {
        int id PK
        int order_id FK
        string method
        decimal amount
        string status
        string transaction_id
        datetime payment_date
    }

    SHIPPING {
        int id PK
        int order_id FK
        string carrier
        decimal fee
        string status
    }