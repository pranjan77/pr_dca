/*
A KBase module: pr_dca
*/

module pr_dca {
    /*
        A string representing a Genome id.
    */
    typedef string genome_id;

    /*
        A string representing a workspace name.
    */
    typedef string workspace_name;

    typedef structure {
        workspace_name workspace;
        genome_id genome_id;
    } DBCanParams;

    typedef structure {
    		string report_name;
	    	string report_ref;
    } ResultsToReport;

  	async funcdef run_dbcan (DBCanParams) returns (ResultsToReport) authentication required;

};
