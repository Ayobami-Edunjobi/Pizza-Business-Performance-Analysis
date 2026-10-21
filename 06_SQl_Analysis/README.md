SQL Analysis

Overview

This folder contains SQL queries developed to analyse the business performance of Urban slice Pizza, a fictional business based in Tampa, Florida

The analysis uses SQL Server to transform relational data into insights that can support business decision-making.

Analysis 1: Revenue by Product Category

Business question: Which product categories generate the most revenue, and what proportion of total revenue does each category contribute?

Method

. joined order_Item, Product, and Category tables.
. Aggregated order_item records, units sold, and revenue by product category.
. Used a common table expression (CTE) and window functions to calculate each category's contributions to total revenue.
. Ranked the categories by revenue.

 Findings

Based on the current dataset:

. Pizza: $151,642 in revenue, approximately 83.4% of total revenue.
. Sides: $17,755 in revenue, approximately 9.8%.
. Beverages: $7,009 in revenue, approximately 3.9%.
. Desserts: $5,525 in revenue, approximately 3.0%.

Total recorded revenue is $181,931 across 12,000 order_item records.

Business implication

Pizza is leading revenue- generating category in this dataset. management could investigate which pizza products drive this performance, while exploring opportunities to increase sales of sides, 
beverages, and desserts.




















