Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F6B144D13;
	Fri,  5 Jul 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167320; cv=none; b=eDyQhWnSny4acDeCjvn0MM6eSjpTRPI993nc7oRvb+ISpA/Rm67BEC6DSlybYPeXDutzMd0mu2LtEyT/7YFgA5rNUn6qLFoO40lNAwovHnlHYGKEB3SgVWbkcwNwQV8ZCfELiZFNb+jbJWtUyzPi2FfRb9v3A5fXWcXyG7COFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167320; c=relaxed/simple;
	bh=Puf9mX6wY7lvOS4f80LQNbWc98AgtwD7kqaYyGbIlI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/H/gip/wo9u90329NuqUfOWxjCwhO32v/I3QLRCZWFxrJfGVW19nGjeyoBMdjbt2/I2fiB2RCQ1pNDooGouUxSWhFxbdeCdNyL1vT4Br0P3cPEyMWtLGzoiYchWpbAEWaKfl61v2Hg0McOHy13ZHMJgmG0831lMKgKYM1ggwRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ckh+HCjN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ckh+HCjN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=66g8bdxGp7OCHG7TbaBOy1YkAOuzAROiSbU/6Ozkhq0=; b=ckh+HCjNnV2C+fNhasPncwCHAT
	2RYofrlfaUoEHkkfK3MUHch19+5vGLfh+Yud0VxnyRT2h7vOalqMKVVCE1XmJa1LhQpd5eLfMUXWQ
	sXut1JNljRKUOkt6nj6essR+oq/mJ5HbyLhciOomqE58VfzZLRb7lGstlPg/0MPEpnBDq6VjAxqIo
	YwE3op0/xn6bANMPEDQ2JFr54rlm6QM4cCZ1rysvukDd9YOWJCy7wQsIkJRrL49EX3xJzpMNQdCYI
	lTqLbIlY6ngEin8PnGtMGbmH9596pAGVluX+mGHNPL3SUdsvQfSp05yUCZAtSc+ttXEJwAiT5o3Iz
	vkriajlw==;
Received: from 2a02-8389-2341-5b80-7f6c-d254-a41c-2a9c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7f6c:d254:a41c:2a9c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPe69-0000000FFL9-1iZO;
	Fri, 05 Jul 2024 08:15:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: add a bvec_phys helper
Date: Fri,  5 Jul 2024 10:14:34 +0200
Message-ID: <20240705081508.2110169-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705081508.2110169-1-hch@lst.de>
References: <20240705081508.2110169-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Get callers out of poking into bvec internals a bit more.  Not a huge win
right now, but with the proposed new DMA mapping API we might end up with
a lot more of this otherwise.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/emu/nfblock.c |  2 +-
 block/bio.c             |  2 +-
 block/blk-merge.c       |  6 ++----
 block/blk.h             |  4 ++--
 include/linux/bvec.h    | 15 +++++++++++++++
 5 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index 8eea7ef9115146..874fe958877388 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -71,7 +71,7 @@ static void nfhd_submit_bio(struct bio *bio)
 		len = bvec.bv_len;
 		len >>= 9;
 		nfhd_read_write(dev->id, 0, dir, sec >> shift, len >> shift,
-				page_to_phys(bvec.bv_page) + bvec.bv_offset);
+				bvec_phys(&bvec));
 		sec += len;
 	}
 	bio_endio(bio);
diff --git a/block/bio.c b/block/bio.c
index e9e809a63c5975..a3b1b2266c50be 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -953,7 +953,7 @@ bool bvec_try_merge_hw_page(struct request_queue *q, struct bio_vec *bv,
 		bool *same_page)
 {
 	unsigned long mask = queue_segment_boundary(q);
-	phys_addr_t addr1 = page_to_phys(bv->bv_page) + bv->bv_offset;
+	phys_addr_t addr1 = bvec_phys(bv);
 	phys_addr_t addr2 = page_to_phys(page) + offset + len - 1;
 
 	if ((addr1 | mask) != (addr2 | mask))
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 515173342eb757..93779fc6dfb1c3 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -255,8 +255,7 @@ static bool bvec_split_segs(const struct queue_limits *lim,
 	unsigned seg_size = 0;
 
 	while (len && *nsegs < max_segs) {
-		seg_size = get_max_segment_size(lim, page_to_phys(bv->bv_page) +
-						bv->bv_offset + total_len);
+		seg_size = get_max_segment_size(lim, bvec_phys(bv) + total_len);
 		seg_size = min(seg_size, len);
 
 		(*nsegs)++;
@@ -492,8 +491,7 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
 	while (nbytes > 0) {
 		unsigned offset = bvec->bv_offset + total;
 		unsigned len = min(get_max_segment_size(&q->limits,
-				   page_to_phys(bvec->bv_page) + offset),
-				   nbytes);
+				   bvec_phys(bvec) + total), nbytes);
 		struct page *page = bvec->bv_page;
 
 		/*
diff --git a/block/blk.h b/block/blk.h
index 47dadd2439b1ca..8e8936e97307c6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -98,8 +98,8 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 		struct bio_vec *vec1, struct bio_vec *vec2)
 {
 	unsigned long mask = queue_segment_boundary(q);
-	phys_addr_t addr1 = page_to_phys(vec1->bv_page) + vec1->bv_offset;
-	phys_addr_t addr2 = page_to_phys(vec2->bv_page) + vec2->bv_offset;
+	phys_addr_t addr1 = bvec_phys(vec1);
+	phys_addr_t addr2 = bvec_phys(vec2);
 
 	/*
 	 * Merging adjacent physical pages may not work correctly under KMSAN
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index bd1e361b351c5a..0b9a56fc0faaf5 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -280,4 +280,19 @@ static inline void *bvec_virt(struct bio_vec *bvec)
 	return page_address(bvec->bv_page) + bvec->bv_offset;
 }
 
+/**
+ * bvec_phys - return the physical address for a bvec
+ * @bvec: bvec to return the physical address for
+ */
+static inline phys_addr_t bvec_phys(const struct bio_vec *bvec)
+{
+	/*
+	 * Note this open codes page_to_phys because page_to_phys is defined in
+	 * <asm/io.h>, which we don't want to pull in here.  If it ever moves to
+	 * a sensible place we should start using it.
+	 */
+	return ((phys_addr_t)page_to_pfn(bvec->bv_page) << PAGE_SHIFT) +
+		bvec->bv_offset;
+}
+
 #endif /* __LINUX_BVEC_H */
-- 
2.43.0

