Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2D515B971
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 06:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746598026; cv=none; b=VqUuv2P0CoQ8chggp05ror9GJWgsz5fVyFIH+JPO+5h+mdKflk9ms0/f29AMpoyg7YlZ29s4yBlz7TaKD3wTGchBE45LO/gHNlY37ztwkhMCfX8BcMWkfU/y7gpmN5dPnEel0C2+7dQitfb3TJlQR1XOUIKD+4gB7LVWpAMihH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746598026; c=relaxed/simple;
	bh=F24lvu0SEwZhwoFC/g+FbX9M2Vzc1HBYO/pfhRh/uqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=syGccf5LK0ZyoPZuG0h3iAcgLEy4UgijahEvILdUDt0Ew98ZgRrkVFXmnJ6ARmKdgmUPn18kLt87Ei9bIixFZGAVuIaUru20SSpg12r3hgNJMB3jZkihgut6KondBfsmpqKUZcpjaOV7vPEpVW0fypXXeO3D2qHyGjD5GFOTAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3AjnUdmO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3AjnUdmO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=EFsN+niu8trHEilCYaGAz/pHjGxJAcZSNAa+sidG8JI=; b=3AjnUdmOpL6lvmsjKd5hnZ6Njk
	W7zsDfYYDB5iV8YNPVvC0XzGTlGklumJod78Wn0u7UGI/qwnXTWA4uHZ5addSqh9cy09dn1Q4TdrH
	+fVBK19y8hIzjk8xtEAhZOvCOJdvExaXx93ojrmYggXO0Isogs3wgTcICg1jvDRnk/cvLrQ9c/4ul
	sibZ7yhT0VrpapEvjc2ZxORUVlawAqdgsAwQvxUx7X/FtmonsdeZ9YZCMeTuO1CYG3TnR1E71ISk9
	TbxzmJ5NBEvhz3LBuSToHoBE5J7OjOe0MWOX0yR7irrCX12jUlh0TO55upzL+WHKwyNH+mcG66R4K
	ZEkPg0rQ==;
Received: from 2a02-8389-2341-5b80-3ba7-83fe-7065-4f0b.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3ba7:83fe:7065:4f0b] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCXvr-0000000EKYe-0QAj;
	Wed, 07 May 2025 06:07:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: yukuai1@huaweicloud.com,
	kbusch@kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH v2] brd: avoid extra xarray lookups on first write
Date: Wed,  7 May 2025 08:06:35 +0200
Message-ID: <20250507060700.3929430-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The xarray can return the previous entry at a location.  Use this
fact to simplify the brd code when there is no existing page at
a location.  This also slighly improves the handling of racy
discards as we now always have a page under RCU protection by the
time we are ready to copy the data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - use __xa_cmpxchg
 - keep the brd_insert_page helper

 drivers/block/brd.c | 76 ++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 43 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index a3725673cf16..b1be6c510372 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -54,32 +54,33 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 /*
  * Insert a new page for a given sector, if one does not already exist.
  */
-static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
+static struct page *brd_insert_page(struct brd_device *brd, sector_t sector,
+		blk_opf_t opf)
+	__releases(rcu)
+	__acquires(rcu)
 {
-	pgoff_t idx = sector >> PAGE_SECTORS_SHIFT;
-	struct page *page;
-	int ret = 0;
-
-	page = brd_lookup_page(brd, sector);
-	if (page)
-		return 0;
+	gfp_t gfp = (opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO;
+	struct page *page, *ret;
 
+	rcu_read_unlock();
 	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
+	rcu_read_lock();
 	if (!page)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	xa_lock(&brd->brd_pages);
-	ret = __xa_insert(&brd->brd_pages, idx, page, gfp);
-	if (!ret)
-		brd->brd_nr_pages++;
-	xa_unlock(&brd->brd_pages);
-
-	if (ret < 0) {
+	ret = __xa_cmpxchg(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT, NULL,
+			page, gfp);
+	if (ret) {
+		xa_unlock(&brd->brd_pages);
 		__free_page(page);
-		if (ret == -EBUSY)
-			ret = 0;
+		if (xa_is_err(ret))
+			return ERR_PTR(xa_err(ret));
+		return ret;
 	}
-	return ret;
+	brd->brd_nr_pages++;
+	xa_unlock(&brd->brd_pages);
+	return page;
 }
 
 /*
@@ -114,36 +115,17 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 
 	bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
 
-	if (op_is_write(opf)) {
-		int err;
-
-		/*
-		 * Must use NOIO because we don't want to recurse back into the
-		 * block or filesystem layers from page reclaim.
-		 */
-		err = brd_insert_page(brd, sector,
-				(opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO);
-		if (err) {
-			if (err == -ENOMEM && (opf & REQ_NOWAIT))
-				bio_wouldblock_error(bio);
-			else
-				bio_io_error(bio);
-			return false;
-		}
-	}
-
 	rcu_read_lock();
 	page = brd_lookup_page(brd, sector);
+	if (!page && op_is_write(opf)) {
+		page = brd_insert_page(brd, sector, opf);
+		if (IS_ERR(page))
+			goto out_error;
+	}
 
 	kaddr = bvec_kmap_local(&bv);
 	if (op_is_write(opf)) {
-		/*
-		 * Page can be removed by concurrent discard, it's fine to skip
-		 * the write and user will read zero data if page does not
-		 * exist.
-		 */
-		if (page)
-			memcpy_to_page(page, offset, kaddr, bv.bv_len);
+		memcpy_to_page(page, offset, kaddr, bv.bv_len);
 	} else {
 		if (page)
 			memcpy_from_page(kaddr, page, offset, bv.bv_len);
@@ -155,6 +137,14 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 
 	bio_advance_iter_single(bio, &bio->bi_iter, bv.bv_len);
 	return true;
+
+out_error:
+	rcu_read_unlock();
+	if (PTR_ERR(page) == -ENOMEM && (opf & REQ_NOWAIT))
+		bio_wouldblock_error(bio);
+	else
+		bio_io_error(bio);
+	return false;
 }
 
 static void brd_free_one_page(struct rcu_head *head)
-- 
2.47.2

