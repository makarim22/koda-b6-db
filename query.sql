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




/// 2

select 
o.id as order_id,
od.id as order_detail_id,
p.product_name,
od.quantity,
s.name as size,
t."label" as variant, 
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


/// 3

select
 product_name,
 description,
 base_price,
 product_image,
 isflashsale 
from products;

/// 4
select 
product_image,
product_name,
description,
rating,
base_price,
discount_percentage
from products p
left join discount d
on p.id = d.product_id;