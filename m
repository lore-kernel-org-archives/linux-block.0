Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE23D98E;
	Sat,  6 Jul 2024 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720252358; cv=none; b=H7PEpB12f0+/TH4i+eLaaXbRhHtrf+t1AdV+m/Wgv0oRK5dpMxzH9BymxZ7VG5uTu6OwxraIzuJ30g+DqDaXFtK/V1Wv/cSb5TTq1jbZT7+PxAiZFdu3SyhB0SzFz52JskFbLzpyf33t00N53eGH/yII3MmHCJ78qoIzsbs2Ctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720252358; c=relaxed/simple;
	bh=U52gJba2YwM9T4/l8y8Kcb/hRMyDOXbWULE3DLAPgWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGZkj7s8x41I+Vxr9n4U3h6vh1aPp6S0AMcCrNG1W8y1KjM2xRhVEj1afk9aJjFRtQf4vN82N9oKK7iUkLbTYHZGYs4dpNhD5rCsS121TMTE1KzyRvhTeiOrwGt0CjOx0RELt42eAZNS2F56JIYB5dCMAa8uVtfYgaiwzYtjuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T8FdPbao; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T8FdPbao"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tEIikGkc3VrjQxF+SfK8CI+uwOPrqP6rjFJzVfcXo3U=; b=T8FdPbaorxNRN7FJOXq1WOdPH4
	YtIhFb3kV+/J3aq1vivvJ1x4ai1V9qRFnXJt94Mrkt3ouqZQ4ytYea3UWMDsYzXibGy1OZT7iUBIg
	WJ29pwN6F1J5zl0OSJM7zRdtcE8FObFem6IHrA3ISEQh325O1cF94oq/i+gs6oSewGg0hKr2A0dPS
	8hecgI1lWw4jFU88ttqaZGJ/3FEd6Xv4MXjjkidtifnb2SskRBbez15BD2IWAsX5PZRlGVsfCTNl4
	A27rjTgT4K/VNSBQIk7bBTm74KcKWvoJRApa7wzAiGMyVlo6JV9vrKG5NdGPdE6jkodqXfTOtdn7p
	JBS9uPTg==;
Received: from 2a02-8389-2341-5b80-918c-9045-e0f1-f54a.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:918c:9045:e0f1:f54a] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQ0Dj-0000000HUuP-3bt7;
	Sat, 06 Jul 2024 07:52:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: pass a phys_addr_t to get_max_segment_size
Date: Sat,  6 Jul 2024 09:52:18 +0200
Message-ID: <20240706075228.2350978-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706075228.2350978-1-hch@lst.de>
References: <20240706075228.2350978-1-hch@lst.de>
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
 block/blk-merge.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index cff20bcc0252a7..e41ea331809936 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -209,23 +209,22 @@ static inline unsigned get_max_io_size(struct bio *bio,
 /**
  * get_max_segment_size() - maximum number of bytes to add as a single segment
  * @lim: Request queue limits.
- * @start_page: See below.
- * @offset: Offset from @start_page where to add a segment.
+ * @paddr: address of the range to add
+ * @max_len: maximum length available to add at @paddr
  *
- * Returns the maximum number of bytes that can be added as a single segment.
+ * Returns the maximum number of bytes of the range starting at @paddr that can
+ * be added to a single segment.
  */
 static inline unsigned get_max_segment_size(const struct queue_limits *lim,
-		struct page *start_page, unsigned long offset)
+		phys_addr_t paddr, unsigned int len)
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
+	return min_t(unsigned long, len,
+		min(lim->seg_boundary_mask - (lim->seg_boundary_mask & paddr),
+		    (unsigned long)lim->max_segment_size - 1) + 1);
 }
 
 /**
@@ -258,9 +257,7 @@ static bool bvec_split_segs(const struct queue_limits *lim,
 	unsigned seg_size = 0;
 
 	while (len && *nsegs < max_segs) {
-		seg_size = get_max_segment_size(lim, bv->bv_page,
-						bv->bv_offset + total_len);
-		seg_size = min(seg_size, len);
+		seg_size = get_max_segment_size(lim, bvec_phys(bv) + total_len, len);
 
 		(*nsegs)++;
 		total_len += seg_size;
@@ -494,8 +491,8 @@ static unsigned blk_bvec_map_sg(struct request_queue *q,
 
 	while (nbytes > 0) {
 		unsigned offset = bvec->bv_offset + total;
-		unsigned len = min(get_max_segment_size(&q->limits,
-				   bvec->bv_page, offset), nbytes);
+		unsigned len = get_max_segment_size(&q->limits, bvec_phys(bvec),
+			nbytes);
 		struct page *page = bvec->bv_page;
 
 		/*
-- 
2.43.0

