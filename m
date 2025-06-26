Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C572F1FF6
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 05:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750914139; cv=none; b=lU9lKSU09B1b0+7duJ5TSpL8JXAm9wlcuaJvwSF9jxt6MWMN+YXXB0Jjyq4+7BxYZcyv4Wf6ai3odEkl3KvVkv7TIW2jDhKKaikoEaWoseokkFXPyeISO2wIGis/nikhfj2BBU5hUAzTerbXuiuohSIpSxMPE/kYBK5x5sLPH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750914139; c=relaxed/simple;
	bh=IHzL+GjeFVQIpG77KhZeoFi30MQNL6RslGygsQFwnLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAYzzRupk/nCs1iKiFXt8vupooNP6o93IVYYXj9+B9Tp427KhSrlNCyn4feFNHxXaJ8HAVa6sZ3QW8YxC4FwXJcoVqFw7ne6NjeV3S3gFH71+C3+r59o0kPXkgnvNhZxsIT4WiZQALh5z/ZHaP4zKGLxJL+lwzksvEgwURoHeQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B92DB68B05; Thu, 26 Jun 2025 07:02:02 +0200 (CEST)
Date: Thu, 26 Jun 2025 07:02:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, leon@kernel.org, joshi.k@samsung.com,
	sagi@grimberg.me
Subject: Re: [PATCH 1/2] blk-integrity: add scatter-less DMA mapping helpers
Message-ID: <20250626050202.GA23248@lst.de>
References: <20250625204445.1802483-1-kbusch@meta.com> <aFxnbP68tZj6zQyb@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFxnbP68tZj6zQyb@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 25, 2025 at 03:17:32PM -0600, Keith Busch wrote:
> > +		next = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
> 
> And then this should be:
> 
> 		next = mp_bvec_iter_bvec(bip->bip_vec, iter->iter);
> 
> Obviously I didn't test merging bio's into plugged requests...

So, testing was the main reason I have skipped this in the initial
conversion, as I could not come up with good coverage of multi-segment
integrity metadata.  Anuj promised we'd get good test coverage once the
PI query ioctl lands, so the plan was to do it just after that.

I had written some code before I realized that, but it never really got
finished, but one thing I did was to trying figure out how we implement
the iterator without too much code duplication.  The below is what I came
up with - it adds two branches to the fast path, but otherwise shares the
entire dma iterator and I think also makes it very clear which bio_vec
table to use.  Maybe this is useful for the next version?  My next step
would have been to convert the scatterlist mapping to use the new common
helper and unify the code with the data mapping, and then implement the
new API (hopefully also sharing most of the code from the data mapping).

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 82bae475dfa4..24667d199525 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -10,28 +10,34 @@ struct phys_vec {
 };
 
 static bool blk_map_iter_next(struct request *req, struct req_iterator *iter,
-			      struct phys_vec *vec)
+			      struct phys_vec *vec, bool integrity)
 {
+	struct bio_vec *base;
 	unsigned int max_size;
 	struct bio_vec bv;
 
-	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
-		if (!iter->bio)
-			return false;
-		vec->paddr = bvec_phys(&req->special_vec);
-		vec->len = req->special_vec.bv_len;
-		iter->bio = NULL;
-		return true;
+	if (integrity) {
+		base = iter->bio->bi_integrity->bip_vec;
+	} else {
+		if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
+			if (!iter->bio)
+				return false;
+			vec->paddr = bvec_phys(&req->special_vec);
+			vec->len = req->special_vec.bv_len;
+			iter->bio = NULL;
+			return true;
+		}
+		base = iter->bio->bi_io_vec;
 	}
 
 	if (!iter->iter.bi_size)
 		return false;
 
-	bv = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+	bv = mp_bvec_iter_bvec(base, iter->iter);
 	vec->paddr = bvec_phys(&bv);
 	max_size = get_max_segment_size(&req->q->limits, vec->paddr, UINT_MAX);
 	bv.bv_len = min(bv.bv_len, max_size);
-	bio_advance_iter_single(iter->bio, &iter->iter, bv.bv_len);
+	bvec_iter_advance_single(base, &iter->iter, bv.bv_len);
 
 	/*
 	 * If we are entirely done with this bi_io_vec entry, check if the next
@@ -46,15 +52,19 @@ static bool blk_map_iter_next(struct request *req, struct req_iterator *iter,
 				break;
 			iter->bio = iter->bio->bi_next;
 			iter->iter = iter->bio->bi_iter;
+			if (integrity)
+				base = iter->bio->bi_integrity->bip_vec;
+			else
+				base = iter->bio->bi_io_vec;
 		}
 
-		next = mp_bvec_iter_bvec(iter->bio->bi_io_vec, iter->iter);
+		next = mp_bvec_iter_bvec(base, iter->iter);
 		if (bv.bv_len + next.bv_len > max_size ||
 		    !biovec_phys_mergeable(req->q, &bv, &next))
 			break;
 
 		bv.bv_len += next.bv_len;
-		bio_advance_iter_single(iter->bio, &iter->iter, next.bv_len);
+		bvec_iter_advance_single(base, &iter->iter, next.bv_len);
 	}
 
 	vec->len = bv.bv_len;
@@ -95,7 +105,7 @@ int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
 	if (iter.bio)
 		iter.iter = iter.bio->bi_iter;
 
-	while (blk_map_iter_next(rq, &iter, &vec)) {
+	while (blk_map_iter_next(rq, &iter, &vec, false)) {
 		*last_sg = blk_next_sg(last_sg, sglist);
 		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
 				offset_in_page(vec.paddr));
