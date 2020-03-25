Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B074C1975A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 12:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767F82076A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 12:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCYMkW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:40:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12129 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727298AbgCYMkV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 08:40:21 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 72D5AFED297F7C42EFE7;
        Wed, 25 Mar 2020 20:40:09 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 25 Mar 2020
 20:40:06 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>, <gregkh@linuxfoundation.org>, <hch@infradead.org>
Subject: [PATCH v4 2/6] bdi: protect bdi->dev with spinlock
Date:   Wed, 25 Mar 2020 20:38:39 +0800
Message-ID: <20200325123843.47452-3-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200325123843.47452-1-yuyufen@huawei.com>
References: <20200325123843.47452-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have reported a kernel crash in __blkg_prfill_rwstat() for
use-after-free the bdi->dev. It tries to get the device name by
'bdi->dev', while the device and kobj->name has been freed by
bdi_unregister().

In fact, similar bug have been reported in wb_workfn when
bdi_unregister(). To fix it, commit 68f23b89067f ("memcg: fix a
crash in wb_workfn when a device disappears") has created bdi_dev_name()
to handle bdi->dev beening NULL. But, bdi->dev can be freed after
bdi_dev_name() return successly, which can cause use-after-free for
dev or kobj->name.

In this patch, we try to protect the 'bdi->dev' with spinlock to
avoid the race. A new helper function bdi_get_dev_name() is defined.
Then, the caller can get device name with this helper safely.

This patch is prepare for following patch to fix use-after-free bug.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 include/linux/backing-dev-defs.h |  1 +
 include/linux/backing-dev.h      | 28 ++++++++++++++++++++++++++++
 mm/backing-dev.c                 |  9 +++++++--
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 4fc87dee005a..c98dac4a7953 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -227,6 +227,7 @@ struct backing_dev_info {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debug_dir;
 #endif
+	spinlock_t lock;		/* protects dev */
 };
 
 enum {
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index f88197c1ffc2..010d80956442 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -19,6 +19,8 @@
 #include <linux/backing-dev-defs.h>
 #include <linux/slab.h>
 
+#define BDI_DEV_NAME_LEN	32
+
 static inline struct backing_dev_info *bdi_get(struct backing_dev_info *bdi)
 {
 	kref_get(&bdi->refcnt);
@@ -514,4 +516,30 @@ static inline const char *bdi_dev_name(struct backing_dev_info *bdi)
 	return dev_name(bdi->dev);
 }
 
+/**
+ * bdi_get_dev_name - copy bdi device name into buffer
+ * @bdi: target bdi
+ * @dname: Where to copy the device name to
+ * @len: size of destination buffer
+ */
+static inline char *bdi_get_dev_name(struct backing_dev_info *bdi,
+			char *dname, int len)
+{
+	if (!bdi)
+		goto unknown;
+
+	spin_lock_irq(&bdi->lock);
+	if (!bdi->dev) {
+		spin_unlock_irq(&bdi->lock);
+		goto unknown;
+	}
+
+	strlcpy(dname, dev_name(bdi->dev), len);
+	spin_unlock_irq(&bdi->lock);
+	return dname;
+
+unknown:
+	strlcpy(dname, bdi_unknown_name, len);
+	return NULL;
+}
 #endif	/* _LINUX_BACKING_DEV_H */
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 62f05f605fb5..aa9ba7dcc2d9 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -859,6 +859,7 @@ static int bdi_init(struct backing_dev_info *bdi)
 	INIT_LIST_HEAD(&bdi->bdi_list);
 	INIT_LIST_HEAD(&bdi->wb_list);
 	init_waitqueue_head(&bdi->wb_waitq);
+	spin_lock_init(&bdi->lock);
 
 	ret = cgwb_bdi_init(bdi);
 
@@ -1007,15 +1008,19 @@ static void bdi_remove_from_list(struct backing_dev_info *bdi)
 
 void bdi_unregister(struct backing_dev_info *bdi)
 {
+	struct device *dev = bdi->dev;
+
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
 	wb_shutdown(&bdi->wb);
 	cgwb_bdi_unregister(bdi);
 
-	if (bdi->dev) {
+	if (dev) {
 		bdi_debug_unregister(bdi);
-		device_unregister(bdi->dev);
+		spin_lock_irq(&bdi->lock);
 		bdi->dev = NULL;
+		spin_unlock_irq(&bdi->lock);
+		device_unregister(dev);
 	}
 
 	if (bdi->owner) {
-- 
2.17.2

