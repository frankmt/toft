require "bundler/gem_tasks"

PROJECT_ROOT = File.dirname(__FILE__)
LXC_PACKAGE_NAME = "toft-lxc"

desc "clean artifacts"
task :clean do
  `rm -rf pkg`
  `rm -rf tmp`
end

desc "build gem and scripts package"
task :package => [:build, :package_scripts]

task :package_scripts do
  src_dir = "#{PROJECT_ROOT}/scripts/ubuntu"
  content_dir = "#{PROJECT_ROOT}/pkg/#{LXC_PACKAGE_NAME}"
  mkdir_p content_dir
  mkdir_p "#{content_dir}/usr/local/bin"
  mkdir_p "#{content_dir}/usr/lib/lxc/templates"
  cp_r Dir.glob("#{src_dir}/bin/*"), "#{content_dir}/usr/local/bin"
  cp_r Dir.glob("#{src_dir}/lxc-templates/*"), "#{content_dir}/usr/lib/lxc/templates"
  
  post_install_script = <<-eos
#!/bin/sh -e
lxc-prepare-host
eos
  File.open("#{PROJECT_ROOT}/pkg/toft-lxc-post-install.sh", 'w') { |f| f.write(post_install_script) }
  
  Dir.chdir("pkg") do
    system <<-EOF
    fpm -s dir \
    -t deb \
    -C #{content_dir} \
    -a all \
    -n #{LXC_PACKAGE_NAME} \
    -v #{Toft::VERSION} \
    -m "Huang Liang<exceedhl@gmail.com>" \
    --description "lxc templates and helper provided by toft" \
    -d dnsutils \
    -d bridge-utils \
    -d debootstrap \
    -d dhcp3-server \
    -d bind9 \
    -d ntp \
    --conflicts apparmor \
    --conflicts apparmor-utils \
    --post-install "#{PROJECT_ROOT}/pkg/toft-lxc-post-install.sh" \
    .
    EOF
  end
end

desc "run all tests and features"
task :test do
  `rspec spec`
  `sudo cucumber features`
end
