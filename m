Return-Path: <SRS0=4UPx=RO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156D7C43381
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 14:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D739A20657
	for <linux-block@archiver.kernel.org>; Mon, 11 Mar 2019 14:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfCKOka (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:40:30 -0400
Received: from verein.lst.de ([213.95.11.211]:41869 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfCKOka (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 10:40:30 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3120468C7B; Mon, 11 Mar 2019 15:40:24 +0100 (CET)
Date:   Mon, 11 Mar 2019 15:40:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/6] block: don't check if adjacent bvecs in one bio
 can be mergeable
Message-ID: <20190311144024.GF7850@lst.de>
References: <20190309013737.27741-1-ming.lei@redhat.com> <20190309013737.27741-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309013737.27741-7-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	bool new_bio;
>  
>  	if (!bio)
>  		return 0;
> @@ -377,9 +377,10 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
>  	fbio = bio;
>  	seg_size = 0;
>  	nr_phys_segs = 0;
> +	new_bio = false;

I'd just initialize it to false in the declaration line.

> +/* only try to merge bvecs into one sg if they are from two bios */
> +static inline bool
> +__blk_segment_map_sg_merge(struct request_queue *q, struct bio_vec *bvec,
> +			   struct bio_vec *bvprv, struct scatterlist **sg)
>  {
>  	int nbytes = bvec->bv_len;
>  
> +	if (!*sg)
> +		return false;
>  
> +	if ((*sg)->length + nbytes > queue_max_segment_size(q))
> +		return false;
> +
> +	if (!biovec_phys_mergeable(q, bvprv, bvec))
> +		return false;
> +
> +	(*sg)->length += nbytes;
> +
> +	return true;
> +}
> +
> +static inline void
> +__blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
> +		     struct scatterlist *sglist, struct scatterlist **sg,
> +		     int *nsegs)
> +{
> +	if (bvec->bv_offset + bvec->bv_len <= PAGE_SIZE) {
> +		*sg = blk_next_sg(sg, sglist);
> +		sg_set_page(*sg, bvec->bv_page, bvec->bv_len, bvec->bv_offset);
> +		(*nsegs) += 1;

This branch is basically the same as __blk_bvec_map_sg, I wonder if
we can reuse it.

> +	} else
> +		(*nsegs) += blk_bvec_map_sg(q, bvec, sglist, sg);
>  }

And then maybe just kill off __blk_segment_map_sg entirely by moving
the if else into the caller.

> @@ -535,11 +543,24 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
>  	struct bio_vec bvec, bvprv = { NULL };
>  	struct bvec_iter iter;
>  	int nsegs = 0;
> +	bool new_bio = false;
>  
> +	for_each_bio(bio) {
> +		bio_for_each_bvec(bvec, bio, iter) {
> +			/*
> +			 * Only try to merge bvecs from two bios given we
> +			 * have done bio internal merge when adding pages
> +			 * to bio
> +			 */
> +			if (!new_bio || !__blk_segment_map_sg_merge(q,
> +						&bvec, &bvprv, sg))

Somewhat hard to read.  Why not:

			if (new_bio ||
			    !__blk_segment_map_sg_merge(q, &bvec, &bvprv, sg))

That being said I'd really like to see some stats on workloads that
actually trigger cross-bio segment merges.  If we get a lot of those
we are doing something wrong.
