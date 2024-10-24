Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CAE16DC15
	for <linux-block@vger.kernel.org>; Thu, 24 Oct 2024 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729749952; cv=none; b=tz5Zve0HvPftP0j98Xfx+37vcorTAMPJYAm31jtHLwyfMzjVQwpzLYrHUqzxYrBLvU8XF67tsQzZWS1sqe+VF1HN41MlieO5SB9d+upM8j/7jnDAtI6cldjrqKRqG5zt9WyBMn3uXzguJ1C6AMNAwc6Nd7/Rw9LMBxwIlRPRtd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729749952; c=relaxed/simple;
	bh=YhYuzo/boLkSrrTQ1SsI4zS/91f+LeBxyXKdcZP5TUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9P6buDEoAffDDPRAC7X6Gg/GJ0iI5R0SLr8fLS8j5y7cab0vAIkjMmsXbwDD5NHno0nehRciXolDFOg9VxOWbewrkBAtLoaOOpBYm8ZYFJ497J4hDV3REmICyznBiCrs4Xjh3FXMgtbP7bruOE/TnxVkCVP8jmbJ0fQNixz8Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 027C7227A88; Thu, 24 Oct 2024 08:05:43 +0200 (CEST)
Date: Thu, 24 Oct 2024 08:05:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, Xinyu Zhang <xizhang@purestorage.com>
Subject: Re: [PATCH] block: fix sanity checks in blk_rq_map_user_bvec
Message-ID: <20241024060543.GA32211@lst.de>
References: <20241023211519.4177873-1-ushankar@purestorage.com> <20241024045622.GA30309@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024045622.GA30309@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 24, 2024 at 06:56:22AM +0200, Christoph Hellwig wrote:
> On Wed, Oct 23, 2024 at 03:15:19PM -0600, Uday Shankar wrote:
> > @@ -600,9 +600,7 @@ static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
> >  		if (nsegs >= nr_segs || bytes > UINT_MAX - bv->bv_len)
> >  			goto put_bio;
> >  		if (bytes + bv->bv_len > nr_iter)
> > -			goto put_bio;
> > -		if (bv->bv_offset + bv->bv_len > PAGE_SIZE)
> > -			goto put_bio;
> > +			break;
> 
> So while this fixes NVMe, it actually breaks just about every SCSI
> driver as the code will easily exceed max_segment_size now, which the
> old code obeyed (although more by accident).

Looking at the existing code a bit more it seems really confused,
e.g. by iterating over all segments in the iov_iter instead of using
the proper iterators that limit to the actualy size for the I/O,
which I think is the root cause of your problem.

Can you try the (untested) patch below?  That uses the proper block
layer helper to check the I/O layout using the bio iterator.  It will
handle all block layer queue limits, and it does so on the actual
iterator instead of the potential larger registration.  One change
in behavior is that it now returns -EREMOTEIO for all limits mismatches
instead of a random mix of -EINVAL and -REMOTEIO.


diff --git a/block/blk-map.c b/block/blk-map.c
index 0e1167b23934..ca2f2ff853da 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -561,57 +561,27 @@ EXPORT_SYMBOL(blk_rq_append_bio);
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
 
-	if (!nr_iter || (nr_iter >> SECTOR_SHIFT) > queue_max_hw_sectors(q))
-		return -EINVAL;
-	if (nr_segs > queue_max_segments(q))
+	if (!iov_iter_count(iter))
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
-			goto put_bio;
-		if (bv->bv_offset + bv->bv_len > PAGE_SIZE)
-			goto put_bio;
-
-		nsegs++;
-		bytes += bv->bv_len;
-		bvprvp = bv;
+	/* check that the data layout matches the hardware restrictions */
+	if (bio_split_rw_at(bio, lim, &nsegs, lim->max_hw_sectors)) {
+		blk_mq_map_bio_put(bio);
+		return -EREMOTEIO;
 	}
+
+	blk_rq_bio_prep(rq, bio, nsegs);
 	return 0;
-put_bio:
-	blk_mq_map_bio_put(bio);
-	return -EINVAL;
 }
 
 /**
