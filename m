Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFC3C5B57D
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 02:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679BF21721
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 02:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfGCCrO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:47:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbfGCCrN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jul 2019 22:47:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 758C7C0495A6;
        Wed,  3 Jul 2019 02:47:13 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8692185A20;
        Wed,  3 Jul 2019 02:46:56 +0000 (UTC)
Date:   Wed, 3 Jul 2019 10:46:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 2/2] blk-mq: Simplify blk_mq_make_request()
Message-ID: <20190703024640.GB30102@ming.t460p>
References: <20190701154730.203795-1-bvanassche@acm.org>
 <20190701154730.203795-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701154730.203795-3-bvanassche@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 03 Jul 2019 02:47:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 01, 2019 at 08:47:30AM -0700, Bart Van Assche wrote:
> Move the blk_mq_bio_to_request() call in front of the if-statement.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4d661545ad1d..0fa03f524541 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1975,10 +1975,10 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  
>  	cookie = request_to_qc_t(data.hctx, rq);
>  
> +	blk_mq_bio_to_request(rq, bio, nr_segs);
> +
>  	plug = current->plug;
>  	if (unlikely(is_flush_fua)) {
> -		blk_mq_bio_to_request(rq, bio, nr_segs);
> -
>  		/* bypass scheduler for flush rq */
>  		blk_insert_flush(rq);
>  		blk_mq_run_hw_queue(data.hctx, true);
> @@ -1990,8 +1990,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  		unsigned int request_count = plug->rq_count;
>  		struct request *last = NULL;
>  
> -		blk_mq_bio_to_request(rq, bio, nr_segs);
> -
>  		if (!request_count)
>  			trace_block_plug(q);
>  		else
> @@ -2005,8 +2003,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  
>  		blk_add_rq_to_plug(plug, rq);
>  	} else if (plug && !blk_queue_nomerges(q)) {
> -		blk_mq_bio_to_request(rq, bio, nr_segs);
> -
>  		/*
>  		 * We do limited plugging. If the bio can be merged, do that.
>  		 * Otherwise the existing request in the plug list will be
> @@ -2031,10 +2027,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>  		}
>  	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
>  			!data.hctx->dispatch_busy)) {
> -		blk_mq_bio_to_request(rq, bio, nr_segs);
>  		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
>  	} else {
> -		blk_mq_bio_to_request(rq, bio, nr_segs);
>  		blk_mq_sched_insert_request(rq, false, true, true);
>  	}
>  
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming
