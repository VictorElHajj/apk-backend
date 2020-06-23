require_relative "../../../lib/collector/importer"

describe Importer do
    describe "importer" do
        context "given array of hashes" do
            let :importer do
                Importer.new
            end
            
            let :apk_list do
                [
                    {
                        artikelid: 2,
                        namn: '4',
                        namn2: '5',
                        prisinklmoms: 6.00,
                        pant: 1.50,
                        volymiml: 700.0,
                        varugrupp: '8',
                        stil: '9',
                        alkoholhalt: 0.2,
                        sortiment: '10'
                    }
                ]
            end
            let :expected_result do
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
            it "import and calculate data" do
                result = importer.import(apk_list)
                expect(result).to eql(expected_result)
            end
        end
    end
end