Pod::Spec.new do |s|

  s.name         = "ZLCellDataSource"
  s.version      = "0.2.2"
  s.summary      = "ZLCellDataSource"

  s.description  = <<-DESC
                      为UIViewController瘦身，分离出DataSource代理
                   DESC

  s.homepage     = "https://github.com/czl0325/ZLCellDataSource"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "czl0325" => "295183917@qq.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/czl0325/ZLCellDataSource.git", :tag => s.version }
  
  #s.ios.deployment_target = '8.0'
  s.source_files  = "ZLCellDataSource/ZLCellDataSource/*.{h,m}"
  s.requires_arc = true

end
