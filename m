Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F402C10F0D
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D77B20857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nyRK42aK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfCRTs3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:48:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfCRTs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ckHueTyWRddXMW8rz7NWuKSRzh/6TUt+4/2u4PLF9EM=; b=nyRK42aKWbhxXZG2MujeKwrnu
        IWzVs/2n/soAb9iVAh8MzMF+nLnuJ634tAVP4A069oFbtWKrPEI6IOO+Rz4CBqnqW/cmBrazQ4JX0
        WjPDlQ/zO7/PPSWc4GK0LWJhsmw1qrd0xBe2D9w3/2ee+7vBaMTbX+wgYuI/AYcPlenK3Ez3Z5L5u
        APwyhrt1XwTWpU5IoolzvvfWXeobAbBEauSAOU+zcr8w6ZWOJG5wUNk0fWhYn1JHL9Ga2VLSPcLeT
        UKPmNoloqyH4npkKil+R+H8qil8/QpNwk0EDiLCJ0jnmWTxl8+SO/A/cSV/9nhzt2GGfJUTPW9GI+
        WqngnXGSA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5yFI-0000vi-OP; Mon, 18 Mar 2019 19:48:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 07/14] bsg: Convert bsg_minor_idr to XArray
Date:   Mon, 18 Mar 2019 12:48:14 -0700
Message-Id: <20190318194821.3470-8-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190318194821.3470-1-willy@infradead.org>
References: <20190318194821.3470-1-willy@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 block/bsg.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/bsg.c b/block/bsg.c
index f306853c6b08..e24420a21383 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -16,9 +16,9 @@
 #include <linux/cdev.h>
 #include <linux/jiffies.h>
 #include <linux/percpu.h>
-#include <linux/idr.h>
 #include <linux/bsg.h>
 #include <linux/slab.h>
+#include <linux/xarray.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_ioctl.h>
@@ -46,7 +46,7 @@ struct bsg_device {
 #define BSG_MAX_DEVS		32768
 
 static DEFINE_MUTEX(bsg_mutex);
-static DEFINE_IDR(bsg_minor_idr);
+static DEFINE_XARRAY_ALLOC(bsg_classes);
 
 #define BSG_LIST_ARRAY_SIZE	8
 static struct hlist_head bsg_device_list[BSG_LIST_ARRAY_SIZE];
@@ -294,7 +294,7 @@ static struct bsg_device *bsg_get_device(struct inode *inode, struct file *file)
 	 * find the class device
 	 */
 	mutex_lock(&bsg_mutex);
-	bcd = idr_find(&bsg_minor_idr, iminor(inode));
+	bcd = xa_load(&bsg_classes, iminor(inode));
 
 	if (!bcd) {
 		bd = ERR_PTR(-ENODEV);
@@ -401,7 +401,7 @@ void bsg_unregister_queue(struct request_queue *q)
 		return;
 
 	mutex_lock(&bsg_mutex);
-	idr_remove(&bsg_minor_idr, bcd->minor);
+	xa_erase(&bsg_classes, bcd->minor);
 	if (q->kobj.sd)
 		sysfs_remove_link(&q->kobj, "bsg");
 	device_unregister(bcd->class_dev);
@@ -429,23 +429,23 @@ int bsg_register_queue(struct request_queue *q, struct device *parent,
 
 	mutex_lock(&bsg_mutex);
 
-	ret = idr_alloc(&bsg_minor_idr, bcd, 0, BSG_MAX_DEVS, GFP_KERNEL);
+	ret = xa_alloc(&bsg_classes, &bcd->minor, bcd,
+			XA_LIMIT(0, BSG_MAX_DEVS - 1), GFP_KERNEL);
 	if (ret < 0) {
-		if (ret == -ENOSPC) {
+		if (ret == -EBUSY) {
 			printk(KERN_ERR "bsg: too many bsg devices\n");
 			ret = -EINVAL;
 		}
 		goto unlock;
 	}
 
-	bcd->minor = ret;
 	bcd->queue = q;
 	bcd->ops = ops;
 	dev = MKDEV(bsg_major, bcd->minor);
 	class_dev = device_create(bsg_class, parent, dev, NULL, "%s", name);
 	if (IS_ERR(class_dev)) {
 		ret = PTR_ERR(class_dev);
-		goto idr_remove;
+		goto remove;
 	}
 	bcd->class_dev = class_dev;
 
@@ -460,8 +460,8 @@ int bsg_register_queue(struct request_queue *q, struct device *parent,
 
 unregister_class_dev:
 	device_unregister(class_dev);
-idr_remove:
-	idr_remove(&bsg_minor_idr, bcd->minor);
+remove:
+	xa_erase(&bsg_classes, bcd->minor);
 unlock:
 	mutex_unlock(&bsg_mutex);
 	return ret;
-- 
2.20.1

