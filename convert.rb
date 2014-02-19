# 使用imagemagick 处理保存在mongo gridfs中的数据

a = Deal.last
# 把文件保存到文件系统
dst = Tempfile.new(RUBY_VERSION < '1.9' ? "image1": ['image1', ".jpg"])
dst.binmode
dst.write a.image.file.read
dst.close

# 根据坐标点和宽高进行图片裁剪
# convert 原始图片 -crop widthxheight+x+y 目标图片
image = ::MiniMagick::Image.new(dst.path, dst)
image.run_command('convert', dst.path, '-crop', '100x100+100+100', dst.path)

a.image = image
a.save

