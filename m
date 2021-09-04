Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49161C433EF
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C6F610A2
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350885AbhIDBgl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 21:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350649AbhIDBgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 21:36:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0601FC061757;
        Fri,  3 Sep 2021 18:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DqxnOIlBn7HOnLcVBtfbuHHKEj6aI4PsYWVAO4qKDFc=; b=MayWC6yylHnqF3VyAQJVkoA6pw
        l0M8TwJQ/7RA8yWEVO2lRil32B4MEzthyNxuOZH8TH2r2eOvGGONpsFQTS+vcSD+EYjQgO3Z57U3G
        b8LwXjP4mHG5JmtGxrSn09W9Ry4kH8o+vnP4czRWqTY758q74WDGySGqWbdpPWJd6n+am9uq3d7CW
        MEf6qytN24isvdn3dBVzNgQy5t01V0nidc+52zbZ6oC1/O4Jbtp/Dm8HAYURd8VDfiO/hKXcTbt5L
        ODlEUff0mXnzVHH3zSsnC3zA7Muryj+Y3iJ4WxaHzxl2RsQ6t7cwhE54nuhI9XAF+JcH303roTTcd
        5WaoEBtw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKan-00DLb4-6y; Sat, 04 Sep 2021 01:35:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 02/14] floppy: fix add_disk() assumption on exit due to new developments
Date:   Fri,  3 Sep 2021 18:35:24 -0700
Message-Id: <20210904013536.3181237-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210904013536.3181237-1-mcgrof@kernel.org>
References: <20210904013536.3181237-1-mcgrof@kernel.org>
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

