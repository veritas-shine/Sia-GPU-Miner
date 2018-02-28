macro(ADD_FRAMEWORK fwname appname)
    find_library(FRAMEWORK_${fwname}
            NAMES ${fwname}
            PATHS /System/Library
            PATH_SUFFIXES Frameworks
            NO_DEFAULT_PATH)
    if( ${FRAMEWORK_${fwname}} STREQUAL FRAMEWORK_${fwname}-NOTFOUND)
        MESSAGE(ERROR ": Framework ${fwname} not found")
    else()
        TARGET_LINK_LIBRARIES(${appname} "${FRAMEWORK_${fwname}}/${fwname}")
        MESSAGE(STATUS "Framework ${fwname} found at ${FRAMEWORK_${fwname}}")
    endif()
endmacro(ADD_FRAMEWORK)

function(CheckLibrary)
    if (APPLE)
        find_library(HAVE_CURL curl)
        if(HAVE_CURL)
            include_directories(/usr/local/opt/curl/include)
            link_directories(/usr/local/opt/curl/lib)
        else()
            message(WARNING "install curl by homebrew is better")
        endif()

    elseif(UNIX)
        include_directories(/usr/include)
        link_directories(/usr/lib /usr/lib/x86_64-linux-gnu)

    endif (APPLE)
endfunction()

function(LinTargetLibrary Target)
    if(APPLE)
        target_link_libraries(${Target} curl "-framework OpenCL")
    elseif(UNIX)
        target_link_libraries(${Target} OpenCL curl)
    endif()
endfunction()
