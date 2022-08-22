Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019EAC28D13
	for <linux-block@archiver.kernel.org>; Mon, 22 Aug 2022 06:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiHVGSB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Aug 2022 02:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiHVGSA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Aug 2022 02:18:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F0A27177
        for <linux-block@vger.kernel.org>; Sun, 21 Aug 2022 23:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0Q8mJOPYBUmxjpWOzMposJNP4qEgZR6D/zBbAyYLSzM=; b=zbfPNxnWfua5gWwL0W9ixkdl5i
        PEqWysochYm9qSAVYI2qH/bwmbcCgd8mLjBGpZMzyd8zGWt7Kkp8VyNIKWRvU3O5jXVcRGeSOfqng
        IZAu6jhELQQp6EQlZi4EIu6WpADCLeTLgZl0BQ9axomY+zc4Jns5htj832glY4QmWgQRwKyGyFLwp
        jSGELS3mzWdIUhxBsB8qUKfwsHpMdYtoFuOm1gA2I7jPUlJAQHOFSRwi8gz7cIVT6jSnodKcc47ec
        0m15QU+HKwhLiY+KOmqhbHDZlr+fBo402LnHWKRxsrox6d3/4j93we0yjusfHpwlzZTKlywpiD9io
        EcqerK3g==;
Received: from [2001:4bb8:198:6528:7eb3:3a42:932d:eeba] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ0l3-005MCG-I6; Mon, 22 Aug 2022 06:17:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/4] rnbd-srv: remove struct rnbd_dev
Date:   Mon, 22 Aug 2022 08:17:45 +0200
Message-Id: <20220822061745.152010-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220822061745.152010-1-hch@lst.de>
References: <20220822061745.152010-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Given that rnbd_srv_sess_dev already has an open_flags member, there
is no need for the rnbd_dev indirection as a simple block_device pointer
works just as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rnbd/rnbd-srv-dev.h | 20 --------------
 drivers/block/rnbd/rnbd-srv.c     | 46 ++++++++++++-------------------
 drivers/block/rnbd/rnbd-srv.h     |  2 +-
 3 files changed, 18 insertions(+), 50 deletions(-)
 delete mode 100644 drivers/block/rnbd/rnbd-srv-dev.h

diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
deleted file mode 100644
index abaf77d68e5b9..0000000000000
--- a/drivers/block/rnbd/rnbd-srv-dev.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * RDMA Network Block Driver
- *
- * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
- * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
- * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
- */
-#ifndef RNBD_SRV_DEV_H
-#define RNBD_SRV_DEV_H
-
-#include <linux/fs.h>
-#include "rnbd-proto.h"
-
-struct rnbd_dev {
-	struct block_device	*bdev;
-	fmode_t			blk_open_flags;
-};
-
-#endif /* RNBD_SRV_DEV_H */
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index be238b625c2c0..4bcb7d0b29c7b 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -13,7 +13,6 @@
 #include <linux/blkdev.h>
 
 #include "rnbd-srv.h"
-#include "rnbd-srv-dev.h"
 #include "rnbd-srv-trace.h"
 
 MODULE_DESCRIPTION("RDMA Network Block Device Server");
@@ -146,7 +145,7 @@ static int process_rdma(struct rnbd_srv_session *srv_sess,
 	priv->sess_dev = sess_dev;
 	priv->id = id;
 
-	bio = bio_alloc(sess_dev->rnbd_dev->bdev, 1,
+	bio = bio_alloc(sess_dev->bdev, 1,
 			rnbd_to_bio_flags(le32_to_cpu(msg->rw)), GFP_KERNEL);
 	if (bio_add_page(bio, virt_to_page(data), datalen,
 			offset_in_page(data)) != datalen) {
@@ -220,9 +219,7 @@ void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
 	rnbd_put_sess_dev(sess_dev);
 	wait_for_completion(&dc); /* wait for inflights to drop to zero */
 
-	blkdev_put(sess_dev->rnbd_dev->bdev,
-		   sess_dev->rnbd_dev->blk_open_flags);
-	kfree(sess_dev->rnbd_dev);
+	blkdev_put(sess_dev->bdev, sess_dev->open_flags);
 	mutex_lock(&sess_dev->dev->lock);
 	list_del(&sess_dev->dev_list);
 	if (sess_dev->open_flags & FMODE_WRITE)
@@ -509,14 +506,14 @@ static int rnbd_srv_check_update_open_perm(struct rnbd_srv_dev *srv_dev,
 }
 
 static struct rnbd_srv_dev *
-rnbd_srv_get_or_create_srv_dev(struct rnbd_dev *rnbd_dev,
+rnbd_srv_get_or_create_srv_dev(struct block_device *bdev,
 				struct rnbd_srv_session *srv_sess,
 				enum rnbd_access_mode access_mode)
 {
 	int ret;
 	struct rnbd_srv_dev *new_dev, *dev;
 
-	new_dev = rnbd_srv_init_srv_dev(rnbd_dev->bdev);
+	new_dev = rnbd_srv_init_srv_dev(bdev);
 	if (IS_ERR(new_dev))
 		return new_dev;
 
@@ -536,7 +533,7 @@ rnbd_srv_get_or_create_srv_dev(struct rnbd_dev *rnbd_dev,
 static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 					struct rnbd_srv_sess_dev *sess_dev)
 {
-	struct block_device *bdev = sess_dev->rnbd_dev->bdev;
+	struct block_device *bdev = sess_dev->bdev;
 
 	rsp->hdr.type = cpu_to_le16(RNBD_MSG_OPEN_RSP);
 	rsp->device_id = cpu_to_le32(sess_dev->device_id);
@@ -561,7 +558,7 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 static struct rnbd_srv_sess_dev *
 rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
 			      const struct rnbd_msg_open *open_msg,
-			      struct rnbd_dev *rnbd_dev, fmode_t open_flags,
+			      struct block_device *bdev, fmode_t open_flags,
 			      struct rnbd_srv_dev *srv_dev)
 {
 	struct rnbd_srv_sess_dev *sdev = rnbd_sess_dev_alloc(srv_sess);
@@ -573,7 +570,7 @@ rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
 
 	strscpy(sdev->pathname, open_msg->dev_name, sizeof(sdev->pathname));
 
-	sdev->rnbd_dev		= rnbd_dev;
+	sdev->bdev		= bdev;
 	sdev->sess		= srv_sess;
 	sdev->dev		= srv_dev;
 	sdev->open_flags	= open_flags;
@@ -680,9 +677,9 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	struct rnbd_srv_dev *srv_dev;
 	struct rnbd_srv_sess_dev *srv_sess_dev;
 	const struct rnbd_msg_open *open_msg = msg;
+	struct block_device *bdev;
 	fmode_t open_flags;
 	char *full_path;
-	struct rnbd_dev *rnbd_dev;
 	struct rnbd_msg_open_rsp *rsp = data;
 
 	trace_process_msg_open(srv_sess, open_msg);
@@ -719,33 +716,25 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		goto reject;
 	}
 
-	rnbd_dev = kzalloc(sizeof(*rnbd_dev), GFP_KERNEL);
-	if (!rnbd_dev) {
-		ret = -ENOMEM;
-		goto free_path;
-	}
-
-	rnbd_dev->blk_open_flags = open_flags;
-	rnbd_dev->bdev = blkdev_get_by_path(full_path, open_flags, THIS_MODULE);
-	if (IS_ERR(rnbd_dev->bdev)) {
-		ret = PTR_ERR(rnbd_dev->bdev);
+	bdev = blkdev_get_by_path(full_path, open_flags, THIS_MODULE);
+	if (IS_ERR(bdev)) {
+		ret = PTR_ERR(bdev);
 		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %d\n",
 		       full_path, srv_sess->sessname, ret);
-		kfree(rnbd_dev);
 		goto free_path;
 	}
 
-	srv_dev = rnbd_srv_get_or_create_srv_dev(rnbd_dev, srv_sess,
+	srv_dev = rnbd_srv_get_or_create_srv_dev(bdev, srv_sess,
 						  open_msg->access_mode);
 	if (IS_ERR(srv_dev)) {
 		pr_err("Opening device '%s' on session %s failed, creating srv_dev failed, err: %ld\n",
 		       full_path, srv_sess->sessname, PTR_ERR(srv_dev));
 		ret = PTR_ERR(srv_dev);
-		goto rnbd_dev_close;
+		goto blkdev_put;
 	}
 
 	srv_sess_dev = rnbd_srv_create_set_sess_dev(srv_sess, open_msg,
-						     rnbd_dev, open_flags,
+						     bdev, open_flags,
 						     srv_dev);
 	if (IS_ERR(srv_sess_dev)) {
 		pr_err("Opening device '%s' on session %s failed, creating sess_dev failed, err: %ld\n",
@@ -760,7 +749,7 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	 */
 	mutex_lock(&srv_dev->lock);
 	if (!srv_dev->dev_kobj.state_in_sysfs) {
-		ret = rnbd_srv_create_dev_sysfs(srv_dev, rnbd_dev->bdev);
+		ret = rnbd_srv_create_dev_sysfs(srv_dev, bdev);
 		if (ret) {
 			mutex_unlock(&srv_dev->lock);
 			rnbd_srv_err(srv_sess_dev,
@@ -802,9 +791,8 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		mutex_unlock(&srv_dev->lock);
 	}
 	rnbd_put_srv_dev(srv_dev);
-rnbd_dev_close:
-	blkdev_put(rnbd_dev->bdev, rnbd_dev->blk_open_flags);
-	kfree(rnbd_dev);
+blkdev_put:
+	blkdev_put(bdev, open_flags);
 free_path:
 	kfree(full_path);
 reject:
diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index 081bceaf4ae9e..f5962fd31d62e 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -46,7 +46,7 @@ struct rnbd_srv_dev {
 struct rnbd_srv_sess_dev {
 	/* Entry inside rnbd_srv_dev struct */
 	struct list_head		dev_list;
-	struct rnbd_dev			*rnbd_dev;
+	struct block_device		*bdev;
 	struct rnbd_srv_session		*sess;
 	struct rnbd_srv_dev		*dev;
 	struct kobject                  kobj;
-- 
2.30.2

