require_relative "../../../lib/collector/extractor/"

describe Extractor do
    describe "extract" do
        context "given test xml file" do
            let :extractor do
                Extractor.new
            end

            let :sheet do
                <<~XML
                    <artiklar>
                        <skapad-tid>2020-06-04 05:20</skapad-tid>
                        <info>
                            <meddelande>example</meddelande>
                        </info>
                        <artikel>
                            <nr>1</nr>
                            <Artikelid>2</Artikelid>
                            <Varnummer>3</Varnummer>
                            <Namn>4</Namn>
                            <Namn2>5</Namn2>
                            <Prisinklmoms>6.00</Prisinklmoms>
                            <Pant>7.00</Pant>
                        </artikel>
                        <artikel>
                            <nr>8</nr>
                            <Artikelid>9</Artikelid>
                            <Varnummer>10</Varnummer>
                            <Namn>11</Namn>
                            <Namn2>12</Namn2>
                            <Prisinklmoms>13.00</Prisinklmoms>
                            <Pant>14.00</Pant>
                        </artikel>
                    </artiklar>
                XML
            end

            let :expected_result do 
                [
                    {
                        nr: '1',
                        artikelid: 2,
                        varnummer: '3',
                        namn: '4',
                        namn2: '5',
                        prisinklmoms: 6.00,
                        pant: 7.00
                    },
                    {
                        nr: '8',
                        artikelid: 9,
                        varnummer: '10',
                        namn: '11',
                        namn2: '12',
                        prisinklmoms: 13.00,
                        pant: 14.00
                    }
                ]
            end
            it "extract info and put it into array of hashes" do
                expect(extractor.extract(sheet.tr!(' ', '').tr!("\n", ''))).to eql(expected_result)
            end
        end
    end
end