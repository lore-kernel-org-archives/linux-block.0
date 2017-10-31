Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:58292 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751593AbdJaIOc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Oct 2017 04:14:32 -0400
From: tang.junhui@zte.com.cn
To: colyli@suse.de, mlyle@lyle.org
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: [PATCH] bcache: stop writeback thread after detaching
Date: Tue, 31 Oct 2017 16:14:11 +0800
Message-Id: <1509437651-24052-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Tang Junhui <tang.junhui@zte.com.cn>

Currently, when a cached device detaching from cache, writeback thread is not stopped,
and writeback_rate_update work is not canceled. For example, after bellow command:
echo 1 >/sys/block/sdb/bcache/detach
you can still see the writeback thread. Then you attach the device to the cache again,
bcache will create another writeback thread, for example, after bellow command:
echo  ba0fb5cd-658a-4533-9806-6ce166d883b9 > /sys/block/sdb/bcache/attach
then you will see 2 writeback threads.
This patch stops writeback thread and cancels writeback_rate_update work when cached
device detaching from cache.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
---
 drivers/md/bcache/super.c | 6 ++++++
 1 file changed, 6 insertions(+)
 mode change 100644 => 100755 drivers/md/bcache/super.c

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
old mode 100644
new mode 100755
index 8352fad..bf79892
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -891,6 +891,12 @@ static void cached_dev_detach_finish(struct work_struct *w)
 	BUG_ON(!test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags));
 	BUG_ON(atomic_read(&dc->count));
 
+	cancel_delayed_work_sync(&dc->writeback_rate_update);
+	if (!IS_ERR_OR_NULL(dc->writeback_thread)) {
+		kthread_stop(dc->writeback_thread);
+		dc->writeback_thread = NULL;
+	}
+
 	mutex_lock(&bch_register_lock);
 
 	memset(&dc->sb.set_uuid, 0, 16);
-- 
1.8.3.1
