module traffic_light_controller(
    input clk,
    input reset,
    output reg [2:0] lightA,
    output reg [2:0] lightB
);

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

reg [1:0] state;
reg [4:0] count;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state <= S0;
        count <= 0;
    end
    else
    begin
        count <= count + 1;

        case(state)
            S0: if(count == 5) begin state <= S1; count <= 0; end
            S1: if(count == 2) begin state <= S2; count <= 0; end
            S2: if(count == 5) begin state <= S3; count <= 0; end
            S3: if(count == 2) begin state <= S0; count <= 0; end
        endcase
    end
end

always @(*)
begin
    case(state)
        S0: begin
            lightA = 3'b001;
            lightB = 3'b100;
        end

        S1: begin
            lightA = 3'b010;
            lightB = 3'b100;
        end

        S2: begin
            lightA = 3'b100;
            lightB = 3'b001;
        end

        S3: begin
            lightA = 3'b100;
            lightB = 3'b010;
        end
    endcase
end

endmodule
