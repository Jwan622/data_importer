describe 'Redemptions CSV' do
  it 'creates the correct redemption output csv from the input csv' do
    orders_path = 'spec/fixtures/test_orders.csv'
    redemptions_path = 'spec/fixtures/test_redemptions.csv'

    input_rows = CSV.read(orders_path)

    expect(input_rows[0]).to eq([14,2,6,"milk"])
    expect(input_rows[1]).to eq([12,2,5,"milk"])
    expect(input_rows[2]).to eq([12,4,4,"dark"])
    expect(input_rows[3]).to eq([6,2,2,"sugar free"])
    expect(input_rows[4]).to eq([6,2,2,"white"])

    OrderProcessor.process(orders_path)

    output_rows = CSV.read(redemptions_path)

    expect(output_rows[0]).to eq(['milk 8', 'dark 0', 'white 0', 'sugar free 1'])
    expect(output_rows[1]).to eq(['milk 7', 'dark 0', 'white 0', 'sugar free 1'])
    expect(output_rows[2]).to eq(['milk 0', 'dark 3', 'white 0', 'sugar free 0'])
    expect(output_rows[3]).to eq(['milk 0', 'dark 3', 'white 0', 'sugar free 5'])
    expect(output_rows[4]).to eq(['milk 0', 'dark 1', 'white 5', 'sugar free 3'])

    File.delete(redemptions_path )
  end
end