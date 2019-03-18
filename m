Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D60BC4360F
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB8120857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SZEHZrXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfCRTsa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:48:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfCRTs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wg4dmSy/RqoCCts/JYr6HGrbCcIu44kKA+TFYCEd1V0=; b=SZEHZrXaa4Paaqyn8UgPvG2OR
        J8zqCiG1d7Id2Gdla4PtVR2YfXHZf6CdhwTMDCNxYcgZ/7xWkkUFZnHMP7NkVCWootOfk8cKJ98z7
        tXOczwzIldIK19ZRlWoFjJtcOED6DiBnt8onPT4L+vcIOJ/VKVgPhSkvU9KFum0bNYmxTTyB5i0q0
        zb9+qU8FZcyNqw/3J2v4PeVT5odUQqd521TkQxKBYhJLwisVsiq3xJqSK/MRY5HfIhgZHn7EeEQ0t
        fkbqNCdb74nw62pAuWYmOrRNdTx0RKDhM+RvXNyDgoRX2XSV8kzOlYy1yRMM3z2CjgPkydH33zk4Z
        P8YmLB7vA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5yFJ-0000wF-Hj; Mon, 18 Mar 2019 19:48:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 12/14] zram: Convert zram_index_idr to XArray
Date:   Mon, 18 Mar 2019 12:48:19 -0700
Message-Id: <20190318194821.3470-13-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190318194821.3470-1-willy@infradead.org>
References: <20190318194821.3470-1-willy@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/block/zram/zram_drv.c | 40 +++++++++++++----------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e7a5f1d1c314..f7e53a681637 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -36,9 +36,7 @@
 
 #include "zram_drv.h"
 
-static DEFINE_IDR(zram_index_idr);
-/* idr index must be protected */
-static DEFINE_MUTEX(zram_index_mutex);
+static DEFINE_XARRAY_ALLOC(zram_devs);
 
 static int zram_major;
 static const char *default_compressor = "lzo-rle";
@@ -1901,10 +1899,9 @@ static int zram_add(void)
 	if (!zram)
 		return -ENOMEM;
 
-	ret = idr_alloc(&zram_index_idr, zram, 0, 0, GFP_KERNEL);
+	ret = xa_alloc(&zram_devs, &device_id, zram, xa_limit_32b, GFP_KERNEL);
 	if (ret < 0)
 		goto out_free_dev;
-	device_id = ret;
 
 	init_rwsem(&zram->init_lock);
 #ifdef CONFIG_ZRAM_WRITEBACK
@@ -1915,7 +1912,7 @@ static int zram_add(void)
 		pr_err("Error allocating disk queue for device %d\n",
 			device_id);
 		ret = -ENOMEM;
-		goto out_free_idr;
+		goto out_remove_dev;
 	}
 
 	blk_queue_make_request(queue, zram_make_request);
@@ -1979,8 +1976,8 @@ static int zram_add(void)
 
 out_free_queue:
 	blk_cleanup_queue(queue);
-out_free_idr:
-	idr_remove(&zram_index_idr, device_id);
+out_remove_dev:
+	xa_erase(&zram_devs, device_id);
 out_free_dev:
 	kfree(zram);
 	return ret;
@@ -2034,9 +2031,7 @@ static ssize_t hot_add_show(struct class *class,
 {
 	int ret;
 
-	mutex_lock(&zram_index_mutex);
 	ret = zram_add();
-	mutex_unlock(&zram_index_mutex);
 
 	if (ret < 0)
 		return ret;
@@ -2059,18 +2054,15 @@ static ssize_t hot_remove_store(struct class *class,
 	if (dev_id < 0)
 		return -EINVAL;
 
-	mutex_lock(&zram_index_mutex);
-
-	zram = idr_find(&zram_index_idr, dev_id);
+	zram = xa_load(&zram_devs, dev_id);
 	if (zram) {
 		ret = zram_remove(zram);
 		if (!ret)
-			idr_remove(&zram_index_idr, dev_id);
+			xa_erase(&zram_devs, dev_id);
 	} else {
 		ret = -ENODEV;
 	}
 
-	mutex_unlock(&zram_index_mutex);
 	return ret ? ret : count;
 }
 static CLASS_ATTR_WO(hot_remove);
@@ -2088,18 +2080,18 @@ static struct class zram_control_class = {
 	.class_groups	= zram_control_class_groups,
 };
 
-static int zram_remove_cb(int id, void *ptr, void *data)
-{
-	zram_remove(ptr);
-	return 0;
-}
-
 static void destroy_devices(void)
 {
+	struct zram *zram;
+	unsigned long index;
+
 	class_unregister(&zram_control_class);
-	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
+	xa_for_each(&zram_devs, index, zram) {
+		zram_remove(zram);
+	}
+	xa_destroy(&zram_devs);
+
 	zram_debugfs_destroy();
-	idr_destroy(&zram_index_idr);
 	unregister_blkdev(zram_major, "zram");
 	cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
 }
@@ -2130,9 +2122,7 @@ static int __init zram_init(void)
 	}
 
 	while (num_devices != 0) {
-		mutex_lock(&zram_index_mutex);
 		ret = zram_add();
-		mutex_unlock(&zram_index_mutex);
 		if (ret < 0)
 			goto out_error;
 		num_devices--;
-- 
2.20.1

