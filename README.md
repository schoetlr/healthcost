# healthcostconnect

Hi! If you are checking out my code, I have to point out two egregious design errors I made due to this being my first project ~2 years ago.  The first is that the same procedures are created for each different provider.  For example, Provider A, will have procedure A, B, and C and if Provider B also has procedure A, B, C they will be recreated.  I should have just made a simple joins table named something like ProviderProcedures that has a provider id and a procedure id.  

Similarily, I made the procedure identification code that insurance companies and physicians use be a column in the procedure table.  These codes should be their own table joined to the procedures by their respective ids.

I might get around to correcting these problems in the future if I decide to put effort into scaling this application.  
