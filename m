Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5989CC433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 08:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37AD620857
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 08:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZIgk6vuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgFZICX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgFZICU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 04:02:20 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7184CC08C5DB;
        Fri, 26 Jun 2020 01:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VUTyrs7EBN/PE5iFqQDA52UEXg/oSXucsE4GbfE4658=; b=ZIgk6vukccFW6Vyo8Z8cULVTQy
        tb5sp/ROJU/u6OwDBCxg4nS2+1bQsg4sYf2BdCoZ+XEURqny+C63v4t31CbIJiawonhcpQ5X+tP8Z
        Wo1qgTgGSoUB4ONNk8WedM95EQYLkSLyO/hmQ2PuODUMo41PlckifS3jT2Yuw9bmR39OLEFgyBNft
        +ZEZceL+XT9ra949xi3l8JY47WaBIXlwnCGP0DW0+looYoyyCcAcpigXB+t4Pw04zL28RQoa0FeMf
        xZK7aPwQCQcDzWeUj+D4RdLBWIVr1Ed5Q1wuSsOa53zpoloGYP/aQk+7BpWP+4FLJ4YluQazVDAo3
        ySxa7tMw==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojJD-0007UT-V9; Fri, 26 Jun 2020 08:02:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] block: remove the bd_block_size field from struct block_device
Date:   Fri, 26 Jun 2020 10:01:55 +0200
Message-Id: <20200626080158.1998621-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626080158.1998621-1-hch@lst.de>
References: <20200626080158.1998621-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can trivially calculate the block size from the inodes i_blkbits
variable.  Use that instead of keeping two redundant copies of the
information in slightly different formats.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c            | 9 ++-------
 include/linux/blk_types.h | 1 -
 include/linux/blkdev.h    | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 8b7a9c76d33edf..06d31e459048ad 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -105,10 +105,7 @@ EXPORT_SYMBOL(invalidate_bdev);
 
 static void set_init_blocksize(struct block_device *bdev)
 {
-	unsigned bsize = bdev_logical_block_size(bdev);
-
-	bdev->bd_block_size = bsize;
-	bdev->bd_inode->i_blkbits = blksize_bits(bsize);
+	bdev->bd_inode->i_blkbits = blksize_bits(bdev_logical_block_size(bdev));
 }
 
 int set_blocksize(struct block_device *bdev, int size)
@@ -122,9 +119,8 @@ int set_blocksize(struct block_device *bdev, int size)
 		return -EINVAL;
 
 	/* Don't change the size if it is same as current */
-	if (bdev->bd_block_size != size) {
+	if (bdev->bd_inode->i_blkbits != blksize_bits(size)) {
 		sync_blockdev(bdev);
-		bdev->bd_block_size = size;
 		bdev->bd_inode->i_blkbits = blksize_bits(size);
 		kill_bdev(bdev);
 	}
@@ -889,7 +885,6 @@ struct block_device *bdget(dev_t dev)
 		bdev->bd_contains = NULL;
 		bdev->bd_super = NULL;
 		bdev->bd_inode = inode;
-		bdev->bd_block_size = i_blocksize(inode);
 		bdev->bd_part_count = 0;
 		bdev->bd_invalidated = 0;
 		inode->i_mode = S_IFBLK;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index a602132cbe32c2..b01cd19bbe8a6e 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -33,7 +33,6 @@ struct block_device {
 	struct list_head	bd_holder_disks;
 #endif
 	struct block_device *	bd_contains;
-	unsigned		bd_block_size;
 	u8			bd_partno;
 	struct hd_struct *	bd_part;
 	/* number of times partitions within this device have been opened. */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 15497782c17656..752a4b771e2f2f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1548,7 +1548,7 @@ static inline unsigned int blksize_bits(unsigned int size)
 
 static inline unsigned int block_size(struct block_device *bdev)
 {
-	return bdev->bd_block_size;
+	return 1 << bdev->bd_inode->i_blkbits;
 }
 
 int kblockd_schedule_work(struct work_struct *work);
-- 
2.26.2

