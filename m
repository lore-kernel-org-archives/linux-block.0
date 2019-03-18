Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53925C10F00
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2290C20857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IRIOsaG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfCRTsi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:48:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfCRTs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EFjKTaxCxPf3DnfiVLUJM56TaKZinfZJ19nTWR8wtiM=; b=IRIOsaG0BvXGYzNn/FqPPPZjQ
        ec4OmQvvAWBvpjSPRcklCXy/yIABLeNQdxyh8dGaWkhJhqFuAkv1QBGzuc1f8naaxPSekLVUt54jY
        SMIsteFYJsIzk6lsUj4UWXzbrDHcpK2YllJvtOrgd0FwLctJ2NuQMEvxe3edyXKHeR+9KU2KntMHM
        EbZhcyqoCaHYeLBo9ItbWzeWD6oBCW71bZOJwuWuUcQZnC8fQQTG8eHx/XdWD4/odTGiBdfiTOFaG
        7QIw95riTKT/1TwaIh9RensbQSqrAZhsyByoJdHuphmD1a55YwrqT34569zhGUcLuZBb4osjsN8BA
        eGQLJ3w6g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5yFI-0000vn-TW; Mon, 18 Mar 2019 19:48:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 08/14] brd: Convert to XArray
Date:   Mon, 18 Mar 2019 12:48:15 -0700
Message-Id: <20190318194821.3470-9-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190318194821.3470-1-willy@infradead.org>
References: <20190318194821.3470-1-willy@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Convert brd_pages from a radix tree to an XArray.  Simpler and smaller
code; in particular another user of radix_tree_preload is eliminated.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/block/brd.c | 93 ++++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 65 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index c18586fccb6f..44ce4891e0db 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -17,7 +17,7 @@
 #include <linux/bio.h>
 #include <linux/highmem.h>
 #include <linux/mutex.h>
-#include <linux/radix-tree.h>
+#include <linux/xarray.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
@@ -28,9 +28,9 @@
 #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
 
 /*
- * Each block ramdisk device has a radix_tree brd_pages of pages that stores
- * the pages containing the block device's contents. A brd page's ->index is
- * its offset in PAGE_SIZE units. This is similar to, but in no way connected
+ * Each block ramdisk device has an xarray brd_pages that stores the pages
+ * containing the block device's contents. A brd page's ->index is its
+ * offset in PAGE_SIZE units. This is similar to, but in no way connected
  * with, the kernel's pagecache or buffer cache (which sit above our block
  * device).
  */
@@ -40,13 +40,7 @@ struct brd_device {
 	struct request_queue	*brd_queue;
 	struct gendisk		*brd_disk;
 	struct list_head	brd_list;
-
-	/*
-	 * Backing store of pages and lock to protect it. This is the contents
-	 * of the block device.
-	 */
-	spinlock_t		brd_lock;
-	struct radix_tree_root	brd_pages;
+	struct xarray		brd_pages;
 };
 
 /*
@@ -61,17 +55,9 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 	 * The page lifetime is protected by the fact that we have opened the
 	 * device node -- brd pages will never be deleted under us, so we
 	 * don't need any further locking or refcounting.
-	 *
-	 * This is strictly true for the radix-tree nodes as well (ie. we
-	 * don't actually need the rcu_read_lock()), however that is not a
-	 * documented feature of the radix-tree API so it is better to be
-	 * safe here (we don't have total exclusion from radix tree updates
-	 * here, only deletes).
 	 */
-	rcu_read_lock();
 	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to page index */
-	page = radix_tree_lookup(&brd->brd_pages, idx);
-	rcu_read_unlock();
+	page = xa_load(&brd->brd_pages, idx);
 
 	BUG_ON(page && page->index != idx);
 
@@ -86,7 +72,7 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 static struct page *brd_insert_page(struct brd_device *brd, sector_t sector)
 {
 	pgoff_t idx;
-	struct page *page;
+	struct page *curr, *page;
 	gfp_t gfp_flags;
 
 	page = brd_lookup_page(brd, sector);
@@ -107,62 +93,40 @@ static struct page *brd_insert_page(struct brd_device *brd, sector_t sector)
 	if (!page)
 		return NULL;
 
-	if (radix_tree_preload(GFP_NOIO)) {
-		__free_page(page);
-		return NULL;
-	}
-
-	spin_lock(&brd->brd_lock);
 	idx = sector >> PAGE_SECTORS_SHIFT;
 	page->index = idx;
-	if (radix_tree_insert(&brd->brd_pages, idx, page)) {
+	curr = xa_cmpxchg(&brd->brd_pages, idx, NULL, page, GFP_NOIO);
+	if (curr) {
 		__free_page(page);
-		page = radix_tree_lookup(&brd->brd_pages, idx);
-		BUG_ON(!page);
-		BUG_ON(page->index != idx);
+		if (xa_err(curr)) {
+			page = NULL;
+		} else {
+			page = curr;
+			BUG_ON(!page);
+			BUG_ON(page->index != idx);
+		}
 	}
-	spin_unlock(&brd->brd_lock);
-
-	radix_tree_preload_end();
 
 	return page;
 }
 
 /*
- * Free all backing store pages and radix tree. This must only be called when
+ * Free all backing store pages and xarray.  This must only be called when
  * there are no other users of the device.
  */
-#define FREE_BATCH 16
 static void brd_free_pages(struct brd_device *brd)
 {
-	unsigned long pos = 0;
-	struct page *pages[FREE_BATCH];
-	int nr_pages;
-
-	do {
-		int i;
-
-		nr_pages = radix_tree_gang_lookup(&brd->brd_pages,
-				(void **)pages, pos, FREE_BATCH);
-
-		for (i = 0; i < nr_pages; i++) {
-			void *ret;
-
-			BUG_ON(pages[i]->index < pos);
-			pos = pages[i]->index;
-			ret = radix_tree_delete(&brd->brd_pages, pos);
-			BUG_ON(!ret || ret != pages[i]);
-			__free_page(pages[i]);
-		}
-
-		pos++;
+	XA_STATE(xas, &brd->brd_pages, 0);
+	struct page *page;
 
-		/*
-		 * This assumes radix_tree_gang_lookup always returns as
-		 * many pages as possible. If the radix-tree code changes,
-		 * so will this have to.
-		 */
-	} while (nr_pages == FREE_BATCH);
+	/* lockdep can't know there are no other users */
+	xas_lock(&xas);
+	xas_for_each(&xas, page, ULONG_MAX) {
+		BUG_ON(page->index != xas.xa_index);
+		__free_page(page);
+		xas_store(&xas, NULL);
+	}
+	xas_unlock(&xas);
 }
 
 /*
@@ -372,8 +336,7 @@ static struct brd_device *brd_alloc(int i)
 	if (!brd)
 		goto out;
 	brd->brd_number		= i;
-	spin_lock_init(&brd->brd_lock);
-	INIT_RADIX_TREE(&brd->brd_pages, GFP_ATOMIC);
+	xa_init(&brd->brd_pages);
 
 	brd->brd_queue = blk_alloc_queue(GFP_KERNEL);
 	if (!brd->brd_queue)
-- 
2.20.1

