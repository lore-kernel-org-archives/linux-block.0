Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B57AC433FE
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2197B604AC
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhJYJtd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232770AbhJYJre (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 05:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635155111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OiX6lnWklY1Uov4BrBC0/7Z1v5U3KErjikfs4iIbOpI=;
        b=Fcnijv34ZLqRFq+/SFqvOigS2lHAm6oWnU6/4Y5P0x0vwfYphEjrh4bAiEOt6j3HisB9pn
        iJJSB1yuZ+v0UyiBpfdeigCYLoTBIHJ431yq3lRxnq3mEEGen+IYEQdbZba/gOYkrpzuIz
        z/f1NXcWnfiPclbsR7vveHY5AiGtSX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-lIH0R-23ND2kihWKTmoSgw-1; Mon, 25 Oct 2021 05:45:08 -0400
X-MC-Unique: lIH0R-23ND2kihWKTmoSgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35BA380A5C9;
        Mon, 25 Oct 2021 09:45:07 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53DF35BAE5;
        Mon, 25 Oct 2021 09:45:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/8] loop: relax loop dio use condition
Date:   Mon, 25 Oct 2021 17:44:35 +0800
Message-Id: <20211025094437.2837701-7-ming.lei@redhat.com>
In-Reply-To: <20211025094437.2837701-1-ming.lei@redhat.com>
References: <20211025094437.2837701-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So far loop dio requires the following conditions:

1) lo->lo_offset is aligned with backing queue's logical block size

2) loop queue's logical block size is <= backing queue's logical block
   size

We have supported to fallback to buffered IO, so unaligned IO can't be
completed successfully.

Also the current usage wrt. loop queue's logical block size is hardly
to work as expected, set dio and updating logical block size are done
in different ioctls, and logical block size is often set before setting
direct io. Relaxing dio use in this way won't cause real effect in
reality.

Then we needn't to freeze queue any more when updating dio since loop
IO can be done successfully with the fallback buffered io.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index fee78a640f75..f42630246758 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -215,31 +215,10 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 {
 	struct file *file = lo->lo_backing_file;
 	struct address_space *mapping = file->f_mapping;
-	struct inode *inode = mapping->host;
-	unsigned short sb_bsize = 0;
-	unsigned dio_align = 0;
 	bool use_dio;
 
-	if (inode->i_sb->s_bdev) {
-		sb_bsize = bdev_logical_block_size(inode->i_sb->s_bdev);
-		dio_align = sb_bsize - 1;
-	}
-
-	/*
-	 * We support direct I/O only if lo_offset is aligned with the
-	 * logical I/O size of backing device, and the logical block
-	 * size of loop is bigger than the backing device's and the loop
-	 * needn't transform transfer.
-	 *
-	 * TODO: the above condition may be loosed in the future, and
-	 * direct I/O may be switched runtime at that time because most
-	 * of requests in sane applications should be PAGE_SIZE aligned
-	 */
 	if (dio) {
-		if (queue_logical_block_size(lo->lo_queue) >= sb_bsize &&
-				!(lo->lo_offset & dio_align) &&
-				mapping->a_ops->direct_IO &&
-				!lo->transfer)
+		if (mapping->a_ops->direct_IO && !lo->transfer)
 			use_dio = true;
 		else
 			use_dio = false;
@@ -253,13 +232,6 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	/* flush dirty pages before changing direct IO */
 	vfs_fsync(file, 0);
 
-	/*
-	 * The flag of LO_FLAGS_DIRECT_IO is handled similarly with
-	 * LO_FLAGS_READ_ONLY, both are set from kernel, and losetup
-	 * will get updated by ioctl(LOOP_GET_STATUS)
-	 */
-	if (lo->lo_state == Lo_bound)
-		blk_mq_freeze_queue(lo->lo_queue);
 	lo->use_dio = use_dio;
 	if (use_dio) {
 		blk_queue_flag_clear(QUEUE_FLAG_NOMERGES, lo->lo_queue);
@@ -268,8 +240,6 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 		blk_queue_flag_set(QUEUE_FLAG_NOMERGES, lo->lo_queue);
 		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
 	}
-	if (lo->lo_state == Lo_bound)
-		blk_mq_unfreeze_queue(lo->lo_queue);
 }
 
 /**
@@ -1248,9 +1218,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 
 	if (config->block_size)
 		bsize = config->block_size;
-	else if ((lo->lo_backing_file->f_flags & O_DIRECT) && inode->i_sb->s_bdev)
-		/* In case of direct I/O, match underlying block size */
-		bsize = bdev_logical_block_size(inode->i_sb->s_bdev);
 	else
 		bsize = 512;
 
@@ -1753,7 +1720,6 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	blk_queue_logical_block_size(lo->lo_queue, arg);
 	blk_queue_physical_block_size(lo->lo_queue, arg);
 	blk_queue_io_min(lo->lo_queue, arg);
-	loop_update_dio(lo);
 out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-- 
2.31.1

