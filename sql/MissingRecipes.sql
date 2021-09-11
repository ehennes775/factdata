--
-- Finds recipes that have not been entered into the database
--

select P.ProductId,
       P.Name
from Product P
         left join Recipe R on P.ProductId = R.ProductId
where R.ProductId is NULL;
