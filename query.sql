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