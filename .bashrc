# .bashrc

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Alias for launching multitail with relevant log files
alias logmon='multitail /var/log/messages /var/log/secure /var/log/exim_mainlog /var/log/maillog'

# Scan a user with clamscan and email results
# Usage: scanuser <username>
scanuser() {
	if [ -z "$1" ]; then
		echo 'You must provide a user to scan.'
	else
		DIR='/home/'$1
		LOG='/root/logs/clamav/clamscan-'$(date +%F.%H:%M:%S)'-'$1'.log'
		EMAIL='radams@ntsi.com'
		clamscan -r -i $DIR -l $LOG
		cat $LOG | mail -s "WHM $(hostname -s): clamav scan results for $1" -r $EMAIL $EMAIL
	fi
}

# Count files in a directory
# Usage: filecount [<directory>]
filecount() {
        if [ -z "$1" ]; then
                find . -type f | wc -l
        else
                find $1 -type f | wc -l
        fi
}

# Count files in each accounts public_html folders
# Usage: countpublichtml
countpublichtml() {
        echo "Files count in public_html folders"
        echo "-----------------------------------------------"
        for i in $(find /home -maxdepth 2 -type d -name public_html) ; do
                COUNT=$( find $i -type f | wc -l ) ;
                echo -e "$COUNT\t$i" ;
        done
}

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


# Load Bash Colors
source ~/.bash_colors.sh

# Load git prompt
source ~/.git-prompt.sh

export PS1="\[$White\]__\[$Green\][\[$BGreen\]\h:\[$Cyan\]\u\[$Green\]]\[$White\]____________________________________________\[$Green\][\[$Yellow\]\@\[$Green\]]\[$White\]__\n| \w\$(__git_ps1) \n| => "
export PS2="| => "

# Preferred implementations
alias ll='ls -FlAhp'
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

