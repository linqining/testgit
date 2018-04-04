# == Schema Information
#
# Table name: actlogs
#
#  id                :integer          not null, primary key
#  device_status_id  :integer
#  original_fullpath :text(65535)
#  referer           :text(65535)
#  path              :string(255)
#  action            :string(255)
#  count_view        :integer
#  params            :text(65535)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Actlog < ActiveRecord::Base
  @concernKeywords=[]
  @concernRoute=[]
  @concernMap=[]
  def self.create(attr)

    unless attr[:params].nil?
      params=attr[:params]
      attr[:params]=attr[:params].to_json
      params_json=attr[:params]
      device_status=attr[:device_status]
      device=attr[:device]
    end
    attr.delete(:device_status)
    attr.delete(:device)

    actlog=super(attr)

    unless attr[:params].nil?
      addConcern('searchSeaFreight','freight/seas',attr) do |attr|
        'departure_city,departure_port,destination_port,boat_company_id,sea_line_id'
      end
      addConcern('searchSeaFreight','supplier/all_sea_oneways',attr) do |attr|
        'departure_city,departure_port,destination_port,boat_company_id,sea_line_id'
      end
      addConcern('searchSeaFreight','demander/all_sea_oneways',attr) do |attr|
        'departure_city,departure_port,destination_port,boat_company_id,sea_line_id'
      end
      addConcern('searchTruckFee','supplier/query_price',attr) do |attr|
        'destination_address,departure_city'
      end
      addConcern('searchTruckFee','demander/query_price',attr) do |attr|
        'destination_address,departure_city'
      end

      attr[:params]=params
      attr[:params_json]=params_json
      attr[:device_status]=device_status
      attr[:device]=device

      concernHandler(attr,actlog)
    end


  end

  def self.concernHandler(attr,actlog)

    path=attr[:path]
    action=attr[:action]
    params=attr[:params]
    @concernRoute.each.with_index do |route,i|
      if route[0]==path && route[1]==action

        status=attr[:device_status]
        c={
            :keywords=>@concernKeywords[i],
            :actlog_id=>actlog.id,
            :user_type=>status[:user_type],
            :user_id=>status[:user_id],
            :path=>actlog[:path],
            :action=>actlog[:action],
            :params=>attr[:params_json],
        }

        map=@concernMap[i].split(',')
        map.each.with_index do |m,i|
          c[('str'+(i+1).to_s).to_sym]=params[m.to_sym]
        end
        ActlogConcern.create(c)
        break  #=====================================互斥，只执行最先匹配的规则
      end
    end

  end

  def self.addConcern(keywords,route,attr)
    @concernKeywords.push(keywords)
    @concernRoute.push(route.split('#'))
    @concernMap.push(yield(attr))
  end
end
