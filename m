Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E954350A69
	for <linux-block@vger.kernel.org>; Fri, 15 Mar 2024 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526341; cv=none; b=gQjxXxlnUaXpPgy6IkvuwengMIQ0rEtlQgzASThAQu9KWtrdcRyAABdZQtq2KOwDKL/mi2nzxaRYrTcJHElaE1UGxo/nLMNdDgzNo46Wrmy/i96JuKdyue9KR49RucWG3OS5wTzw6o3g5k26lXpG7RPEH/KRUFh45m2VukmTKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526341; c=relaxed/simple;
	bh=IEpGNHUTEUKHjWNajftL/6DaDENrQvVc2dmKQjeTmdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lx0IgSU3y/ZDza6eY0IEgZkumbcbB61mgNgRtO9T6d4He+tZZJsOG8vfM+79x7z3cRvRiD07AwC9xG2nc6Rc1J/5AJOU99GGIw7kgIJLs2XomsbAiLN2lP8XIwwcJdJY37kPTh0iwjwVSIrnOCrgM0Q8n+0UJhPAywa7ojZ+qTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DXkmbcnw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DXkmbcnw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=tpT0TnjYK9MafbE4hhmfMjmjyPGY/+5cWvckZ49u59w=; b=DXkmbcnwHrHGAS8UZcsZOBL1pT
	wwyVvIgygvr0q4v76vGLWsSVefgrSWfBRA2KAvUgaPLf8d7zEdd45LamMnjaIkQPr133ft1OLGG6U
	tdIzyQeZ19qUOlKZXzUeq5sFbbVJHqYQx6p2yIBFIXYHejOV4NjF+m4rL1TkdDs9/9IDF9VCFwV94
	BIMkIpOn6vLVARMzvhWOAzfqvr37h0LSdI5+ilPUFTb4QUWc6KeiEYmL3FCFka5r5ebsO9+QhesPQ
	/oRGY/9ZH1mAeqrRm9DE8D8UMF4edshFx86PTV/SdcEY+5jWvFTeYhvJhvWjh6pHVZOiiRVYdh7Vk
	d/m7EQbA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlC2Q-0000000AnYO-2GJG;
	Fri, 15 Mar 2024 18:12:14 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] brd: Remove use of page->index
Date: Fri, 15 Mar 2024 18:12:09 +0000
Message-ID: <20240315181212.2573753-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This debugging check will become more costly in the future when we shrink
struct page.  It has not proven to be useful, so simply remove it.

This lets us use __xa_insert instead of __xa_cmpxchg() as we no longer
need to know about the page that is currently stored in the XArray.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/block/brd.c | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index e322cef6596b..b900fe9e0030 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -29,10 +29,7 @@
 
 /*
  * Each block ramdisk device has a xarray brd_pages of pages that stores
- * the pages containing the block device's contents. A brd page's ->index is
- * its offset in PAGE_SIZE units. This is similar to, but in no way connected
- * with, the kernel's pagecache or buffer cache (which sit above our block
- * device).
+ * the pages containing the block device's contents.
  */
 struct brd_device {
 	int			brd_number;
@@ -51,15 +48,7 @@ struct brd_device {
  */
 static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 {
-	pgoff_t idx;
-	struct page *page;
-
-	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to page index */
-	page = xa_load(&brd->brd_pages, idx);
-
-	BUG_ON(page && page->index != idx);
-
-	return page;
+	return xa_load(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
 }
 
 /*
@@ -67,8 +56,8 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
  */
 static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
 {
-	pgoff_t idx;
-	struct page *page, *cur;
+	pgoff_t idx = sector >> PAGE_SECTORS_SHIFT;
+	struct page *page;
 	int ret = 0;
 
 	page = brd_lookup_page(brd, sector);
@@ -80,23 +69,16 @@ static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
 		return -ENOMEM;
 
 	xa_lock(&brd->brd_pages);
-
-	idx = sector >> PAGE_SECTORS_SHIFT;
-	page->index = idx;
-
-	cur = __xa_cmpxchg(&brd->brd_pages, idx, NULL, page, gfp);
-
-	if (unlikely(cur)) {
-		__free_page(page);
-		ret = xa_err(cur);
-		if (!ret && (cur->index != idx))
-			ret = -EIO;
-	} else {
+	ret = __xa_insert(&brd->brd_pages, idx, page, gfp);
+	if (!ret)
 		brd->brd_nr_pages++;
-	}
-
 	xa_unlock(&brd->brd_pages);
 
+	if (ret < 0) {
+		__free_page(page);
+		if (ret == -EBUSY)
+			ret = 0;
+	}
 	return ret;
 }
 
-- 
2.43.0

