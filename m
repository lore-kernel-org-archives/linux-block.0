Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F41BC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 02:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC5BD60F70
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 02:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbhIWCjR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 22:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25318 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238859AbhIWCjR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 22:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632364666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ABiN1/rr46NBTE/MYp4WucHHrl7YR7Bbsi69wTtcSFM=;
        b=XAS0UhW0LOIzRK+dnAW5WVgkvAUgxTNk6tKh8GucsIR3vnIlKKX0TE7St7huiisaPhPqON
        XnFIIAuBwQNEtWEmBDaK9y70ga12G4RaXagY0zXBUAtymfhBqnERl6TRXyGRCWXGrQLbhy
        OQLfWBBV8yENCH+8idCJcgNQhgPf89Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-DYbtqsSPMd2e7tH_E81cFQ-1; Wed, 22 Sep 2021 22:37:44 -0400
X-MC-Unique: DYbtqsSPMd2e7tH_E81cFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93E11801E72;
        Thu, 23 Sep 2021 02:37:43 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C64A360C2B;
        Thu, 23 Sep 2021 02:37:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH V2] block: hold ->invalidate_lock in blkdev_fallocate
Date:   Thu, 23 Sep 2021 10:37:51 +0800
Message-Id: <20210923023751.1441091-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When running ->fallocate(), blkdev_fallocate() should hold
mapping->invalidate_lock to prevent page cache from being accessed,
otherwise stale data may be read in page cache.

Without this patch, blktests block/009 fails sometimes. With this patch,
block/009 can pass always.

Also as Jan pointed out, no pages can be created in the discarded area
while you are holding the invalidate_lock, so remove the 2nd
truncate_bdev_range().

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- include <linux/fs.h> for avoiding implicit declaration of function 
	filemap_invalidate_lock
	- remove 2nd truncate_bdev_range() as suggested by Jan

 block/fops.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index ffce6f6c68dd..1e970c247e0e 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -14,6 +14,7 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/falloc.h>
 #include <linux/suspend.h>
+#include <linux/fs.h>
 #include "blk.h"
 
 static struct inode *bdev_file_inode(struct file *file)
@@ -553,7 +554,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
 {
-	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
+	struct inode *inode = bdev_file_inode(file);
+	struct block_device *bdev = I_BDEV(inode);
 	loff_t end = start + len - 1;
 	loff_t isize;
 	int error;
@@ -580,10 +582,12 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
+	filemap_invalidate_lock(inode->i_mapping);
+
 	/* Invalidate the page cache, including dirty pages. */
 	error = truncate_bdev_range(bdev, file->f_mode, start, end);
 	if (error)
-		return error;
+		goto fail;
 
 	switch (mode) {
 	case FALLOC_FL_ZERO_RANGE:
@@ -600,17 +604,12 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 					     GFP_KERNEL, 0);
 		break;
 	default:
-		return -EOPNOTSUPP;
+		error = -EOPNOTSUPP;
 	}
-	if (error)
-		return error;
 
-	/*
-	 * Invalidate the page cache again; if someone wandered in and dirtied
-	 * a page, we just discard it - userspace has no way of knowing whether
-	 * the write happened before or after discard completing...
-	 */
-	return truncate_bdev_range(bdev, file->f_mode, start, end);
+ fail:
+	filemap_invalidate_unlock(inode->i_mapping);
+	return error;
 }
 
 const struct file_operations def_blk_fops = {
-- 
2.31.1

