Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E63C10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 11:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49632089F
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 11:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfDXLPS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:15:18 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:43736 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDXLPS (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Wed, 24 Apr 2019 07:15:18 -0400
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 24 Apr 2019 13:15:16 +0200
Subject: Re: [PATCH V7 6/9] blk-mq: always free hctx after request queue is
 freed
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
References: <20190424110221.17435-1-ming.lei@redhat.com>
 <20190424110221.17435-7-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <eb76b2b7-dc20-f600-357f-610827188b86@suse.com>
Date:   Wed, 24 Apr 2019 13:15:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424110221.17435-7-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/19 1:02 PM, Ming Lei wrote:
> In normal queue cleanup path, hctx is released after request queue
> is freed, see blk_mq_release().
> 
> However, in __blk_mq_update_nr_hw_queues(), hctx may be freed because
> of hw queues shrinking. This way is easy to cause use-after-free,
> because: one implicit rule is that it is safe to call almost all block
> layer APIs if the request queue is alive; and one hctx may be retrieved
> by one API, then the hctx can be freed by blk_mq_update_nr_hw_queues();
> finally use-after-free is triggered.
> 
> Fixes this issue by always freeing hctx after releasing request queue.
> If some hctxs are removed in blk_mq_update_nr_hw_queues(), introduce
> a per-queue list to hold them, then try to resuse these hctxs if numa
> node is matched.
> 
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: linux-scsi@vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> Tested-by: James Smart <james.smart@broadcom.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c         | 46 +++++++++++++++++++++++++++++++++-------------
>   include/linux/blk-mq.h |  2 ++
>   include/linux/blkdev.h |  7 +++++++
>   3 files changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1eceeb26ae7d..b9d711d12cae 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2274,6 +2274,10 @@ static void blk_mq_exit_hctx(struct request_queue *q,
>   		set->ops->exit_hctx(hctx, hctx_idx);
>   
>   	blk_mq_remove_cpuhp(hctx);
> +
> +	spin_lock(&q->unused_hctx_lock);
> +	list_add(&hctx->hctx_list, &q->unused_hctx_list);
> +	spin_unlock(&q->unused_hctx_lock);
>   }
>   
>   static void blk_mq_exit_hw_queues(struct request_queue *q,
> @@ -2362,6 +2366,8 @@ blk_mq_alloc_hctx(struct request_queue *q,
>   	hctx->queue = q;
>   	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
>   
> +	INIT_LIST_HEAD(&hctx->hctx_list);
> +
>   	/*
>   	 * Allocate space for all possible cpus to avoid allocation at
>   	 * runtime
> @@ -2675,15 +2681,17 @@ static int blk_mq_alloc_ctxs(struct request_queue *q)
>    */
>   void blk_mq_release(struct request_queue *q)
>   {
> -	struct blk_mq_hw_ctx *hctx;
> -	unsigned int i;
> +	struct blk_mq_hw_ctx *hctx, *next;
> +	int i;
>   
>   	cancel_delayed_work_sync(&q->requeue_work);
>   
> -	/* hctx kobj stays in hctx */
> -	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (!hctx)
> -			continue;
> +	queue_for_each_hw_ctx(q, hctx, i)
> +		WARN_ON_ONCE(hctx && list_empty(&hctx->hctx_list));
> +
> +	/* all hctx are in .unused_hctx_list now */
> +	list_for_each_entry_safe(hctx, next, &q->unused_hctx_list, hctx_list) {
> +		list_del_init(&hctx->hctx_list);
>   		kobject_put(&hctx->kobj);
>   	}
>   
I would consider it a bug if the hctx is still assigned to 
->queue_hw_ctx at this point.
But that's a minor issue.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
