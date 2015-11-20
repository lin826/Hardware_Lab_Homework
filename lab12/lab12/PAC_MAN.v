/*********************************** 
 * Show a crying Pac-man on LCD.   *
 * Each image is 16x16 bits.        *
 ***********************************/

module PAC_MAN(LCD_CLK, RESETN, vir, hor, LCD_DATA, LCD_ENABLE,
       LCD_RW, LCD_RSTN, LCD_CS1, LCD_CS2, LCD_DI);

	input  LCD_CLK;
	input  RESETN;
	input [1:0] vir,hor;
	output reg [7:0]  LCD_DATA;
	output LCD_ENABLE; 
	output reg LCD_RW;
	output LCD_RSTN;
	output reg LCD_CS1;
	output reg LCD_CS2;
	output reg LCD_DI;

	reg [7:0]  LCD_DATA_NEXT;
	reg LCD_RW_NEXT;
	reg LCD_DI_NEXT;
	reg LCD_CS1_NEXT;
	reg LCD_CS2_NEXT;
	
	reg [5:0] startline, startline_next;
	
	reg [2:0]  STATE, STATE_NEXT;
	reg [2:0]  X_PAGE, X_PAGE_NEXT;
	reg [11:0]  Y, Y_NEXT;
	reg [11:0]  Y_START, Y_START_NEXT;
	reg [1:0] IMAGE;
   reg [1:0] IMAGE_NEXT;
	reg [7:0] PATTERN;
	reg [4:0]  INDEX, INDEX_NEXT;
	reg [15:0] PAUSE_TIME, PAUSE_TIME_NEXT;
	
	reg START, START_NEXT;	
	reg NEW_PAGE, NEW_PAGE_NEXT;
	reg NEW_startline, NEW_startline_next;
	reg NEW_COL, NEW_COL_NEXT;
	reg [2:0] PAGE_COUNTER, PAGE_COUNTER_NEXT;
	reg [6:0] COL_COUNTER, COL_COUNTER_NEXT;
	reg ENABLE, ENABLE_NEXT;
	reg CROSS, CROSS_NEXT;
	parameter Init = 3'd0, Set_StartLine = 3'd1, Clear_Screen = 3'd2, Copy_Image = 3'd3, Pause = 3'd4;
	parameter Delay = 16'b1000_0000_0000_0000;
	
	assign LCD_ENABLE = LCD_CLK & ENABLE; // when ENABLE=1, LCD write can occur at falling edge of clock 
	assign LCD_RSTN = RESETN;
	assign PAUSED_TO_THE_END = (PAUSE_TIME == 0) ? 1 : 0;	
	
	always@(posedge LCD_CLK or negedge RESETN) begin
		if (!RESETN) begin
			STATE    <= Init;
			PAUSE_TIME    <= Delay;
			X_PAGE   <= 0;
			Y  <= 0;
			INDEX 	<=  0;
			LCD_DI   <= 0;
			LCD_RW   <= 0;
			IMAGE    <= 0;
			START <= 0;
			NEW_PAGE <= 1'b0;
			NEW_COL <= 1'b0;
			COL_COUNTER <= 0;
			PAGE_COUNTER <= 0;
			ENABLE <= 1'b0;
			CROSS <= 1'b0;
			startline <= 6'b000000;
			Y_START <= 6'b000000;
			NEW_startline <=0;
			LCD_CS1 <= 1'b0;
			LCD_CS2 <= 1'b1;
		end else begin
			LCD_CS1 <= LCD_CS1_NEXT;
			LCD_CS2 <= LCD_CS2_NEXT;
			STATE    <= STATE_NEXT;
			PAUSE_TIME    <= PAUSE_TIME_NEXT;
			X_PAGE   <= X_PAGE_NEXT;
			Y  <= Y_NEXT;
			Y_START <= Y_START_NEXT;
			INDEX<= INDEX_NEXT;
			LCD_DI   <= LCD_DI_NEXT;
			LCD_RW   <= LCD_RW_NEXT;
			LCD_DATA <= LCD_DATA_NEXT;			
			IMAGE <= IMAGE_NEXT;	
			START <= START_NEXT;	
			NEW_PAGE <= NEW_PAGE_NEXT;
			NEW_COL <= NEW_COL_NEXT;
			COL_COUNTER <= COL_COUNTER_NEXT;
			PAGE_COUNTER <= PAGE_COUNTER_NEXT;
			ENABLE <= ENABLE_NEXT;
			CROSS <= CROSS_NEXT;
			startline <= startline_next;
			NEW_startline <= NEW_startline_next;
		end
	end
	always @(*) begin
		// default assignments
		STATE_NEXT  = STATE;
		PAUSE_TIME_NEXT = PAUSE_TIME;
		X_PAGE_NEXT = X_PAGE;
		Y_NEXT = Y;
		Y_START_NEXT = Y_START;
		INDEX_NEXT = INDEX;
		LCD_DI_NEXT = LCD_DI;
		LCD_RW_NEXT = LCD_RW;
		LCD_DATA_NEXT = LCD_DATA;
		LCD_CS1_NEXT = LCD_CS1;
		LCD_CS2_NEXT = LCD_CS2;
		IMAGE_NEXT = IMAGE;
		COL_COUNTER_NEXT = COL_COUNTER; 
		PAGE_COUNTER_NEXT = PAGE_COUNTER;
		START_NEXT =	1'b0;	
		NEW_PAGE_NEXT = 1'b0;
		NEW_COL_NEXT = 1'b0;	
		ENABLE_NEXT = 1'b0;
		CROSS_NEXT = 1'b1;
		startline_next = startline;
		NEW_startline_next = 1'b0;
		case(STATE)
			Init: begin  //initial state
				STATE_NEXT =  Set_StartLine;
				// prepare LCD instruction to turn display on
				LCD_CS1_NEXT = 1'b0;
				LCD_CS2_NEXT = 1'b1;
				LCD_DI_NEXT = 1'b0;
				LCD_RW_NEXT = 1'b0;				
				LCD_DATA_NEXT = 8'b0011111_1;
				ENABLE_NEXT = 1'b1;
			end
			Set_StartLine: begin //set start line
				STATE_NEXT = Clear_Screen;
				// prepare LCD instruction to set start line
				LCD_DI_NEXT = 1'b0;
				LCD_RW_NEXT = 1'b0;
				LCD_DATA_NEXT = 8'b11_000000; // start line = 0
				ENABLE_NEXT = 1'b1;
				START_NEXT = 1'b1;
			end
			Clear_Screen: begin
				if (START) begin
					NEW_PAGE_NEXT = 1'b1;
					//CROSS_NEXT = 1'b1;	
					PAGE_COUNTER_NEXT = 0;
					COL_COUNTER_NEXT = 0;
					X_PAGE_NEXT = 0; // set initial X address
					Y_NEXT = 0; // set initial Y address
				end else if (CROSS) begin
					LCD_DI_NEXT    = 1'b0;
					LCD_RW_NEXT    = 1'd0;
					//LCD_CS1_NEXT = !LCD_CS1;
					//LCD_CS2_NEXT = !LCD_CS2;
					LCD_DATA_NEXT  = 8'b00_111111; // to move to another CS
					ENABLE_NEXT = 1'b1;
					NEW_PAGE_NEXT = 1'b1;
				end else	
				if (NEW_PAGE) begin
					// prepare LCD instruction to move to new page
					LCD_DI_NEXT = 1'b0;
					LCD_RW_NEXT = 1'd0;
					LCD_DATA_NEXT = {5'b10111, X_PAGE};
					ENABLE_NEXT = 1'b1;
					NEW_COL_NEXT = 1'b1;
					//CROSS_NEXT = 1'b1;				
				end else if (NEW_COL) begin 
					// prepare LCD instruction to move to column 0 
					LCD_DI_NEXT    = 1'b0;
					LCD_RW_NEXT    = 1'd0;
					LCD_DATA_NEXT  = 8'b01_000000; // to move to column 0
					ENABLE_NEXT = 1'b1;
				end else if (COL_COUNTER < 64) begin
					// prepare LCD instruction to write 00000000 into display RAM
					LCD_DI_NEXT    = 1'b1;
					LCD_RW_NEXT    = 1'd0;
					LCD_DATA_NEXT  = 8'b00000000;
					ENABLE_NEXT = 1'b1;
					COL_COUNTER_NEXT = COL_COUNTER + 1;					
				end else begin
					if (PAGE_COUNTER == 7 && CROSS) begin // last page of screen and change CS
						CROSS_NEXT = 1'b0;
						PAGE_COUNTER_NEXT = 0;
						COL_COUNTER_NEXT = 0;
					end else if (PAGE_COUNTER == 7 && !CROSS) begin // last page of screen
						STATE_NEXT = Copy_Image;
						START_NEXT = 1'b1;
					end else begin
						// prepare to change page
						X_PAGE_NEXT  = X_PAGE + 1;
						NEW_PAGE_NEXT = 1'b1;
						PAGE_COUNTER_NEXT = PAGE_COUNTER + 1;
						COL_COUNTER_NEXT = 0;
					end
				end
			end						
			Copy_Image: begin // write image pattern into LCD RAM
				if (START) begin
					NEW_startline_next = 1'b1;
					X_PAGE_NEXT = 3;  // image initial X address
					
					if(vir==2'b10)
						startline_next = startline - 1;
					else if(vir==2'b01)
						startline_next = startline +1;
					else
						startline_next = startline;
					
					if(hor == 2'b01)
						Y_START_NEXT = Y_START + 1'b1; // image initial Y address
					else if(hor == 2'b10)
						Y_START_NEXT = Y_START - 1'b1;
					else 
						Y_START_NEXT = Y_START;	
						
					Y_NEXT = Y_START;
					
					PAGE_COUNTER_NEXT = 0;
					COL_COUNTER_NEXT = 0;
				end else if (NEW_startline) begin
					// prepare LCD instruction to move to new page 
					LCD_DI_NEXT = 1'b0;
					LCD_RW_NEXT = 1'b0;
					LCD_DATA_NEXT = {2'b11,startline}; 
					ENABLE_NEXT = 1'b1;					
					NEW_PAGE_NEXT = 1'b1;
					//CROSS_NEXT = 1'b1;
				end else if (CROSS) begin
					LCD_DI_NEXT    = 1'b0;
					LCD_RW_NEXT    = 1'd0;
					LCD_CS1_NEXT = !LCD_CS1;
					LCD_CS2_NEXT = !LCD_CS2;
					LCD_DATA_NEXT  = 8'b00_111111; // to move to another CS
					ENABLE_NEXT = 1'b1;
					NEW_PAGE_NEXT = 1'b1;
				end else if (NEW_PAGE) begin
					// prepare LCD instruction to move to new page 
					LCD_DI_NEXT = 1'b0;
					LCD_RW_NEXT = 1'b0;
					LCD_DATA_NEXT = {5'b10111, X_PAGE}; 
					ENABLE_NEXT = 1'b1;
					NEW_COL_NEXT = 1'b1;
					//CROSS_NEXT = 1'b1;				
				end else if (NEW_COL) begin
					// prepare LCD instruction to move to new column
					LCD_DI_NEXT = 1'b0;
					LCD_RW_NEXT = 1'b0;
					
					if(LCD_CS1) LCD_DATA_NEXT = {2'b01,Y[11:6]};
					else LCD_DATA_NEXT = {2'b01,Y[5:0]};
					
					ENABLE_NEXT = 1'b1;
				end else if (COL_COUNTER < 16) begin //load image 1 byte at a time, 16 is the width of image
					// prepare LCD instruction to write image data into display RAM
					LCD_DI_NEXT = 1'b1;
					LCD_RW_NEXT = 1'b0;
					if({1'b0,COL_COUNTER}+{1'b0,Y_START}>64 && !CROSS) begin
						//CROSS_NEXT = 1'b1;
						LCD_CS1_NEXT = !LCD_CS1;
						LCD_CS2_NEXT = !LCD_CS2;
						LCD_DATA_NEXT = 8'b00_111110; // to move to another CS
						ENABLE_NEXT = 1'b1;
						CROSS_NEXT = !CROSS;
					end
					else begin
						LCD_DATA_NEXT = PATTERN;			
						ENABLE_NEXT = 1'b1;
						INDEX_NEXT = INDEX + 1;
						COL_COUNTER_NEXT = COL_COUNTER + 1;
						CROSS_NEXT = 1'b0;
					end
				end else begin 
					if (PAGE_COUNTER == 1) begin // last page of image
						IMAGE_NEXT = IMAGE + 1;
						STATE_NEXT = Pause;
					end else begin
						// prepare to change page
						X_PAGE_NEXT = X_PAGE + 1;		
						NEW_PAGE_NEXT = 1'b1;
						PAGE_COUNTER_NEXT = PAGE_COUNTER + 1;
						COL_COUNTER_NEXT = 0;
					end
				end				
			end
			Pause: begin
				if (PAUSED_TO_THE_END) begin
					STATE_NEXT = Copy_Image;
					START_NEXT = 1'b1;
				end 
				else STATE_NEXT = Pause;
				PAUSE_TIME_NEXT = PAUSE_TIME - 1; 
			end
			default: STATE_NEXT = Init;
		endcase
    end
	
/*******************************
 * Set PAC_MAN image patterns  *
 *******************************/
  always @(*)begin
	case (IMAGE)
		2'd0:	// 1st image 	
			case (INDEX)
			  8'h00  :  PATTERN = 8'h00; // upper half of image
			  8'h01  :  PATTERN = 8'hE0;
			  8'h02  :  PATTERN = 8'hF8;
			  8'h03  :  PATTERN = 8'hFC;
			  8'h04  :  PATTERN = 8'hFC;
			  8'h05  :  PATTERN = 8'hFE;
			  8'h06  :  PATTERN = 8'hFE;
			  8'h07  :  PATTERN = 8'hFE;    
			  8'h08  :  PATTERN = 8'hFE; 
			  8'h09  :  PATTERN = 8'hFE;
			  8'h0A  :  PATTERN = 8'hFE;
			  8'h0B  :  PATTERN = 8'hFC;
			  8'h0C  :  PATTERN = 8'hFC;
			  8'h0D  :  PATTERN = 8'hF8;
			  8'h0E  :  PATTERN = 8'hE0;
			  8'h0F  :  PATTERN = 8'h00;
			  8'h10  :  PATTERN = 8'h00; // lower half of image
			  8'h11  :  PATTERN = 8'h03;
			  8'h12  :  PATTERN = 8'h0F;
			  8'h13  :  PATTERN = 8'h1F;
			  8'h14  :  PATTERN = 8'h1F;
			  8'h15  :  PATTERN = 8'h3F;
			  8'h16  :  PATTERN = 8'h3F;
			  8'h17  :  PATTERN = 8'h3F;  
			  8'h18  :  PATTERN = 8'h3F; 
			  8'h19  :  PATTERN = 8'h3F;
			  8'h1A  :  PATTERN = 8'h3F;
			  8'h1B  :  PATTERN = 8'h1F;
			  8'h1C  :  PATTERN = 8'h1F;
			  8'h1D  :  PATTERN = 8'h0F;
			  8'h1E  :  PATTERN = 8'h03;
			  8'h1F  :  PATTERN = 8'h00; 			  
			endcase
		2'd1:	// 2nd image
			case (INDEX)
			  8'h00  :  PATTERN = 8'h00; // upper half of image
			  8'h01  :  PATTERN = 8'hE0;
			  8'h02  :  PATTERN = 8'hF8;
			  8'h03  :  PATTERN = 8'hFC;
			  8'h04  :  PATTERN = 8'hFC;
			  8'h05  :  PATTERN = 8'hFE;
			  8'h06  :  PATTERN = 8'hFE;
			  8'h07  :  PATTERN = 8'hFE;  
			  8'h08  :  PATTERN = 8'h7E; 
			  8'h09  :  PATTERN = 8'h7E;
			  8'h0A  :  PATTERN = 8'h7E;
			  8'h0B  :  PATTERN = 8'h7C;
			  8'h0C  :  PATTERN = 8'h3C;
			  8'h0D  :  PATTERN = 8'h38;
			  8'h0E  :  PATTERN = 8'h20;
			  8'h0F  :  PATTERN = 8'h00;
			  8'h10  :  PATTERN = 8'h00; // lower half of image
			  8'h11  :  PATTERN = 8'h03;
			  8'h12  :  PATTERN = 8'h0F;
			  8'h13  :  PATTERN = 8'h1F;
			  8'h14  :  PATTERN = 8'h1F;
			  8'h15  :  PATTERN = 8'h3F;
			  8'h16  :  PATTERN = 8'h3F;
			  8'h17  :  PATTERN = 8'h3F;  
			  8'h18  :  PATTERN = 8'h3F; 
			  8'h19  :  PATTERN = 8'h3F;
			  8'h1A  :  PATTERN = 8'h3F;
			  8'h1B  :  PATTERN = 8'h1F;
			  8'h1C  :  PATTERN = 8'h1E;
			  8'h1D  :  PATTERN = 8'h0E;
			  8'h1E  :  PATTERN = 8'h02;
			  8'h1F  :  PATTERN = 8'h00; 	
			  endcase
      2'd2:	// third image
			case (INDEX)
		     8'h00  :  PATTERN = 8'h00; // upper half of image
			  8'h01  :  PATTERN = 8'hE0;
			  8'h02  :  PATTERN = 8'hF8;
			  8'h03  :  PATTERN = 8'hFC;
			  8'h04  :  PATTERN = 8'hFC;
			  8'h05  :  PATTERN = 8'hFE;
			  8'h06  :  PATTERN = 8'hFE;
			  8'h07  :  PATTERN = 8'hFE;  
			  8'h08  :  PATTERN = 8'h7E; 
			  8'h09  :  PATTERN = 8'b01101110;
			  8'h0A  :  PATTERN = 8'b01000110;
			  8'h0B  :  PATTERN = 8'b01101110;
			  8'h0C  :  PATTERN = 8'h3C;
			  8'h0D  :  PATTERN = 8'h38;
			  8'h0E  :  PATTERN = 8'h20;
			  8'h0F  :  PATTERN = 8'h00;
			  8'h10  :  PATTERN = 8'h00; // lower half of image
			  8'h11  :  PATTERN = 8'h03;
			  8'h12  :  PATTERN = 8'h0F;
			  8'h13  :  PATTERN = 8'h1F;
			  8'h14  :  PATTERN = 8'h1F;
			  8'h15  :  PATTERN = 8'h3F;
			  8'h16  :  PATTERN = 8'h3F;
			  8'h17  :  PATTERN = 8'h3F;  
			  8'h18  :  PATTERN = 8'h3F; 
			  8'h19  :  PATTERN = 8'h3F;
			  8'h1A  :  PATTERN = 8'h3F;
			  8'h1B  :  PATTERN = 8'h1F;
			  8'h1C  :  PATTERN = 8'h1E;
			  8'h1D  :  PATTERN = 8'h0E;
			  8'h1E  :  PATTERN = 8'h02;
			  8'h1F  :  PATTERN = 8'h00;
       endcase
      2'd3:	// forth image 	
			case (INDEX)
			  8'h00  :  PATTERN = 8'h00; // upper half of image
			  8'h01  :  PATTERN = 8'hE0;
			  8'h02  :  PATTERN = 8'hF8;
			  8'h03  :  PATTERN = 8'hFC;
			  8'h04  :  PATTERN = 8'hFC;
			  8'h05  :  PATTERN = 8'hFE;
			  8'h06  :  PATTERN = 8'hFE;
			  8'h07  :  PATTERN = 8'hFE;    
			  8'h08  :  PATTERN = 8'hFE; 
			  8'h09  :  PATTERN = 8'hFE;
			  8'h0A  :  PATTERN = 8'hFE;
			  8'h0B  :  PATTERN = 8'hFC;
			  8'h0C  :  PATTERN = 8'hFC;
			  8'h0D  :  PATTERN = 8'hF8;
			  8'h0E  :  PATTERN = 8'hE0;
			  8'h0F  :  PATTERN = 8'h00;
			  8'h10  :  PATTERN = 8'h00; // lower half of image
			  8'h11  :  PATTERN = 8'h03;
			  8'h12  :  PATTERN = 8'h0F;
			  8'h13  :  PATTERN = 8'h1F;
			  8'h14  :  PATTERN = 8'h1F;
			  8'h15  :  PATTERN = 8'h3F;
			  8'h16  :  PATTERN = 8'h3F;
			  8'h17  :  PATTERN = 8'h3F;  
			  8'h18  :  PATTERN = 8'h3F; 
			  8'h19  :  PATTERN = 8'h3F;
			  8'h1A  :  PATTERN = 8'h3F;
			  8'h1B  :  PATTERN = 8'h1F;
			  8'h1C  :  PATTERN = 8'h1F;
			  8'h1D  :  PATTERN = 8'h0F;
			  8'h1E  :  PATTERN = 8'h03;
			  8'h1F  :  PATTERN = 8'h00; 			  
			endcase	 
			
	endcase	
  end
endmodule