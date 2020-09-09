function [y, pred] = jayant_adm_modulator(x)

%Jayant Algorithm 
%Source  - Adaptive Delta Modulation Techniques, Niranjan U, M.N. Suma

    N = length(x);
    y = zeros(N,1);
    pred = zeros(N,1);
    
%     DELTA = STEP SIZE
    delta = 0.05;

%     LIMIT DELTA
    max_delta = delta*16;
    min_delta = delta/16;
    
    curr = 0;
    for i=2:N
        if(i>4)  
            
%             SERIES OF 0000 OR 1111
%             INCREASE DELTA BY 2
%             TO OVERCOME SLOPE OVERLOAD
            if( ~xor(y(i-3),y(i-4)) && ~xor(y(i-3),y(i-2)) && ~xor(y(i-2),y(i-1)) )
                if(delta<max_delta)
                    delta = delta*2 ;
                end
%             SERIES OF 0101 OR 1010
%             REDUCE DELTA BY 2
%             TO OVERCOME GRANULAR NOISE
            elseif(xor(y(i-3),y(i-4)) && xor(y(i-3),y(i-2)) && xor(y(i-2),y(i-1)) )
                if(delta>min_delta)
                    delta = delta/2 ;
                end
            end
        end
        
%         COMPARING WITH THE CURRENT SAMPLE VALUE
%         SETTIND DELTA POSITIVE OR NEGATIVE
        if( x(i) >= curr)
            y(i) = 1;
            curr = curr + delta;
        else
            y(i) = 0;
            curr = curr - delta;
        end 
        if(y(i) == 0) 
            err = -1;
        else
            err = 1;
        end
        pred(i) = pred(i-1) + err*delta; 
    end
end
