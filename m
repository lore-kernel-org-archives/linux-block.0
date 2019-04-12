Return-Path: <SRS0=iV0P=SO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A94EC10F0E
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 10:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB512084D
	for <linux-block@archiver.kernel.org>; Fri, 12 Apr 2019 10:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDLKzO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:55:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:50014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbfDLKzO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Apr 2019 06:55:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36772AC44;
        Fri, 12 Apr 2019 10:55:12 +0000 (UTC)
Subject: Re: [PATCH V5 1/9] blk-mq: grab .q_usage_counter when queuing request
 from plug code path
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
References: <20190412033032.10418-1-ming.lei@redhat.com>
 <20190412033032.10418-2-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e6050974-08a9-eb60-88ac-a52c9c05dc66@suse.de>
Date:   Fri, 12 Apr 2019 12:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412033032.10418-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/19 5:30 AM, Ming Lei wrote:
> Just like aio/io_uring, we need to grab 2 refcount for queuing one
> request, one is for submission, another is for completion.
> 
> If the request isn't queued from plug code path, the refcount grabbed
> in generic_make_request() serves for submission. In theroy, this
> refcount should have been released after the sumission(async run queue)
> is done. blk_freeze_queue() works with blk_sync_queue() together
> for avoiding race between cleanup queue and IO submission, given async
> run queue activities are canceled because hctx->run_work is scheduled with
> the refcount held, so it is fine to not hold the refcount when
> running the run queue work function for dispatch IO.
> 
> However, if request is staggered into plug list, and finally queued
> from plug code path, the refcount in submission side is actually missed.
> And we may start to run queue after queue is removed because the queue's
> kobject refcount isn't guaranteed to be grabbed in flushing plug list
> context, then kernel oops is triggered, see the following race:
> 
> blk_mq_flush_plug_list():
>          blk_mq_sched_insert_requests()
>                  insert requests to sw queue or scheduler queue
>                  blk_mq_run_hw_queue
> 
> Because of concurrent run queue, all requests inserted above may be
> completed before calling the above blk_mq_run_hw_queue. Then queue can
> be freed during the above blk_mq_run_hw_queue().
> 
> Fixes the issue by grab .q_usage_counter before calling
> blk_mq_sched_insert_requests() in blk_mq_flush_plug_list(). This way is
> safe because the queue is absolutely alive before inserting request.
> 
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: linux-scsi@vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> Cc: jianchao wang <jianchao.w.wang@oracle.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3ff3d7b49969..5b586affee09 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1728,9 +1728,12 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>   		if (rq->mq_hctx != this_hctx || rq->mq_ctx != this_ctx) {
>   			if (this_hctx) {
>   				trace_block_unplug(this_q, depth, !from_schedule);
> +
> +				percpu_ref_get(&this_q->q_usage_counter);
>   				blk_mq_sched_insert_requests(this_hctx, this_ctx,
>   								&rq_list,
>   								from_schedule);
> +				percpu_ref_put(&this_q->q_usage_counter);
>   			}
>   
>   			this_q = rq->q;
> @@ -1749,8 +1752,11 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>   	 */
>   	if (this_hctx) {
>   		trace_block_unplug(this_q, depth, !from_schedule);
> +
> +		percpu_ref_get(&this_q->q_usage_counter);
>   		blk_mq_sched_insert_requests(this_hctx, this_ctx, &rq_list,
>   						from_schedule);
> +		percpu_ref_put(&this_q->q_usage_counter);
>   	}
>   }
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
