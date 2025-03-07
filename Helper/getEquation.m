function [eq,met,stoichCoeff]=getEquation(model,reactionID)
            eq={};
            met=[];
            stoichCoeff={};
            [reactant,~,reactantNum]=model.getReactants(reactionID);
            [product,~,productsNum]=model.getProducts(reactionID);
            for i = 1:length(reactant)
                if i == length(reactant)
                    eq=sprintf('%s%s%s',string(eq),string(-cell2mat(reactantNum(i))),string(reactant(i)));
                    met=[string(met),string(reactant(i))];
                    stoichCoeff=[stoichCoeff,reactantNum(i)];
                    % eq=sprintf('%s%s',string(eq),string(reactant(i)));
                    % eq=[string(eq) string(-cell2mat(reactantNum(i)))];
                    % eq=[eq reactant(i)];
                else
                    eq=sprintf('%s%s%s%s',string(eq),string(-cell2mat(reactantNum(i))),string(reactant(i)),'+');
                    met=[string(met),string(reactant(i))];
                    stoichCoeff=[stoichCoeff,reactantNum(i)];
                    % eq=sprintf('%s%s',string(eq),string(reactant(i)));
                    % eq=[eq -cell2mat(reactantNum(i))];
                    % eq=[eq reactant(i)];
                    % eq=[eq '+'];
                end
            end
            reactionIndex = find(strcmp(model.now.rxns, reactionID));
            bool=model.now.rev(reactionIndex);
            if bool
                eq=[eq,'<=>'];
            else
                eq=[eq,'=>'];
            end

            for i = 1:length(product)
                if i == length(product)
                    eq=sprintf('%s%s%s',string(eq),string(cell2mat(productsNum(i))),string(product(i)));
                    met=[string(met),string(product(i))];
                    stoichCoeff=[stoichCoeff productsNum(i)];
                    stoichCoeff=cell2mat(stoichCoeff);
                    % eq=[eq,cell2mat(productsNum(i))];
                    % eq=[eq,product(i)];
                else
                    eq=sprintf('%s%s%s%s',string(eq),string(cell2mat(productsNum(i))),string(product(i)),'+');
                    met=[string(met),string(product(i))];
                    stoichCoeff=[stoichCoeff productsNum(i)];
                    % eq=[eq,cell2mat(productsNum(i))];
                    % eq=[eq,product(i)];
                    % eq=[eq,'+'];
                end
            end
            
end