// 首页专用JavaScript

$(document).ready(function() {
    // 轮播图自动播放
    $('#main_ad').carousel({
        interval: 5000,
        pause: "hover"
    });
    
    // 平滑滚动效果
    $('a[href^="#"]').on('click', function(event) {
        var target = $(this.getAttribute('href'));
        if (target.length) {
            event.preventDefault();
            $('html, body').stop().animate({
                scrollTop: target.offset().top - 70
            }, 1000);
        }
    });
    
    // 滚动动画效果
    function animateOnScroll() {
        $('.feature-card').each(function() {
            var elementTop = $(this).offset().top;
            var elementBottom = elementTop + $(this).outerHeight();
            var viewportTop = $(window).scrollTop();
            var viewportBottom = viewportTop + $(window).height();
            
            if (elementBottom > viewportTop && elementTop < viewportBottom) {
                $(this).addClass('animated fadeInUp');
            }
        });
        
        $('.book-card').each(function() {
            var elementTop = $(this).offset().top;
            var elementBottom = elementTop + $(this).outerHeight();
            var viewportTop = $(window).scrollTop();
            var viewportBottom = viewportTop + $(window).height();
            
            if (elementBottom > viewportTop && elementTop < viewportBottom) {
                $(this).addClass('animated fadeInUp');
            }
        });
        
        $('.stat-item').each(function() {
            var elementTop = $(this).offset().top;
            var elementBottom = elementTop + $(this).outerHeight();
            var viewportTop = $(window).scrollTop();
            var viewportBottom = viewportTop + $(window).height();
            
            if (elementBottom > viewportTop && elementTop < viewportBottom) {
                $(this).addClass('animated fadeInUp');
            }
        });
    }
    
    // 初始执行一次
    animateOnScroll();
    
    // 滚动时执行
    $(window).scroll(function() {
        animateOnScroll();
    });
    
    // 数字计数动画
    function animateNumbers() {
        $('.stat-number').each(function() {
            var $this = $(this);
            var countTo = $this.text();
            
            if (countTo.includes('+')) {
                countTo = parseInt(countTo.replace('+', ''));
                $({ countNum: 0 }).animate({
                    countNum: countTo
                }, {
                    duration: 2000,
                    easing: 'swing',
                    step: function() {
                        $this.text(Math.floor(this.countNum) + '+');
                    },
                    complete: function() {
                        $this.text(countTo + '+');
                    }
                });
            } else if (countTo.includes('%')) {
                countTo = parseInt(countTo.replace('%', ''));
                $({ countNum: 0 }).animate({
                    countNum: countTo
                }, {
                    duration: 2000,
                    easing: 'swing',
                    step: function() {
                        $this.text(Math.floor(this.countNum) + '%');
                    },
                    complete: function() {
                        $this.text(countTo + '%');
                    }
                });
            } else if (countTo.includes('h')) {
                $this.addClass('animated pulse');
            }
        });
    }
    
    // 当统计数据区域进入视口时执行数字动画
    $(window).scroll(function() {
        var statsSection = $('.stats-section');
        var statsTop = statsSection.offset().top;
        var statsBottom = statsTop + statsSection.outerHeight();
        var viewportTop = $(window).scrollTop();
        var viewportBottom = viewportTop + $(window).height();
        
        if (statsBottom > viewportTop && statsTop < viewportBottom) {
            if (!statsSection.hasClass('numbers-animated')) {
                statsSection.addClass('numbers-animated');
                animateNumbers();
            }
        }
    });
    
    // 导航栏滚动效果
    $(window).scroll(function() {
        if ($(this).scrollTop() > 50) {
            $('.navbar').addClass('scrolled');
        } else {
            $('.navbar').removeClass('scrolled');
        }
    });
    
    // 卡片悬停效果增强
    $('.feature-card').hover(
        function() {
            $(this).find('.feature-icon').addClass('pulse');
        },
        function() {
            $(this).find('.feature-icon').removeClass('pulse');
        }
    );
    
    // 图书卡片点击效果
    $('.book-card').click(function() {
        var href = $(this).find('a').attr('href');
        if (href) {
            window.location.href = href;
        }
    });
    
    // 模态框美化
    $('.modal').on('show.bs.modal', function() {
        $(this).find('.modal-content').addClass('animated fadeInDown');
    });
    
    // 表单验证增强
    $('#loginForm, #registerForm').on('submit', function(e) {
        e.preventDefault();
        
        var $form = $(this);
        var $submitBtn = $form.find('button[type="submit"]');
        var originalText = $submitBtn.text();
        
        // 显示加载状态
        $submitBtn.html('<span class="loading"></span> 处理中...');
        $submitBtn.prop('disabled', true);
        
        // 模拟处理时间
        setTimeout(function() {
            $submitBtn.text(originalText);
            $submitBtn.prop('disabled', false);
        }, 2000);
    });
    
    // 返回顶部按钮
    var $backToTop = $('<button class="back-to-top" style="position: fixed; bottom: 20px; right: 20px; width: 50px; height: 50px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 50%; font-size: 20px; cursor: pointer; z-index: 1000; opacity: 0; transition: all 0.3s ease;"><i class="fa fa-arrow-up"></i></button>');
    $('body').append($backToTop);
    
    $(window).scroll(function() {
        if ($(this).scrollTop() > 300) {
            $backToTop.fadeIn().css('opacity', '1');
        } else {
            $backToTop.fadeOut().css('opacity', '0');
        }
    });
    
    $backToTop.click(function() {
        $('html, body').animate({
            scrollTop: 0
        }, 800);
    });
    
    // 页面加载完成后的欢迎动画
    setTimeout(function() {
        $('.main-container').addClass('loaded');
    }, 500);
    
    // 键盘快捷键
    $(document).keydown(function(e) {
        // Ctrl + K 快速搜索
        if (e.ctrlKey && e.keyCode === 75) {
            e.preventDefault();
            $('input[type="search"], input[placeholder*="搜索"]').focus();
        }
        
        // ESC 关闭模态框
        if (e.keyCode === 27) {
            $('.modal').modal('hide');
        }
    });
    
    // 移动端优化
    if ($(window).width() <= 768) {
        // 移动端特殊处理
        $('.carousel').swipe({
            swipe: function(event, direction, distance, duration, fingerCount, fingerData) {
                if (direction == 'left') $(this).carousel('next');
                if (direction == 'right') $(this).carousel('prev');
            },
            allowPageScroll: "vertical"
        });
    }
});

// 工具函数
function showNotification(message, type = 'info') {
    var $notification = $('<div class="notification" style="position: fixed; top: 20px; right: 20px; padding: 15px 20px; border-radius: 5px; color: white; z-index: 9999; transform: translateX(100%); transition: all 0.3s ease;"></div>');
    
    var bgColor = type === 'success' ? '#27ae60' : 
                  type === 'error' ? '#e74c3c' : 
                  type === 'warning' ? '#f39c12' : '#3498db';
    
    $notification.css('background-color', bgColor).text(message);
    $('body').append($notification);
    
    setTimeout(function() {
        $notification.css('transform', 'translateX(0)');
    }, 100);
    
    setTimeout(function() {
        $notification.css('transform', 'translateX(100%)');
        setTimeout(function() {
            $notification.remove();
        }, 300);
    }, 3000);
}

// 导出函数供其他脚本使用
window.showNotification = showNotification;
