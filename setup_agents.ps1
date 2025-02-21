# Define the root directory (assuming this script runs from the Nova project root)
$projectRoot = Get-Location

# Function to create directories if they don't exist
function Create-Directory {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    try {
        if (-not (Test-Path -Path $Path)) {
            New-Item -ItemType Directory -Path $Path -ErrorAction Stop | Out-Null
            Write-Host "Created directory: $Path"
        } else {
            Write-Host "Directory already exists: $Path"
        }
    } catch {
        Write-Error "Failed to create directory $Path : $_"
    }
}

# Function to create files with optional content
function Create-File {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Path,
        [string]$Content = ""
    )
    try {
        if (-not (Test-Path -Path $Path)) {
            New-Item -ItemType File -Path $Path -ErrorAction Stop | Out-Null
            if ($Content) {
                Set-Content -Path $Path -Value $Content -ErrorAction Stop
            } elseif ($Path -like "*.py") {
                Set-Content -Path $Path -Value "# Placeholder for future implementation" -ErrorAction Stop
            } elseif ($Path -like "*.txt") {
                Set-Content -Path $Path -Value "# Placeholder text" -ErrorAction Stop
            }
            Write-Host "Created file: $Path"
        } else {
            Write-Host "File already exists: $Path"
        }
    } catch {
        Write-Error "Failed to create file $Path : $_"
    }
}

# Ensure the Agents directory exists
$agentsRoot = Join-Path -Path $projectRoot -ChildPath "Agents"
Create-Directory -Path $agentsRoot

# Define agent directories with subfolders and files
$agents = @{
    "WorkerBee" = @{
        "MainScript" = "workerbee_agent.py"
        "SubFolders" = @{
            "Config" = "workerbee_config.txt"
            "Logs"   = "workerbee_logs.txt"
            "Utils"  = "workerbee_utils.py"
        }
    }
    "Open_Source_Agent" = @{
        "MainScript" = "open_source_agent.py"
        "SubFolders" = @{
            "Config" = "open_source_config.txt"
            "Logs"   = "open_source_logs.txt"
            "Utils"  = "open_source_utils.py"
        }
    }
    "Passive_Listener" = @{
        "MainScript" = "listener_agent.py"
        "SubFolders" = @{
            "Config" = "listener_config.txt"
            "Logs"   = "user_inputs.log"
            "Utils"  = "listener_utils.py"
        }
    }
    "Dependency_Mapping" = @{
        "MainScript" = "dependency_mapper.py"
        "SubFolders" = @{
            "Config" = "dependency_config.txt"
            "Logs"   = "dependency_logs.txt"
            "Utils"  = "dependency_utils.py"
        }
    }
    "Memory_Cleaning" = @{
        "MainScript" = "memory_cleaner.py"
        "SubFolders" = @{
            "Config" = "memory_config.txt"
            "Logs"   = "memory_logs.txt"
            "Utils"  = "memory_utils.py"
        }
    }
    "SIKTYK" = @{
        "MainScript" = "siktyk_agent.py"
        "SubFolders" = @{
            "Config" = "siktyk_config.txt"
            "Logs"   = "siktyk_logs.txt"
            "Utils"  = "siktyk_utils.py"
        }
    }
    "Auditing" = @{
        "MainScript" = "auditing_suite.py"
        "SubFolders" = @{
            "Config" = "auditing_config.txt"
            "Logs"   = "auditing_logs.txt"
            "Utils"  = "auditing_utils.py"
        }
    }
    "Evolutionary_Tracking" = @{
        "MainScript" = "evolutionary_tracker.py"
        "SubFolders" = @{
            "Config" = "evolutionary_config.txt"
            "Logs"   = "evolutionary_logs.txt"
            "Utils"  = "evolutionary_utils.py"
        }
    }
    "Bio_Systems" = @{
        "MainScript" = "bio_systems_agent.py"
        "SubFolders" = @{
            "Config" = "bio_config.txt"
            "Logs"   = "bio_logs.txt"
            "Utils"  = "bio_utils.py"
        }
    }
}

# Create agent directories and their files
foreach ($agent in $agents.Keys) {
    $agentDir = Join-Path -Path $agentsRoot -ChildPath $agent
    Create-Directory -Path $agentDir
    
    # Create main agent script
    $mainScriptPath = Join-Path -Path $agentDir -ChildPath $agents[$agent]["MainScript"]
    Create-File -Path $mainScriptPath
    
    # Create subfolders and their files
    foreach ($subDir in $agents[$agent]["SubFolders"].Keys) {
        $subDirPath = Join-Path -Path $agentDir -ChildPath $subDir
        Create-Directory -Path $subDirPath
        $subFilePath = Join-Path -Path $subDirPath -ChildPath $agents[$agent]["SubFolders"][$subDir]
        Create-File -Path $subFilePath
    }
}

# Additional placeholder directories at the Agents root
$additionalDirs = @(
    "Agent_Communication",
    "Agent_Performance",
    "Agent_Security",
    "Agent_Training"
)
foreach ($dir in $additionalDirs) {
    $dirPath = Join-Path -Path $agentsRoot -ChildPath $dir
    Create-Directory -Path $dirPath
}

Write-Host "Agents folder structure created successfully!" -ForegroundColor Green