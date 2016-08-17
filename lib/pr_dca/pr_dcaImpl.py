# -*- coding: utf-8 -*-
#BEGIN_HEADER

import sys
import traceback
import uuid
from pprint import pprint, pformat
from biokbase.workspace.client import Workspace as workspaceService

#END_HEADER


class pr_dca:
    '''
    Module Name:
    pr_dca

    Module Description:
    A KBase module: pr_dca
    '''

    ######## WARNING FOR GEVENT USERS #######
    # Since asynchronous IO can lead to methods - even the same method -
    # interrupting each other, you must be *very* careful when using global
    # state. A method could easily clobber the state set by another while
    # the latter method is running.
    #########################################
    VERSION = "0.0.1"
    GIT_URL = ""
    GIT_COMMIT_HASH = ""
    
    #BEGIN_CLASS_HEADER

    workspaceURL = None

    #END_CLASS_HEADER

    # config contains contents of config file in a hash or None if it couldn't
    # be found
    def __init__(self, config):
        #BEGIN_CONSTRUCTOR
        self.workspaceURL = config['workspace-url']
        #END_CONSTRUCTOR
        pass
    

    def run_dbcan(self, ctx, DBCanParams):
        """
        :param DBCanParams: instance of type "DBCanParams" -> structure:
           parameter "workspace" of type "workspace_name" (A string
           representing a workspace name.), parameter "genome_id" of type
           "genome_id" (A string representing a Genome id.)
        :returns: instance of type "ResultsToReport" -> structure: parameter
           "report_name" of String, parameter "report_ref" of String
        """
        # ctx is the context object
        # return variables are: returnVal
        #BEGIN run_dbcan
        print('Starting Annotation with DBCan')
        params = DBCanParams

        #Step1: Get Genome data
        if 'workspace' not in params:
            raise ValueError('Parameter workspace is not set in input arguments')
        workspace_name = params['workspace']
        if 'genome_id' not in params:
            raise ValueError('Parameter genome_id is not set in input arguments')
        genome_id = params['genome_id']

        token = ctx['token']
        wsClient = workspaceService(self.workspaceURL, token=token) 
        try: 
            # Note that results from the workspace are returned in a list, and the actual data is saved
            # in the 'data' key.  So to get the ContigSet data, we get the first element of the list, and
            # look at the 'data' field.
            Genome = wsClient.get_objects([{'ref': workspace_name+'/'+genome_id}])[0]['data']
        except:
            exc_type, exc_value, exc_traceback = sys.exc_info()
            lines = traceback.format_exception(exc_type, exc_value, exc_traceback)
            orig_error = ''.join('    ' + line for line in lines)
            raise ValueError('Error loading original Genome object from workspace:\n' + orig_error)
        
        print('Got Genome data.')
        
        #Step2: Parse Genome to get protein fasta files
 
        provenance = [{}]
        if 'provenance' in ctx:
            provenance = ctx['provenance']
        # add additional info to provenance here, in this case the input data object reference
        provenance[0]['input_ws_objects']=[workspace_name+'/'+genome_id]

        report =  'This is working\n'
        report += 'This is step2\n'

        reportObj = {
            'objects_created':[],
            'text_message':report
        }

        reportName = 'run_dbcan_'+str(hex(uuid.getnode()))
        report_info = ws_client.save_objects({
            'id':info[6],
            'objects':[
                 {
                  'type':'KBaseReport.Report',
                  'data':reportObj,
                  'name':reportName,
                  'meta':{},
                  'hidden':1, # important!  make sure the report is hidden
                  'provenance':provenance
                 }
            ] })[0]  
        print('saved Report: '+pformat(report_info))

	returnVal = { "report_name" : reportName,"report_ref" : str(report_info[6]) + '/' + str(report_info[0]) + '/' + str(report_info[4]) }

        #END run_dbcan

        # At some point might do deeper type checking...
        if not isinstance(returnVal, dict):
            raise ValueError('Method run_dbcan return value ' +
                             'returnVal is not type dict as required.')
        # return the results
        return [returnVal]

    def status(self, ctx):
        #BEGIN_STATUS
        returnVal = {'state': "OK", 'message': "", 'version': self.VERSION, 
                     'git_url': self.GIT_URL, 'git_commit_hash': self.GIT_COMMIT_HASH}
        #END_STATUS
        return [returnVal]
