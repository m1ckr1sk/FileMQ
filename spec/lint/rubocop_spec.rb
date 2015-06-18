describe 'rubocop_lint' do
  it 'should pass all lint commands' do
    rubocop_output = `rubocop --config rubocop.yml`
    expect(rubocop_output).to include("files inspected, no offenses detected")
  end
end