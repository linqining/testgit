require "browser"
module ApplicationControllerDevice
  module ClassMethods
    @route_path
    @browser
    @is_mobile
    @path_mobile
    def initDevice
      # is_skip_init_device=Rails.env.development?
      is_skip_init_device = false
      path_route=[]
      path_route.push(controller_name)
      path_route.push(action_name)
      path_url=request.original_fullpath.gsub(/^\//,'')
      path_url=path_url.gsub(/^(.*?)\?(.*)/,'\1')
      path_url=path_url.gsub(/^(.*?)\/\d+\/.*/,'\1')
      path_url=path_url.split('/')
      path=[]
      path_url.each.with_index do |p,i|
        break if path_route[i].nil?
        path.push(p) if p==path_route[i]
      end
      if path.length==0
        path=path_url
      end
      action=action_name
      action=nil if path[path.size-1]==action

      return if path.join('/')=='js/head'

      isAdmin= (defined? current_active_admin_user) ? true : false
      isDemander= ((defined? current_demander) && !current_demander.nil?) ? true : false
      isSupplier= ((defined? current_supplier) && !current_supplier.nil?) ? true : false
      userType='unknown'
      user_id=-1

      # if !isAdmin && (path.join('/')=='admin' || path.join('/')=='admin/login')
      #   isAdmin=true
      # end
      if isAdmin
        userType='admin'
        user_id=current_active_admin_user.nil? ? -1 : current_active_admin_user.id
        path_route.push('admin')
      end
      unless isAdmin
        if isSupplier
          userType='supplier'
          user_id=current_supplier.id
        end
        if isDemander
          userType='demander'
          user_id=current_demander.id
          userType=if current_demander.can_publish_sea_flights
                     'demander.prefered'
                   elsif current_demander.if_banned
                     'demander.banned'
                   else
                     'demander.normal'
                   end
        end
      end

      # 这是为了防止ActviceAdmin缓存controller出错，只能禁止开发时后台追踪
      # return if isAdmin && Rails.env.development?

      # get decive
      cookieId='youtu_id'
      deviceId=cookies[cookieId]

      newDeviceAttr={
          :ua=>request.user_agent,
          :is_null_cookie=>false,
          :count_login=>0,
      }

      unless is_skip_init_device
        if deviceId.nil?
          newDeviceAttr[:is_null_cookie]=true
          deviceId=SecureRandom.hex(16)
          newDeviceAttr[:youtu_id]=deviceId
          device=::Device.create(newDeviceAttr)
          cookies.permanent[cookieId]=deviceId
          device.is_new=true
        else
          device= ::Device.where({
                                     :youtu_id=>deviceId,
                                     :ua=>request.user_agent,
                                 })
          if !device || device.size==0 || !device.first
            newDeviceAttr[:youtu_id]=deviceId
            device=::Device.create(newDeviceAttr)
            device.is_new=true
          else
            device=device.first unless device.first.nil?
            device.is_new=false
          end
        end

        @device=device


        statusAttr={
            :user_type=>userType,
            :user_id=>user_id,
            :ip=>request.remote_ip,
            :session=>request.session_options[:id],
            :device_id=>device.id,
        }
        status=::DeviceStatus.where(statusAttr).first()
        if status.nil?
          statusAttr[:is_new_device]=device.is_new
          status=::DeviceStatus.create(statusAttr)
        end
        @device_status=status
      end

      route=action_name
      blackList=%w(get_history check do_upload do_check do_import)


      params = blackList.include?(route) ? {'message':'行为已被过滤，不记录Params详细'} : self.betterParams


      referer=request.referer
      referer=referer.clone.gsub(/^http(s)?:\/\/(www\.)?#{request.domain.gsub('.','\.')}/,'') unless (referer.nil? || request.domain.nil?)
      unless is_skip_init_device
        actlog=::Actlog.create({
                                   :device_status_id=>status.id,
                                   :original_fullpath=>request.original_fullpath,
                                   :referer=>referer,
                                   :path=>path.join('/'),
                                   :action=>action,
                                   :count_view=>1,
                                   :params=>params,
                                   :device_status=>status,
                                   :device=>device
                               })
      end

      @actlog=actlog
      @route_path=path.join('/')
      @browser = Browser.new(request.user_agent)
      @is_mobile=@browser.device.tablet? || @browser.device.mobile?
      # @is_mobile=true
      if @is_mobile
        @path_mobile='_mobile'
      else
        @path_mobile=''
      end
    end

    def betterParams
      params=request.params.deep_dup


      unless params.empty?
        params=::Literate.literate(params,'default') { |k,v,isKeyInArray|
          Literate.commonBlock 30,1000,k,v,isKeyInArray
        }
      end

      params=nil if params.try(:keys).try(:empty?)

      params
    end


  end
end