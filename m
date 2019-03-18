Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB1CC10F11
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8BF20989
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LAOKpmb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfCRTs3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:48:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfCRTs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0mXU83czsrrlKjLEhrrYM6cEFyI0U5urP7EMqQ3H560=; b=LAOKpmb1mqn3lCTZZ7R+LRZU0
        XHZWJPdvcui7/2wRn245+LupjIN7uknhSa7U28FoiX6ynN5fhbAQEbfNpHLJ9IbAhkeqW+xtvKK5h
        1rx9+bPLeSLnDs6pT3Ykjz2wMEnnsl6wh/PucID2ApKN3+gGhm4j0zPU4DCeVWw+89i12Ss5e8gps
        VDOrV12SBB+Mj/kIWmfCLUSge17nap8qcIJJxi1I9EfLvCKIDTzNsOnJeCpLadDzoxQd2nUUVrRAz
        4zq4VrFs6AWK5yipIspWu2rabqATWG/WDZLkQ2Z+9WEiz21djMiWE0PN/cf9JnheVdGqPEvN0yMhY
        kQ1FdLGMA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5yFI-0000vc-Jb; Mon, 18 Mar 2019 19:48:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 06/14] genhd: Convert to XArray
Date:   Mon, 18 Mar 2019 12:48:13 -0700
Message-Id: <20190318194821.3470-7-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190318194821.3470-1-willy@infradead.org>
References: <20190318194821.3470-1-willy@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the IDR with the XArray.  Includes converting the lookup from
being protected by a spinlock to being protected by RCU.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 block/genhd.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 703267865f14..7bb4d15f7574 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -17,7 +17,7 @@
 #include <linux/kmod.h>
 #include <linux/kobj_map.h>
 #include <linux/mutex.h>
-#include <linux/idr.h>
+#include <linux/xarray.h>
 #include <linux/log2.h>
 #include <linux/pm_runtime.h>
 #include <linux/badblocks.h>
@@ -30,11 +30,8 @@ struct kobject *block_depr;
 /* for extended dynamic devt allocation, currently only one major is used */
 #define NR_EXT_DEVT		(1 << MINORBITS)
 
-/* For extended devt allocation.  ext_devt_lock prevents look up
- * results from going away underneath its user.
- */
-static DEFINE_SPINLOCK(ext_devt_lock);
-static DEFINE_IDR(ext_devt_idr);
+/* For extended devt allocation */
+static DEFINE_XARRAY_FLAGS(ext_devt, XA_FLAGS_LOCK_BH | XA_FLAGS_ALLOC);
 
 static const struct device_type disk_type;
 
@@ -487,7 +484,8 @@ static int blk_mangle_minor(int minor)
 int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
 {
 	struct gendisk *disk = part_to_disk(part);
-	int idx;
+	u32 idx;
+	int err;
 
 	/* in consecutive minor range? */
 	if (part->partno < disk->minors) {
@@ -495,16 +493,10 @@ int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
 		return 0;
 	}
 
-	/* allocate ext devt */
-	idr_preload(GFP_KERNEL);
-
-	spin_lock_bh(&ext_devt_lock);
-	idx = idr_alloc(&ext_devt_idr, part, 0, NR_EXT_DEVT, GFP_NOWAIT);
-	spin_unlock_bh(&ext_devt_lock);
-
-	idr_preload_end();
-	if (idx < 0)
-		return idx == -ENOSPC ? -EBUSY : idx;
+	err = xa_alloc(&ext_devt, &idx, part, XA_LIMIT(0, NR_EXT_DEVT - 1),
+			GFP_KERNEL);
+	if (err < 0)
+		return err;
 
 	*devt = MKDEV(BLOCK_EXT_MAJOR, blk_mangle_minor(idx));
 	return 0;
@@ -516,8 +508,7 @@ int blk_alloc_devt(struct hd_struct *part, dev_t *devt)
  *
  * Free @devt which was allocated using blk_alloc_devt().
  *
- * CONTEXT:
- * Might sleep.
+ * Context: Might sleep.
  */
 void blk_free_devt(dev_t devt)
 {
@@ -525,9 +516,7 @@ void blk_free_devt(dev_t devt)
 		return;
 
 	if (MAJOR(devt) == BLOCK_EXT_MAJOR) {
-		spin_lock_bh(&ext_devt_lock);
-		idr_remove(&ext_devt_idr, blk_mangle_minor(MINOR(devt)));
-		spin_unlock_bh(&ext_devt_lock);
+		xa_erase_bh(&ext_devt, blk_mangle_minor(MINOR(devt)));
 	}
 }
 
@@ -852,13 +841,13 @@ struct gendisk *get_gendisk(dev_t devt, int *partno)
 	} else {
 		struct hd_struct *part;
 
-		spin_lock_bh(&ext_devt_lock);
-		part = idr_find(&ext_devt_idr, blk_mangle_minor(MINOR(devt)));
+		rcu_read_lock();
+		part = xa_load(&ext_devt, blk_mangle_minor(MINOR(devt)));
 		if (part && get_disk_and_module(part_to_disk(part))) {
 			*partno = part->partno;
 			disk = part_to_disk(part);
 		}
-		spin_unlock_bh(&ext_devt_lock);
+		rcu_read_unlock();
 	}
 
 	if (!disk)
@@ -1303,8 +1292,9 @@ static void disk_release(struct device *dev)
 	hd_free_part(&disk->part0);
 	if (disk->queue)
 		blk_put_queue(disk->queue);
-	kfree(disk);
+	kfree_rcu(disk, part0.rcu_work.rcu);
 }
+
 struct class block_class = {
 	.name		= "block",
 };
-- 
2.20.1

