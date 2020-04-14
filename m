Return-Path: <SRS0=NWvS=56=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2509C2BA19
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 07:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF824206E9
	for <linux-block@archiver.kernel.org>; Tue, 14 Apr 2020 07:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pzcLJ/oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390788AbgDNH31 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:29:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390783AbgDNH3Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 03:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Sg0pLK6tzb2RMqiGLyHTRbff4Kxm9M8LAoyqqkjVw84=; b=pzcLJ/ozGDnE3XGR07YeDmhptJ
        1jIZdMAvEFeBMYJX7vNa+3kAQn5HiZam3QInbpVSfoZESDiwbGTUDccozZuucbacp3cUhM66+dlRQ
        vYSI1TFXoknodgr8nhvMkkYOMAcXRVmX1vxF0fGAd+JDdEuVD9X3qOijcw0vHTeE1jwbTYD+z3i50
        MAno+tb0jNW1AHjKiYNtFrOnlNGX58lHDZURWiuyRINR3MegKRBXOsrv+zaeve9cEmajh41ZvKDnK
        /5vvD0DDYB+I0vp5ikYEFETUzpvhyjiTaQp0D1N8M85R6s5wkepCUmtc6Ykc4HHXpDTP+NfQE4KY4
        RuVkrPWg==;
Received: from [2001:4bb8:180:384b:4c21:af7:dd95:e552] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOG0a-0005aN-0j; Tue, 14 Apr 2020 07:29:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 06/10] dasd: use blk_drop_partitions instead of badly reimplementing it
Date:   Tue, 14 Apr 2020 09:28:58 +0200
Message-Id: <20200414072902.324936-7-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414072902.324936-1-hch@lst.de>
References: <20200414072902.324936-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the blk_drop_partitions function instead of messing around with
ioctls that get kernel pointers.  For this blk_drop_partitions needs
to be exported, which it normally shouldn't - make an exception for
s390 only.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c         |  4 ++++
 drivers/s390/block/dasd_genhd.c | 20 ++++----------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index deccc3fbcd37..8c5295ca8ea6 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -624,6 +624,10 @@ int blk_drop_partitions(struct block_device *bdev)
 
 	return 0;
 }
+#ifdef CONFIG_S390
+/* for historic reasons in the DASD driver */
+EXPORT_SYMBOL_GPL(blk_drop_partitions);
+#endif
 
 static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 		struct parsed_partitions *state, int p)
diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 7d079154f849..af5b0ecb8f89 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -143,9 +143,6 @@ int dasd_scan_partitions(struct dasd_block *block)
  */
 void dasd_destroy_partitions(struct dasd_block *block)
 {
-	/* The two structs have 168/176 byte on 31/64 bit. */
-	struct blkpg_partition bpart;
-	struct blkpg_ioctl_arg barg;
 	struct block_device *bdev;
 
 	/*
@@ -155,19 +152,10 @@ void dasd_destroy_partitions(struct dasd_block *block)
 	bdev = block->bdev;
 	block->bdev = NULL;
 
-	/*
-	 * See fs/partition/check.c:delete_partition
-	 * Can't call delete_partitions directly. Use ioctl.
-	 * The ioctl also does locking and invalidation.
-	 */
-	memset(&bpart, 0, sizeof(struct blkpg_partition));
-	memset(&barg, 0, sizeof(struct blkpg_ioctl_arg));
-	barg.data = (void __force __user *) &bpart;
-	barg.op = BLKPG_DEL_PARTITION;
-	for (bpart.pno = block->gdp->minors - 1; bpart.pno > 0; bpart.pno--)
-		ioctl_by_bdev(bdev, BLKPG, (unsigned long) &barg);
-
-	invalidate_partition(block->gdp, 0);
+	mutex_lock(&bdev->bd_mutex);
+	blk_drop_partitions(bdev);
+	mutex_unlock(&bdev->bd_mutex);
+
 	/* Matching blkdev_put to the blkdev_get in dasd_scan_partitions. */
 	blkdev_put(bdev, FMODE_READ);
 	set_capacity(block->gdp, 0);
-- 
2.25.1

