Function Get-Greenshot {
    <#
        .SYNOPSIS
            Returns the available Greenshot versions.

        .NOTES
            Author: Aaron Parker
            Twitter: @stealthpuppy
        
        .LINK
            https://github.com/aaronparker/Evergreen

        .EXAMPLE
            Get-Greenshot

            Description:
            Returns the released Greenshot version and download URI.
    #>
    [OutputType([System.Management.Automation.PSObject])]
    [CmdletBinding()]
    Param()

    # Get application resource strings from its manifest
    $res = Get-FunctionResource -AppName ("$($MyInvocation.MyCommand)".Split("-"))[1]
    Write-Verbose -Message $res.Name

    # Pass the repo releases API URL and return a formatted object
    $params = @{
        Uri          = $res.Get.Uri
        MatchVersion = $res.Get.MatchVersion
        Filter       = $res.Get.MatchFileTypes
    }
    $object = Get-GitHubRepoRelease @params
    If ($object) {
        Write-Output -InputObject $object
    }
    Else {
        Write-Warning -Message "$($MyInvocation.MyCommand): Failed to return a usable object from the repo."
    }
}
