classdef reaction
    properties
        rxns
        equations
        mets
        stoichCoeffs
        rxnNames
        lb
        ub
        c
        eccodes
        subSystems
        grRules
        rxnMiriams
        rxnComps
        rxnNotes
        rxnDeltaG
        rxnReferences
        rxnConfidenceScores
    end

    methods
        function obj=reaction(model,reactionID)
            [eq,met,stoichCoeff]=getEquation(model,reactionID);
            model=model.now;
            [~,index]=ismember(model.rxns,reactionID);
            index=find(index);
            obj.rxns={reactionID};
            obj.equations=eq;
            obj.mets=met;
            obj.stoichCoeffs=stoichCoeff;
            obj.rxnNames=model.rxnNames(index);
            obj.lb=model.lb(index);
            obj.ub=model.ub(index);
            obj.c=0;
            if isfield(model,'eccode')
                obj.eccodes=model.eccode(index);
            end
            if isfield(model,'subSystem')
                obj.subSystems=model.subSystem(index);
            end
            if isfield(model,'grRules')
                obj.grRules=model.grRules(index);
            end
        end
    end


        

    %     function [metabolites,metabolitesName,metabolitesNum]=findMetaboliteFromReaction(model,reactionID)
    %         S = model.S;
    %         % find rxnID
    %         reactionIndex = find(strcmp(model.rxns, reactionID));
    %         if ~isempty(reactionIndex)
    %             % prase the reaction
    %             reactionStoichiometry = S(:, reactionIndex);
    %             % 初始化反应物和产物的容器
    %             metabolites = {}; % 存储反应物
    %             metabolitesName = {}; % 存储反应物的名称
    %             metabolitesNum = {}; % 存储反应物的数量
    %             % 遍历反应的代谢物和化学计量
    %             for i = 1:length(reactionStoichiometry)
    %                 if reactionStoichiometry(i) ~= 0
    %                     % 如果系数小于0，则为反应物
    %                     metabolites{end+1} = strcat(model.mets{i}, '[1]'); 
    %                     metabolitesName{end+1} = model.metNames{i};
    %                     metabolitesNum{end+1} = full(reactionStoichiometry(i));  % 将稀疏矩阵转换为数值
    %                 end
    %             end
    %         end
    %     end
    % end
                
        
end