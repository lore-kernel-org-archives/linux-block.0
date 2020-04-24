Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49A4C54FCB
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 13:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3BF20776
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 13:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgDXNrb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:47:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:56964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbgDXNrb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 09:47:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4CC1CAD4B;
        Fri, 24 Apr 2020 13:47:29 +0000 (UTC)
Subject: Re: [PATCH V8 08/11] block: add blk_end_flush_machinery
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-9-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <390e713c-8289-ba35-4e4a-86f0d1ba0cf4@suse.de>
Date:   Fri, 24 Apr 2020 15:47:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424102351.475641-9-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/20 12:23 PM, Ming Lei wrote:
> Flush requests aren't same with normal FS request:
> 
> 1) one dedicated per-hctx flush rq is pre-allocated for sending flush request
> 
> 2) flush request si issued to hardware via one machinary so that flush merge
> can be applied
> 
> We can't simply re-submit flush rqs via blk_steal_bios(), so add
> blk_end_flush_machinery to collect flush requests which needs to
> be resubmitted:
> 
> - if one flush command without DATA is enough, send one flush, complete this
> kind of requests
> 
> - otherwise, add the request into a list and let caller re-submit it.
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-flush.c | 123 +++++++++++++++++++++++++++++++++++++++++++---
>   block/blk.h       |   4 ++
>   2 files changed, 120 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 977edf95d711..745d878697ed 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -170,10 +170,11 @@ static void blk_flush_complete_seq(struct request *rq,
>   	unsigned int cmd_flags;
>   
>   	BUG_ON(rq->flush.seq & seq);
> -	rq->flush.seq |= seq;
> +	if (!error)
> +		rq->flush.seq |= seq;
>   	cmd_flags = rq->cmd_flags;
>   
> -	if (likely(!error))
> +	if (likely(!error && !fq->flush_queue_terminating))
>   		seq = blk_flush_cur_seq(rq);
>   	else
>   		seq = REQ_FSEQ_DONE;
> @@ -200,9 +201,15 @@ static void blk_flush_complete_seq(struct request *rq,
>   		 * normal completion and end it.
>   		 */
>   		BUG_ON(!list_empty(&rq->queuelist));
> -		list_del_init(&rq->flush.list);
> -		blk_flush_restore_request(rq);
> -		blk_mq_end_request(rq, error);
> +
> +		/* Terminating code will end the request from flush queue */
> +		if (likely(!fq->flush_queue_terminating)) {
> +			list_del_init(&rq->flush.list);
> +			blk_flush_restore_request(rq);
> +			blk_mq_end_request(rq, error);
> +		} else {
> +			list_move_tail(&rq->flush.list, pending);
> +		}
>   		break;
>   
>   	default:
> @@ -279,7 +286,8 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
>   	struct request *flush_rq = fq->flush_rq;
>   
>   	/* C1 described at the top of this file */
> -	if (fq->flush_pending_idx != fq->flush_running_idx || list_empty(pending))
> +	if (fq->flush_pending_idx != fq->flush_running_idx ||
> +			list_empty(pending) || fq->flush_queue_terminating)
>   		return;
>   
>   	/* C2 and C3
> @@ -331,7 +339,7 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
>   	struct blk_flush_queue *fq = blk_get_flush_queue(q, ctx);
>   
>   	if (q->elevator) {
> -		WARN_ON(rq->tag < 0);
> +		WARN_ON(rq->tag < 0 && !fq->flush_queue_terminating);
>   		blk_mq_put_driver_tag(rq);
>   	}
>   
> @@ -503,3 +511,104 @@ void blk_free_flush_queue(struct blk_flush_queue *fq)
>   	kfree(fq->flush_rq);
>   	kfree(fq);
>   }
> +
> +static void __blk_end_queued_flush(struct blk_flush_queue *fq,
> +		unsigned int queue_idx, struct list_head *resubmit_list,
> +		struct list_head *flush_list)
> +{
> +	struct list_head *queue = &fq->flush_queue[queue_idx];
> +	struct request *rq, *nxt;
> +
> +	list_for_each_entry_safe(rq, nxt, queue, flush.list) {
> +		unsigned int seq = blk_flush_cur_seq(rq);
> +
> +		list_del_init(&rq->flush.list);
> +		blk_flush_restore_request(rq);
> +		if (!blk_rq_sectors(rq) || seq == REQ_FSEQ_POSTFLUSH )
> +			list_add_tail(&rq->queuelist, flush_list);
> +		else
> +			list_add_tail(&rq->queuelist, resubmit_list);
> +	}
> +}
> +
> +static void blk_end_queued_flush(struct blk_flush_queue *fq,
> +		struct list_head *resubmit_list, struct list_head *flush_list)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fq->mq_flush_lock, flags);
> +	__blk_end_queued_flush(fq, 0, resubmit_list, flush_list);
> +	__blk_end_queued_flush(fq, 1, resubmit_list, flush_list);
> +	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
> +}
> +
> +/* complete requests which just requires one flush command */
> +static void blk_complete_flush_requests(struct blk_flush_queue *fq,
> +		struct list_head *flush_list)
> +{
> +	struct block_device *bdev;
> +	struct request *rq;
> +	int error = -ENXIO;
> +
> +	if (list_empty(flush_list))
> +		return;
> +
> +	rq = list_first_entry(flush_list, struct request, queuelist);
> +
> +	/* Send flush via one active hctx so we can move on */
> +	bdev = bdget_disk(rq->rq_disk, 0);
> +	if (bdev) {
> +		error = blkdev_issue_flush(bdev, GFP_KERNEL, NULL);
> +		bdput(bdev);
> +	}
> +
> +	while (!list_empty(flush_list)) {
> +		rq = list_first_entry(flush_list, struct request, queuelist);
> +		list_del_init(&rq->queuelist);
> +		blk_mq_end_request(rq, error);
> +	}
> +}
> +
I must admit I'm getting nervous if one mixes direct request 
manipulations with high-level 'blkdev_XXX' calls.
Can't we just requeue everything including the flush itself, and letting 
the requeue algorithm pick a new hctx?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
