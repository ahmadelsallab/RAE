% Function:
% The main entry point to train and test Generic Deep ANN
% Inputs:
% CONFIG_strParams: the configurations parameters to be used
% Output:
% None
function MAIN_trainAndClassify(CONFIG_strParams)    
    rand('state',0);
    fprintf(1, 'Converting input files...\n');
	% Check the dataset used
	switch(CONFIG_strParams.sDataset)
        case 'ATB_Senti_RAE'
        	% The output of conversion is saved in CONFIG_strParams.sInputDataWorkspace
			[mFeatures, mTargets] = DCONV_convertATB_Senti_RAE(CONFIG_strParams);
            
		otherwise
			% Do nothing
	end
	
	
    
    fprintf(1, 'Conversion done successfuly\n');
    
	fprintf(1, 'Splitting dataset into train and test sets...\n');
	[mTestFeatures, mTestTargets, mTrainFeatures, mTrainTargets] = TTS_formTrainTestSets(mFeatures, mTargets, CONFIG_strParams.sSplitCriteria, CONFIG_strParams.nTrainToTestFactor);
% 	switch (CONFIG_strParams.sInputFormat)
% 		case 'MatlabWorkspaceReadyTestTrainSplit'
% 			%load(CONFIG_strParams.sInputDataWorkspace);
% 			DPREP_strData.mTestFeatures = mTestFeatures;
% 			DPREP_strData.mTestTargets = mTestTargets;
% 			DPREP_strData.mTrainFeatures = mTrainFeatures;
% 			DPREP_strData.mTrainTargets = mTrainTargets;
%             clear mTestFeatures mTestTargets mTrainFeatures mTrainTargets;
%         %case 'CrossVal'
%             %TTS_formTrainTestSets_CV()
%         otherwise
% 			% Split into train and test sets
% 			[DPREP_strData.mTestFeatures, DPREP_strData.mTestTargets, DPREP_strData.mTrainFeatures, DPREP_strData.mTrainTargets] =... 
% 				TTS_formTrainTestSets(DPREP_strData.mFeatures,...
% 									  DPREP_strData.mTargets,...
% 									  CONFIG_strParams.sSplitCriteria,...
% 									  CONFIG_strParams.nTrainToTestFactor);
%                 
%                 %Save split data
%                 save(CONFIG_strParams.sInputDataWorkspace, '-struct', 'DPREP_strData', '-append',...
%                      'mTestFeatures',...
%                      'mTestTargets',...
%                      'mTrainFeatures',...
%                      'mTrainTargets');
%                 
%                 if(strcmp(CONFIG_strParams.sMemorySavingMode, 'ON'))
%                     % clear DPREP_strData.mFeatures DPREP_strData.mTargets;
%                     DPREP_strData.mFeatures = [];
%                     DPREP_strData.mTargets = [];
%                 end
%          
%     end
%     
	fprintf(1, 'Splitting done successfully\n');

    % Load auto label data if enabled
 	%[DPREP_strData.mTrainTargets, DPREP_strData.mAutoLabels] = DPREP_autoLabel(DPREP_strData.mTrainTargets, CONFIG_strParams);
 
	fprintf(1, 'Start learning process\n');
	switch(CONFIG_strParams.eClassifierType)
        case 'RAE'
            LM_startLearningProcessRAE;
% 			LM_startLearningProcessRAE(CONFIG_strParams,...
%                                        mDevFeatures, mDevTargets,...
%                                        DPREP_strData.mTestFeatures, DPREP_strData.mTestTargets, DPREP_strData.mTrainFeatures, DPREP_strData.mTrainTargets,...
%                                        DPREP_strData.mTrainBatchTargets, DPREP_strData.mTrainBatchData, DPREP_strData.mTestBatchTargets, DPREP_strData.mTestBatchData,...
%                                        DPREP_strData.nBitfieldLength, DPREP_strData.vChunkLength, DPREP_strData.vOffset, DPREP_strData.mAutoLabels);
%             
	end % end switch
	fprintf(1, 'Learning process performed successfuly\n'); 
% 
% 
% 	if(CONFIG_strParams.bTestOnIndependentTestSet == 1)
% 		
% 		% Open log file
% 		hFidLog = fopen(CONFIG_strParams.sIndependentDataSetLogFile,'w');
% 		fprintf(1, 'Testing on independent data set...\n');
% 		fprintf(hFidLog, 'Testing on independent data set...\n');				
% 		
% 		fprintf(1, 'Converting input files...\n');
%     
% 		switch (CONFIG_strParams.sInputFormatOfIndependentTestSet)
% 			case 'MATLAB'
% 				% Convert raw data to matlab vars
% 				[mIndependentDataSetFeatures, mIndependentDataSetTargets] = DCONV_convertMatlabInput_Indepdataset_Binary();
% 			case 'TxtFile'
% 				% Convert raw data to matlab vars
% 				[mIndependentDataSetFeatures, mIndependentDataSetTargets] = DCONV_convert(CONFIG_strParams.sIndependentTestSetFeaturesFilePath);
% 			otherwise
% 				% Convert raw data to matlab vars
% 				[mIndependentDataSetFeatures, mIndependentDataSetTargets] = DCONV_convert(CONFIG_strParams.sIndependentTestSetFeaturesFilePath);
% 				
% 		end
% 
% 		% Save converted data
% 		save(CONFIG_strParams.sInputDataWorkspace,  '-append', 'mIndependentDataSetFeatures', 'mIndependentDataSetTargets');
% 		
% 		fprintf(1, 'Conversion done successfuly\n');
% 	
% 		[nErr, nConfusionErr, nErrRate, nConfusionErrRate] = TST_computeClassificationErr(hFidLog, mIndependentDataSetFeatures, mIndependentDataSetTargets, NM_strNetParams, SVM_strParams, CONFIG_strParams);
% 		
% 		fprintf(1, 'Testing on independent data set done successfuly\n');
% 		fprintf(hFidLog, 'Testing on independent data set done successfuly\n');
% 		
% 		fclose(hFidLog);
% 		
% 		% Save the current configuration in the error performance workspace
% 		save(CONFIG_strParams.sNameofErrWorkspace, '-append', 'nErr', 'nConfusionErr', 'nErrRate', 'nConfusionErrRate');
	end
end