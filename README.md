# WORKON

The goal of this scipt is to help me quickly jump to my python projects.

It will move to the project directory and activate its virtual environment.

Tested with bash only.

## Installation
Copy those scripts to ```~/.workon```.

Source ```~/.workon/workon_start.sh``` from your bashrc.

## Usage
Create a file ```workonrc``` in ```~/.workon/``` with that content:
```
project_name1=/path/to/project1
project_name2=/path/to/project2
```

To use the command just type:
```
workon project_name1
```
Autocomplete is also available.

If a ```.postactivate``` file is available in the project directory, it is sourced after the virtual environment is activated.
