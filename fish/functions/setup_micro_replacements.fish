function setup_micro_replacements
    function nano
        micro $argv
    end

    function vim
        micro $argv
    end

    function cat
        micro $argv
    end

    function bat
        micro $argv
    end

    function sudo
        if test (count $argv) -ge 2
            switch $argv[1]
                case nano vim cat bat
                    command sudo micro $argv[2..-1]
                case '*'
                    command sudo $argv
            end
        else
            command sudo $argv
        end
    end

    set -gx EDITOR micro
    set -gx VISUAL micro
end
