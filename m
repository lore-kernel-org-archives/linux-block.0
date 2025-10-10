Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ED0271A9A
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760094458; cv=none; b=P3+jwoxgXm94zNz4+cT6sDzZlJRl6Zs/RiuSMqk6RmHDURe/u9gN+mXb4Ta3f3IGlh5AWrDTjmfvFwmv2nR9bKmboB43BTYPjsBQfl8ZMZsj2k7O9SEPWZxocqGNGEt5d6CCLru0oBFJbYTi1YaCVod+484RRnkUg7mU1NYvSHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760094458; c=relaxed/simple;
	bh=WOuKHkir7K2b29klulezhb5+LfWyEkc+6DbOiZctPL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PqpjM6RPU+3wPIY8CrEHict4uL93M9kwzaaUfZPdZa3gTqDX4IpBl9fRzc0hWHnuPmGVPET2knsIZBYwniQdXD3aMDFgYPuT+L4RgR01QXve+Fwr311EkjwFime3uvvfj8awP1gtIcWtJL9bTq1EVZF2Cm1RjuloP80qOXa7suA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zc558neJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zc558neJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=iHl27HNxPJ3gOTtU1uATmOOkVj78R46RsboI21U9HsI=; b=zc558neJkO1lx4wGUr0CMzu5Pj
	A96rpbmhzGNJWn0g0fjxZ6GlIj5uJ22UKRYnBFCETVML9cS2DZOjN4z7kanDL0vumQFB2PdVSoIAI
	bvx7sOGrcx1VKMQVYIJ6PnTL5ri6hZInrpOUdHJ53AjE5HXBspA0ddo27xeqCW5buPv4UBl/RYfZJ
	mcND5WjHFjPqycQtFqTEv6+kA7cEYeTDGb0L8h7FabojZf6ixE3laTEeXif8mMSshO4/3AriGJUC9
	AwiByl1u2cQ4sKu/7cmsnBZJU2l1wgeW2AbgIxK7kuG8mZtPxBNMqvOvA1ostwaJJiykH0XLY5T/x
	kRQ86dcQ==;
Received: from 211-9-41-222.cust.bit-drive.ne.jp ([211.9.41.222] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7AyE-00000008KOL-0Jm6;
	Fri, 10 Oct 2025 11:07:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: kbusch@kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH] block: cleanup and optimize bvec_gap_to_prev
Date: Fri, 10 Oct 2025 20:07:29 +0900
Message-ID: <20251010110729.3875213-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Micro-optimize the code in bvec_gap_to_prev using two tricks:

 - OR the offset and previous length + offset so that there is no need
   for a branch to check both with separate logical and checks.
 - Always OR in the virtual boundary mask, as the instruction for that
   is cheaper than the branch to check for a 0 value.

This together then removes the need for the separate __-handler as
skipping the branch for the 0 check is gone.

The first optimization was stolen from Keith Busch's virtual boundary
series.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c |  2 +-
 block/blk.h       | 12 ++----------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 37864c5d287e..002c59479824 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -81,7 +81,7 @@ static inline bool bio_will_gap(struct request_queue *q,
 	bio_get_first_bvec(next, &nb);
 	if (biovec_phys_mergeable(q, &pb, &nb))
 		return false;
-	return __bvec_gap_to_prev(&q->limits, &pb, nb.bv_offset);
+	return bvec_gap_to_prev(&q->limits, &pb, nb.bv_offset);
 }
 
 static inline bool req_gap_back_merge(struct request *req, struct bio *bio)
diff --git a/block/blk.h b/block/blk.h
index 170794632135..d95788caa129 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -140,13 +140,6 @@ static inline bool biovec_phys_mergeable(struct request_queue *q,
 	return true;
 }
 
-static inline bool __bvec_gap_to_prev(const struct queue_limits *lim,
-		struct bio_vec *bprv, unsigned int offset)
-{
-	return (offset & lim->virt_boundary_mask) ||
-		((bprv->bv_offset + bprv->bv_len) & lim->virt_boundary_mask);
-}
-
 /*
  * Check if adding a bio_vec after bprv with offset would create a gap in
  * the SG list. Most drivers don't care about this, but some do.
@@ -154,9 +147,8 @@ static inline bool __bvec_gap_to_prev(const struct queue_limits *lim,
 static inline bool bvec_gap_to_prev(const struct queue_limits *lim,
 		struct bio_vec *bprv, unsigned int offset)
 {
-	if (!lim->virt_boundary_mask)
-		return false;
-	return __bvec_gap_to_prev(lim, bprv, offset);
+	return (offset | (bprv->bv_offset + bprv->bv_len)) &
+		lim->virt_boundary_mask;
 }
 
 static inline bool rq_mergeable(struct request *rq)
-- 
2.47.3

