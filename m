Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D425C54FCB
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 13:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C3320776
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 13:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgDXNzk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:55:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:59818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgDXNzk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 09:55:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E2860AB3D;
        Fri, 24 Apr 2020 13:55:36 +0000 (UTC)
Subject: Re: [PATCH V8 10/11] blk-mq: re-submit IO in case that hctx is
 inactive
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-11-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1bba5ed8-21db-751b-e638-4b287db14cd0@suse.de>
Date:   Fri, 24 Apr 2020 15:55:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424102351.475641-11-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/20 12:23 PM, Ming Lei wrote:
> When all CPUs in one hctx are offline and this hctx becomes inactive, we
> shouldn't run this hw queue for completing request any more.
> 
> So allocate request from one live hctx, and clone & resubmit the request,
> either it is from sw queue or scheduler queue.
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 98 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0759e0d606b3..a4a26bb23533 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2370,6 +2370,98 @@ static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
>   	return 0;
>   }
>   
> +static void blk_mq_resubmit_end_rq(struct request *rq, blk_status_t error)
> +{
> +	struct request *orig_rq = rq->end_io_data;
> +
> +	blk_mq_cleanup_rq(orig_rq);
> +	blk_mq_end_request(orig_rq, error);
> +
> +	blk_put_request(rq);
> +}
> +
> +static void blk_mq_resubmit_rq(struct request *rq)
> +{
> +	struct request *nrq;
> +	unsigned int flags = 0;
> +	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> +	struct blk_mq_tags *tags = rq->q->elevator ? hctx->sched_tags :
> +		hctx->tags;
> +	bool reserved = blk_mq_tag_is_reserved(tags, rq->internal_tag);
> +
> +	if (rq->rq_flags & RQF_PREEMPT)
> +		flags |= BLK_MQ_REQ_PREEMPT;
> +	if (reserved)
> +		flags |= BLK_MQ_REQ_RESERVED;
> +
> +	/* avoid allocation failure by clearing NOWAIT */
> +	nrq = blk_get_request(rq->q, rq->cmd_flags & ~REQ_NOWAIT, flags);
> +	if (!nrq)
> +		return;
> +

Ah-ha. So what happens if we don't get a request here?

> +	blk_rq_copy_request(nrq, rq);
> +
> +	nrq->timeout = rq->timeout;
> +	nrq->rq_disk = rq->rq_disk;
> +	nrq->part = rq->part;
> +
> +	memcpy(blk_mq_rq_to_pdu(nrq), blk_mq_rq_to_pdu(rq),
> +			rq->q->tag_set->cmd_size);
> +
> +	nrq->end_io = blk_mq_resubmit_end_rq;
> +	nrq->end_io_data = rq;
> +	nrq->bio = rq->bio;
> +	nrq->biotail = rq->biotail;
> +
> +	if (blk_insert_cloned_request(nrq->q, nrq) != BLK_STS_OK)
> +		blk_mq_request_bypass_insert(nrq, false, true);
> +}
> +

Not sure if that is a good idea.
With the above code we would having to allocate an additional
tag per request; if we're running full throttle with all tags active 
where should they be coming from?

And all the while we _have_ perfectly valid tags; the tag of the 
original request _is_ perfectly valid, and we have made sure that it's 
not inflight (because if it were we would have to wait for to be 
completed by the hardware anyway).

So why can't we re-use the existing tag here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
