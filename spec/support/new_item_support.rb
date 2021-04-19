module NewItemSupport
  def new_item(item)
    visit new_item_path
    attach_file "item-image", "public/images/sample.png"
    fill_in 'item[name]', with: @item.name
    fill_in 'item[explain]', with: @item.explain
    select "メンズ", from: "item[category_id]"
    select "未使用に近い", from: "item[status_id]"
    select "着払い(購入者負担)", from: "item[postage_id]"
    select "東京都", from: "item[carry_area_id]"
    select "2~3日で発送", from: "item[carry_date_id]"
    fill_in 'item[price]', with: @item.price
    expect {
      click_on '出品する'
    }.to change{ Item.count }.by(1)
    expect(current_path).to eq(root_path)
  end
end