Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F79C433F5
	for <linux-block@archiver.kernel.org>; Thu, 12 May 2022 13:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354620AbiELNsZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 May 2022 09:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243881AbiELNsX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 May 2022 09:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAE7E6338A
        for <linux-block@vger.kernel.org>; Thu, 12 May 2022 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652363300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fcPL7ZjdcG7UkpFj1PVIS/PVnXXXrYzBpwCe/9ghwGU=;
        b=SpZMJoq7MojgOq2s/AxMN6Pob0f8UGgcZ6UuFJWevbqT58Iz8pgIm5E1JO1TQF3j/3yPW7
        NQiSDKfbli8IELe4FRYd2gZLsgYePbPqH1O6w8GbOMUdGsQA9OghE48qqPNAsglHB6bO/H
        9r35C+pco6jxaKj/I6y20As2U21Rjk4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-0sN_IdQ1PnuowG4dKOz_Xg-1; Thu, 12 May 2022 09:48:19 -0400
X-MC-Unique: 0sN_IdQ1PnuowG4dKOz_Xg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5408833A01;
        Thu, 12 May 2022 13:48:18 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08E62573EA7;
        Thu, 12 May 2022 13:48:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] block: avoid to serialize blkdev_fallocate
Date:   Thu, 12 May 2022 21:48:14 +0800
Message-Id: <20220512134814.1454451-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit f278eb3d8178 ("block: hold ->invalidate_lock in blkdev_fallocate")
adds ->invalidate_lock in blkdev_fallocate() for preventing stale data
from being read during fallocate().

However, the side effect is that blkdev_fallocate() becomes serialized
since blkdev_fallocate() always blocks.

Add one atomic fallocate counter for allowing blkdev_fallocate() to
be run concurrently so that discard/write_zero bios from different
fallocate() can be submitted in parallel.

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/fops.c              | 6 ++++--
 include/linux/blk_types.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 9f2ecec406b0..368866b15e68 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -651,7 +651,8 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	filemap_invalidate_lock(inode->i_mapping);
+	if (atomic_inc_return(&bdev->bd_fallocate_count) == 1)
+		filemap_invalidate_lock(inode->i_mapping);
 
 	/* Invalidate the page cache, including dirty pages. */
 	error = truncate_bdev_range(bdev, file->f_mode, start, end);
@@ -679,7 +680,8 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	}
 
  fail:
-	filemap_invalidate_unlock(inode->i_mapping);
+	if (!atomic_dec_return(&bdev->bd_fallocate_count))
+		filemap_invalidate_unlock(inode->i_mapping);
 	return error;
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1973ef9bd40f..9ccd841ea8ed 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -58,6 +58,8 @@ struct block_device {
 	struct gendisk *	bd_disk;
 	struct request_queue *	bd_queue;
 
+	atomic_t		bd_fallocate_count;
+
 	/* The counter of freeze processes */
 	int			bd_fsfreeze_count;
 	/* Mutex for freeze */
-- 
2.31.1

