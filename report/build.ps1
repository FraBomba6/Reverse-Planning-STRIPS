$folder = "build"
if (!(Test-Path $folder)) {
    New-Item -ItemType Directory -Path $folder
}
Get-Process -name FoxitPDFReader | Stop-Process
pdflatex -shell-escape -output-directory=build report.tex
pdflatex -shell-escape -output-directory=build report.tex
Move-Item build/report.pdf . -Force
Invoke-Item report.pdf