Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7500C61DA4
	for <linux-block@archiver.kernel.org>; Mon,  6 Mar 2023 12:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCFMBv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Mar 2023 07:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjCFMBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Mar 2023 07:01:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFBE298F5
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 04:01:41 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 60D7A22027;
        Mon,  6 Mar 2023 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678104099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwuiA4ikQa/M46+bw1EkkXbFkC8gprTE2kfTQZ73XFw=;
        b=yquJMVlt4CzxTKrVf99x2sKeNpSD9Y+InO+7DTBmKXnDQYZPul69F+7e4R+qp+7zQ/hU3L
        5PCF/a3hNbsu1ls3j2ETms+pVvtyoRd5avbR3yJ76JXYDn28gQUMTLbUyDvFzh0qWcW4BD
        L0PBYOeQbXoGRb6BER/oYKL6LXYAksc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678104099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UwuiA4ikQa/M46+bw1EkkXbFkC8gprTE2kfTQZ73XFw=;
        b=WsMuE6ROSyi71alF8Z1Vl+zxJIesnuGxsNbqudo1NyoQJKJxHXMVO4Dz2UL9/+ScAAaOvZ
        v6AZsbZXHMlsq2DA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 50B2A2C149;
        Mon,  6 Mar 2023 12:01:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 4607B51BE38D; Mon,  6 Mar 2023 13:01:39 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/5] brd: make sector size configurable
Date:   Mon,  6 Mar 2023 13:01:25 +0100
Message-Id: <20230306120127.21375-4-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230306120127.21375-1-hare@suse.de>
References: <20230306120127.21375-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a module option 'rd_blksize' to allow the user to change
the sector size of the RAM disks.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/brd.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index fc41ea641dfb..11bac3c3f1b6 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -30,7 +30,7 @@
 /*
  * Each block ramdisk device has a radix_tree brd_folios of folios that stores
  * the folios containing the block device's contents. A brd folio's ->index is
- * its offset in PAGE_SIZE units. This is similar to, but in no way connected
+ * its offset in brd_blksize units. This is similar to, but in no way connected
  * with, the kernel's pagecache or buffer cache (which sit above our block
  * device).
  */
@@ -46,6 +46,8 @@ struct brd_device {
 	spinlock_t		brd_lock;
 	struct radix_tree_root	brd_folios;
 	u64			brd_nr_folios;
+	unsigned int		brd_sector_shift;
+	unsigned int		brd_sector_size;
 };
 
 /*
@@ -55,7 +57,7 @@ static struct folio *brd_lookup_folio(struct brd_device *brd, sector_t sector)
 {
 	pgoff_t idx;
 	struct folio *folio;
-	unsigned int rd_sector_shift = PAGE_SHIFT - SECTOR_SHIFT;
+	unsigned int rd_sector_shift = brd->brd_sector_shift - SECTOR_SHIFT;
 
 	/*
 	 * The folio lifetime is protected by the fact that we have opened the
@@ -85,8 +87,8 @@ static int brd_insert_folio(struct brd_device *brd, sector_t sector, gfp_t gfp)
 {
 	pgoff_t idx;
 	struct folio *folio;
-	unsigned int rd_sector_shift = PAGE_SHIFT - SECTOR_SHIFT;
-	unsigned int rd_sector_order = get_order(PAGE_SIZE);
+	unsigned int rd_sector_shift = brd->brd_sector_shift - SECTOR_SHIFT;
+	unsigned int rd_sector_order = get_order(brd->brd_sector_size);
 	int ret = 0;
 
 	folio = brd_lookup_folio(brd, sector);
@@ -170,9 +172,9 @@ static void brd_free_folios(struct brd_device *brd)
 static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n,
 			     gfp_t gfp)
 {
-	unsigned int rd_sectors_shift = PAGE_SHIFT - SECTOR_SHIFT;
+	unsigned int rd_sectors_shift = brd->brd_sector_shift - SECTOR_SHIFT;
 	unsigned int rd_sectors = 1 << rd_sectors_shift;
-	unsigned int rd_sector_size = PAGE_SIZE;
+	unsigned int rd_sector_size = brd->brd_sector_size;
 	unsigned int offset = (sector & (rd_sectors - 1)) << SECTOR_SHIFT;
 	size_t copy;
 	int ret;
@@ -196,9 +198,9 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 {
 	struct folio *folio;
 	void *dst;
-	unsigned int rd_sectors_shift = PAGE_SHIFT - SECTOR_SHIFT;
+	unsigned int rd_sectors_shift = brd->brd_sector_shift - SECTOR_SHIFT;
 	unsigned int rd_sectors = 1 << rd_sectors_shift;
-	unsigned int rd_sector_size = PAGE_SIZE;
+	unsigned int rd_sector_size = brd->brd_sector_size;
 	unsigned int offset = (sector & (rd_sectors - 1)) << SECTOR_SHIFT;
 	size_t copy;
 
@@ -231,9 +233,9 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 {
 	struct folio *folio;
 	void *src;
-	unsigned int rd_sectors_shift = PAGE_SHIFT - SECTOR_SHIFT;
+	unsigned int rd_sectors_shift = brd->brd_sector_shift - SECTOR_SHIFT;
 	unsigned int rd_sectors = 1 << rd_sectors_shift;
-	unsigned int rd_sector_size = PAGE_SIZE;
+	unsigned int rd_sector_size = brd->brd_sector_size;
 	unsigned int offset = (sector & (rd_sectors - 1)) << SECTOR_SHIFT;
 	size_t copy;
 
@@ -346,6 +348,10 @@ static int max_part = 1;
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
 
+static unsigned int rd_blksize = PAGE_SIZE;
+module_param(rd_blksize, uint, 0444);
+MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");
+
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
 MODULE_ALIAS("rd");
@@ -382,6 +388,8 @@ static int brd_alloc(int i)
 		return -ENOMEM;
 	brd->brd_number		= i;
 	list_add_tail(&brd->brd_list, &brd_devices);
+	brd->brd_sector_shift = ilog2(rd_blksize);
+	brd->brd_sector_size = rd_blksize;
 
 	spin_lock_init(&brd->brd_lock);
 	INIT_RADIX_TREE(&brd->brd_folios, GFP_ATOMIC);
@@ -410,7 +418,7 @@ static int brd_alloc(int i)
 	 *  otherwise fdisk will align on 1M. Regardless this call
 	 *  is harmless)
 	 */
-	blk_queue_physical_block_size(disk->queue, PAGE_SIZE);
+	blk_queue_physical_block_size(disk->queue, rd_blksize);
 
 	/* Tell the block layer that this is not a rotational device */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
-- 
2.35.3

