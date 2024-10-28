Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9353518FDA9
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106526; cv=none; b=gyW1gpFiCKzEmz/WdZ6ALXuzyRrSzlSfHtzBBLD6GYf7S1M4gTaMS26h/e88kHsV9IGXo5oHKf95pn24qXWEXlJb3ckbUtSHYZfvrAFsnszuxdFg6Sc01tmpfrzT38jKC+ycxJ/KAQnupbridoUslhZARPVH2N/6F92adypGAGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106526; c=relaxed/simple;
	bh=OSAJI1jwuGHIRfSpgOD/s7Frxjf+kCl0hxXujjU+AeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kz3NsCRubl15ngUI7d2qdPc1Kks8RLP4m2da1rLCsXq5WIXGGoM1rYWp8BEpjRF3noJ3QERryYqKQtcCAsJRJw8VBJbTp2TTcG5yEbR8+hgZQ6YsQW8u7e2Ke5mykSq7cbgr9h1rNwiYPq8IL4kbyPGHFctG/rlmLGUCHCdN0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SQ7ubCZO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SQ7ubCZO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=7jVA2N/s+NcS1snkND2EYZyFpx7CO7vA7AP1k7hnEHU=; b=SQ7ubCZO/Z8aM6fTpwYIQ/qtDu
	Phwx+GHPsUwlvEcTwXjiRw7uo3VnlkQyMyMRTIMJq1uu9nrmzytJn7dvBJVd+DOwrLvI+HSOTxtcz
	0UOR6Bd9bDchKzJi0hVeescyxQsj3ck2/fnZ9nPZGMm/+kB5s2eF1addFuJMN5sAYywHgW/HIZSf0
	pFNBCwcYdELRpMiM5Rd/3CGxieepams2ihr5/2j3wV3oqlyGHPyMyhBJEocmC+pUvGz05yuSvUQoj
	1P6fbOyUO3Mes2k7KWBT1IJHD9Ie6cwFuVXahoW+mNs9AXY2uWg2oY4/LrJzXhgWsjXlgTAYi3CLB
	Rm9JDSkA==;
Received: from 2a02-8389-2341-5b80-1c2d-c630-ed0a-56eb.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1c2d:c630:ed0a:56eb] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Ljv-0000000AB9J-2GcO;
	Mon, 28 Oct 2024 09:08:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: ushankar@purestorage.com,
	xizhang@purestorage.com,
	joshi.k@samsung.com,
	anuj20.g@samsung.com,
	linux-block@vger.kernel.org
Subject: [PATCH v2] block: fix queue limits checks in blk_rq_map_user_bvec for real
Date: Mon, 28 Oct 2024 10:07:48 +0100
Message-ID: <20241028090840.446180-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

blk_rq_map_user_bvec currently only has ad-hoc checks for queue limits,
and the last fix to it enabled valid NVMe I/O to pass, but also allowed
invalid one for drivers that set a max_segment_size or seg_boundary
limit.

Fix it once for all by using the bio_split_rw_at helper from the I/O
path that indicates if and where a bio would be have to be split to
adhere to the queue limits, and it it returns a positive value, turn
that into -EREMOTEIO to retry using the copy path.

Fixes: 2ff949441802 ("block: fix sanity checks in blk_rq_map_user_bvec")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - correctly shift the max_hw_sectors value.  Tested by actually
   checking for max_hw_sectors exceeding I/Os to fail properly

 block/blk-map.c | 56 +++++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 39 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 6ef2ec1f7d78..b5fd1d857461 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -561,55 +561,33 @@ EXPORT_SYMBOL(blk_rq_append_bio);
 /* Prepare bio for passthrough IO given ITER_BVEC iter */
 static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 {
-	struct request_queue *q = rq->q;
-	size_t nr_iter = iov_iter_count(iter);
-	size_t nr_segs = iter->nr_segs;
-	struct bio_vec *bvecs, *bvprvp = NULL;
-	const struct queue_limits *lim = &q->limits;
-	unsigned int nsegs = 0, bytes = 0;
+	const struct queue_limits *lim = &rq->q->limits;
+	unsigned int max_bytes = lim->max_hw_sectors << SECTOR_SHIFT;
+	unsigned int nsegs;
 	struct bio *bio;
-	size_t i;
+	int ret;
 
-	if (!nr_iter || (nr_iter >> SECTOR_SHIFT) > queue_max_hw_sectors(q))
-		return -EINVAL;
-	if (nr_segs > queue_max_segments(q))
+	if (!iov_iter_count(iter) || iov_iter_count(iter) > max_bytes)
 		return -EINVAL;
 
-	/* no iovecs to alloc, as we already have a BVEC iterator */
+	/* reuse the bvecs from the iterator instead of allocating new ones */
 	bio = blk_rq_map_bio_alloc(rq, 0, GFP_KERNEL);
-	if (bio == NULL)
+	if (!bio)
 		return -ENOMEM;
-
 	bio_iov_bvec_set(bio, (struct iov_iter *)iter);
-	blk_rq_bio_prep(rq, bio, nr_segs);
-
-	/* loop to perform a bunch of sanity checks */
-	bvecs = (struct bio_vec *)iter->bvec;
-	for (i = 0; i < nr_segs; i++) {
-		struct bio_vec *bv = &bvecs[i];
-
-		/*
-		 * If the queue doesn't support SG gaps and adding this
-		 * offset would create a gap, fallback to copy.
-		 */
-		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv->bv_offset)) {
-			blk_mq_map_bio_put(bio);
-			return -EREMOTEIO;
-		}
-		/* check full condition */
-		if (nsegs >= nr_segs || bytes > UINT_MAX - bv->bv_len)
-			goto put_bio;
-		if (bytes + bv->bv_len > nr_iter)
-			break;
 
-		nsegs++;
-		bytes += bv->bv_len;
-		bvprvp = bv;
+	/* check that the data layout matches the hardware restrictions */
+	ret = bio_split_rw_at(bio, lim, &nsegs, max_bytes);
+	if (ret) {
+		/* if we would have to split the bio, copy instead */
+		if (ret > 0)
+			ret = -EREMOTEIO;
+		blk_mq_map_bio_put(bio);
+		return ret;
 	}
+
+	blk_rq_bio_prep(rq, bio, nsegs);
 	return 0;
-put_bio:
-	blk_mq_map_bio_put(bio);
-	return -EINVAL;
 }
 
 /**
-- 
2.45.2

