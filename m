Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B54C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6AC20857
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b38JTHGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfCRTsi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:48:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfCRTs3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=syzjGXm7nZCMWATApfkoGI2YZgFq4WD7FAbxvnSIUZs=; b=b38JTHGHP/Txgst2+ZYrbbPDu
        Mwk46zT8F//mpcMJvRB7QXdm2kMYhEn5SoSVlc8l4O8cqUcKcZADski72/RgKnAYwuWqM66Hmn+wW
        5HLMnj7onyrA1ZZI2Oy1c6I7fMRvaBjRzQCUy68P3e7MwEegkt9TVUxLmWKmZpXVDaDm0KMyjtQ+X
        Rp2UhLQZl6WOaRXIWr+j08FQ3kA6vBIRWasTHlUklLiXgEq0q90CvXIABLEyJIJx+h8YCHVqrP5b2
        rNT1clMQveYBGWNRUI9kGSxhxJFBpiTr7fiDcdYPBN7SiTyx2UNpEfMiWA3XajUDuGHv/fEdCHPvE
        Qx0sS9xBg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5yFJ-0000vw-2T; Mon, 18 Mar 2019 19:48:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-block@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 09/14] null_blk: Convert to XArray
Date:   Mon, 18 Mar 2019 12:48:16 -0700
Message-Id: <20190318194821.3470-10-willy@infradead.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190318194821.3470-1-willy@infradead.org>
References: <20190318194821.3470-1-willy@infradead.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

By changing the locking we could remove the slightly awkward dance in
null_insert_page(), but I'll leave that for someone who's more familiar
with the driver.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/block/null_blk.h      |  4 +-
 drivers/block/null_blk_main.c | 97 ++++++++++++++---------------------
 2 files changed, 40 insertions(+), 61 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index 34b22d6523ba..8460eb0b2fe2 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -35,8 +35,8 @@ struct nullb_queue {
 struct nullb_device {
 	struct nullb *nullb;
 	struct config_item item;
-	struct radix_tree_root data; /* data stored in the disk */
-	struct radix_tree_root cache; /* disk cache data */
+	struct xarray data; /* data stored in the disk */
+	struct xarray cache; /* disk cache data */
 	unsigned long flags; /* device flags */
 	unsigned int curr_cache;
 	struct badblocks badblocks;
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 417a9f15c116..2a9832eb9ad4 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/init.h>
+#include <linux/xarray.h>
 #include "null_blk.h"
 
 #define PAGE_SECTORS_SHIFT	(PAGE_SHIFT - SECTOR_SHIFT)
@@ -507,8 +508,8 @@ static struct nullb_device *null_alloc_dev(void)
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return NULL;
-	INIT_RADIX_TREE(&dev->data, GFP_ATOMIC);
-	INIT_RADIX_TREE(&dev->cache, GFP_ATOMIC);
+	xa_init_flags(&dev->data, XA_FLAGS_LOCK_IRQ);
+	xa_init_flags(&dev->cache, XA_FLAGS_LOCK_IRQ);
 	if (badblocks_init(&dev->badblocks, 0)) {
 		kfree(dev);
 		return NULL;
@@ -689,18 +690,18 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
 	unsigned int sector_bit;
 	u64 idx;
 	struct nullb_page *t_page, *ret;
-	struct radix_tree_root *root;
+	struct xarray *xa;
 
-	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
+	xa = is_cache ? &nullb->dev->cache : &nullb->dev->data;
 	idx = sector >> PAGE_SECTORS_SHIFT;
 	sector_bit = (sector & SECTOR_MASK);
 
-	t_page = radix_tree_lookup(root, idx);
+	t_page = xa_load(xa, idx);
 	if (t_page) {
 		__clear_bit(sector_bit, t_page->bitmap);
 
 		if (null_page_empty(t_page)) {
-			ret = radix_tree_delete_item(root, idx, t_page);
+			ret = xa_cmpxchg(xa, idx, t_page, NULL, 0);
 			WARN_ON(ret != t_page);
 			null_free_page(ret);
 			if (is_cache)
@@ -709,47 +710,17 @@ static void null_free_sector(struct nullb *nullb, sector_t sector,
 	}
 }
 
-static struct nullb_page *null_radix_tree_insert(struct nullb *nullb, u64 idx,
-	struct nullb_page *t_page, bool is_cache)
-{
-	struct radix_tree_root *root;
-
-	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
-
-	if (radix_tree_insert(root, idx, t_page)) {
-		null_free_page(t_page);
-		t_page = radix_tree_lookup(root, idx);
-		WARN_ON(!t_page || t_page->page->index != idx);
-	} else if (is_cache)
-		nullb->dev->curr_cache += PAGE_SIZE;
-
-	return t_page;
-}
-
 static void null_free_device_storage(struct nullb_device *dev, bool is_cache)
 {
-	unsigned long pos = 0;
-	int nr_pages;
-	struct nullb_page *ret, *t_pages[FREE_BATCH];
-	struct radix_tree_root *root;
-
-	root = is_cache ? &dev->cache : &dev->data;
-
-	do {
-		int i;
-
-		nr_pages = radix_tree_gang_lookup(root,
-				(void **)t_pages, pos, FREE_BATCH);
-
-		for (i = 0; i < nr_pages; i++) {
-			pos = t_pages[i]->page->index;
-			ret = radix_tree_delete_item(root, pos, t_pages[i]);
-			WARN_ON(ret != t_pages[i]);
-			null_free_page(ret);
-		}
+	struct nullb_page *t_page;
+	XA_STATE(xas, is_cache ? &dev->cache : &dev->data, 0);
 
-		pos++;
-	} while (nr_pages == FREE_BATCH);
+	xas_lock(&xas);
+	xas_for_each(&xas, t_page, ULONG_MAX) {
+		xas_store(&xas, NULL);
+		null_free_page(t_page);
+	}
+	xas_unlock(&xas);
 
 	if (is_cache)
 		dev->curr_cache = 0;
@@ -761,13 +732,13 @@ static struct nullb_page *__null_lookup_page(struct nullb *nullb,
 	unsigned int sector_bit;
 	u64 idx;
 	struct nullb_page *t_page;
-	struct radix_tree_root *root;
+	struct xarray *xa;
 
 	idx = sector >> PAGE_SECTORS_SHIFT;
 	sector_bit = (sector & SECTOR_MASK);
 
-	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
-	t_page = radix_tree_lookup(root, idx);
+	xa = is_cache ? &nullb->dev->cache : &nullb->dev->data;
+	t_page = xa_load(xa, idx);
 	WARN_ON(t_page && t_page->page->index != idx);
 
 	if (t_page && (for_write || test_bit(sector_bit, t_page->bitmap)))
@@ -793,8 +764,9 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 	__releases(&nullb->lock)
 	__acquires(&nullb->lock)
 {
-	u64 idx;
-	struct nullb_page *t_page;
+	struct xarray *xa;
+	unsigned long idx;
+	struct nullb_page *exist, *t_page;
 
 	t_page = null_lookup_page(nullb, sector, true, ignore_cache);
 	if (t_page)
@@ -806,14 +778,21 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 	if (!t_page)
 		goto out_lock;
 
-	if (radix_tree_preload(GFP_NOIO))
+	idx = sector >> PAGE_SECTORS_SHIFT;
+	xa = ignore_cache ? &nullb->dev->data : &nullb->dev->cache;
+	if (xa_insert_irq(xa, idx, NULL, GFP_NOIO) == -ENOMEM)
 		goto out_freepage;
 
 	spin_lock_irq(&nullb->lock);
-	idx = sector >> PAGE_SECTORS_SHIFT;
 	t_page->page->index = idx;
-	t_page = null_radix_tree_insert(nullb, idx, t_page, !ignore_cache);
-	radix_tree_preload_end();
+	exist = xa_cmpxchg(xa, idx, XA_ZERO_ENTRY, t_page, GFP_ATOMIC);
+	if (exist) {
+		null_free_page(t_page);
+		t_page = exist;
+	} else if (!ignore_cache)
+		nullb->dev->curr_cache += PAGE_SIZE;
+
+	WARN_ON(t_page->page->index != idx);
 
 	return t_page;
 out_freepage:
@@ -839,8 +818,7 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 	if (test_bit(NULLB_PAGE_FREE, c_page->bitmap)) {
 		null_free_page(c_page);
 		if (t_page && null_page_empty(t_page)) {
-			ret = radix_tree_delete_item(&nullb->dev->data,
-				idx, t_page);
+			xa_cmpxchg(&nullb->dev->data, idx, t_page, NULL, 0);
 			null_free_page(t_page);
 		}
 		return 0;
@@ -865,7 +843,7 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 	kunmap_atomic(dst);
 	kunmap_atomic(src);
 
-	ret = radix_tree_delete_item(&nullb->dev->cache, idx, c_page);
+	ret = xa_cmpxchg(&nullb->dev->cache, idx, c_page, NULL, 0);
 	null_free_page(ret);
 	nullb->dev->curr_cache -= PAGE_SIZE;
 
@@ -883,8 +861,9 @@ static int null_make_cache_space(struct nullb *nullb, unsigned long n)
 	     nullb->dev->curr_cache + n || nullb->dev->curr_cache == 0)
 		return 0;
 
-	nr_pages = radix_tree_gang_lookup(&nullb->dev->cache,
-			(void **)c_pages, nullb->cache_flush_pos, FREE_BATCH);
+	nr_pages = xa_extract(&nullb->dev->cache, (void **)c_pages,
+				nullb->cache_flush_pos, ULONG_MAX,
+				FREE_BATCH, XA_PRESENT);
 	/*
 	 * nullb_flush_cache_page could unlock before using the c_pages. To
 	 * avoid race, we don't allow page free
@@ -1025,7 +1004,7 @@ static int null_handle_flush(struct nullb *nullb)
 			break;
 	}
 
-	WARN_ON(!radix_tree_empty(&nullb->dev->cache));
+	WARN_ON(!xa_empty(&nullb->dev->cache));
 	spin_unlock_irq(&nullb->lock);
 	return err;
 }
-- 
2.20.1

