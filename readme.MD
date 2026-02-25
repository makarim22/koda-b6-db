``` mermaid
erDiagram

    USER ||--o{ ORDER : "melakukan"
    USER ||--o{ CART : "memiliki"
    USER ||--o{ USER_REVIEW : "menulis"

    PRODUCT ||--o{ CART : "ditambahkan ke"
    PRODUCT ||--o{ ORDER_DETAIL : "mempunyai"
    PRODUCT ||--o{ USER_REVIEW : "menerima"
    PRODUCT ||--o{ PRODUCT_IMAGE : "memiliki"
    PRODUCT ||--o{ CATEGORY : "memiliki"
    PRODUCT_VARIANT ||--o{ PRODUCT : "mengkategorikan"
    PRODUCT_SIZE ||--o{ PRODUCT : "memiliki"
    PRODUCT || --o{ PRODUCT_CATEGORY_MAP : "memiliki"
    CATEGORY || --O{ PRODUCT_CATEGORY_MAP : "memiliki"

    ORDER ||--o{ ORDER_DETAIL : "termasuk"
    ORDER ||--|| PAYMENT : "memiliki"
    ORDER ||--o{ USER_REVIEW : "menghasilkan"

    SIZE ||--o{ ORDER_DETAIL : "digunakan di"
    SIZE ||--o{ CART : "digunakan di"
    TEMPERATURE ||--o{ ORDER_DETAIL : "digunakan di"
    TEMPERATURE ||--o{ CART : "digunakan di"

    USER {
        int id PK
        string full_name
        string email
        string password
        string phone
        string profile_image
    }

    PRODUCT {
        int id PK
        string product_name
        text description
        int stock
        decimal base_price
        int product_variant_id FK
        int product_size_id FK
    }

    PRODUCT_VARIANT {
        int id PK
        string name
        decimal additional_price
    }


    PRODUCT_SIZE {
        int id PK
        string name
        decimal additional_price
    }

    PRODUCT_IMAGE {
        int id PK
        int product_id FK
        string path
    }

    SIZE {
        int id PK
        string label
    }

    TEMPERATURE {
        int id PK
        string label
    }

    ORDER {
        int id PK
        int customer_id FK
        int shipping_address_id FK
        datetime order_date
        decimal subtotal
        decimal tax
        decimal delivery_fee
        string status
        datetime created_at
    }

    ORDER_DETAIL {
        int id PK
        int order_id FK
        int product_id FK
        int size_id FK
        int temperature_id FK
        int quantity
    }

    CART {
        int id PK
        int customer_id FK
        int product_id FK
        int size_id FK
        int temperature_id FK
        int quantity
        datetime timestamp
    }

    PAYMENT {
        int id PK
        int order_id FK
        string method
        string status
        string transaction_id
        datetime payment_date
    }

    USER_REVIEW {
        int id PK
        int user_id FK
        int product_id FK
        int order_id FK
        string message
        int rating
    }

    CATEGORY {
        int id PK
        string name
    }

    PRODUCT_CATEGORY_MAP {
        int id PK
        int product_id FK
        int category_id FK
    }