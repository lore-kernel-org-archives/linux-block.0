Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B05C2BA4C
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 15:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbiAZPuy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiAZPuy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 10:50:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1237BC06161C
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 07:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9/2ocyAfFb9WcrJmZL29CrnDp2o44xaVi/iPH+KHTeQ=; b=N6n1nTxMW04/zDH8ffKhTQVMqX
        PSwXzZCp0XR84SEeCAQFbzTFsuXQ3I8jwo5DJrMXh/hXJzoo1dZjIRkNQSvE8s7CbwyhhD8M5zh2Z
        BvwfVn07hHEIuyDg8qekWkx1OvoMA8cmJsb4AB4S8fh/83zDp1JLIKV2jxvMKmZRdFkOFk5PvF6nI
        GqRXodXcmp1s8+CVI9/ZNl8AN+sT1/c0R+vhN94r61I6URrzGXzmRx8cWPFAxdhJaMLFnmqQmELLd
        MBwNHUYD4SRmc5+vygabckpbhYq8K6vMNgbP+6Zqq458JpoOjjCOr5Sh9g6CZN0rVOCGSEu9X3+gA
        AYWQb4WQ==;
Received: from [2001:4bb8:180:4c4c:c422:bb0a:5a5f:dce0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCkZP-00CQ7V-5u; Wed, 26 Jan 2022 15:50:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/8] block: remove the racy bd_inode->i_mapping->nrpages asserts
Date:   Wed, 26 Jan 2022 16:50:35 +0100
Message-Id: <20220126155040.1190842-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126155040.1190842-1-hch@lst.de>
References: <20220126155040.1190842-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nothing prevents a file system or userspace opener of the block device
from redirtying the page right afte sync_blockdev returned.  Fortunately
data in the page cache during a block device change is mostly harmless
anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6ec55a5d9dfc4..d3a7f281ce1b6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1278,15 +1278,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	/* I/O need to be drained during transfer transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
-	if (size_changed && lo->lo_device->bd_inode->i_mapping->nrpages) {
-		/* If any pages were dirtied after invalidate_bdev(), try again */
-		err = -EAGAIN;
-		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-			__func__, lo->lo_number, lo->lo_file_name,
-			lo->lo_device->bd_inode->i_mapping->nrpages);
-		goto out_unfreeze;
-	}
-
 	prev_lo_flags = lo->lo_flags;
 
 	err = loop_set_status_from_info(lo, info);
@@ -1497,21 +1488,10 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	invalidate_bdev(lo->lo_device);
 
 	blk_mq_freeze_queue(lo->lo_queue);
-
-	/* invalidate_bdev should have truncated all the pages */
-	if (lo->lo_device->bd_inode->i_mapping->nrpages) {
-		err = -EAGAIN;
-		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-			__func__, lo->lo_number, lo->lo_file_name,
-			lo->lo_device->bd_inode->i_mapping->nrpages);
-		goto out_unfreeze;
-	}
-
 	blk_queue_logical_block_size(lo->lo_queue, arg);
 	blk_queue_physical_block_size(lo->lo_queue, arg);
 	blk_queue_io_min(lo->lo_queue, arg);
 	loop_update_dio(lo);
-out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
 	return err;
-- 
2.30.2

