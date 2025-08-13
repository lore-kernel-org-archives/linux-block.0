Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF36627B50F
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100551; cv=none; b=sZq5QMUGkIncwfwK3p28S87egwFGCx1FdbVrwJeAVMVdJ6F2yog9s5IR2KeLJWPN0dirCAIb9+zEakeodj3+c+MItMyI7r0ZSbfaFGCNqLgAErSJbKzhiwURtaJqfdgI4AClMxNh+M3Ei5X70JRV0dSqKyx0byxVvUFx0Jp0slE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100551; c=relaxed/simple;
	bh=yhMxLBeY+2daedjvIevi+hAVC72Jqpz4xPDMEfRaB5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4CoYeuZ+r1TuxZxyiZdtCmKjU2jNxUlDNMan5KQXZ2V0Kf5ccq3ADrKI0b1ufVf4Wyu7FJGQYWOnsctmm5eUyWhvhF2BWN9Nfk1K2x4nNH1OF45F/h+ByVniER2giWErQ3lzpKlDDwm/3axx4IKpFyPIu5gio4CY50aYPiE0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4746A227AA8; Wed, 13 Aug 2025 17:55:46 +0200 (CEST)
Date: Wed, 13 Aug 2025 17:55:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv7 7/9] blk-integrity: use iterator for mapping sg
Message-ID: <20250813155546.GA14275@lst.de>
References: <20250813153153.3260897-1-kbusch@meta.com> <20250813153153.3260897-8-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813153153.3260897-8-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 13, 2025 at 08:31:51AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Modify blk_rq_map_integrity_sg to use the blk-mq mapping iterator. This
> produces more efficient code and converges the integrity mapping
> implementations to reduce future maintenance burdens.
> 
> The function implementation moves from blk-integrity.c to blk-mq-dma.c
> in order to use the types and functions private to that file. 
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-integrity.c | 58 -------------------------------------------
>  block/blk-mq-dma.c    | 45 +++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 58 deletions(-)
> 
> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> index 056b8948369d5..dd97b27366e0e 100644
> --- a/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -122,64 +122,6 @@ int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
>  				   NULL);
>  }
>  
> -/**
> - * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
> - * @rq:		request to map
> - * @sglist:	target scatterlist
> - *
> - * Description: Map the integrity vectors in request into a
> - * scatterlist.  The scatterlist must be big enough to hold all
> - * elements.  I.e. sized using blk_rq_count_integrity_sg() or
> - * rq->nr_integrity_segments.
> - */
> -int blk_rq_map_integrity_sg(struct request *rq, struct scatterlist *sglist)
> -{
> -	struct bio_vec iv, ivprv = { NULL };
> -	struct request_queue *q = rq->q;
> -	struct scatterlist *sg = NULL;
> -	struct bio *bio = rq->bio;
> -	unsigned int segments = 0;
> -	struct bvec_iter iter;
> -	int prev = 0;
> -
> -	bio_for_each_integrity_vec(iv, bio, iter) {
> -		if (prev) {
> -			if (!biovec_phys_mergeable(q, &ivprv, &iv))
> -				goto new_segment;
> -			if (sg->length + iv.bv_len > queue_max_segment_size(q))
> -				goto new_segment;
> -
> -			sg->length += iv.bv_len;
> -		} else {
> -new_segment:
> -			if (!sg)
> -				sg = sglist;
> -			else {
> -				sg_unmark_end(sg);
> -				sg = sg_next(sg);
> -			}
> -
> -			sg_set_page(sg, iv.bv_page, iv.bv_len, iv.bv_offset);
> -			segments++;
> -		}
> -
> -		prev = 1;
> -		ivprv = iv;
> -	}
> -
> -	if (sg)
> -		sg_mark_end(sg);
> -
> -	/*
> -	 * Something must have been wrong if the figured number of segment
> -	 * is bigger than number of req's physical integrity segments
> -	 */
> -	BUG_ON(segments > rq->nr_integrity_segments);
> -	BUG_ON(segments > queue_max_integrity_segments(q));
> -	return segments;
> -}
> -EXPORT_SYMBOL(blk_rq_map_integrity_sg);
> -
>  int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
>  			      ssize_t bytes)
>  {
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index 60a244a129c3c..660b5e200ccf6 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -379,4 +379,49 @@ bool blk_rq_integrity_dma_map_iter_next(struct request *req,
>  	return blk_dma_map_direct(req, dma_dev, iter, &vec);
>  }
>  EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_next);
> +
> +/**
> + * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
> + * @rq:		request to map
> + * @sglist:	target scatterlist
> + *
> + * Description: Map the integrity vectors in request into a
> + * scatterlist.  The scatterlist must be big enough to hold all
> + * elements.  I.e. sized using blk_rq_count_integrity_sg() or
> + * rq->nr_integrity_segments.
> + */
> +int blk_rq_map_integrity_sg(struct request *rq, struct scatterlist *sglist)
> +{
> +	struct request_queue *q = rq->q;
> +	struct scatterlist *sg = NULL;
> +	struct bio *bio = rq->bio;
> +	unsigned int segments = 0;
> +	struct phys_vec vec;
> +
> +	struct blk_map_iter iter = {

The empty line above is a bit odd.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
