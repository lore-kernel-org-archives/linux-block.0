Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46525 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754781AbeCSAgt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Mar 2018 20:36:49 -0400
Received: by mail-pl0-f68.google.com with SMTP id f5-v6so9199629plj.13
        for <linux-block@vger.kernel.org>; Sun, 18 Mar 2018 17:36:49 -0700 (PDT)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com, Tang Junhui <tang.junhui@zte.com.cn>
Subject: [for-4.17 07/20] bcache: fix incorrect sysfs output value of strip size
Date: Sun, 18 Mar 2018 17:36:20 -0700
Message-Id: <20180319003633.27225-8-mlyle@lyle.org>
In-Reply-To: <20180319003633.27225-1-mlyle@lyle.org>
References: <20180319003633.27225-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

Stripe size is shown as zero when no strip in back end device:
[root@ceph132 ~]# cat /sys/block/sdd/bcache/stripe_size
0.0k

Actually it should be 1T Bytes (1 << 31 sectors), but in sysfs
interface, stripe_size was changed from sectors to bytes, and move
9 bits left, so the 32 bits variable overflows.

This patch change the variable to a 64 bits type before moving bits.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
---
 drivers/md/bcache/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 414129f7c49f..8c3fd05db87a 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -181,7 +181,7 @@ SHOW(__bch_cached_dev)
 	sysfs_hprint(dirty_data,
 		     bcache_dev_sectors_dirty(&dc->disk) << 9);
 
-	sysfs_hprint(stripe_size,	dc->disk.stripe_size << 9);
+	sysfs_hprint(stripe_size,	 ((uint64_t)dc->disk.stripe_size) << 9);
 	var_printf(partial_stripes_expensive,	"%u");
 
 	var_hprint(sequential_cutoff);
-- 
2.14.1
