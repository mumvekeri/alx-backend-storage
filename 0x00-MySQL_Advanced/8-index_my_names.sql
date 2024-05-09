-- Assuming the table names is already imported and exists

-- Create an index on the first letter of the name column
CREATE INDEX idx_name_first ON names (name(1))

