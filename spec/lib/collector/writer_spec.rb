require_relative "../../../lib/collector/writer"

describe Writer do
    describe "writer" do
        context 'given data' do
            let :writer do
                Writer.new(':memory:')
            end

            let :data do
                [
                    {
                        id: 2,
                        apk: 18.667, 
                        name: '4 5',
                        price: 7.5,
                        volume: 700.0,
                        style: '9',
                        type: '8',
                        abv: 0.2,
                        availability: '10'
                    }
                ]
            end
            
            let :expected_result do
                [[2, 18.667, '4 5', 7.5, 700.0, '8', '9', 0.2, '10']]
            end

            it 'write to db' do
                expect(writer.write(data).execute('SELECT * FROM apk;')).to eql(expected_result)
            end
        end
    end
end