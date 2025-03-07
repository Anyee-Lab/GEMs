classdef model < handle
    properties
        now
        last
        state
    end

    methods
        function obj=model(parser,fileName)
            if strcmp(parser,'libSBML')
                obj.now=TranslateSBML(fileName);
                obj.state='libSBML';
            elseif strcmp(parser,'Raven')
                obj.now=importModel(fileName);
                obj.state='RAVEN';
            end
        end

        function rollback(obj)
            obj.now=obj.last;
        end

        % IS REVERSIBLE
        function bool=isReversible(obj,reactionID)
            reactionIndex = find(strcmp(obj.now.rxns, reactionID));
            bool=obj.now.rev(reactionIndex);
        end

        % GET REACTANTS
        function [metabolites,metabolitesName,metabolitesNum]=getReactants(obj,reactionID)
            S = obj.now.S;
            % find rxnID
            reactionIndex = find(strcmp(obj.now.rxns, reactionID));
            if ~isempty(reactionIndex)
                % prase the reaction
                reactionStoichiometry = S(:, reactionIndex);
                % meatbolite box
                metabolites = {}; 
                metabolitesName = {}; 
                metabolitesNum = {}; 
                for i = 1:length(reactionStoichiometry)
                    if reactionStoichiometry(i) < 0
                        % 如果系数小于0，则为反应物
                        metabolites{end+1} = strcat(obj.now.mets{i}); 
                        metabolitesName{end+1} = obj.now.metNames{i};
                        metabolitesNum{end+1} = full(reactionStoichiometry(i));  % 将稀疏矩阵转换为数值
                    end
                end
            end
        end

        % GET PRODUCTS
        function [metabolites,metabolitesName,metabolitesNum]=getProducts(obj,reactionID)
            S = obj.now.S;
            % find rxnID
            reactionIndex = find(strcmp(obj.now.rxns, reactionID));
            if ~isempty(reactionIndex)
                % prase the reaction
                reactionStoichiometry = S(:, reactionIndex);
                % meatbolite box
                metabolites = {}; 
                metabolitesName = {}; 
                metabolitesNum = {}; 
                for i = 1:length(reactionStoichiometry)
                    if reactionStoichiometry(i) > 0
                        metabolites{end+1} = strcat(obj.now.mets{i}); 
                        metabolitesName{end+1} = obj.now.metNames{i};
                        metabolitesNum{end+1} = full(reactionStoichiometry(i));  % 将稀疏矩阵转换为数值
                    end
                end
            end
        end


    end
end