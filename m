Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4438D143726;
	Fri,  5 Jul 2024 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182767; cv=none; b=ppWauSZUm38ECmot4VE4iONjPWxNAyuaVVcEpGmaSXZgXiqOeMa5FyoWBzTig+UXzc0bdhthMih4NPPg0dDD/G1/5qzXD0HMkNJtz1tNSzasbdqZcMXO1R9cwZJ0mMbX7bO7jI9U6uu/r3tulYTqHi4zTLU6vStD5RDQ4PT79V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182767; c=relaxed/simple;
	bh=ZFcXVOmCGsymWSXB/+o1jgfKqoTbeoChMUHzD6YGn4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBnauR9R4JQKyd/7NC8gR0yPjy/hWAVeQAhKMypq9vbgqV1ckIytsj5puFoXaq6Mwd928OSJH00R/MyZ/SE3AIXA9S3W1z5cKESxDTAvxfmnvt8EC/ftfPNRc7JTPc7y7TDEZ+zn9B/dHbJsf6lLIuHAWXGNljqvSl6ZwGSKPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Og6xb9Io; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Og6xb9Io"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=67fp9uDtW2CQklPy6RYwHi3RXDhIY4u45ucrmxZ3R0A=; b=Og6xb9IoR1JHgOjxuFbCHVaAuz
	5cTY1AGIFLUEMR1ZqMpm2EQ/Cosl0tyhLqSo8RUWV+2npJ26KxFDI+ytyeUTa+YgRuTjbtj8EVxHH
	ig/oJ9e4H5ydfte30JQHsYVbwO/yKAq8Y7XCf6vyAYwHWnrkEa331zo9DpNwA8rKr7kCHfTzNuCCU
	m2QcdgctAyD/2XhzBKwRPfgd5Lh4VLV0D53lqqY3ddj+V89Bo1YhNAip+BnmhxI1oAcKCFOavNa/l
	sM2lGqIAmt/YcVCj4HVOeTF/d6cphACfYUEYFERgBTK+2AeO+qCug2GOjRY/UXbHXKu5JepMryq08
	3HP143MA==;
Received: from 2a02-8389-2341-5b80-e919-81a4-5d6c-0d5c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e919:81a4:5d6c:d5c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPi7I-0000000FuwB-0gGU;
	Fri, 05 Jul 2024 12:32:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: pass a phys_addr_t to get_max_segment_size
Date: Fri,  5 Jul 2024 14:32:20 +0200
Message-ID: <20240705123232.2165187-3-hch@lst.de>
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

Work on a single address to simplify the logic, and prepare the callers
from using better helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index cff20bcc0252a7..b1e1b7a6933511 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -207,25 +207,24 @@ static inline unsigned get_max_io_size(struct bio *bio,
 }
 
 /**
- * get_max_segment_size() - maximum number of bytes to add as a single segment
+ * get_max_segment_size() - maximum number of bytes to add to a single segment
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

