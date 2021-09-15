Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CE6C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 12:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0749D611C2
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 12:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhIOMhB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 08:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232921AbhIOMhA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 08:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631709341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tYQm4LMb0WZkGy8QTiFE0aEl6fYLKHvVrM4pDnTLibU=;
        b=UL9/N8RjW6uyCdXNKyicPA59JtqskRwK4AdYbfgJAFoxeeftI5THGE3vKmSD6TxywDREcV
        85SRM26xtvD0O+2Crzac86cldNYBVRYrwhG7NVvdCnY2kZie6kfp72fxdCJukczC01gQkX
        VBF4FAueQKf4BI+Fl2tTaV+gEQWXFDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-LjIzIsSkOBaV65WhPxAWEg-1; Wed, 15 Sep 2021 08:35:40 -0400
X-MC-Unique: LjIzIsSkOBaV65WhPxAWEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B117819200C0;
        Wed, 15 Sep 2021 12:35:39 +0000 (UTC)
Received: from localhost (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41A39196F1;
        Wed, 15 Sep 2021 12:35:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] block: hold ->invalidate_lock in blkdev_fallocate
Date:   Wed, 15 Sep 2021 20:35:45 +0800
Message-Id: <20210915123545.1000534-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When running ->fallocate(), blkdev_fallocate() should hold
mapping->invalidate_lock to prevent page cache from being
accessed, otherwise stale data may be read in page cache.

Without this patch, blktests block/009 fails sometimes. With
this patch, block/009 can pass always.

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/block_dev.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 45df6cbccf12..f55e14ae89a0 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1516,7 +1516,8 @@ static const struct address_space_operations def_blk_aops = {
 static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 			     loff_t len)
 {
-	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
+	struct inode *inode = bdev_file_inode(file);
+	struct block_device *bdev = I_BDEV(inode);
 	loff_t end = start + len - 1;
 	loff_t isize;
 	int error;
@@ -1543,10 +1544,12 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
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
@@ -1563,17 +1566,18 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 					     GFP_KERNEL, 0);
 		break;
 	default:
-		return -EOPNOTSUPP;
+		error = -EOPNOTSUPP;
 	}
-	if (error)
-		return error;
-
 	/*
 	 * Invalidate the page cache again; if someone wandered in and dirtied
 	 * a page, we just discard it - userspace has no way of knowing whether
 	 * the write happened before or after discard completing...
 	 */
-	return truncate_bdev_range(bdev, file->f_mode, start, end);
+	if (!error)
+		error = truncate_bdev_range(bdev, file->f_mode, start, end);
+ fail:
+	filemap_invalidate_unlock(inode->i_mapping);
+	return error;
 }
 
 const struct file_operations def_blk_fops = {
-- 
2.31.1

