'HOMEWORK 2: STOCK MARKET DATA 

 'Create a script that will loop through each year of stock data and grab the 
 'total amount of volume each stock had over the year. 
 'You will also need to display the ticker symbol to coincide with the total volume. 

 Sub Stock_market (): 

    'looking through all worksheets
    For Each ws in worksheets
    
        'creating variable for ticket information 
        dim Ticker as string

        ' Set an initial variable for holding the total per ticker 
        Dim Ticker_Total As Double
        Ticket_Total = 0

        ' Keep track of the location for each credit card brand in the summary table
        Dim Summary_Table_Row As Integer
        Summary_Table_Row = 2

        'loop through all stocks
        For R = 2 to 70926

            'Check to see if we are still in the same stock ticker, if not then...
            If ws.Cells(R + 1, 1).Value <> ws.Cells(R, 1).Value Then

                'print message box of next ticket
                'worked proper so commenting out 
                'MsgBox (Cells(R,1).Value) 

                ' Set the Ticker
                Ticker = ws.Cells(R, 1).Value 

                ' Print the Ticker in the Summary Table
                ws.Range("I" & Summary_Table_Row).Value = Ticker

                ' Print the Ticker Amount to the Summary Table
                ws.Range("J" & Summary_Table_Row).Value = Ticker_Total 

                ' Add one to the summary table row
                Summary_Table_Row = Summary_Table_Row + 1
        
                ' Reset the Brand Total
                Ticker_Total = 0 

                ' If the cell immediately following a row is the same brand...
            Else

            ' Add to the Ticker Total
            Ticker_Total = Ticker_Total + ws.Cells(R, 7).Value

            End If 
        Next R 
    Next ws
End Sub 