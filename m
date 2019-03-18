Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC9AC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1C820989
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="agtHmvpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfCRTsa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:48:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfCRTs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hArS45QIEYgOtIjQ5G4rtpb1oLKhSIxMrFciiZBLEXU=; b=agtHmvpcop4YFI6uoZhHq0jgG
        zbd2gRuJZh6xX8JbGxa3RQ8BtUlNaIu2BKOotlV0FhHfVaNdPK9h1wTHWZFglsNqEwccXWhWPKwx3
        2dS0c+6vhsOJ5bgQa0WT6QFdH4xR3aH17h/TcGiDbXqCV1Dro0C2mfVOfYlRoQSvrKsMyuHhuTQ0l
        dH3W/VapoBz200m0bVs0Ksor2qifITIVo6HcXvs/pcUGX9BDUzjurWDvp6QRwBHIQXhl/2Fs3Ggtn
        XFEVs/qTs8LCQh0uD9hbFJ1SL6tBrQ1y+2oy6xIws5/v1aQBaVVuk6f0cLfWisEObWSkMcNAdI/4p
        bfEPF0ezQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5yFJ-0000w2-7Y; Mon, 18 Mar 2019 19:48:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 10/14] loop: Convert loop_index_idr to XArray
Date:   Mon, 18 Mar 2019 12:48:17 -0700
Message-Id: <20190318194821.3470-11-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190318194821.3470-1-willy@infradead.org>
References: <20190318194821.3470-1-willy@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/block/loop.c | 88 ++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 57 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1e6edd568214..d1a0f689788d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -83,7 +83,7 @@
 
 #include <linux/uaccess.h>
 
-static DEFINE_IDR(loop_index_idr);
+static DEFINE_XARRAY_ALLOC(loop_devs);
 static DEFINE_MUTEX(loop_ctl_mutex);
 
 static int max_part;
@@ -1812,28 +1812,23 @@ int loop_register_transfer(struct loop_func_table *funcs)
 	return 0;
 }
 
-static int unregister_transfer_cb(int id, void *ptr, void *data)
-{
-	struct loop_device *lo = ptr;
-	struct loop_func_table *xfer = data;
-
-	mutex_lock(&loop_ctl_mutex);
-	if (lo->lo_encryption == xfer)
-		loop_release_xfer(lo);
-	mutex_unlock(&loop_ctl_mutex);
-	return 0;
-}
-
 int loop_unregister_transfer(int number)
 {
 	unsigned int n = number;
 	struct loop_func_table *xfer;
+	struct loop_device *lo;
+	unsigned long index;
 
 	if (n == 0 || n >= MAX_LO_CRYPT || (xfer = xfer_funcs[n]) == NULL)
 		return -EINVAL;
 
 	xfer_funcs[n] = NULL;
-	idr_for_each(&loop_index_idr, &unregister_transfer_cb, xfer);
+	xa_for_each(&loop_devs, index, lo) {
+		mutex_lock(&loop_ctl_mutex);
+		if (lo->lo_encryption == xfer)
+			loop_release_xfer(lo);
+		mutex_unlock(&loop_ctl_mutex);
+	}
 	return 0;
 }
 
@@ -1935,15 +1930,14 @@ static int loop_add(struct loop_device **l, int i)
 
 	/* allocate id, if @id >= 0, we're requesting that specific id */
 	if (i >= 0) {
-		err = idr_alloc(&loop_index_idr, lo, i, i + 1, GFP_KERNEL);
-		if (err == -ENOSPC)
-			err = -EEXIST;
+		err = xa_insert(&loop_devs, i, lo, GFP_KERNEL);
 	} else {
-		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_KERNEL);
+		err = xa_alloc(&loop_devs, &i, lo, xa_limit_32b, GFP_KERNEL);
 	}
+	if (err == -EBUSY)
+		err = -EEXIST;
 	if (err < 0)
 		goto out_free_dev;
-	i = err;
 
 	err = -ENOMEM;
 	lo->tag_set.ops = &loop_mq_ops;
@@ -1956,7 +1950,7 @@ static int loop_add(struct loop_device **l, int i)
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
 	if (err)
-		goto out_free_idr;
+		goto out_free_xa;
 
 	lo->lo_queue = blk_mq_init_queue(&lo->tag_set);
 	if (IS_ERR(lo->lo_queue)) {
@@ -2018,8 +2012,8 @@ static int loop_add(struct loop_device **l, int i)
 	blk_cleanup_queue(lo->lo_queue);
 out_cleanup_tags:
 	blk_mq_free_tag_set(&lo->tag_set);
-out_free_idr:
-	idr_remove(&loop_index_idr, i);
+out_free_xa:
+	xa_erase(&loop_devs, i);
 out_free_dev:
 	kfree(lo);
 out:
@@ -2035,41 +2029,28 @@ static void loop_remove(struct loop_device *lo)
 	kfree(lo);
 }
 
-static int find_free_cb(int id, void *ptr, void *data)
-{
-	struct loop_device *lo = ptr;
-	struct loop_device **l = data;
-
-	if (lo->lo_state == Lo_unbound) {
-		*l = lo;
-		return 1;
-	}
-	return 0;
-}
-
 static int loop_lookup(struct loop_device **l, int i)
 {
 	struct loop_device *lo;
 	int ret = -ENODEV;
 
 	if (i < 0) {
-		int err;
+		unsigned long index;
 
-		err = idr_for_each(&loop_index_idr, &find_free_cb, &lo);
-		if (err == 1) {
-			*l = lo;
-			ret = lo->lo_number;
+		xa_for_each(&loop_devs, index, lo) {
+			if (lo->lo_state != Lo_unbound)
+				continue;
+			break;
 		}
-		goto out;
+	} else {
+		/* lookup and return a specific i */
+		lo = xa_load(&loop_devs, i);
 	}
 
-	/* lookup and return a specific i */
-	lo = idr_find(&loop_index_idr, i);
 	if (lo) {
 		*l = lo;
 		ret = lo->lo_number;
 	}
-out:
 	return ret;
 }
 
@@ -2126,7 +2107,7 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			break;
 		}
 		lo->lo_disk->private_data = NULL;
-		idr_remove(&loop_index_idr, lo->lo_number);
+		xa_erase(&loop_devs, lo->lo_number);
 		loop_remove(lo);
 		break;
 	case LOOP_CTL_GET_FREE:
@@ -2233,23 +2214,16 @@ static int __init loop_init(void)
 	return err;
 }
 
-static int loop_exit_cb(int id, void *ptr, void *data)
-{
-	struct loop_device *lo = ptr;
-
-	loop_remove(lo);
-	return 0;
-}
-
 static void __exit loop_exit(void)
 {
-	unsigned long range;
-
-	range = max_loop ? max_loop << part_shift : 1UL << MINORBITS;
+	struct loop_device *lo;
+	unsigned long range, index;
 
-	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
-	idr_destroy(&loop_index_idr);
+	xa_for_each(&loop_devs, index, lo)
+		loop_remove(lo);
+	xa_destroy(&loop_devs);
 
+	range = max_loop ? max_loop << part_shift : 1UL << MINORBITS;
 	blk_unregister_region(MKDEV(LOOP_MAJOR, 0), range);
 	unregister_blkdev(LOOP_MAJOR, "loop");
 
-- 
2.20.1

