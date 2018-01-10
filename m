Return-Path: <linux-block-owner@vger.kernel.org>
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:7731 "EHLO
        BJEXMBX011.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S965006AbeAJPSt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jan 2018 10:18:49 -0500
Date: Wed, 10 Jan 2018 23:18:28 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <jack@suse.cz>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] bdi: show error log when fail to create bdi debugfs entry
Message-ID: <20180110151822.GA19852@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bdi debugfs dir/file may create fail, add error log here.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 mm/backing-dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index b5f940c..9117c21 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -885,7 +885,8 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 	cgwb_bdi_register(bdi);
 	bdi->dev = dev;
 
-	bdi_debug_register(bdi, dev_name(dev));
+	 if (bdi_debug_register(bdi, dev_name(dev)))
+		 pr_warn("blkdev %s create bdi debugfs failed\n", dev_name(dev));
 	set_bit(WB_registered, &bdi->wb.state);
 
 	spin_lock_bh(&bdi_lock);
-- 
2.9.4
