describe 'reek_code_smells' do
  it 'should pass all code smell commands' do
    reek_output = `reek ./lib`
    expect(reek_output).to include("m0 total warnings")
  end
end