categories <- factor(c("OfficeSupplies", 'Computers', 'Packaging', 'Machinery', 'Building'))
categories

# Ini dataFrames di R
categories_df <- data.frame(categories=c("OfficeSupplies", 'Computers', 'Packaging', 'Machinery', 'Building'),
                            category_id=c(111, 112, 113, 114, 115))
categories_df

categories_df$category_id + 1
categories_df$categories
categories_df
