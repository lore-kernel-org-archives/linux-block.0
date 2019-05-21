Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527C3C04AAF
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 08:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 118C12173C
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 08:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfEUIGO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 04:06:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfEUIGO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 04:06:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 84CCE30842A8;
        Tue, 21 May 2019 08:06:13 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65C5F5D9C8;
        Tue, 21 May 2019 08:06:08 +0000 (UTC)
Date:   Tue, 21 May 2019 16:06:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@fb.com, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 4/4] block: remove the bi_seg_{front,back}_size fields in
 struct bio
Message-ID: <20190521080603.GC27095@ming.t460p>
References: <20190521070143.22631-1-hch@lst.de>
 <20190521070143.22631-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521070143.22631-5-hch@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 21 May 2019 08:06:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 21, 2019 at 09:01:43AM +0200, Christoph Hellwig wrote:
> At this point these fields aren't used for anything, so we can remove
> them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-merge.c         | 94 +++++----------------------------------
>  include/linux/blk_types.h |  7 ---
>  2 files changed, 12 insertions(+), 89 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index eee2c02c50ce..17713d7d98d5 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -162,8 +162,7 @@ static unsigned get_max_segment_size(struct request_queue *q,
>   * variables.
>   */
>  static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
> -		unsigned *nsegs, unsigned *last_seg_size,
> -		unsigned *front_seg_size, unsigned *sectors, unsigned max_segs)
> +		unsigned *nsegs, unsigned *sectors, unsigned max_segs)
>  {
>  	unsigned len = bv->bv_len;
>  	unsigned total_len = 0;
> @@ -185,28 +184,12 @@ static bool bvec_split_segs(struct request_queue *q, struct bio_vec *bv,
>  			break;
>  	}
>  
> -	if (!new_nsegs)
> -		return !!len;
> -
> -	/* update front segment size */
> -	if (!*nsegs) {
> -		unsigned first_seg_size;
> -
> -		if (new_nsegs == 1)
> -			first_seg_size = get_max_segment_size(q, bv->bv_offset);
> -		else
> -			first_seg_size = queue_max_segment_size(q);
> -
> -		if (*front_seg_size < first_seg_size)
> -			*front_seg_size = first_seg_size;
> +	if (new_nsegs) {
> +		*nsegs += new_nsegs;
> +		if (sectors)
> +			*sectors += total_len >> 9;
>  	}
>  
> -	/* update other varibles */
> -	*last_seg_size = seg_size;
> -	*nsegs += new_nsegs;
> -	if (sectors)
> -		*sectors += total_len >> 9;
> -
>  	/* split in the middle of the bvec if len != 0 */
>  	return !!len;
>  }
> @@ -218,8 +201,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  {
>  	struct bio_vec bv, bvprv, *bvprvp = NULL;
>  	struct bvec_iter iter;
> -	unsigned seg_size = 0, nsegs = 0, sectors = 0;
> -	unsigned front_seg_size = bio->bi_seg_front_size;
> +	unsigned nsegs = 0, sectors = 0;
>  	bool do_split = true;
>  	struct bio *new = NULL;
>  	const unsigned max_sectors = get_max_io_size(q, bio);
> @@ -243,8 +225,6 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  				/* split in the middle of bvec */
>  				bv.bv_len = (max_sectors - sectors) << 9;
>  				bvec_split_segs(q, &bv, &nsegs,
> -						&seg_size,
> -						&front_seg_size,
>  						&sectors, max_segs);
>  			}
>  			goto split;
> @@ -258,12 +238,9 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  
>  		if (bv.bv_offset + bv.bv_len <= PAGE_SIZE) {
>  			nsegs++;
> -			seg_size = bv.bv_len;
>  			sectors += bv.bv_len >> 9;
> -			if (nsegs == 1 && seg_size > front_seg_size)
> -				front_seg_size = seg_size;
> -		} else if (bvec_split_segs(q, &bv, &nsegs, &seg_size,
> -				    &front_seg_size, &sectors, max_segs)) {
> +		} else if (bvec_split_segs(q, &bv, &nsegs, &sectors,
> +				max_segs)) {
>  			goto split;
>  		}
>  	}
> @@ -278,10 +255,6 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  			bio = new;
>  	}
>  
> -	bio->bi_seg_front_size = front_seg_size;
> -	if (seg_size > bio->bi_seg_back_size)
> -		bio->bi_seg_back_size = seg_size;
> -
>  	return do_split ? new : NULL;
>  }
>  
> @@ -336,17 +309,13 @@ EXPORT_SYMBOL(blk_queue_split);
>  static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
>  					     struct bio *bio)
>  {
> -	struct bio_vec uninitialized_var(bv), bvprv = { NULL };
> -	unsigned int seg_size, nr_phys_segs;
> -	unsigned front_seg_size;
> -	struct bio *fbio, *bbio;
> +	unsigned int nr_phys_segs = 0;
>  	struct bvec_iter iter;
> +	struct bio_vec bv;
>  
>  	if (!bio)
>  		return 0;
>  
> -	front_seg_size = bio->bi_seg_front_size;
> -
>  	switch (bio_op(bio)) {
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_SECURE_ERASE:
> @@ -356,23 +325,11 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
>  		return 1;
>  	}
>  
> -	fbio = bio;
> -	seg_size = 0;
> -	nr_phys_segs = 0;
>  	for_each_bio(bio) {
> -		bio_for_each_bvec(bv, bio, iter) {
> -			bvec_split_segs(q, &bv, &nr_phys_segs, &seg_size,
> -					&front_seg_size, NULL, UINT_MAX);
> -		}
> -		bbio = bio;
> -		if (likely(bio->bi_iter.bi_size))
> -			bvprv = bv;
> +		bio_for_each_bvec(bv, bio, iter)
> +			bvec_split_segs(q, &bv, &nr_phys_segs, NULL, UINT_MAX);
>  	}
>  
> -	fbio->bi_seg_front_size = front_seg_size;
> -	if (seg_size > bbio->bi_seg_back_size)
> -		bbio->bi_seg_back_size = seg_size;
> -
>  	return nr_phys_segs;
>  }
>  
> @@ -392,24 +349,6 @@ void blk_recount_segments(struct request_queue *q, struct bio *bio)
>  	bio_set_flag(bio, BIO_SEG_VALID);
>  }
>  
> -static int blk_phys_contig_segment(struct request_queue *q, struct bio *bio,
> -				   struct bio *nxt)
> -{
> -	struct bio_vec end_bv = { NULL }, nxt_bv;
> -
> -	if (bio->bi_seg_back_size + nxt->bi_seg_front_size >
> -	    queue_max_segment_size(q))
> -		return 0;
> -
> -	if (!bio_has_data(bio))
> -		return 1;
> -
> -	bio_get_last_bvec(bio, &end_bv);
> -	bio_get_first_bvec(nxt, &nxt_bv);
> -
> -	return biovec_phys_mergeable(q, &end_bv, &nxt_bv);
> -}
> -
>  static inline struct scatterlist *blk_next_sg(struct scatterlist **sg,
>  		struct scatterlist *sglist)
>  {
> @@ -669,8 +608,6 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
>  				struct request *next)
>  {
>  	int total_phys_segments;
> -	unsigned int seg_size =
> -		req->biotail->bi_seg_back_size + next->bio->bi_seg_front_size;
>  
>  	if (req_gap_back_merge(req, next->bio))
>  		return 0;
> @@ -683,13 +620,6 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
>  		return 0;
>  
>  	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
> -	if (blk_phys_contig_segment(q, req->biotail, next->bio)) {
> -		if (req->nr_phys_segments == 1)
> -			req->bio->bi_seg_front_size = seg_size;
> -		if (next->nr_phys_segments == 1)
> -			next->biotail->bi_seg_back_size = seg_size;
> -	}
> -
>  	if (total_phys_segments > queue_max_segments(q))
>  		return 0;
>  
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index be418275763c..95202f80676c 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -159,13 +159,6 @@ struct bio {
>  	 */
>  	unsigned int		bi_phys_segments;
>  
> -	/*
> -	 * To keep track of the max segment size, we account for the
> -	 * sizes of the first and last mergeable segments in this bio.
> -	 */
> -	unsigned int		bi_seg_front_size;
> -	unsigned int		bi_seg_back_size;
> -
>  	struct bvec_iter	bi_iter;
>  
>  	atomic_t		__bi_remaining;
> -- 
> 2.20.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
