select p.product_name, pc.name, pc.description, v.name, v.additional_price, s.name from products p
left join product_category_map pcm 
on p.id = pcm.product_id 
left join product_category pc 
on pcm.category_id = pc.id 
left join product_variant pv 
on p.id = pv.product_id
left join variants v 
on pv.variant_id = v.id
left join product_sizes ps 
on p.id = ps.product_id 
left join sizes s 
on ps.size_id  = s.id
limit 5;

///

SELECT 
    p.id,
    p.product_name,
    p.base_price,
    p.stock,
    STRING_AGG(DISTINCT pc.name, ', ') AS categories,
    STRING_AGG(DISTINCT v.name, ', ') AS variant_options,
    STRING_AGG(DISTINCT s.name, ', ') AS size_options
FROM products p
LEFT JOIN product_category_map pcm ON p.id = pcm.product_id
LEFT JOIN product_category pc ON pcm.category_id = pc.id
LEFT JOIN product_variant pv ON p.id = pv.product_id
LEFT JOIN variants v ON pv.variant_id = v.id
LEFT JOIN product_sizes ps ON p.id = ps.product_id
LEFT JOIN sizes s ON ps.size_id = s.id
GROUP BY p.id, p.product_name, p.base_price, p.stock
ORDER BY p.id
LIMIT 5;

/// 2

select 
o.id as order_id,
od.id as order_detail_id,
p.product_name,
od.quantity,
s.name,
t."label", 
p.base_price, 
s.additional_price as tambahan_harga_size,
t.additional_price as tambahan_harga_variant,
sum(s.additional_price + t.additional_price) as total_additional_price,
sum((p.base_price + s.additional_price + t.additional_price) *od.quantity ) as subtotal 
from orders o 
left join order_detail od 
on o.id = od.order_id 
left join products p 
on od.product_id = p.id
left join sizes s
on od.size_id = s.id 
left join temperature t 
on od.temperature_id = t.id 
where o.id = 1
group by o.id,od.id, p.product_name, s.name, t."label", p.base_price, od.quantity, s.additional_price , t.additional_price 
limit 3;
