module ItemOrderSupport
  def item_order(order_address)

    visit item_orders_path(@another_item.id)
    expect(current_path).to eq(item_orders_path(@another_item.id))
    fill_in 'order_address[number]', with: '4242424242424242'
    fill_in 'order_address[exp_month]', with: '12'
    fill_in 'order_address[exp_year]', with: '25'
    fill_in 'order_address[cvc]', with: '123'
    fill_in 'order_address[postal_num]', with: order_address.postal_num
    select "東京都", from: "prefecture"
    fill_in 'order_address[city]', with: order_address.city
    fill_in 'order_address[address]', with: order_address.address
    fill_in 'order_address[building]', with: order_address.building
    fill_in 'order_address[phone_num]', with: order_address.phone_num


  end
end
