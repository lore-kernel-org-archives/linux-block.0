Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E01C4A13
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365335; cv=none; b=NPp61AYp0pMAZCDafV+TDgvBtsH9CzYh4EHxzfLI8eO2Z2TDplto7PggECH0s1keuLWxrADsfdNM/FC6yRbw2qS94cnhtl/RgKDOK8esUXAaves49lPScCGwHCo+t+BWsizNkVxHbOsTPv/l58BIydHUtcqphZbRxxxFTrhkZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365335; c=relaxed/simple;
	bh=yvT6BX1A5abka04dX69pIyjhAB1iWIfQ3OoRb9iMpXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgSiNHYUFckoyNfjfb9sdwG7psVmPLqn7JahBCzu/QCWlQOt3oYlps2+ZWCFU6VW91iLZnUirei0D9ngpHERGkuOd3AywzFUKtD8oJ9i91Hp/qDBgLQtMgVmlUmdvcWT0jMsMbiWISVIoHduDjWyAdzNQCHmarcid7yNCAddMRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fex9lam6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fex9lam6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=T109xR7A52y3jsTtN6EWOLRQ+QPipGmtsBTed4jhDKI=; b=fex9lam6CLwlTUVKjnvFSsZdhN
	7w8fvdu1eG1F6aHfDlTpF3DSnpNPPJ5iY225nwiNnqwn5GOeBnp4UzyWtbxb/Kzn7dkQvSWvQNQ9d
	kjdrb2IudPRLRRSHNWXGzYsjemOZE6eUEK3L+Sw97uLGurqd9Q7njDWHNG9YqwJDT64h/SPsr/CAV
	rSpaJKfPvFSgv5T+HYCTpt29vXRHA5Y/+iDn3p4H0kAfb5dn7sgUHpgCAIRbDUW053umWgluEFNGU
	E7kfcII5DFKFCAkrNLeBOAWIE6DyFXnP79u2/fF2TDb5XGc3sv/+XjCFH2D5UoF1Ge3GmHoqKcvp1
	8cBxcKTw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDeN-000000008Gb-41VK;
	Mon, 16 Dec 2024 16:08:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] null_blk: Remove accesses to page->index
Date: Mon, 16 Dec 2024 16:08:47 +0000
Message-ID: <20241216160849.31739-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use page->private to store the index instead of page->index.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/block/null_blk/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 3c3d8d200abb..825b738119cb 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -899,7 +899,7 @@ static struct nullb_page *null_radix_tree_insert(struct nullb *nullb, u64 idx,
 	if (radix_tree_insert(root, idx, t_page)) {
 		null_free_page(t_page);
 		t_page = radix_tree_lookup(root, idx);
-		WARN_ON(!t_page || t_page->page->index != idx);
+		WARN_ON(!t_page || t_page->page->private != idx);
 	} else if (is_cache)
 		nullb->dev->curr_cache += PAGE_SIZE;
 
@@ -922,7 +922,7 @@ static void null_free_device_storage(struct nullb_device *dev, bool is_cache)
 				(void **)t_pages, pos, FREE_BATCH);
 
 		for (i = 0; i < nr_pages; i++) {
-			pos = t_pages[i]->page->index;
+			pos = t_pages[i]->page->private;
 			ret = radix_tree_delete_item(root, pos, t_pages[i]);
 			WARN_ON(ret != t_pages[i]);
 			null_free_page(ret);
@@ -948,7 +948,7 @@ static struct nullb_page *__null_lookup_page(struct nullb *nullb,
 
 	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
 	t_page = radix_tree_lookup(root, idx);
-	WARN_ON(t_page && t_page->page->index != idx);
+	WARN_ON(t_page && t_page->page->private != idx);
 
 	if (t_page && (for_write || test_bit(sector_bit, t_page->bitmap)))
 		return t_page;
@@ -991,7 +991,7 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 
 	spin_lock_irq(&nullb->lock);
 	idx = sector >> PAGE_SECTORS_SHIFT;
-	t_page->page->index = idx;
+	t_page->page->private = idx;
 	t_page = null_radix_tree_insert(nullb, idx, t_page, !ignore_cache);
 	radix_tree_preload_end();
 
@@ -1011,7 +1011,7 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 	struct nullb_page *t_page, *ret;
 	void *dst, *src;
 
-	idx = c_page->page->index;
+	idx = c_page->page->private;
 
 	t_page = null_insert_page(nullb, idx << PAGE_SECTORS_SHIFT, true);
 
@@ -1070,7 +1070,7 @@ static int null_make_cache_space(struct nullb *nullb, unsigned long n)
 	 * avoid race, we don't allow page free
 	 */
 	for (i = 0; i < nr_pages; i++) {
-		nullb->cache_flush_pos = c_pages[i]->page->index;
+		nullb->cache_flush_pos = c_pages[i]->page->private;
 		/*
 		 * We found the page which is being flushed to disk by other
 		 * threads
-- 
2.45.2

