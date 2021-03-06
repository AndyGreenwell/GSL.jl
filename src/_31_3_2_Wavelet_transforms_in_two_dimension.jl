#!/usr/bin/env julia
#GSL Julia wrapper
#(c) 2013 Jiahao Chen <jiahao@mit.edu>
##############################################
# 31.3.2 Wavelet transforms in two dimension #
##############################################
export wavelet2d_transform, wavelet2d_transform_forward,
       wavelet2d_transform_inverse, wavelet2d_transform_matrix,
       wavelet2d_transform_matrix_forward, wavelet2d_transform_matrix_inverse,
       wavelet2d_nstransform, wavelet2d_nstransform_forward,
       wavelet2d_nstransform_inverse, wavelet2d_nstransform_matrix,
       wavelet2d_nstransform_matrix_forward,
       wavelet2d_nstransform_matrix_inverse


# These functions compute two-dimensional in-place forward and inverse discrete
# wavelet transforms in standard form on the array data stored in row-major
# form with dimensions size1 and size2 and physical row length tda.  The
# dimensions must be equal (square matrix) and are restricted to powers of two.
# For the transform version of the function the argument dir can be either
# forward (+1) or backward (-1).  A workspace work of the appropriate size must
# be provided.  On exit, the appropriate elements of the array data are
# replaced by their two-dimensional wavelet transform.          The functions
# return a status of GSL_SUCCESS upon successful completion.  GSL_EINVAL is
# returned if size1 and size2 are not equal and integer powers of 2, or if
# insufficient workspace is provided.
# 
#   Returns: Cint
function wavelet2d_transform(w::Ref{gsl_wavelet}, tda::Integer, size1::Integer, size2::Integer, dir::gsl_wavelet_direction)
    v = Ref{Cdouble}()
    work = Ref{gsl_wavelet_workspace}()
    errno = ccall( (:gsl_wavelet2d_transform, libgsl), Cint,
        (Ref{gsl_wavelet}, Ref{Cdouble}, Csize_t, Csize_t, Csize_t,
        gsl_wavelet_direction, Ref{gsl_wavelet_workspace}), w, data, tda,
        size1, size2, dir, work )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return data[], work[]
end


# These functions compute two-dimensional in-place forward and inverse discrete
# wavelet transforms in standard form on the array data stored in row-major
# form with dimensions size1 and size2 and physical row length tda.  The
# dimensions must be equal (square matrix) and are restricted to powers of two.
# For the transform version of the function the argument dir can be either
# forward (+1) or backward (-1).  A workspace work of the appropriate size must
# be provided.  On exit, the appropriate elements of the array data are
# replaced by their two-dimensional wavelet transform.          The functions
# return a status of GSL_SUCCESS upon successful completion.  GSL_EINVAL is
# returned if size1 and size2 are not equal and integer powers of 2, or if
# insufficient workspace is provided.
# 
#   Returns: Cint
function wavelet2d_transform_forward(w::Ref{gsl_wavelet}, tda::Integer, size1::Integer, size2::Integer)
    v = Ref{Cdouble}()
    work = Ref{gsl_wavelet_workspace}()
    errno = ccall( (:gsl_wavelet2d_transform_forward, libgsl), Cint,
        (Ref{gsl_wavelet}, Ref{Cdouble}, Csize_t, Csize_t, Csize_t,
        Ref{gsl_wavelet_workspace}), w, data, tda, size1, size2, work )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return data[], work[]
end


# These functions compute two-dimensional in-place forward and inverse discrete
# wavelet transforms in standard form on the array data stored in row-major
# form with dimensions size1 and size2 and physical row length tda.  The
# dimensions must be equal (square matrix) and are restricted to powers of two.
# For the transform version of the function the argument dir can be either
# forward (+1) or backward (-1).  A workspace work of the appropriate size must
# be provided.  On exit, the appropriate elements of the array data are
# replaced by their two-dimensional wavelet transform.          The functions
# return a status of GSL_SUCCESS upon successful completion.  GSL_EINVAL is
# returned if size1 and size2 are not equal and integer powers of 2, or if
# insufficient workspace is provided.
# 
#   Returns: Cint
function wavelet2d_transform_inverse(w::Ref{gsl_wavelet}, tda::Integer, size1::Integer, size2::Integer)
    v = Ref{Cdouble}()
    work = Ref{gsl_wavelet_workspace}()
    errno = ccall( (:gsl_wavelet2d_transform_inverse, libgsl), Cint,
        (Ref{gsl_wavelet}, Ref{Cdouble}, Csize_t, Csize_t, Csize_t,
        Ref{gsl_wavelet_workspace}), w, data, tda, size1, size2, work )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return data[], work[]
end


# These functions compute the two-dimensional in-place wavelet transform on a
# matrix a.
# 
#   Returns: Cint
function wavelet2d_transform_matrix(w::Ref{gsl_wavelet}, dir::gsl_wavelet_direction)
    m = Ref{gsl_matrix}()
    work = Ref{gsl_wavelet_workspace}()
    errno = ccall( (:gsl_wavelet2d_transform_matrix, libgsl), Cint,
        (Ref{gsl_wavelet}, Ref{gsl_matrix}, gsl_wavelet_direction,
        Ref{gsl_wavelet_workspace}), w, m, dir, work )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return m[], work[]
end


# These functions compute the two-dimensional in-place wavelet transform on a
# matrix a.
# 
#   Returns: Cint
function wavelet2d_transform_matrix_forward(w::Ref{gsl_wavelet})
    m = Ref{gsl_matrix}()
    work = Ref{gsl_wavelet_workspace}()
    errno = ccall( (:gsl_wavelet2d_transform_matrix_forward, libgsl),
        Cint, (Ref{gsl_wavelet}, Ref{gsl_matrix}, Ref{gsl_wavelet_workspace}),
        w, m, work )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return m[], work[]
end


# These functions compute the two-dimensional in-place wavelet transform on a
# matrix a.
# 
#   Returns: Cint
function wavelet2d_transform_matrix_inverse(w::Ref{gsl_wavelet})
    m = Ref{gsl_matrix}()
    work = Ref{gsl_wavelet_workspace}()
    errno = ccall( (:gsl_wavelet2d_transform_matrix_inverse, libgsl),
        Cint, (Ref{gsl_wavelet}, Ref{gsl_matrix}, Ref{gsl_wavelet_workspace}),
        w, m, work )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return m[], work[]
end


# These functions compute the two-dimensional wavelet transform in non-standard
# form.
# 
#   Returns: Cint
function wavelet2d_nstransform(w::Ref{gsl_wavelet}, tda::Integer, size1::Integer, size2::Integer, dir::gsl_wavelet_direction)
    v = Ref{Cdouble}()
    work = Ref{gsl_wavelet_workspace}()
    errno = ccall( (:gsl_wavelet2d_nstransform, libgsl), Cint,
        (Ref{gsl_wavelet}, Ref{Cdouble}, Csize_t, Csize_t, Csize_t,
        gsl_wavelet_direction, Ref{gsl_wavelet_workspace}), w, data, tda,
        size1, size2, dir, work )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return data[], work[]
end


# These functions compute the two-dimensional wavelet transform in non-standard
# form.
# 
#   Returns: Cint
function wavelet2d_nstransform_forward(w::Ref{gsl_wavelet}, tda::Integer, size1::Integer, size2::Integer)
    v = Ref{Cdouble}()
    work = Ref{gsl_wavelet_workspace}()
    errno = ccall( (:gsl_wavelet2d_nstransform_forward, libgsl), Cint,
        (Ref{gsl_wavelet}, Ref{Cdouble}, Csize_t, Csize_t, Csize_t,
        Ref{gsl_wavelet_workspace}), w, data, tda, size1, size2, work )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return data[], work[]
end


# These functions compute the two-dimensional wavelet transform in non-standard
# form.
# 
#   Returns: Cint
function wavelet2d_nstransform_inverse(w::Ref{gsl_wavelet}, tda::Integer, size1::Integer, size2::Integer)
    v = Ref{Cdouble}()
    work = Ref{gsl_wavelet_workspace}()
    errno = ccall( (:gsl_wavelet2d_nstransform_inverse, libgsl), Cint,
        (Ref{gsl_wavelet}, Ref{Cdouble}, Csize_t, Csize_t, Csize_t,
        Ref{gsl_wavelet_workspace}), w, data, tda, size1, size2, work )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return data[], work[]
end


# These functions compute the non-standard form of the two-dimensional in-place
# wavelet transform on a matrix a.
# 
#   Returns: Cint
function wavelet2d_nstransform_matrix(w::Ref{gsl_wavelet}, dir::gsl_wavelet_direction)
    m = Ref{gsl_matrix}()
    work = Ref{gsl_wavelet_workspace}()
    errno = ccall( (:gsl_wavelet2d_nstransform_matrix, libgsl), Cint,
        (Ref{gsl_wavelet}, Ref{gsl_matrix}, gsl_wavelet_direction,
        Ref{gsl_wavelet_workspace}), w, m, dir, work )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return m[], work[]
end


# These functions compute the non-standard form of the two-dimensional in-place
# wavelet transform on a matrix a.
# 
#   Returns: Cint
function wavelet2d_nstransform_matrix_forward(w::Ref{gsl_wavelet})
    m = Ref{gsl_matrix}()
    work = Ref{gsl_wavelet_workspace}()
    errno = ccall( (:gsl_wavelet2d_nstransform_matrix_forward, libgsl),
        Cint, (Ref{gsl_wavelet}, Ref{gsl_matrix}, Ref{gsl_wavelet_workspace}),
        w, m, work )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return m[], work[]
end


# These functions compute the non-standard form of the two-dimensional in-place
# wavelet transform on a matrix a.
# 
#   Returns: Cint
function wavelet2d_nstransform_matrix_inverse(w::Ref{gsl_wavelet})
    m = Ref{gsl_matrix}()
    work = Ref{gsl_wavelet_workspace}()
    errno = ccall( (:gsl_wavelet2d_nstransform_matrix_inverse, libgsl),
        Cint, (Ref{gsl_wavelet}, Ref{gsl_matrix}, Ref{gsl_wavelet_workspace}),
        w, m, work )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return m[], work[]
end
