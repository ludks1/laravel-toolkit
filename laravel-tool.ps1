function Show-MainMenu {
    Write-Host "`n=== Laravel Artisan Toolkit ===" -ForegroundColor Cyan
    Write-Host "1. Run Migrations" -ForegroundColor Magenta
    Write-Host "2. Run Seeders" -ForegroundColor Magenta
    Write-Host "3. Fresh Migrations (Drop & Migrate)" -ForegroundColor Magenta
    Write-Host "4. Start Laravel Server" -ForegroundColor Magenta
    Write-Host "5. Run Tests" -ForegroundColor Magenta
    Write-Host "6. Migration Generator" -ForegroundColor Magenta
    Write-Host "7. Rollback Migrations" -ForegroundColor Magenta
    Write-Host "10. Generate Controller" -ForegroundColor Magenta
    Write-Host "8. Generate Model + Migration + Factory" -ForegroundColor Magenta
    Write-Host "9. Generate Factory" -ForegroundColor Magenta
    Write-Host "10. Generate Request" -ForegroundColor Magenta
    Write-Host "11. Toolbox (maintenance & debug tools)" -ForegroundColor Magenta
    Write-Host "12. Controller Generator Menu" -ForegroundColor Magenta
    Write-Host "0. Exit" -ForegroundColor Green
    Write-Host "===================================" -ForegroundColor Cyan
}

function Show-MigrationsMenu {
    Write-Host "`n=== Migration Generator ===" -ForegroundColor Magenta
    Write-Host "1. Create Table" -ForegroundColor Cyan
    Write-Host "2. Add Column(s)" -ForegroundColor Cyan
    Write-Host "3. Remove Column(s)" -ForegroundColor Cyan
    Write-Host "4. Rename Column" -ForegroundColor Cyan
    Write-Host "5. Update Table" -ForegroundColor Cyan
    Write-Host "6. Drop Table" -ForegroundColor Cyan
    Write-Host "7. Modify Column" -ForegroundColor Cyan
    Write-Host "8. Change Table Structure" -ForegroundColor Cyan
    Write-Host "9. Normalize Table" -ForegroundColor Cyan
    Write-Host "10. Deprecate Table" -ForegroundColor Cyan
    Write-Host "0. Back to Main Menu" -ForegroundColor Green
    Write-Host "===================================" -ForegroundColor Magenta
}

function Artisan-ToolboxMenu{
    Write-Host "`n=== Artisan Toolbox ===" -ForegroundColor Magenta
    Write-Host "1. List Routes" -ForegroundColor Cyan
    Write-Host "2. Clear Route Cache" -ForegroundColor Cyan
    Write-Host "3. Cache Routes" -ForegroundColor Cyan
    Write-Host "4. Clear View Cache" -ForegroundColor Cyan
    Write-Host "5. Clear Application Cache" -ForegroundColor Cyan
    Write-Host "6. Clear Config Cache" -ForegroundColor Cyan
    Write-Host "7. Cache Config" -ForegroundColor Cyan
    Write-Host "8. Optimize" -ForegroundColor Cyan
    Write-Host "9. Clear Optimizations" -ForegroundColor Cyan
    Write-Host "10. Generate App Key" -ForegroundColor Cyan
    Write-Host "11. Link Storage Folder" -ForegroundColor Cyan
    Write-Host "12. Enter Maintenance Mode" -ForegroundColor Cyan
    Write-Host "13. Exit Maintenance Mode" -ForegroundColor Cyan
    Write-Host "14. Show Environment" -ForegroundColor Cyan
    Write-Host "0. Back to Main Menu" -ForegroundColor Green
    Write-Host "===================================" -ForegroundColor Magenta
}


function Show-ControllerMenu {
    Write-Host "`n=== Controller Generator ===" -ForegroundColor Magenta
    Write-Host "1. Basic Controller" -ForegroundColor Cyan
    Write-Host "2. RESTful Controller" -ForegroundColor Cyan
    Write-Host "3. RESTful Controller with Model" -ForegroundColor Cyan
    Write-Host "4. API Controller (e.g., Api/Post)" -ForegroundColor Cyan
    Write-Host "5. API Controller with Model (e.g., Api/Post)" -ForegroundColor Cyan
    Write-Host "6. Invokable Controller" -ForegroundColor Cyan
    Write-Host "7. Controller in Subdirectory (e.g., Admin/Post)" -ForegroundColor Cyan
    Write-Host "8. Show make:controller help" -ForegroundColor Yellow
    Write-Host "0. Back to Main Menu" -ForegroundColor Green
    Write-Host "==========================================" -ForegroundColor Magenta
}


function Run-LaravelCommand {
    param([string]$command)

    try {
        $args = $command -split ' '
        & php artisan @args
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Successfully executed: php artisan $command" -ForegroundColor Green
        } else {
            Write-Host "Command failed: php artisan $command (exit code $LASTEXITCODE)" -ForegroundColor Red
        }
    } catch {
        Write-Host "Error executing: php artisan $command" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor DarkRed
    }
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Get-Content "$scriptDir\ascii.txt" | ForEach-Object { Write-Host $_ -ForegroundColor Red }

do {
    Show-MainMenu
    $choice = Read-Host "Select an option"
    
    switch ($choice) {
        "1" { Run-LaravelCommand "migrate" }
        "2" { Run-LaravelCommand "db:seed" }
        "3" { Run-LaravelCommand "migrate:fresh" }
        "4" {Run-LaravelCommand "serve"}
        "5" { Run-LaravelCommand "test" }
        "6" {
            do {
                Show-MigrationsMenu
                $type = Read-Host "Select a migration option"

                if ($type -match '^\d+$' -and [int]$type -ge 0 -and [int]$type -le 10) {
                    if ($type -ne "0") {
                        $tableName = Read-Host "Enter the table name"
                    }

                    switch ($type) {
                        "1" {Run-LaravelCommand "make:migration create_${tableName}_table"}
                        "2" {
                            $columnsCount = Read-Host "How many columns to add? (default: 1)"
                            if (-not $columnsCount) {
                                $columnName = Read-Host "Enter column name"
                                Run-LaravelCommand "make:migration add_${columnName}_to_${tableName}_table"
                            } else {
                                $columns = ""
                                for ($i = 1; $i -le $columnsCount; $i++) {
                                    $columnName = Read-Host "Column #$i name"
                                    $columns += ($i -eq 1) ? $columnName : "_and_$columnName"
                                }
                                Run-LaravelCommand "make:migration add_${columns}_to_${tableName}_table"
                            }
                        }
                        "3" {
                            $columnsCount = Read-Host "How many columns to remove? (default: 1)"
                            if (-not $columnsCount) {
                                $columnName = Read-Host "Enter column name"
                                Run-LaravelCommand "make:migration remove_${columnName}_from_${tableName}_table"
                            } else {
                                $columns = ""
                                for ($i = 1; $i -le $columnsCount; $i++) {
                                    $columnName = Read-Host "Column #$i name"
                                    $columns += ($i -eq 1) ? $columnName : "_and_$columnName"
                                }
                                Run-LaravelCommand "make:migration remove_${columns}_from_${tableName}_table"
                            }
                        }
                        "4" {
                            $oldColumn = Read-Host "Old column name"
                            $newColumn = Read-Host "New column name"
                            Run-LaravelCommand "make:migration rename_${oldColumn}_to_${newColumn}_on_${tableName}_table"
                        }
                        "5" {Run-LaravelCommand "make:migration update_${tableName}_table"}
                        "6" {Run-LaravelCommand "make:migration drop_${tableName}_table"}
                        "7" {
                            $columnName = Read-Host "Enter column name to modify"
                            Run-LaravelCommand "make:migration modify_${columnName}_on_${tableName}_table"
                        }
                        "8" {Run-LaravelCommand "make:migration change_${tableName}_structure"}
                        "9" {Run-LaravelCommand "make:migration normalize_${tableName}_table"}
                        "10" {Run-LaravelCommand "make:migration deprecate_${tableName}_table"}
                    }
                } else {
                    Write-Host "Invalid option. Try again." -ForegroundColor Red
                }
            } while ($type -ne "0")
        }
        "7" {
            $steps = Read-Host "How many steps to rollback? (default: 1)"
            if (-not $steps) {
                Run-LaravelCommand "migrate:rollback"
            } else {
                Run-LaravelCommand "migrate:rollback --step=$steps"
            }
        }
        "8" {
            $model = Read-Host "Enter model name"
            Run-LaravelCommand "make:model $model -mf"
        }
        "9" {
            $model = Read-Host "Enter model name for factory"
            Run-LaravelCommand "make:factory ${model}Factory"
        }
        "10"{
            $model = Read-Host "Enter model name for Request"
            Run-LaravelCommand "make:request ${model}Request"
        }
        "11" {
            do {
                Artisan-ToolboxMenu
                $toolChoice = Read-Host "Select a toolbox option"
                switch ($toolChoice) {
                    "1" { Run-LaravelCommand "route:list" }
                    "2" { Run-LaravelCommand "route:clear" }
                    "3" { Run-LaravelCommand "route:cache" }
                    "4" { Run-LaravelCommand "view:clear" }
                    "5" { Run-LaravelCommand "cache:clear" }
                    "6" { Run-LaravelCommand "config:clear" }
                    "7" { Run-LaravelCommand "config:cache" }
                    "8" { Run-LaravelCommand "optimize" }
                    "9" { Run-LaravelCommand "optimize:clear" }
                    "10" { Run-LaravelCommand "key:generate" }
                    "11" { Run-LaravelCommand "storage:link" }
                    "12" { Run-LaravelCommand "down" }
                    "13" { Run-LaravelCommand "up" }
                    "14" { Run-LaravelCommand "env" }
                    "0" { Write-Host "Returning to main menu..." -ForegroundColor Cyan }
                    default { Write-Host "Invalid option. Try again." -ForegroundColor Red }
                }
            } while ($toolChoice -ne "0")
        }
        "12" {
            do {
                Show-ControllerMenu
                $ControllerChoice = Read-Host "Select a Controller option"

                if ($ControllerChoice -eq "0") {
                    Write-Host "Returning to main menu..." -ForegroundColor Cyan
                    break
                }
                if ($ControllerChoice -match '^\d+$' -and [int]$ControllerChoice -ge 1 -and [int]$ControllerChoice -le 8) {
                    if ($ControllerChoice -ne "8") {
                        $name = Read-Host "Enter the controller name"
                    }
                    if ($ControllerChoice -eq "3" -or $ControllerChoice -eq "5") {
                        $model = Read-Host "Enter the model name"
                    }
                    if ($ControllerChoice -eq "7") {
                        $subdirectory = Read-Host "Enter the subdirectory name"
                    }
                    switch ($ControllerChoice) {
                        "1" { Run-LaravelCommand "make:controller ${name}Controller" }
                        "2" { Run-LaravelCommand "make:controller ${name}Controller --resource" }
                        "3" { Run-LaravelCommand "make:controller ${name}Controller --resource --model=$model" }
                        "4" { Run-LaravelCommand "make:controller ${name}Controller --api" }
                        "5" { Run-LaravelCommand "make:controller ${name}Controller --api --model=$model" }
                        "6" { Run-LaravelCommand "make:controller ${name}Controller --invokable" }
                        "7" { Run-LaravelCommand "make:controller ${subdirectory}/${name}Controller" }
                        "8" { Run-LaravelCommand "help make:controller" }
                        default { Write-Host "Invalid option. Try again." -ForegroundColor Red }
                    }
                } else {
                    Write-Host "Invalid option. Try again." -ForegroundColor Red
                }

            } while ($true)
        }
        "0" {
            Write-Host "Goodbye! May the code be with you." -ForegroundColor Cyan
        }
        default {
            Write-Host "Invalid option. Try again." -ForegroundColor Red
        }
    }
} while ($choice -ne "0")
