Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC70DC6FD1C
	for <linux-block@archiver.kernel.org>; Mon,  6 Mar 2023 12:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCFMBs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Mar 2023 07:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjCFMBo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Mar 2023 07:01:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA82F298F0
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 04:01:40 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6D4691FE6B;
        Mon,  6 Mar 2023 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678104099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=coGGIOogyleEfcue49LqcYBByvDZ9BHmyGsH3i/Pbcs=;
        b=zFWsoLx0mVATe4BGpb7FEvnV4IJCpbuYCHeZ0TenJvUFiaf6lqkkzNzxxwwRwLzoLt7IYd
        nklzBLgTyz4Nj9f32Wb09FkNBEEN9GyhKvcCcn5KtQIfHivohQXY1/ex+ZsbGtEtSzGILq
        U73iZWY2OvjCkr3yjPn90Hnnke7E4q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678104099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=coGGIOogyleEfcue49LqcYBByvDZ9BHmyGsH3i/Pbcs=;
        b=fTK7QxT0bGb32lRksuApFAWMAD6Wu9QyjaF+XIp5V2f6W7Uh1pA0tqGndHtaHCxbtgsAzw
        IWtfOVPrNdeSTfAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 5BE012C14F;
        Mon,  6 Mar 2023 12:01:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 552D051BE391; Mon,  6 Mar 2023 13:01:39 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/5] brd: make logical sector size configurable
Date:   Mon,  6 Mar 2023 13:01:27 +0100
Message-Id: <20230306120127.21375-6-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230306120127.21375-1-hare@suse.de>
References: <20230306120127.21375-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a module option 'rd_logical_blksize' to allow the user to change
the logical sector size of the RAM disks.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/brd.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 1ed114cd5cb0..dda791805aba 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -48,6 +48,8 @@ struct brd_device {
 	u64			brd_nr_folios;
 	unsigned int		brd_sector_shift;
 	unsigned int		brd_sector_size;
+	unsigned int		brd_logical_sector_shift;
+	unsigned int		brd_logical_sector_size;
 };
 
 /*
@@ -57,7 +59,7 @@ static struct folio *brd_lookup_folio(struct brd_device *brd, sector_t sector)
 {
 	pgoff_t idx;
 	struct folio *folio;
-	unsigned int rd_sector_shift = brd->brd_sector_shift - SECTOR_SHIFT;
+	unsigned int rd_sector_shift = brd->brd_sector_shift - brd->brd_logical_sector_shift;
 
 	/*
 	 * The folio lifetime is protected by the fact that we have opened the
@@ -87,7 +89,7 @@ static int brd_insert_folio(struct brd_device *brd, sector_t sector, gfp_t gfp)
 {
 	pgoff_t idx;
 	struct folio *folio;
-	unsigned int rd_sector_shift = brd->brd_sector_shift - SECTOR_SHIFT;
+	unsigned int rd_sector_shift = brd->brd_sector_shift - brd->brd_logical_sector_shift;
 	unsigned int rd_sector_order = get_order(brd->brd_sector_size);
 	int ret = 0;
 
@@ -172,10 +174,10 @@ static void brd_free_folios(struct brd_device *brd)
 static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n,
 			     gfp_t gfp)
 {
-	unsigned int rd_sectors_shift = brd->brd_sector_shift - SECTOR_SHIFT;
+	unsigned int rd_sectors_shift = brd->brd_sector_shift - brd->brd_logical_sector_shift;
 	unsigned int rd_sectors = 1 << rd_sectors_shift;
 	unsigned int rd_sector_size = brd->brd_sector_size;
-	unsigned int offset = (sector & (rd_sectors - 1)) << SECTOR_SHIFT;
+	unsigned int offset = (sector & (rd_sectors - 1)) << brd->brd_logical_sector_shift;
 	size_t copy;
 	int ret;
 
@@ -184,7 +186,7 @@ static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n,
 	if (ret)
 		return ret;
 	if (copy < n) {
-		sector += copy >> SECTOR_SHIFT;
+		sector += copy >> brd->brd_logical_sector_shift;
 		ret = brd_insert_folio(brd, sector, gfp);
 	}
 	return ret;
@@ -198,10 +200,10 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 {
 	struct folio *folio;
 	void *dst;
-	unsigned int rd_sectors_shift = brd->brd_sector_shift - SECTOR_SHIFT;
+	unsigned int rd_sectors_shift = brd->brd_sector_shift - brd->brd_logical_sector_shift;
 	unsigned int rd_sectors = 1 << rd_sectors_shift;
 	unsigned int rd_sector_size = brd->brd_sector_size;
-	unsigned int offset = (sector & (rd_sectors - 1)) << SECTOR_SHIFT;
+	unsigned int offset = (sector & (rd_sectors - 1)) << brd->brd_logical_sector_shift;
 	size_t copy;
 
 	copy = min_t(size_t, n, rd_sector_size - offset);
@@ -214,7 +216,7 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 
 	if (copy < n) {
 		src += copy;
-		sector += copy >> SECTOR_SHIFT;
+		sector += copy >> brd->brd_logical_sector_shift;
 		copy = n - copy;
 		folio = brd_lookup_folio(brd, sector);
 		BUG_ON(!folio);
@@ -233,10 +235,10 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 {
 	struct folio *folio;
 	void *src;
-	unsigned int rd_sectors_shift = brd->brd_sector_shift - SECTOR_SHIFT;
+	unsigned int rd_sectors_shift = brd->brd_sector_shift - brd->brd_logical_sector_shift;
 	unsigned int rd_sectors = 1 << rd_sectors_shift;
 	unsigned int rd_sector_size = brd->brd_sector_size;
-	unsigned int offset = (sector & (rd_sectors - 1)) << SECTOR_SHIFT;
+	unsigned int offset = (sector & (rd_sectors - 1)) << brd->brd_logical_sector_shift;
 	size_t copy;
 
 	copy = min_t(size_t, n, rd_sector_size - offset);
@@ -250,7 +252,7 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 
 	if (copy < n) {
 		dst += copy;
-		sector += copy >> SECTOR_SHIFT;
+		sector += copy >> brd->brd_logical_sector_shift;
 		copy = n - copy;
 		folio = brd_lookup_folio(brd, sector);
 		if (folio) {
@@ -309,8 +311,8 @@ static void brd_submit_bio(struct bio *bio)
 		int err;
 
 		/* Don't support un-aligned buffer */
-		WARN_ON_ONCE((iter.offset & (SECTOR_SIZE - 1)) ||
-				(len & (SECTOR_SIZE - 1)));
+		WARN_ON_ONCE((iter.offset & (brd->brd_logical_sector_size - 1)) ||
+				(len & (brd->brd_logical_sector_size - 1)));
 
 		err = brd_do_folio(brd, iter.folio, len, iter.offset,
 				   bio->bi_opf, sector);
@@ -322,7 +324,7 @@ static void brd_submit_bio(struct bio *bio)
 			bio_io_error(bio);
 			return;
 		}
-		sector += len >> SECTOR_SHIFT;
+		sector += len >> brd->brd_logical_sector_shift;
 	}
 
 	bio_endio(bio);
@@ -353,6 +355,10 @@ static unsigned int rd_blksize = PAGE_SIZE;
 module_param(rd_blksize, uint, 0444);
 MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");
 
+static unsigned int rd_logical_blksize = SECTOR_SIZE;
+module_param(rd_logical_blksize, uint, 0444);
+MODULE_PARM_DESC(rd_logical_blksize, "Logical blocksize of each RAM disk in bytes.");
+
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
 MODULE_ALIAS("rd");
@@ -391,6 +397,8 @@ static int brd_alloc(int i)
 	list_add_tail(&brd->brd_list, &brd_devices);
 	brd->brd_sector_shift = ilog2(rd_blksize);
 	brd->brd_sector_size = rd_blksize;
+	brd->brd_logical_sector_shift = ilog2(rd_logical_blksize);
+	brd->brd_logical_sector_size = rd_logical_blksize;
 
 	spin_lock_init(&brd->brd_lock);
 	INIT_RADIX_TREE(&brd->brd_folios, GFP_ATOMIC);
@@ -418,6 +426,7 @@ static int brd_alloc(int i)
 		goto out_cleanup_disk;
 	}
 	blk_queue_physical_block_size(disk->queue, rd_blksize);
+	blk_queue_logical_block_size(disk->queue, rd_logical_blksize);
 	blk_queue_max_hw_sectors(disk->queue, RD_MAX_SECTOR_SIZE);
 
 	/* Tell the block layer that this is not a rotational device */
-- 
2.35.3

