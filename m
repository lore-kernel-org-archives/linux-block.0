Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2021F145B24;
	Fri,  5 Jul 2024 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720167317; cv=none; b=hozXFHy73lqGDjP80yy5D8VkqqJmeL+CVIG/KtVcsTA64z1r/A6r/6kIKuMFwH6BiB0ZSV54aIJasA22kndzjWY/rMAlE7DkpykkdNLdlz4yw8JOqO3Glluig9PgD2r4zUqJUUUI6/o+CMY+5nhT3sKIiCuw5JnatATcxVGhS+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720167317; c=relaxed/simple;
	bh=A6iEpg8zRxlSKm/VHGCIjtrPAdPrqYzVQVS1f0EjP5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKEOc058fO6XMDG5gDRUjItGX58TMwnP7isMatbEMgcLUDnv4VsS0E/ysq+x8QQRfm375O1g05vTrPiQfVNqIf7Jsn75WGoLeZP1elF/YNRRspMAlq2+j+stGKYZ5Y6mBp49F6r+VOp22NUUn3rLqyV/r01s57X9SeX+lOmK9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VULN9By9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VULN9By9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uG31UgimUbuo+zCMxygAYLOYQ/KAs9C6e3J9T3445bo=; b=VULN9By9M3yOW7yT4sK1B7aV5D
	EZxQVX6aricmnoT79/xdsBkvE9RxYPw6Fe88Jrm1pgp4nUc3yZYRekWz3U4CEAKBsIQTbQmAabQ8d
	eOhIVD8Zv6/8GzmCQELIUQlsRc+5tRuolfKdCUvwkDITODu82jIBFVskxYI5kP3JLhL31SHP6f8v9
	2u8aoUfVbmKyYhcuN5e/98RvPuFkJRQzNz0YiqZCB0j+S/7C/aPOyKkHyy+5jyrCJJDb+L7KdhHeA
	tjUS0jGpQdzlZIAMZ4c7o2vvpn63xgf+gsjHJgVvUwnpYAwkNwS/Nj2ZJ90j8q/Nl3GCVeucWgBRj
	AxHEXXyw==;
Received: from 2a02-8389-2341-5b80-7f6c-d254-a41c-2a9c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7f6c:d254:a41c:2a9c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPe66-0000000FFKf-1Sgc;
	Fri, 05 Jul 2024 08:15:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: pass a phys_addr_t to get_max_segment_size
Date: Fri,  5 Jul 2024 10:14:33 +0200
Message-ID: <20240705081508.2110169-2-hch@lst.de>
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

Work on a single address to simplify the logic, and prepare the callers
from using better helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index cff20bcc0252a7..515173342eb757 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -207,25 +207,22 @@ static inline unsigned get_max_io_size(struct bio *bio,
 }
 
 /**
- * get_max_segment_size() - maximum number of bytes to add as a single segment
+ * get_max_segment_size() - maximum number of bytes to add to a single segment
  * @lim: Request queue limits.
- * @start_page: See below.
- * @offset: Offset from @start_page where to add a segment.
+ * @paddr: address of the range to add
  *
- * Returns the maximum number of bytes that can be added as a single segment.
+ * Returns the maximum number of bytes of the range starting at @addr that can
+ * be added to a single request.
  */
 static inline unsigned get_max_segment_size(const struct queue_limits *lim,
-		struct page *start_page, unsigned long offset)
+		phys_addr_t paddr)
 {
-	unsigned long mask = lim->seg_boundary_mask;
-
-	offset = mask & (page_to_phys(start_page) + offset);
-
 	/*
 	 * Prevent an overflow if mask = ULONG_MAX and offset = 0 by adding 1
 	 * after having calculated the minimum.
 	 */
-	return min(mask - offset, (unsigned long)lim->max_segment_size - 1) + 1;
+	return min(lim->seg_boundary_mask - (lim->seg_boundary_mask & paddr),
+		    (unsigned long)lim->max_segment_size - 1) + 1;
 }
 
 /**
@@ -258,7 +255,7 @@ static bool bvec_split_segs(const struct queue_limits *lim,
 	unsigned seg_size = 0;
 
 	while (len && *nsegs < max_segs) {
-		seg_size = get_max_segment_size(lim, bv->bv_page,
+		seg_size = get_max_segment_size(lim, page_to_phys(bv->bv_page) +
 						bv->bv_offset + total_len);
 		seg_size = min(seg_size, len);
 
@@ -495,7 +492,8 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
 	while (nbytes > 0) {
 		unsigned offset = bvec->bv_offset + total;
 		unsigned len = min(get_max_segment_size(&q->limits,
-				   bvec->bv_page, offset), nbytes);
+				   page_to_phys(bvec->bv_page) + offset),
+				   nbytes);
 		struct page *page = bvec->bv_page;
 
 		/*
-- 
2.43.0

