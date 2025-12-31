// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

        string requestBody ='{ \"requests\": [ { \"features\": [ { \"maxResults\": 5, \"type\": \"LABEL_DETECTION\" } ], \"image\": { \"source\": { \"imageUri\": \"https://www.partysuppliesindia.com/cdn/shop/products/Tom_Jerry_1-31.jpg?v=1735574326&width=3840\" } } } ] }';

        Http http = new Http();
        HttpRequest req = new HttpRequest();

        req.setMethod('POST');
        req.setEndpoint('https://vision.googleapis.com/v1/images:annotate?key=REMOVED');
        req.setHeader('content-Type', 'application/json');
        req.setBody(requestBody);
        HttpResponse res = http.send(req);

        
        System.debug('Asjad:' + res.getBody()) ;