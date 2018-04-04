class Literate
  @test={"data"=>[{"md5"=>"9e74381cbb0866b7a255694c04505781", "oldMd5"=>"9e74381cbb0866b7a255694c04505781", "xlsJson"=>"asdasd", "fileName"=>"均辉-5.26-john-导致重复.xls"}], "controller"=>"admin/sea_freight_imports", "action"=>"check", "sea_freight_dir_id"=>"-1", "sea_freight_import"=>{}}
  @DeleteArray = %w(_json xlsJson tabData sheetData utf8 authenticity_token password password_confirmation controller action)
  class << self
    attr_accessor :DeleteArray,:test

    def commonBlock threadHold_Array,threadHold_String,k,v,isKeyInArray
      is_delete=true if v.blank?
      is_delete=true if isKeyInArray
      if v.is_a?(String)
        is_delete=true if v.strip.blank?
        th=threadHold_String
        v=v[0..th] << "...[字符串超过#{th}，已截断。]" if v.size>th # 截取长字符
      elsif v.is_a?(Array)
        th=threadHold_Array
        if v.size>th
          v=v[0,th]
          v+=["...[数组超过#{th}，已截断。]"]
        end
      end
      # is_delete=true if /^ActionDispatch::Http::UploadedFile/=~v.class.name
      v='<Object>' if v.to_s.match(/^#<.*>$/) # 删除对象
      {:v=>v,:is_delete=>is_delete}
    end

    def literate(params,deleteArray=[],grade=0,parent=nil,&block) # iterate
      # ap deleteArray
      # ap params
      deleteArray=@DeleteArray if deleteArray=='default'
      if params.blank?
        params
      elsif params.is_a?(Hash)
        params.map { |k,v|
          # ap k
          # ap deleteArray
          ret=block.call(k,v,deleteArray.include?(k.to_s))

          is_delete=ret[:is_delete]
          v=ret[:v]

          if is_delete
            params.delete(k)
          else
            v=literate(v,deleteArray,grade+=1,params,&block)
            params[k.to_sym]=v
          end
        }
        params
      elsif params.is_a?(Array)
        params.map { |v|
          ret=block.call(nil,v)
          is_delete=ret[:is_delete]
          v=ret[:v]
          # ap 'grade='+('  '*grade)+k

          if is_delete
            v=nil
          else
            v=literate(v,deleteArray,grade+=1,params,&block)
          end
        }
      else
        ret=block.call(nil,params)
        is_delete=ret[:is_delete]
        v=ret[:v]

        if is_delete
          v=nil
        else
          v
        end
        v
      end
    end
  end
end