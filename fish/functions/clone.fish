function clone --description "Clone git repository using gix"
    set -l repo $argv[1]
  
    # Jeśli format to autor/repo
    if not string match -q -- "https://*" $repo
        set repo "https://github.com/$repo"
    end
  
    # Usuń "git clone" jeśli użytkownik wpisał pełną komendę
    set repo (string replace "git clone " "" $repo)
  
    # Wyciągnij nazwę repo z URL
    set -l repo_name (string split "/" $repo)[-1]
    set -l repo_name (string replace ".git" "" $repo_name)
  
    # Wykonaj klonowanie
    gix clone $repo /Users/kenny/Repositories/$repo_name
end