use Cwd;

my $base = getcwd;

system("mkdir morphes");
chdir("$base/morphes");

# create .gro
system("echo 0 | /usr/local/gromacs/5.0/501-impi403-fftw332-gcc447-cuda60/bin/trjconv -s ../md.tpr -f ../traj_comp.xtc -o frame.gro -ur compact -pbc mol -sep -b 2001 -skip 8");
system("rm *#");

# create .tpr
for(my $i=0; $i<100; $i++)
{
	my $num = $i+1;
	system("mkdir $base/morphes/frame$num");
	chdir("$base/morphes/frame$num");
	system("mv ../frame$i.gro frame$num.gro");
	system("/usr/local/gromacs/5.0/501-impi403-fftw332-gcc447-cuda60/bin/grompp -p $base/../newtop.top -c frame$num.gro -f $base/morph.mdp -v");

	system("rm *#");
}

