    always @(posedge clk)
    begin
    if (v_sync && !pass_ini && state != inicializa) begin
        state <= inicializa; end
    else begin
            case (state)
                inicializa : begin
                control_ed <= 0;
                   if (contador == 70)
                      state <= waiting;
                   else
                      state <= inicializa;
                end
                waiting : begin
                control_ed <= 0;
                   if (!pass_ini)
                      state <= inicializa;
                   else if (sw && (contador_lectura == 68 || v_sync == 1))
                      state <= edita;
                   else if (!v_sync && contador_lectura != 68)
                      state <= lee;        
                   else if (contador_form == 0 && !v_sync && contador_lectura == 68 && !sw)
                      state <= formato;
                   else
                      state <= waiting;
                end
                edita : begin
                control_ed <= 1;
                   if (!pass_ini && v_sync)
                      state <= inicializa;
                   else if (!sw && v_sync)
                      state <= escribe;
                   else if (!v_sync && contador_lectura != 68)
                       state <= lee;
                   else
                      state <= edita;
                end
                lee : begin
                   if (swreset)
                      state <= inicializa;
                   else if (contador_lectura == 68 && !sw)
                      state <= waiting;
                   else if (contador_lectura == 68 && sw)
                      state <= edita;
                   else if (contador_lectura != 68 && !sw && control_ed)
                      state <= escribe;
                   else
                      state <= lee;
                end
                escribe: begin
                control_ed <= 0;
                   if (swreset)
                       state <= inicializa;
                   else if (contador_escritura == 69)
                       state <= waiting;
                   else 
                       state <= escribe; end
                  formato:
                    if (swreset)
                      state <= inicializa;
                    else if (contador_form == 1)
                      state <= waiting;
                    else
                      state <= formato;
                    
             default: state <= waiting;
             endcase
             end
       end     
