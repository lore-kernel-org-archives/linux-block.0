Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64B5C6FD1A
	for <linux-block@archiver.kernel.org>; Mon,  6 Mar 2023 12:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjCFMBr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Mar 2023 07:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCFMBo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Mar 2023 07:01:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A769B298EA
        for <linux-block@vger.kernel.org>; Mon,  6 Mar 2023 04:01:40 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 581921FE65;
        Mon,  6 Mar 2023 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678104099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BcFZu1EKqaMhKwOFz1ZWi9/9YMK4hKcp66uUAYqgWw8=;
        b=wWLwLMpUaYWu9CcdFNGkbXM6rATq5Or7uwjNNd/hIwu3BqDVeniwXtPPwfhBEHTh/Zx3Yj
        w4gmwn5OBs0n34IRK2gQ6yBdyivar9V6UZm2zA1JoA8XnHvcEYYwxq4iMG+8PnhnLzELa+
        3fShMlEF0GLQD+4GtuHFLt3sAO6lVkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678104099;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BcFZu1EKqaMhKwOFz1ZWi9/9YMK4hKcp66uUAYqgWw8=;
        b=VjS05isvtMkxkrbjyLsOPy68t54uafJwp0KWzhylE5x9/zvrmVQhUUMnxU+78jjAInCHf0
        7iWlRq/mC9AFwwCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 417D02C143;
        Mon,  6 Mar 2023 12:01:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 3620951BE389; Mon,  6 Mar 2023 13:01:39 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/5] brd: convert to folios
Date:   Mon,  6 Mar 2023 13:01:23 +0100
Message-Id: <20230306120127.21375-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230306120127.21375-1-hare@suse.de>
References: <20230306120127.21375-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert the driver to work on folios instead of pages.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/brd.c | 171 ++++++++++++++++++++++----------------------
 1 file changed, 85 insertions(+), 86 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 34177f1bd97d..7efc276c4963 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -28,8 +28,8 @@
 #include <linux/uaccess.h>
 
 /*
- * Each block ramdisk device has a radix_tree brd_pages of pages that stores
- * the pages containing the block device's contents. A brd page's ->index is
+ * Each block ramdisk device has a radix_tree brd_folios of folios that stores
+ * the folios containing the block device's contents. A brd folio's ->index is
  * its offset in PAGE_SIZE units. This is similar to, but in no way connected
  * with, the kernel's pagecache or buffer cache (which sit above our block
  * device).
@@ -40,25 +40,25 @@ struct brd_device {
 	struct list_head	brd_list;
 
 	/*
-	 * Backing store of pages and lock to protect it. This is the contents
-	 * of the block device.
+	 * Backing store of folios and lock to protect it.
+	 * This is the contents of the block device.
 	 */
 	spinlock_t		brd_lock;
-	struct radix_tree_root	brd_pages;
-	u64			brd_nr_pages;
+	struct radix_tree_root	brd_folios;
+	u64			brd_nr_folios;
 };
 
 /*
- * Look up and return a brd's page for a given sector.
+ * Look up and return a brd's folio for a given sector.
  */
-static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
+static struct folio *brd_lookup_folio(struct brd_device *brd, sector_t sector)
 {
 	pgoff_t idx;
-	struct page *page;
+	struct folio *folio;
 
 	/*
-	 * The page lifetime is protected by the fact that we have opened the
-	 * device node -- brd pages will never be deleted under us, so we
+	 * The folio lifetime is protected by the fact that we have opened the
+	 * device node -- brd folios will never be deleted under us, so we
 	 * don't need any further locking or refcounting.
 	 *
 	 * This is strictly true for the radix-tree nodes as well (ie. we
@@ -68,49 +68,49 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 	 * here, only deletes).
 	 */
 	rcu_read_lock();
-	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to page index */
-	page = radix_tree_lookup(&brd->brd_pages, idx);
+	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to folio index */
+	folio = radix_tree_lookup(&brd->brd_folios, idx);
 	rcu_read_unlock();
 
-	BUG_ON(page && page->index != idx);
+	BUG_ON(folio && folio->index != idx);
 
-	return page;
+	return folio;
 }
 
 /*
- * Insert a new page for a given sector, if one does not already exist.
+ * Insert a new folio for a given sector, if one does not already exist.
  */
-static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
+static int brd_insert_folio(struct brd_device *brd, sector_t sector, gfp_t gfp)
 {
 	pgoff_t idx;
-	struct page *page;
+	struct folio *folio;
 	int ret = 0;
 
-	page = brd_lookup_page(brd, sector);
-	if (page)
+	folio = brd_lookup_folio(brd, sector);
+	if (folio)
 		return 0;
 
-	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
-	if (!page)
+	folio = folio_alloc(gfp | __GFP_ZERO, 0);
+	if (!folio)
 		return -ENOMEM;
 
 	if (radix_tree_maybe_preload(gfp)) {
-		__free_page(page);
+		folio_put(folio);
 		return -ENOMEM;
 	}
 
 	spin_lock(&brd->brd_lock);
 	idx = sector >> PAGE_SECTORS_SHIFT;
-	page->index = idx;
-	if (radix_tree_insert(&brd->brd_pages, idx, page)) {
-		__free_page(page);
-		page = radix_tree_lookup(&brd->brd_pages, idx);
-		if (!page)
+	folio->index = idx;
+	if (radix_tree_insert(&brd->brd_folios, idx, folio)) {
+		folio_put(folio);
+		folio = radix_tree_lookup(&brd->brd_folios, idx);
+		if (!folio)
 			ret = -ENOMEM;
-		else if (page->index != idx)
+		else if (folio->index != idx)
 			ret = -EIO;
 	} else {
-		brd->brd_nr_pages++;
+		brd->brd_nr_folios++;
 	}
 	spin_unlock(&brd->brd_lock);
 
@@ -119,30 +119,30 @@ static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
 }
 
 /*
- * Free all backing store pages and radix tree. This must only be called when
+ * Free all backing store folios and radix tree. This must only be called when
  * there are no other users of the device.
  */
 #define FREE_BATCH 16
-static void brd_free_pages(struct brd_device *brd)
+static void brd_free_folios(struct brd_device *brd)
 {
 	unsigned long pos = 0;
-	struct page *pages[FREE_BATCH];
-	int nr_pages;
+	struct folio *folios[FREE_BATCH];
+	int nr_folios;
 
 	do {
 		int i;
 
-		nr_pages = radix_tree_gang_lookup(&brd->brd_pages,
-				(void **)pages, pos, FREE_BATCH);
+		nr_folios = radix_tree_gang_lookup(&brd->brd_folios,
+				(void **)folios, pos, FREE_BATCH);
 
-		for (i = 0; i < nr_pages; i++) {
+		for (i = 0; i < nr_folios; i++) {
 			void *ret;
 
-			BUG_ON(pages[i]->index < pos);
-			pos = pages[i]->index;
-			ret = radix_tree_delete(&brd->brd_pages, pos);
-			BUG_ON(!ret || ret != pages[i]);
-			__free_page(pages[i]);
+			BUG_ON(folios[i]->index < pos);
+			pos = folios[i]->index;
+			ret = radix_tree_delete(&brd->brd_folios, pos);
+			BUG_ON(!ret || ret != folios[i]);
+			folio_put(folios[i]);
 		}
 
 		pos++;
@@ -155,10 +155,10 @@ static void brd_free_pages(struct brd_device *brd)
 
 		/*
 		 * This assumes radix_tree_gang_lookup always returns as
-		 * many pages as possible. If the radix-tree code changes,
+		 * many folios as possible. If the radix-tree code changes,
 		 * so will this have to.
 		 */
-	} while (nr_pages == FREE_BATCH);
+	} while (nr_folios == FREE_BATCH);
 }
 
 /*
@@ -172,12 +172,12 @@ static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n,
 	int ret;
 
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
-	ret = brd_insert_page(brd, sector, gfp);
+	ret = brd_insert_folio(brd, sector, gfp);
 	if (ret)
 		return ret;
 	if (copy < n) {
 		sector += copy >> SECTOR_SHIFT;
-		ret = brd_insert_page(brd, sector, gfp);
+		ret = brd_insert_folio(brd, sector, gfp);
 	}
 	return ret;
 }
@@ -188,29 +188,29 @@ static int copy_to_brd_setup(struct brd_device *brd, sector_t sector, size_t n,
 static void copy_to_brd(struct brd_device *brd, const void *src,
 			sector_t sector, size_t n)
 {
-	struct page *page;
+	struct folio *folio;
 	void *dst;
 	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
 	size_t copy;
 
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
-	page = brd_lookup_page(brd, sector);
-	BUG_ON(!page);
+	folio = brd_lookup_folio(brd, sector);
+	BUG_ON(!folio);
 
-	dst = kmap_atomic(page);
-	memcpy(dst + offset, src, copy);
-	kunmap_atomic(dst);
+	dst = kmap_local_folio(folio, offset);
+	memcpy(dst, src, copy);
+	kunmap_local(dst);
 
 	if (copy < n) {
 		src += copy;
 		sector += copy >> SECTOR_SHIFT;
 		copy = n - copy;
-		page = brd_lookup_page(brd, sector);
-		BUG_ON(!page);
+		folio = brd_lookup_folio(brd, sector);
+		BUG_ON(!folio);
 
-		dst = kmap_atomic(page);
+		dst = kmap_local_folio(folio, 0);
 		memcpy(dst, src, copy);
-		kunmap_atomic(dst);
+		kunmap_local(dst);
 	}
 }
 
@@ -220,17 +220,17 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 static void copy_from_brd(void *dst, struct brd_device *brd,
 			sector_t sector, size_t n)
 {
-	struct page *page;
+	struct folio *folio;
 	void *src;
 	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
 	size_t copy;
 
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
-	page = brd_lookup_page(brd, sector);
-	if (page) {
-		src = kmap_atomic(page);
-		memcpy(dst, src + offset, copy);
-		kunmap_atomic(src);
+	folio = brd_lookup_folio(brd, sector);
+	if (folio) {
+		src = kmap_local_folio(folio, offset);
+		memcpy(dst, src, copy);
+		kunmap_local(src);
 	} else
 		memset(dst, 0, copy);
 
@@ -238,20 +238,20 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 		dst += copy;
 		sector += copy >> SECTOR_SHIFT;
 		copy = n - copy;
-		page = brd_lookup_page(brd, sector);
-		if (page) {
-			src = kmap_atomic(page);
+		folio = brd_lookup_folio(brd, sector);
+		if (folio) {
+			src = kmap_local_folio(folio, 0);
 			memcpy(dst, src, copy);
-			kunmap_atomic(src);
+			kunmap_local(src);
 		} else
 			memset(dst, 0, copy);
 	}
 }
 
 /*
- * Process a single bvec of a bio.
+ * Process a single folio of a bio.
  */
-static int brd_do_bvec(struct brd_device *brd, struct page *page,
+static int brd_do_folio(struct brd_device *brd, struct folio *folio,
 			unsigned int len, unsigned int off, blk_opf_t opf,
 			sector_t sector)
 {
@@ -261,7 +261,7 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 	if (op_is_write(opf)) {
 		/*
 		 * Must use NOIO because we don't want to recurse back into the
-		 * block or filesystem layers from page reclaim.
+		 * block or filesystem layers from folio reclaim.
 		 */
 		gfp_t gfp = opf & REQ_NOWAIT ? GFP_NOWAIT : GFP_NOIO;
 
@@ -270,15 +270,15 @@ static int brd_do_bvec(struct brd_device *brd, struct page *page,
 			goto out;
 	}
 
-	mem = kmap_atomic(page);
+	mem = kmap_local_folio(folio, off);
 	if (!op_is_write(opf)) {
-		copy_from_brd(mem + off, brd, sector, len);
-		flush_dcache_page(page);
+		copy_from_brd(mem, brd, sector, len);
+		flush_dcache_folio(folio);
 	} else {
-		flush_dcache_page(page);
-		copy_to_brd(brd, mem + off, sector, len);
+		flush_dcache_folio(folio);
+		copy_to_brd(brd, mem, sector, len);
 	}
-	kunmap_atomic(mem);
+	kunmap_local(mem);
 
 out:
 	return err;
@@ -288,19 +288,18 @@ static void brd_submit_bio(struct bio *bio)
 {
 	struct brd_device *brd = bio->bi_bdev->bd_disk->private_data;
 	sector_t sector = bio->bi_iter.bi_sector;
-	struct bio_vec bvec;
-	struct bvec_iter iter;
+	struct folio_iter iter;
 
-	bio_for_each_segment(bvec, bio, iter) {
-		unsigned int len = bvec.bv_len;
+	bio_for_each_folio_all(iter, bio) {
+		unsigned int len = iter.length;
 		int err;
 
 		/* Don't support un-aligned buffer */
-		WARN_ON_ONCE((bvec.bv_offset & (SECTOR_SIZE - 1)) ||
+		WARN_ON_ONCE((iter.offset & (SECTOR_SIZE - 1)) ||
 				(len & (SECTOR_SIZE - 1)));
 
-		err = brd_do_bvec(brd, bvec.bv_page, len, bvec.bv_offset,
-				  bio->bi_opf, sector);
+		err = brd_do_folio(brd, iter.folio, len, iter.offset,
+				   bio->bi_opf, sector);
 		if (err) {
 			if (err == -ENOMEM && bio->bi_opf & REQ_NOWAIT) {
 				bio_wouldblock_error(bio);
@@ -373,12 +372,12 @@ static int brd_alloc(int i)
 	list_add_tail(&brd->brd_list, &brd_devices);
 
 	spin_lock_init(&brd->brd_lock);
-	INIT_RADIX_TREE(&brd->brd_pages, GFP_ATOMIC);
+	INIT_RADIX_TREE(&brd->brd_folios, GFP_ATOMIC);
 
 	snprintf(buf, DISK_NAME_LEN, "ram%d", i);
 	if (!IS_ERR_OR_NULL(brd_debugfs_dir))
 		debugfs_create_u64(buf, 0444, brd_debugfs_dir,
-				&brd->brd_nr_pages);
+				&brd->brd_nr_folios);
 
 	disk = brd->brd_disk = blk_alloc_disk(NUMA_NO_NODE);
 	if (!disk)
@@ -434,7 +433,7 @@ static void brd_cleanup(void)
 	list_for_each_entry_safe(brd, next, &brd_devices, brd_list) {
 		del_gendisk(brd->brd_disk);
 		put_disk(brd->brd_disk);
-		brd_free_pages(brd);
+		brd_free_folios(brd);
 		list_del(&brd->brd_list);
 		kfree(brd);
 	}
@@ -465,7 +464,7 @@ static int __init brd_init(void)
 
 	brd_check_and_reset_par();
 
-	brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
+	brd_debugfs_dir = debugfs_create_dir("ramdisk_folios", NULL);
 
 	for (i = 0; i < rd_nr; i++) {
 		err = brd_alloc(i);
-- 
2.35.3

