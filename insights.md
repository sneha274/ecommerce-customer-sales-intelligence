# E-Commerce Customer & Sales Intelligence — Insights

Dataset: Olist Brazilian E-Commerce (9 tables, ~96,500 delivered orders, 2016-2018)

## Insight 1: Late delivery is the strongest driver of bad reviews
- On-time orders: 4.21 average star rating
- Late orders: 2.55 average star rating (a ~1.7 star drop)
- Only 8.1% of orders are late, but this group accounts for a disproportionate share of 1-star reviews (9.8% of all orders are 1-star).
- Recommendation: delivery speed/reliability improvements will move customer satisfaction more than almost any other lever.

## Insight 2: The relationship is a steep decline, not gradual
- 0-7 days: 4.33 stars
- 8-14 days: 4.20 stars
- 15-21 days: 4.02 stars
- 22+ days: 2.98 stars
- The drop accelerates sharply past ~3 weeks — this is the threshold to protect against operationally.

## Insight 3: Delivery performance varies sharply by region
- São Paulo (SP), the largest customer base (40,494 orders): 8.3 day avg delivery, 4.18 star reviews
- Bahia (BA): 18.7 day avg delivery (over 2x SP), 3.86 star reviews — the worst combination of slow + dissatisfied
- Recommendation: investigate logistics/fulfillment specifically for northern/northeastern states (BA, ES, GO all show 14.9-18.7 day averages vs SP's 8.3)

## Insight 4: Bed_bath_table category has a satisfaction problem despite strong sales
- 2nd highest revenue category among top 10 ($1.09M) but the LOWEST average review score (3.92) of the top 10
- Worth investigating: product quality, sizing/description accuracy, or packaging/shipping damage specific to this category

## Insight 5: Credit card + installments dominate purchasing behavior
- 74,297 of ~96,500 orders (77%) paid by credit card, averaging 3.6 installments per purchase
- Boleto (bank slip), voucher, and debit card are all single-payment, no installments
- This suggests Brazilian e-commerce customers rely heavily on installment financing — relevant for any pricing or checkout UX decisions

## Insight 6: Repeat purchase rate is extremely low (Python analysis)
- Using the correct customer identifier (customer_unique_id — note: customer_id is actually
  unique PER ORDER in this dataset, a common trap in the Olist data)
- Only 3.00% of customers place a second order; 97% buy exactly once and never return.
- This context matters for Insight #1: with so little repeat business, Olist has very little
  margin for customer experience mistakes — there's rarely a "next order" to win a customer back with.

## Insight 7: Review score is a weak predictor of repeat purchase (an honest non-finding)
- First-order review score barely moves repeat purchase rate: 2.4% (1-star) vs 3.2% (5-star) — a small, real
  difference, but nowhere near large enough to explain the overall 97% one-and-done rate.
- This suggests the near-total lack of repeat purchases is a structural pattern (e.g. one-off big-ticket
  categories, no re-engagement/marketing loop) rather than something delivery speed alone would fix.
- Recommendation: delivery/satisfaction improvements are still worth making (they clearly drive review score),
  but retention strategy needs its own separate investment (email re-engagement, loyalty incentives) —
  fixing delivery alone won't meaningfully move repeat purchase rate.

## Next to explore
- Customer repeat-purchase / retention patterns (which customers order more than once?)
- Whether product category affects delivery time (some categories may ship slower)
- Seller-level performance (are late deliveries concentrated among specific sellers?)
