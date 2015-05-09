# set locations of Java
if [ -x /usr/libexec/java_home ]; then
	export J6="$(/usr/libexec/java_home -v 1.6)"
	export J7="$(/usr/libexec/java_home -v 1.7)"
	export J8="$(/usr/libexec/java_home -v 1.8)"
fi
alias j6='export JAVA_HOME=$J6 && echo "JAVA_HOME -> $JAVA_HOME" && java -version'
alias j7='export JAVA_HOME=$J7 && echo "JAVA_HOME -> $JAVA_HOME" && java -version'
alias j8='export JAVA_HOME=$J8 && echo "JAVA_HOME -> $JAVA_HOME" && java -version'

# unset the actual classpath, since some programs play badly with it
unset CLASSPATH

# add some basic directories to the classpath
# NB: We avoid the CLASSPATH variable since some programs play badly with it.
export JAVA_CP=\
$HOME/java:\
$CODE_PRIVATE/java:\
$CODE_PRIVATE/java/utils

# generate classpath for desired Maven artifacts
cpFile="$HOME/.java-classpath"
if [ ! -e "$cpFile" ]; then
	# generate classpath cache
	echo "Regenerating $cpFile"
	maven-cp \
		ome:formats-gpl:5.0.5 \
		loci:loci-utils:1.0.0-SNAPSHOT \
		org.beanshell:bsh:2.0b4 > $cpFile
fi
export JAVA_CP="$JAVA_CP:$(cat $cpFile)"

# add aliases for launching Java with the JAVA_CP classpath
alias j='java -cp "$JAVA_CP:."'
alias jc='javac -cp "$JAVA_CP:."'
alias jp='javap -cp "$JAVA_CP:."'
