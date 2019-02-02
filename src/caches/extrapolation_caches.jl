@cache mutable struct RichardsonEulerCache{uType,rateType,arrayType,dtType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  tmp::uType
  k::rateType
  fsalfirst::rateType
  dtproposeold::dtType
  dtpropose::dtType
  T::arrayType
  order::Int
  order_max::Int
  last_work::dtType
  work::dtType
  A::Int
end

@cache mutable struct RichardsonEulerConstantCache{dtType,arrayType} <: OrdinaryDiffEqConstantCache
  dtproposeold::dtType
  dtpropose::dtType
  T::arrayType
  order::Int
  order_max::Int
  last_work::dtType
  work::dtType
  A::Int
end

function alg_cache(alg::RichardsonEuler,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  tmp = similar(u)
  k = zero(rate_prototype)
  fsalfirst = zero(rate_prototype)
  order = 1
  order_max = 9
  dtproposeold = zero(dt)
  dtpropose = zero(dt)
  T = fill(zeros(eltype(u), size(u)), (order_max, order_max))
  last_work = zero(dt)
  work = zero(dt)
  A = one(Int)
  RichardsonEulerCache(u,uprev,tmp,k,fsalfirst,dtproposeold,dtpropose,T,order,order_max,last_work,work,A)
end

function alg_cache(alg::RichardsonEuler,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}})
  dtproposeold = zero(dt)
  dtpropose = zero(dt)
  order = 1
  order_max = 9
  T = fill(zero(eltype(u)), (order_max, order_max))
  last_work = zero(dt)
  work = zero(dt)
  A = one(Int)  
  RichardsonEulerConstantCache(dtproposeold,dtpropose,T,order,order_max,last_work,work,A)
end
