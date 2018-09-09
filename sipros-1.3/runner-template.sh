# Import Agave runtime extensions
. _lib/extend-runtime.sh

# Allow CONTAINER_IMAGE over-ride via local file
if [ -z "${CONTAINER_IMAGE}" ]
then
    if [ -f "./_lib/CONTAINER_IMAGE" ]; then
        CONTAINER_IMAGE=$(cat ./_lib/CONTAINER_IMAGE)
    fi
    if [ -z "${CONTAINER_IMAGE}" ]; then
        echo "CONTAINER_IMAGE was not set via the app or CONTAINER_IMAGE file"
        CONTAINER_IMAGE="sd2e/base:ubuntu17"
    fi
fi

# Usage: container_exec IMAGE COMMAND OPTIONS
#   Example: docker run centos:7 uname -a
#            container_exec centos:7 uname -a



COMMAND=" Sipros_OpenMP "
PARAMS=" -c ${configuration_file} "

if [ "${single_or_multi}" = "single" ];
then
	PARAMS="${PARAMS} -f ${ms2_file} "

elif [ "${single_or_multi}" = "multi" ];
then
	PARAMS="${PARAMS} -w ${working_directory} "
	
fi

if [ -z "${silence_output}" ];
then
	PARAMS="${PARAMS} -s "
fi

_NUM_THREADS=auto_maxthreads
export OMP_NUM_THREADS=${_NUM_THREADS}
mkdir -p ./output/
container_exec ${CONTAINER_IMAGE} ${COMMAND} ${PARAMS} -o ./output/


