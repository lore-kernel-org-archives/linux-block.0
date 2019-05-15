Return-Path: <SRS0=Ir13=TP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7ACC04E53
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 08:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FF420881
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 08:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfEOIfK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 May 2019 04:35:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfEOIfJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 May 2019 04:35:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 725803082129;
        Wed, 15 May 2019 08:35:09 +0000 (UTC)
Received: from ming.t460p (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 693905C1A3;
        Wed, 15 May 2019 08:35:04 +0000 (UTC)
Date:   Wed, 15 May 2019 16:34:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@fb.com, Matias Bjorling <mb@lightnvm.io>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 03/10] block: remove the segment size check in
 bio_will_gap
Message-ID: <20190515083455.GC23052@ming.t460p>
References: <20190513063754.1520-1-hch@lst.de>
 <20190513063754.1520-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513063754.1520-4-hch@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 15 May 2019 08:35:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 13, 2019 at 08:37:47AM +0200, Christoph Hellwig wrote:
> We fundamentally do not have a maximum segement size for devices with a
> virt boundary.  So don't bother checking it, especially given that the
> existing checks didn't properly work to start with as we never update
> bi_seg_back_size after a successful merge, and for front merges would

.bi_seg_back_size is only needed to update in case of single segment
request.

However, ll_new_hw_segment() does not merge segment, so the existing
check works fine.

> have had to check bi_seg_front_size anyway.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-merge.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 80a5a0facb87..eee2c02c50ce 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -12,23 +12,6 @@
>  
>  #include "blk.h"
>  
> -/*
> - * Check if the two bvecs from two bios can be merged to one segment.  If yes,
> - * no need to check gap between the two bios since the 1st bio and the 1st bvec
> - * in the 2nd bio can be handled in one segment.
> - */
> -static inline bool bios_segs_mergeable(struct request_queue *q,
> -		struct bio *prev, struct bio_vec *prev_last_bv,
> -		struct bio_vec *next_first_bv)
> -{
> -	if (!biovec_phys_mergeable(q, prev_last_bv, next_first_bv))
> -		return false;
> -	if (prev->bi_seg_back_size + next_first_bv->bv_len >
> -			queue_max_segment_size(q))
> -		return false;
> -	return true;
> -}
> -
>  static inline bool bio_will_gap(struct request_queue *q,
>  		struct request *prev_rq, struct bio *prev, struct bio *next)
>  {
> @@ -60,7 +43,7 @@ static inline bool bio_will_gap(struct request_queue *q,
>  	 */
>  	bio_get_last_bvec(prev, &pb);
>  	bio_get_first_bvec(next, &nb);
> -	if (bios_segs_mergeable(q, prev, &pb, &nb))
> +	if (biovec_phys_mergeable(q, &pb, &nb))
>  		return false;
>  	return __bvec_gap_to_prev(q, &pb, nb.bv_offset);
>  }
> -- 
> 2.20.1
> 

The patch itself is good, if the commit log is fixed:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming
