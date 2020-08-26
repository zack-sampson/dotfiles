postgres_dir=/Applications/Postgres.app/Contents/Versions/latest

if [ -d "${postgres_dir}" ] ; then
  export PATH=${postgres_dir}/bin:$PATH
fi
