Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0F143726;
	Fri,  5 Jul 2024 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182764; cv=none; b=QxJnTDN/19yfAut+c1b/fL9B5VQxWT67PQ4EUyrC1+ANiQUVA6Fv8AMmOSlKsZ5xPsntVeAjauIlbc3dp6QaqOLrHovH/rrH8MGYitFRhe+CcehiHDHwF6jLW6ZYZk7EYhnD+rM71bwFlbHmaW+gCd/xKlS+/jorg9j90hB9hmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182764; c=relaxed/simple;
	bh=6AmjPKFOvBcokm1Hsm96lBP/aqegWa8U0Q9PVCC6LAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRaiYS8HWkpw07sIHBx1tsO8j63oth2Eo6kvDVS0QNR8l3VVJ4J/qrXe2HFLL8qY0cR7Rd4OzW4DnfRbCQnnPT3z4LcGCd2JJlXffZci1J1Is1+7RGRr+BAOrpBVZc6V3YzXu2iK7nZb+t2TC9Y9ob0MkF1/uYz5vYtYjUl/DxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mKIF6z4B; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mKIF6z4B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0XHBGZLJYh3tY7bCTnGfXIOctYm8jqm89lOwpnosniY=; b=mKIF6z4BT+zeLdY0gGtCNusxs6
	pw+Iv9kCL0J1Pc/+gYkZWHttvdeTCIepe27qskO16HEgMCOAnLnWPWsvBq4hhLS1rATath+HSLxMA
	jqj3kpYKxq28n2rTorr/ZOL77wjcd7dzn5quhKCO9eVzYYp5coMMCMK2Ndgx74ndWYLtNSF342DNO
	78QL7R3ku+kEzkh3u2gD3zQaWNELqlLSV4X7ZLTpw7/CFJoc/6Ju+rrMXgNjY6Hg/7Y/WIc4g0Qpy
	UvmjpKCFFAVoskj35SW0BpYMjGHbTZmRTkn+dG+KEYjlG3uY+oU3LloebJ7VMJwicl8oLxziLk8WQ
	D8+F+SlA==;
Received: from 2a02-8389-2341-5b80-e919-81a4-5d6c-0d5c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e919:81a4:5d6c:d5c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPi7F-0000000Fuw0-1WEx;
	Fri, 05 Jul 2024 12:32:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: add a bvec_phys helper
Date: Fri,  5 Jul 2024 14:32:19 +0200
Message-ID: <20240705123232.2165187-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705123232.2165187-1-hch@lst.de>
References: <20240705123232.2165187-1-hch@lst.de>
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
 block/blk.h             |  4 ++--
 include/linux/bvec.h    | 14 ++++++++++++++
 4 files changed, 18 insertions(+), 4 deletions(-)

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
index bd1e361b351c5a..f41c7f0ef91ed5 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -280,4 +280,18 @@ static inline void *bvec_virt(struct bio_vec *bvec)
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
+	return PFN_PHYS(page_to_pfn(bvec->bv_page)) + bvec->bv_offset;
+}
+
 #endif /* __LINUX_BVEC_H */
-- 
2.43.0

