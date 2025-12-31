public with sharing class CloudVisionController {
    public CloudVisionController() {

    }
     @AuraEnabled
     public static List<ImageAnnotationInfo> getImageInfo(){
        
        string requestBody ='{ \"requests\": [ { \"features\": [ { \"maxResults\": 5, \"type\": \"LABEL_DETECTION\" } ], \"image\": { \"source\": { \"imageUri\": \"https://www.partysuppliesindia.com/cdn/shop/products/Tom_Jerry_1-31.jpg?v=1735574326&width=3840\" } } } ] }';

        Http http = new Http();
        HttpRequest req = new HttpRequest();

        req.setMethod('POST');
        req.setEndpoint('https://vision.googleapis.com/v1/images:annotate?key=REMOVED');
        req.setHeader('content-Type', 'application/json');
        req.setBody(requestBody);
        HttpResponse res = http.send(req);

        if(res.getStatusCode() == 200){
            //return res.getBody();

            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());

            List<Object> responseList = (List<Object>) responseMap.get('responses');

            Map<String, Object> firstResponse = (Map<String, Object>) responseList[0];

            List<Object> labelAnnotations = (List<Object>) firstResponse.get('labelAnnotations');

            // Create a variable of type List<ImageAnnotationInfo>
            List<ImageAnnotationInfo> imagesInfo = new List<ImageAnnotationInfo>();

            for (Object annotation : labelAnnotations) {

            Map<String, Object> annotationMap = (Map<String, Object>) annotation;
            String description = (String) annotationMap.get('description');
            Decimal score = (Decimal) annotationMap.get('score');

            System.debug('Description: ' + description + ', Score: ' + score);

            // 2. Create ImageAnnotationInfo record(s)
          ImageAnnotationInfo imageInfo = new ImageAnnotationInfo();
          imageInfo.description = description;
          imageInfo.score = score;
 
          //3. Add the records to the List
          imagesInfo.add(imageInfo);
        }

        System.debug('ImagesInfo: ' + imagesInfo);
        return imagesInfo;
        }
        return null;

     }
    
     //wrapper class to be used for deserialisation
     public class ImageAnnotationInfo {
      @AuraEnabled
      public String description;
      @AuraEnabled
      public Decimal score;
    }
}