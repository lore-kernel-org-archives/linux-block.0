Return-Path: <zhangweiping@didichuxing.com>
Date: Fri, 27 Oct 2017 01:36:14 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <jack@suse.cz>
CC: <linux-block@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH 3/4] bdi: add error handle for bdi_debug_register
Message-ID: <b28a35a3af256e2c64b905728b0e9df307e12b0b.1509038624.git.zhangweiping@didichuxing.com>
References: <cover.1509038624.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1509038624.git.zhangweiping@didichuxing.com>
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

In order to make error handle more cleaner we call bdi_debug_register
before set state to WB_registered, that we can avoid call bdi_unregister
in release_bdi().

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 mm/backing-dev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index e9d6a1ede12b..54396d53f471 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -893,10 +893,13 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 	if (IS_ERR(dev))
 		return PTR_ERR(dev);
 
+	if (bdi_debug_register(bdi, dev_name(dev))) {
+		device_destroy(bdi_class, dev->devt);
+		return -ENOMEM;
+	}
 	cgwb_bdi_register(bdi);
 	bdi->dev = dev;
 
-	bdi_debug_register(bdi, dev_name(dev));
 	set_bit(WB_registered, &bdi->wb.state);
 
 	spin_lock_bh(&bdi_lock);
@@ -916,6 +919,8 @@ int bdi_register(struct backing_dev_info *bdi, const char *fmt, ...)
 	va_start(args, fmt);
 	ret = bdi_register_va(bdi, fmt, args);
 	va_end(args);
+	if (ret)
+		bdi_put(bdi);
 	return ret;
 }
 EXPORT_SYMBOL(bdi_register);
-- 
2.14.2
