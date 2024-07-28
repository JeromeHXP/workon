# This script is used to start a virtual environment for python projects.
# It gets available virtual env from the workonrc file in the .workon home folder.
# This workonrc file should contain a list of the name of the virtual environment
# to use for the project and the path to the project root.

# The workonrc file should look like this:
# Smati=~/path/to/project/root/

# The script will activate the virtual environment and cd to the project root.
# It will then source an available .postactivate file in the project root

# Get the workonrc file
workonrc=~/.workon/workonrc

# Check if the workonrc file exists
if [ ! -f $workonrc ]; then
    echo "workonrc file not found. Please create a workonrc file in the .workon home folder."
    return
fi

# Get the virtual env name and project root path
while IFS='=' read -r name path
do
    if [ "$name" = "$1" ]; then
        # Change path to an absolute path if it's not already
        if [ ! -d $path ]; then
            path=$(eval echo $path)
        fi

        # Check if the project home path exists
        if [ ! -d $path ]; then
            echo "Project home not found."
            return
        fi

        # Remove last / at the end if it exists
        path=$(echo $path | sed 's:/*$::')

        # Check that the vistualenv exist in the project home (.venv, venv, env, .env)
        for dir in .venv venv env .env; do
            if [ -d "$path/$dir" ]; then
                venvpath="$path/$dir"
                break
            fi
        done

        if [ -z "$venvpath" ]; then
            echo "Virtual environment not found."
            return
        fi

        # Activate the virtual environment
        source "$venvpath/bin/activate"

        # Change to the project root
        cd $path

        # Source the .postactivate file
        if [ -f $path/.postactivate ]; then
            source $path/.postactivate
        fi
        break
    fi
done < $workonrc

