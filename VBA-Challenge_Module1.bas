Attribute VB_Name = "Module1"
Sub VBA_challenge()

    Dim ws As Worksheet
    Dim ticker As String
    Dim openPrice As Double
    Dim closePrice As Double
    Dim totalVolume As Double
    Dim greatestIncrease As Double
    Dim greatestDecrease As Double
    Dim greatestVolume As Double
    Dim greatestIncreaseTicker As String
    Dim greatestDecreaseTicker As String
    Dim greatestVolumeTicker As String
    Dim lastRow As Long
    Dim i As Long
    Dim summaryRow As Integer

    For Each ws In ThisWorkbook.Worksheets
        
        summaryRow = 2
        greatestIncrease = 0
        greatestDecrease = 0
        greatestVolume = 0
        
        
        lastRow = ws.Cells(ws.Rows.Count, 1).End(xlUp).Row
        
        ' open price and total volume
        openPrice = ws.Cells(2, 3).Value
        totalVolume = 0
        
        ' Loop through all rows in the worksheet
        For i = 2 To lastRow
            
            ' Check ticker
            If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
                
                ticker = ws.Cells(i, 1).Value
                closePrice = ws.Cells(i, 6).Value
                totalVolume = totalVolume + ws.Cells(i, 7).Value
                
                ' quarterly and percentage change
                Dim quarterlyChange As Double
                quarterlyChange = closePrice - openPrice
                
                Dim percentageChange As Double
                If openPrice <> 0 Then
                    percentageChange = (quarterlyChange / openPrice) * 100
                Else
                    percentageChange = 0
                End If
                
                ' Output
                ws.Cells(summaryRow, 9).Value = ticker
                ws.Cells(summaryRow, 10).Value = quarterlyChange
                ws.Cells(summaryRow, 11).Value = percentageChange
                ws.Cells(summaryRow, 12).Value = totalVolume
                
                ' conditional formatting
                If quarterlyChange > 0 Then
                    ws.Cells(summaryRow, 10).Interior.Color = vbGreen
                Else
                    ws.Cells(summaryRow, 10).Interior.Color = vbRed
                End If
                
                ' greatest changes and volumes
                If percentageChange > greatestIncrease Then
                    greatestIncrease = percentageChange
                    greatestIncreaseTicker = ticker
                End If
                
                If percentageChange < greatestDecrease Then
                    greatestDecrease = percentageChange
                    greatestDecreaseTicker = ticker
                End If
                
                If totalVolume > greatestVolume Then
                    greatestVolume = totalVolume
                    greatestVolumeTicker = ticker
                End If
                
                summaryRow = summaryRow + 1
                openPrice = ws.Cells(i + 1, 3).Value
                totalVolume = 0
            
            Else
                ' collect volume
                totalVolume = totalVolume + ws.Cells(i, 7).Value
            End If
        Next i
        
        ' greatest values output
        ws.Cells(2, 14).Value = "Greatest % Increase"
        ws.Cells(2, 15).Value = greatestIncreaseTicker
        ws.Cells(2, 16).Value = greatestIncrease
        
        ws.Cells(3, 14).Value = "Greatest % Decrease"
        ws.Cells(3, 15).Value = greatestDecreaseTicker
        ws.Cells(3, 16).Value = greatestDecrease
        
        ws.Cells(4, 14).Value = "Greatest Total Volume"
        ws.Cells(4, 15).Value = greatestVolumeTicker
        ws.Cells(4, 16).Value = greatestVolume
        
    Next ws

End Sub


