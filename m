Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34471D4358
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729857505; cv=none; b=bpqle2CkZw8vLfBTfFfVOoonsfNK+EieTRLvS8WrSHWbJUkA65kkahvjAUFGdiwp77YIrXqhEQROS5r8VB6HrbxS0zSoiXaruWETnQKt6acARhuwImetHhXmqay+Ty/Vp9sIxdAdHG94VMzZucRG0zlRbqENcENrWO975ERlyyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729857505; c=relaxed/simple;
	bh=UPwIwm1YW9/URU8IUpK3jpl7HpqsmJ08CJOo7QkFTKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KDw5hbKxGr/0sKYETJUTRN9R5C/hU4sOIF6HqSf7sj/w7Vq5Ipk4NS4QaWYYIaJrGzcZKGgECdrmxWvSWlbQZyt+z+GrRnyA6l+wdqsp09d2yDNXh/vUaU+XyYCwZRrdO8NOwJsdJwGEZEh1QR6wlGF9X5h9pk0N5WDExqqyHOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I26NV6WA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I26NV6WA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rHU7vevGdZfYnyghhDH+FQONTdYdcrZekT4PNE4+2h8=; b=I26NV6WAqA4qEnl//GJsyPslfm
	IZ0S2DRzk7JE/NnN95CWRL/bLahF/aCUAW04/CnzjLfeffAFm7SuaOiUO1Xz8qeN+4WBsZ52oBSrw
	YjXoRMRDw3LC1JjtFo9DRvhyDKwgbykecMfQNK4u+s9bPQViyUO7h1hePSlNIr0SImX3Ymi0De0Gb
	pMXl6BQe8avdjB0jocgbKim814//+iPyGSnW3g2DyqPWIm4JWXHyqbkfKlr60m+zQ/PMEoOzhJ0Ld
	BNIZrrahX7nLt+RUIhRP5aMstkRzaw2Rl5xP/LOJUScUDbyhW0Q9BFsQ+eefqXT16d640tQxK5uEP
	3ku3om9A==;
Received: from [212.185.66.17] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4IxQ-00000003aTX-3AmJ;
	Fri, 25 Oct 2024 11:58:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: ushankar@purestorage.com,
	xizhang@purestorage.com,
	joshi.k@samsung.com,
	anuj20.g@samsung.com,
	linux-block@vger.kernel.org
Subject: [PATCH] block: fix queue limits checks in blk_rq_map_user_bvec for real
Date: Fri, 25 Oct 2024 13:58:11 +0200
Message-ID: <20241025115818.54976-1-hch@lst.de>
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
 block/blk-map.c | 54 ++++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 6ef2ec1f7d78..d1dce1470054 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -561,55 +561,35 @@ EXPORT_SYMBOL(blk_rq_append_bio);
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
+	unsigned int nsegs;
 	struct bio *bio;
-	size_t i;
+	int ret;
 
-	if (!nr_iter || (nr_iter >> SECTOR_SHIFT) > queue_max_hw_sectors(q))
-		return -EINVAL;
-	if (nr_segs > queue_max_segments(q))
+	if (!iov_iter_count(iter) ||
+	    (iov_iter_count(iter) >> SECTOR_SHIFT) > lim->max_hw_sectors)
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
 
+	/* check that the data layout matches the hardware restrictions */
+	ret = bio_split_rw_at(bio, lim, &nsegs, lim->max_hw_sectors);
+	if (ret) {
 		/*
-		 * If the queue doesn't support SG gaps and adding this
-		 * offset would create a gap, fallback to copy.
+		 * If we would have to split the bio, try to copy.
 		 */
-		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv->bv_offset)) {
-			blk_mq_map_bio_put(bio);
-			return -EREMOTEIO;
-		}
-		/* check full condition */
-		if (nsegs >= nr_segs || bytes > UINT_MAX - bv->bv_len)
-			goto put_bio;
-		if (bytes + bv->bv_len > nr_iter)
-			break;
-
-		nsegs++;
-		bytes += bv->bv_len;
-		bvprvp = bv;
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

