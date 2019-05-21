Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85189C04AAF
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 08:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1D221773
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 08:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfEUIFa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 04:05:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfEUIFa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 04:05:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71BB330BB546;
        Tue, 21 May 2019 08:05:30 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 955A06085B;
        Tue, 21 May 2019 08:05:25 +0000 (UTC)
Date:   Tue, 21 May 2019 16:05:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@fb.com, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 1/4] block: don't decrement nr_phys_segments for
 physically contigous segments
Message-ID: <20190521080519.GB27095@ming.t460p>
References: <20190521070143.22631-1-hch@lst.de>
 <20190521070143.22631-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521070143.22631-2-hch@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 21 May 2019 08:05:30 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 21, 2019 at 09:01:40AM +0200, Christoph Hellwig wrote:
> Currently ll_merge_requests_fn, unlike all other merge functions,
> reduces nr_phys_segments by one if the last segment of the previous,
> and the first segment of the next segement are contigous.  While this
> seems like a nice solution to avoid building smaller than possible
> requests it causes a mismatch between the segments actually present
> in the request and those iterated over by the bvec iterators, including
> __rq_for_each_bio.  This can for example mistrigger the single segment
> optimization in the nvme-pci driver, and might lead to mismatching
> nr_phys_segments number when recalculating the number of request
> when inserting a cloned request.
> 
> We could possibly work around this by making the bvec iterators take
> the front and back segment size into account, but that would require
> moving them from the bio to the bio_iter and spreading this mess
> over all users of bvecs.  Or we could simply remove this optimization
> under the assumption that most users already build good enough bvecs,
> and that the bio merge patch never cared about this optimization
> either.  The latter is what this patch does.
> 
> dff824b2aadb ("nvme-pci: optimize mapping of small single segment requests").
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-merge.c | 23 +----------------------
>  1 file changed, 1 insertion(+), 22 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 21e87a714a73..80a5a0facb87 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -358,7 +358,6 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
>  	unsigned front_seg_size;
>  	struct bio *fbio, *bbio;
>  	struct bvec_iter iter;
> -	bool new_bio = false;
>  
>  	if (!bio)
>  		return 0;
> @@ -379,31 +378,12 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
>  	nr_phys_segs = 0;
>  	for_each_bio(bio) {
>  		bio_for_each_bvec(bv, bio, iter) {
> -			if (new_bio) {
> -				if (seg_size + bv.bv_len
> -				    > queue_max_segment_size(q))
> -					goto new_segment;
> -				if (!biovec_phys_mergeable(q, &bvprv, &bv))
> -					goto new_segment;
> -
> -				seg_size += bv.bv_len;
> -
> -				if (nr_phys_segs == 1 && seg_size >
> -						front_seg_size)
> -					front_seg_size = seg_size;
> -
> -				continue;
> -			}
> -new_segment:
>  			bvec_split_segs(q, &bv, &nr_phys_segs, &seg_size,
>  					&front_seg_size, NULL, UINT_MAX);
> -			new_bio = false;
>  		}
>  		bbio = bio;
> -		if (likely(bio->bi_iter.bi_size)) {
> +		if (likely(bio->bi_iter.bi_size))
>  			bvprv = bv;
> -			new_bio = true;
> -		}
>  	}
>  
>  	fbio->bi_seg_front_size = front_seg_size;
> @@ -725,7 +705,6 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
>  			req->bio->bi_seg_front_size = seg_size;
>  		if (next->nr_phys_segments == 1)
>  			next->biotail->bi_seg_back_size = seg_size;
> -		total_phys_segments--;
>  	}
>  
>  	if (total_phys_segments > queue_max_segments(q))
> -- 
> 2.20.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
