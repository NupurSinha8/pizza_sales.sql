---total number of orders placed
select COUNT(order_id) as total_orders from orders;

---total revenue generated from sales
select round(sum(order_details.quantity * pizzas.price),2) as total_revenue 
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id;

---highest-priced pizza
select top 1 pizza_types.name, round((pizzas.price),2) as price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc;

---most common pizza size ordered
select top 1 pizzas.size, count(order_details.quantity) as order_count
from pizzas join order_details 
on pizzas.pizza_id =order_details.pizza_id
group by pizzas.size
order by pizzas.size;

---top 5 most ordered pizza types with quantity
select top  5 pizza_types.name, sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by quantity desc;

---total quantity of each pizza category ordered
select pizza_types.category, sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by category
order by quantity desc;

---Determine the distribution of orders by hour of the day
select (orders.time), count(order_id) as order_count 
from orders 
group by orders.time
order by order_count desc

---Join relevant tables to find the category-wise distribution of pizzas
select pizza_types.category, count(pizza_types.pizza_type_id)
from pizza_types
group by category

---Group the orders by date and
---calculate the average number of pizzas ordered per day
select avg(order_quantity) as avg_qty from
(select orders.date, sum(order_details.quantity) as order_quantity
from orders join order_details 
on orders.order_id = order_details.order_id
group by orders.date) as order_qty

---top 3 most ordered pizza types based on revenue
select top 3 pizza_types.name, SUM(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by revenue desc

---percentage contribution of each pizza category to total revenue
select pizza_types.category,
round(sum(order_details.quantity * pizzas.price) / (select round(sum(order_details.quantity * pizzas.price),2) as total_sales
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id) * 100,2) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by category
order by revenue desc




























































