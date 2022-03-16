Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1659FC4332F
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 08:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354617AbiCPIqt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 04:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354595AbiCPIqs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 04:46:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72B264BD7
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 01:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DUmrrWpDIgVSlj8a/27oSUPz+jLHXhALNhViz2nDfYY=; b=4lGo5Z2pw2EVW1JSDp/4GYHdWW
        WwewE5/K0QAI47C/AWVTN+hWiRZ3XG3dnO3BHsQMK3rO2Ruf5cpfl9txFkZiWvN0FlSL1PpXF8ndL
        1191UseV6eMKAgBySzMYqnUqyKy0uzgAYWDJqG1JjE1xhfQEZFYhVB1Vnz7QCjVCI1P8orfBZTaSK
        zJy7oUuCxvhpBlu7xTpRii26DjPywEe3vgfdMJR/upw9puFdtWKq9bwT6gR4Ax92sKVK5x/MZ2p0s
        u9TnHq1NhnBGGK77pksvNvg1nCzR/GyWGbRfMeNO/dXmzV9bJrfRGHs1X7urES9beUpE5ac+VijaX
        OtQQGw+Q==;
Received: from [46.140.54.162] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUPHe-00CCBM-O6; Wed, 16 Mar 2022 08:45:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/8] loop: remove the racy bd_inode->i_mapping->nrpages asserts
Date:   Wed, 16 Mar 2022 09:45:14 +0100
Message-Id: <20220316084519.2850118-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316084519.2850118-1-hch@lst.de>
References: <20220316084519.2850118-1-hch@lst.de>
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
Tested-by: Darrick J. Wong <djwong@kernel.org>
---
 drivers/block/loop.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2d344fefda6b8..e3361c6b22150 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1276,15 +1276,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	/* I/O need to be drained during transfer transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
-	if (size_changed && lo->lo_device->bd_inode->i_mapping->nrpages) {
-		/* If any pages were dirtied after invalidate_bdev(), try again */
-		err = -EAGAIN;
-		pr_warn("%s: loop%d (%s) still has dirty pages (nrpages=%lu)\n",
-			__func__, lo->lo_number, lo->lo_file_name,
-			lo->lo_device->bd_inode->i_mapping->nrpages);
-		goto out_unfreeze;
-	}
-
 	prev_lo_flags = lo->lo_flags;
 
 	err = loop_set_status_from_info(lo, info);
@@ -1495,21 +1486,10 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	invalidate_bdev(lo->lo_device);
 
 	blk_mq_freeze_queue(lo->lo_queue);
-
-	/* invalidate_bdev should have truncated all the pages */
-	if (lo->lo_device->bd_inode->i_mapping->nrpages) {
-		err = -EAGAIN;
-		pr_warn("%s: loop%d (%s) still has dirty pages (nrpages=%lu)\n",
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

