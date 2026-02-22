``` mermaid
erDiagram
    USER ||--o{ ORDER : "places"
    USER ||--o{ CART : "has"
    PRODUCT ||--o{ CART : "added_to"
    PRODUCT ||--o{ ORDER_DETAIL : "contains"
    ORDER ||--o{ ORDER_DETAIL : "includes"
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
        text description
        string photo
        string size
        int stock
        decimal price
        decimal originalPrice
        
    }

    ORDER {
        id int PK
        int customer_id FK
        datetime order_date
        decimal subtotal
        decimal tax
        decimal delivery_fee
        decimal total
        string status
        datetime created_at
    }

    ORDER_DETAIL {
        id int PK
        string order_id FK
        int product_id FK
        int quantity
        string size
        string temperature
        decimal price
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