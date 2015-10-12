# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

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
alias ll='ls -FGlAhp'
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

