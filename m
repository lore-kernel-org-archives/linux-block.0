Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AD3C54FCE
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 13:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906F22070A
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 13:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgCWNZ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:25:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54432 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728370AbgCWNZz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 09:25:55 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9702621BB8F3DBC1B39B;
        Mon, 23 Mar 2020 21:25:32 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 23 Mar 2020
 21:25:30 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <tj@kernel.org>, <jack@suse.cz>, <bvanassche@acm.org>,
        <tytso@mit.edu>, <gregkh@linuxfoundation.org>
Subject: [PATCH v3 4/4] bdi: protect bdi->dev with spinlock
Date:   Mon, 23 Mar 2020 21:22:54 +0800
Message-ID: <20200323132254.47157-5-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200323132254.47157-1-yuyufen@huawei.com>
References: <20200323132254.47157-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We reported a kernel crash in __blkg_prfill_rwstat() for use-after-free
the bdi->dev. It tries to get the device name by 'bdi->dev', while the
device and kobj->name has been freed by bdi_unregister(). Then,
blkg_dev_name() will return an invalid name pointer, resulting in crash
on string(). The race as following:

CPU1                          CPU2
blkg_print_stat_bytes
                              __scsi_remove_device
                              del_gendisk
                                bdi_unregister

                                put_device(bdi->dev)
                                  kfree(bdi->dev)
__blkg_prfill_rwstat
  blkg_dev_name
    //use the freed bdi->dev
    dev_name(blkg->q->backing_dev_info->dev)
                                bdi->dev = NULL

To fix the bug, we add a new spinlock for bdi to protect the device.

In addition, to fix crash in wb_workfn when bdi_unreigster(), commit
68f23b89067f ("memcg: fix a crash in wb_workfn when a device disappears")
has created bdi_dev_name() to handle bdi->dev beening NULL. But, bdi->dev
can be freed after bdi_dev_name() return successly, which may cause
use-after-free for dev or kobj->name. After replacing bdi_dev_name()
with bdi_get_dev_name() and protect bdi->dev by spinlock, we can fix
the bug thoroughly.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 include/linux/backing-dev-defs.h | 1 +
 include/linux/backing-dev.h      | 4 ++++
 mm/backing-dev.c                 | 9 +++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

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
index 82d2401fec37..1c0e2d0d6236 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -525,12 +525,16 @@ static inline const char *bdi_dev_name(struct backing_dev_info *bdi)
 static inline char *bdi_get_dev_name(struct backing_dev_info *bdi,
 			char *dname, int len)
 {
+	spin_lock_irq(&bdi->lock);
 	if (!bdi || !bdi->dev) {
+		spin_unlock_irq(&bdi->lock);
 		strlcpy(dname, bdi_unknown_name, len);
 		return NULL;
 	}
 
 	strlcpy(dname, dev_name(bdi->dev), len);
+	spin_unlock_irq(&bdi->lock);
+
 	return dname;
 }
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

