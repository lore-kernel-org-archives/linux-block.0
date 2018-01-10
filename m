Return-Path: <zhangweiping@didichuxing.com>
Date: Thu, 11 Jan 2018 00:36:37 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <jack@suse.cz>, <Bart.VanAssche@wdc.com>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH v2] bdi: show error log when fail to create bdi debugfs entry
Message-ID: <20180110163633.GA24230@bogon.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

bdi debugfs dir/file may create fail, add error log here.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
V1->V2:
fix indentation and make log message more clear

 mm/backing-dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index b5f940c..0a49665 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -885,7 +885,9 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 	cgwb_bdi_register(bdi);
 	bdi->dev = dev;
 
-	bdi_debug_register(bdi, dev_name(dev));
+	if (bdi_debug_register(bdi, dev_name(dev)))
+		pr_warn("blkdev %s: creation of bdi debugfs entries failed.\n",
+			dev_name(dev));
 	set_bit(WB_registered, &bdi->wb.state);
 
 	spin_lock_bh(&bdi_lock);
-- 
2.9.4
