public class DataProcessor {
    public static void updateRecords(Map<String, String> fieldValues, List<SObject> records) {
        try {
            if (fieldValues == null || fieldValues.isEmpty() || records == null || records.isEmpty()) {
                return;
            }
            
            List<SObject> recordsToUpdate = new List<SObject>();
            
            for (SObject record : records) {
                try {
                    for (String fieldName : fieldValues.keySet()) {
                        record.put(fieldName, fieldValues.get(fieldName));
                    }
                    recordsToUpdate.add(record);
                } catch (Exception e) {
                    // Handle the error for this specific record (e.g., log the issue, send an alert)
                }
            }
            
            if (!recordsToUpdate.isEmpty()) {
                Database.SaveResult[] results = Database.update(recordsToUpdate, false);
                
                for (Integer i = 0; i < results.size(); i++) {
                    if (!results[i].isSuccess()) {
                        // Capture details about the failed update (e.g., log the record ID and error message)
                    }
                }
            }
        } catch (Exception ex) {
            // Handle unexpected errors that may affect the entire process (e.g., log the error, trigger an alert)
        }
    }
}