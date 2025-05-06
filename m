Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7017022A4F0
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542322; cv=none; b=nbRX1Qg7dVZx3bBfn8Y3o9TsVtfwVILH58RDM8juKnGm1CkSpg2ZkxOk93VFY3wGUKqkf0QQdkX1qM217nZ/hUIaNKRwxgw6t3qeFu7m7kW+dfd5ELOHCCAzCY7sPz39Uk0pzqoZY7Y6WnEo8FVmdyTV/D6c/6pn2NMP/mOnouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542322; c=relaxed/simple;
	bh=rrle3lpSUoinfagiAfysMJAD83suP25CwQE00GlXMIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0qp5I6WPOp7IaCFhrksSqRuc/0BNgPqwR14L6cUKjO7PJYGp/LHCur55ekdVbbWaLQzFaFVeal7Si4TSBNFTOZDCjEpVfWuyGLTwxQI1gbrBAupoQZyJ5gBRImwJ2nTy1bNFClXfzN3pPOzL/ZZo2CZ1RzZHWP7+ZaqSPqtm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Slq8SV4u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Slq8SV4u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DfRtvjBC0w0uX4g6HuzeH+hTSjcKgp2J/o1Y2hz3LUI=; b=Slq8SV4uh2VzA5S4a3Yf+ou/ej
	zz2pam2lobTkeWY8+PUqh9VTHU9Er90icYmKajp9NmoFecwJ3pczFB/mNS66gNha+7TIG1luY86pc
	ohGANbiMan6+pOmzvITU0XKr6sCd5ta26YFG+jD6nwhGVTIs2FKDW1/Da0/PJogDne5WoX4GjapIi
	XiKe3a2qB3UgO28dkALKOpLKPkvHp9A4s0Ma1DqY429qXUSd/hu9Pjh18UbaGaqEwaGvKW3MGCBlt
	+wrZAosSr0AvfxBjWOfBOPSIJX/k0rJmMPd2luTv7atfDVMDpy6dqu8/mks0ygzT8xqU5dOBLzQMP
	tq1zfYUA==;
Received: from 2a02-8389-2341-5b80-3871-beb2-232f-7711.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3871:beb2:232f:7711] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCJRO-0000000CLqs-3ZST;
	Tue, 06 May 2025 14:38:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: yukuai1@huaweicloud.com,
	linux-block@vger.kernel.org
Subject: [PATCH] brd: avoid extra xarray lookups on first write
Date: Tue,  6 May 2025 16:38:36 +0200
Message-ID: <20250506143836.3793765-1-hch@lst.de>
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
 drivers/block/brd.c | 89 ++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 53 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index a3725673cf16..1857da901227 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -51,37 +51,6 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 	return xa_load(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT);
 }
 
-/*
- * Insert a new page for a given sector, if one does not already exist.
- */
-static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
-{
-	pgoff_t idx = sector >> PAGE_SECTORS_SHIFT;
-	struct page *page;
-	int ret = 0;
-
-	page = brd_lookup_page(brd, sector);
-	if (page)
-		return 0;
-
-	page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
-	if (!page)
-		return -ENOMEM;
-
-	xa_lock(&brd->brd_pages);
-	ret = __xa_insert(&brd->brd_pages, idx, page, gfp);
-	if (!ret)
-		brd->brd_nr_pages++;
-	xa_unlock(&brd->brd_pages);
-
-	if (ret < 0) {
-		__free_page(page);
-		if (ret == -EBUSY)
-			ret = 0;
-	}
-	return ret;
-}
-
 /*
  * Free all backing store pages and xarray. This must only be called when
  * there are no other users of the device.
@@ -109,41 +78,48 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 	sector_t sector = bio->bi_iter.bi_sector;
 	u32 offset = (sector & (PAGE_SECTORS - 1)) << SECTOR_SHIFT;
 	blk_opf_t opf = bio->bi_opf;
-	struct page *page;
+	struct page *page, *ret;
 	void *kaddr;
+	int err;
 
 	bv.bv_len = min_t(u32, bv.bv_len, PAGE_SIZE - offset);
 
-	if (op_is_write(opf)) {
-		int err;
-
+	rcu_read_lock();
+	page = brd_lookup_page(brd, sector);
+	if (!page && op_is_write(opf)) {
 		/*
 		 * Must use NOIO because we don't want to recurse back into the
 		 * block or filesystem layers from page reclaim.
 		 */
-		err = brd_insert_page(brd, sector,
-				(opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO);
-		if (err) {
-			if (err == -ENOMEM && (opf & REQ_NOWAIT))
-				bio_wouldblock_error(bio);
-			else
-				bio_io_error(bio);
-			return false;
+		gfp_t gfp = (opf & REQ_NOWAIT) ? GFP_NOWAIT : GFP_NOIO;
+
+		rcu_read_unlock();
+		page = alloc_page(gfp | __GFP_ZERO | __GFP_HIGHMEM);
+		if (!page) {
+			err = -ENOMEM;
+			goto out_error;
+		}
+		rcu_read_lock();
+
+		xa_lock(&brd->brd_pages);
+		ret = __xa_store(&brd->brd_pages, sector >> PAGE_SECTORS_SHIFT,
+				page, gfp);
+		if (!ret)
+			brd->brd_nr_pages++;
+		xa_unlock(&brd->brd_pages);
+
+		if (ret) {
+			__free_page(page);
+			err = xa_err(ret);
+			if (err < 0)
+				goto out_error;
+			page = ret;
 		}
 	}
 
-	rcu_read_lock();
-	page = brd_lookup_page(brd, sector);
-
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
@@ -155,6 +131,13 @@ static bool brd_rw_bvec(struct brd_device *brd, struct bio *bio)
 
 	bio_advance_iter_single(bio, &bio->bi_iter, bv.bv_len);
 	return true;
+
+out_error:
+	if (err == -ENOMEM && (opf & REQ_NOWAIT))
+		bio_wouldblock_error(bio);
+	else
+		bio_io_error(bio);
+	return false;
 }
 
 static void brd_free_one_page(struct rcu_head *head)
-- 
2.47.2

