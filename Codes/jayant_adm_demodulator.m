function [z] = jayant_adm_demodulator(y, f, Fs)

    N = length(y);
    z = zeros(N,1);
    
%     DELTA = STEP SIZE
    delta = 0.05;
    
%     LIMIT DELTA
    max_delta = delta*16;
    min_delta = delta/16;
    
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
%         ADDING STEP SIZE TO THE PREDICTED OUTPUT
        if( y(i) == 1)
            z(i) = z(i-1) + delta;
        else
            z(i) = z(i-1) - delta;
        end 
    end
    
%     INTERPOLATION OF SAMPLES USING LOW-PASS
    z  =lowpass(z,f,Fs);
end
