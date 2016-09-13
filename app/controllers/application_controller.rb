class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def page
    params[:page].to_i == 0 ? 1 : params[:page].to_i
  end

  def per_page
    params[:per_page].to_i == 0 ? 10 : params[:per_page].to_i
  end

  def auto_paginate(value, count = nil)
    retval = {}
    retval[:current_page] = page
    retval[:per_page] = per_page
    retval[:previous_page] = (page - 1 > 0 ? page - 1 : 1)

    # 当没有block或者传入的是一个mongoid集合对象时就自动分页
    # TODO : 更优的判断是否mongoid对象?
    # instance_of?(Mongoid::Criteria) .by lcm
    # if block_given? 
    # if value.methods.include? :page
    if value.instance_of?(Mongoid::Criteria)
      count ||= value.count
      value = value.page(retval[:current_page]).per(retval[:per_page])
    elsif value.is_a?(Array) && value.count > per_page
      count ||= value.count
      value = value.slice((page - 1) * per_page, per_page)
    end
      
    if block_given?
      retval[:data] = yield(value) 
    else
      retval[:data] = value
    end
    retval[:total_page] = ( (count || value.count )/ per_page.to_f ).ceil
    retval[:total_page] = retval[:total_page] == 0 ? 1 : retval[:total_page]
    retval[:total_number] = count || value.count
    retval[:next_page] = (page+1 <= retval[:total_page] ? page+1: retval[:total_page])
    retval
  end
end
