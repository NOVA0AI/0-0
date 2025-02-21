param (
    [switch]$OpenInVSCode
)

# Function to create directories if they don't exist
function Create-Directory {
    param (
        [string]$path
    )
    if (-not (Test-Path $path)) {
        New-Item -ItemType Directory -Path $path | Out-Null
        Write-Host "Created directory: $path"
    }
}

# Function to create files with optional content
function Create-File {
    param (
        [string]$path,
        [string]$content = ""
    )
    if (-not (Test-Path $path)) {
        New-Item -ItemType File -Path $path | Out-Null
        if ($content) {
            Set-Content -Path $path -Value $content
        } elseif ($path -like "*.py") {
            Set-Content -Path $path -Value "# Placeholder for future implementation"
        } elseif ($path -like "*.txt") {
            Set-Content -Path $path -Value "# Placeholder text"
        }
        Write-Host "Created file: $path"
    }
}

# Define the root directory (current directory)
$projectRoot = "."

# Create all directories
$directories = @(
    "Constitution",
    "Orchestrator",
    "Shared_Agentic_Toolbox",
    "Passive_Listener",
    "Project_Management/Command_Interpreter",
    "Data/Raw_Data",
    "Data/Data_Infrastructure",
    "Model/Self_Learning",
    "Model/Model_Scale",
    "Deployment/Server",
    "Deployment/Packaging",
    "Monitoring/Logs",
    "Monitoring/Dashboards",
    "Documentation/Guides",
    "Documentation/Gaps",
    "Backups"
)
foreach ($dir in $directories) {
    Create-Directory (Join-Path $projectRoot $dir)
}

# Define files with optional content
$files = @{
    "Constitution" = @(
        @{ Name = "principles.txt"; Content = "1. Self-optimize at every level.`n2. Automate updates and scaling.`n3. Over-design for future-proofing." }
    )
    "Orchestrator" = @(
        @{ Name = "master_orchestrator.py" }
    )
    "Shared_Agentic_Toolbox" = @(
        @{ Name = "guidelines.txt"; Content = "# Nova Guidelines`n- default_terminal: PowerShell`n- automation_preference: code_over_manual`n- task_delivery: one_at_a_time" },
        @{ Name = "current_context.txt"; Content = "Setup" }
    )
    "Passive_Listener" = @(
        @{ Name = "listener_agent.py" },
        @{ Name = "user_inputs.log" }
    )
    "Project_Management/Command_Interpreter" = @(
        @{ Name = "command_parser.py" },
        @{ Name = "interact_with_grok.py" }
    )
    "Data/Raw_Data" = @(
        @{ Name = "test_data.csv" }
    )
    "Data/Data_Infrastructure" = @(
        @{ Name = "data_scale_plan.txt" }
    )
    "Model/Self_Learning" = @(
        @{ Name = "workerbee_memory.txt" }
    )
    "Model/Model_Scale" = @(
        @{ Name = "model_scale_plan.txt" }
    )
    "Deployment/Server" = @(
        @{ Name = "nova_server.py" }
    )
    "Deployment/Packaging" = @(
        @{ Name = "nova_package.py" }
    )
    "Monitoring/Logs" = @(
        @{ Name = "nova_monitor_log.txt" }
    )
    "Monitoring/Dashboards" = @(
        @{ Name = "nova_dashboard.txt" }
    )
    "Documentation/Guides" = @(
        @{ Name = "nova_guide.txt" }
    )
    "Documentation/Gaps" = @(
        @{ Name = "nova_gaps.txt" }
    )
    "Backups" = @(
        @{ Name = "nova_day1.zip" }
    )
}

# Create files with content
foreach ($dir in $files.Keys) {
    foreach ($file in $files[$dir]) {
        $filePath = Join-Path $projectRoot (Join-Path $dir $file.Name)
        Create-File $filePath $file.Content
    }
}

# Create README.md
$readmeContent = @"
# Nova: Self-Learning AI Chat Hub

Nova is an open-source, self-learning AI chat hub designed for scalability, automation, and type-only interaction.

## Setup

1. Clone the repository.
2. Run `setup.ps1` in PowerShell to create the project structure.
3. Start developing!

## Structure

- `/Constitution/`: Core principles
- `/Orchestrator/`: Master orchestrator
- `/Shared_Agentic_Toolbox/`: Guidelines and context
- `/Passive_Listener/`: Listener agent
- `/Project_Management/`: Command interpreter
- `/Data/`: Data management
"@
Create-File (Join-Path $projectRoot "README.md") $readmeContent

# Create .gitignore
$gitignoreContent = @"
*.log
*.zip
__pycache__/
"@
Create-File (Join-Path $projectRoot ".gitignore") $gitignoreContent

# Create virtual environment
if (-not (Test-Path (Join-Path $projectRoot "venv"))) {
    python -m venv (Join-Path $projectRoot "venv")
    Write-Host "Virtual environment created in 'venv'. Activate with '.\venv\Scripts\Activate.ps1'"
}

Write-Host "Project structure created successfully!"

# Open in VS Code if specified
if ($OpenInVSCode) {
    code $projectRoot
}