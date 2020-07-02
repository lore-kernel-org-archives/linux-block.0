Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4109C433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 16:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA52B20720
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 16:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgGBQm3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:42:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:46800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgGBQm3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Jul 2020 12:42:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50E20ADC0;
        Thu,  2 Jul 2020 16:42:27 +0000 (UTC)
Subject: Re: [PATCH] blk-mq: release driver tag before freeing request via
 .end_io
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20200702134838.2822844-1-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <383fa210-cf08-740c-cb39-a2564a7934ea@suse.de>
Date:   Thu, 2 Jul 2020 18:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702134838.2822844-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/20 3:48 PM, Ming Lei wrote:
> The built-in flush request shares tag with the request inserted to flush
> machinery, turns out its .end_io callback has to touch the built-in
> flush request's internal tag or tag.
> 
> On the other hand, we have to make sure that driver tag is released
> from __blk_mq_end_request(), since this request may not be completed
> via blk_mq_complete_request().
> 
> Given we have moved blk_mq_put_driver_tag() out of header file, fix this
> issue by releasing driver tag before calling .end_io().
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 36a3df5a4574("blk-mq: put driver tag when this request is completed")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 46 ++++++++++++++++++++++++----------------------
>   1 file changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 948987e9b6ab..6b36969220c1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -532,6 +532,26 @@ void blk_mq_free_request(struct request *rq)
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_free_request);
>   
> +static void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
> +		struct request *rq)
> +{
> +	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
> +	rq->tag = BLK_MQ_NO_TAG;
> +
> +	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
> +		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
> +		atomic_dec(&hctx->nr_active);
> +	}
> +}
> +
> +static inline void blk_mq_put_driver_tag(struct request *rq)
> +{
> +	if (rq->tag == BLK_MQ_NO_TAG || rq->internal_tag == BLK_MQ_NO_TAG)
> +		return;
> +
> +	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
> +}
> +
>   inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
>   {
>   	u64 now = 0;
> @@ -551,6 +571,7 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
>   
>   	if (rq->end_io) {
>   		rq_qos_done(rq->q, rq);
> +		blk_mq_put_driver_tag(rq);
>   		rq->end_io(rq, error);
>   	} else {
>   		blk_mq_free_request(rq);
> @@ -660,26 +681,6 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
>   	return cpu_online(rq->mq_ctx->cpu);
>   }
>   
> -static void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
> -		struct request *rq)
> -{
> -	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
> -	rq->tag = BLK_MQ_NO_TAG;
> -
> -	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
> -		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
> -		atomic_dec(&hctx->nr_active);
> -	}
> -}
> -
> -static inline void blk_mq_put_driver_tag(struct request *rq)
> -{
> -	if (rq->tag == BLK_MQ_NO_TAG || rq->internal_tag == BLK_MQ_NO_TAG)
> -		return;
> -
> -	__blk_mq_put_driver_tag(rq->mq_hctx, rq);
> -}
> -
>   bool blk_mq_complete_request_remote(struct request *rq)
>   {
>   	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
> @@ -983,9 +984,10 @@ static bool blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
>   	if (blk_mq_req_expired(rq, next))
>   		blk_mq_rq_timed_out(rq, reserved);
>   
> -	if (is_flush_rq(rq, hctx))
> +	if (is_flush_rq(rq, hctx)) {
> +		blk_mq_put_driver_tag(rq);
>   		rq->end_io(rq, 0);
> -	else if (refcount_dec_and_test(&rq->ref))
> +	} else if (refcount_dec_and_test(&rq->ref))
>   		__blk_mq_free_request(rq);
>   
>   	return true;
> 
Hmm.
Let's hope that no-one in the ->end_io() handler will need to look at 
the tag, because that's gone now.

But if that fixes the flush machinery:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
