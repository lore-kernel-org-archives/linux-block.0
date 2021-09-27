Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9B5C4332F
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32754610A2
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbhI0WHT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbhI0WGh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:06:37 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A77C051749;
        Mon, 27 Sep 2021 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DqxnOIlBn7HOnLcVBtfbuHHKEj6aI4PsYWVAO4qKDFc=; b=i6uXEICvlSpg7T5FMTnlp3aUuy
        xuk5iIy+cOhaN9U462dLuzHGkAlwF3BR6Iyh+YX9HJw8CR14PxvTGsmL/adh+RDRIUUzojYeo2IG1
        qbTOtQD5Cc/ptacI37x2OnoL6AnEbTKstLCjpA/yYu+ZytEaHPmREt07wvHp6MVesvcBIXusKpkdL
        orqC6fO/j6PY1vK5m8OS2PRsmkOUofOPa0qIOO4yH4S1ex/fQI4e0deW+e5hDY/SOM39ZAf1eHvP7
        U1V1OSUfutZlyqnGKowWeytxb/15571J81u7nKIq20Y3N/YncwOmJDWNkSk4aUsXmpgM3V7+4d4NM
        x/4C6pLA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyiF-004VHu-E2; Mon, 27 Sep 2021 22:03:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 02/14] floppy: fix add_disk() assumption on exit due to new developments
Date:   Mon, 27 Sep 2021 15:02:50 -0700
Message-Id: <20210927220302.1073499-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220302.1073499-1-mcgrof@kernel.org>
References: <20210927220302.1073499-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After the patch titled "floppy: use blk_mq_alloc_disk and
blk_cleanup_disk" the floppy driver was modified to allocate
the blk_mq_alloc_disk() which allocates the disk with the
queue. This is further clarified later with the patch titled
"block: remove alloc_disk and alloc_disk_node". This clarifies
that:

   Most drivers should use and have been converted to use
   blk_alloc_disk and blk_mq_alloc_disk.  Only the scsi
   ULPs and dasd still allocate a disk separately from the
   request_queue so don't bother with convenience macros for
   something that should not see significant new users and
   remove these wrappers.

And then we have the patch titled, "block: hold a request_queue
reference for the lifetime of struct gendisk" which ensures
that a queue is *always* present for sure during the entire
lifetime of a disk.

In the floppy driver's case then the disk always comes with the
queue. So even if even if the queue was cleaned up on exit, putting
the disk *is* still required, and likewise, blk_cleanup_queue() on
a null queue should not happen now as disk->queue is valid from
disk allocation time on.

Automatic backport code scrapers should hopefully not cherry pick
this patch as a stable fix candidate without full due dilligence to
ensure all the work done on the block layer to make this happen is
merged first.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/floppy.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index fef79ea52e3e..3e6390fd5f2b 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4953,19 +4953,6 @@ static void __exit floppy_module_exit(void)
 				blk_cleanup_queue(disks[drive][i]->queue);
 		}
 		blk_mq_free_tag_set(&tag_sets[drive]);
-
-		/*
-		 * These disks have not called add_disk().  Don't put down
-		 * queue reference in put_disk().
-		 */
-		if (!(allowed_drive_mask & (1 << drive)) ||
-		    fdc_state[FDC(drive)].version == FDC_NONE) {
-			for (i = 0; i < ARRAY_SIZE(floppy_type); i++) {
-				if (disks[drive][i])
-					disks[drive][i]->queue = NULL;
-			}
-		}
-
 		for (i = 0; i < ARRAY_SIZE(floppy_type); i++) {
 			if (disks[drive][i])
 				put_disk(disks[drive][i]);
-- 
2.30.2

