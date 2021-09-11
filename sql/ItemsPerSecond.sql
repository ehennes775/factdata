--
-- Calculates the items per second, of all ingredients, to create a single product
--

with recursive material(ProductId, Name, ItemsPerSecond, FactoryCapacity) as (
    select ProductId,
           Name,
           0.125                                             as ItemsPerSecond,
           0.125 * Product.CraftingTime / (QuantityProduced) as FactoryCapacity
    from Product
    where ProductId = 157

    union all

    select I.ProductId,
           I.Name,
           M.ItemsPerSecond * R.Quantity                                           as ItemsPerSecond,
           (M.ItemsPerSecond * R.Quantity * I.CraftingTime) / (I.QuantityProduced) as FactoryCapacity
    from material M
             join Recipe R on material.ProductId = R.ProductId
             join Product I on R.IngredientId = I.ProductId
)


select Name, sum(ItemsPerSecond), sum(FactoryCapacity)
from material
group by ProductId;
