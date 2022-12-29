import Foundation


extension URLSession{
    func fetchData( at url: URL, completion:@escaping(Swift.Result<QuoteData, Error>)->Void){
        
        self.dataTask(with: url){ data, response, error in
            if data != nil && error == nil {
                do{
                    let fetchingData = try JSONDecoder().decode(QuoteData.self, from: data!)
                    self.parseJSON(data!)
                    completion(.success(fetchingData))
                   
                }catch{
                    completion(.failure(error))
                    print(error)
                   
                }
            }
        }.resume()
        
    }
    func parseJSON(_ quoteData: Data) -> Void{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(QuoteData.self, from: quoteData)
            
            QuoteModel.quote = decodedData.content
            QuoteModel.author = decodedData.author
            
    
        } catch {
            print(error)
        }
    }
    
}

