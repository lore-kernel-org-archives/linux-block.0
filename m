Return-Path: <SRS0=IEWf=S7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C255AC43219
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 06:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6742075E
	for <linux-block@archiver.kernel.org>; Mon, 29 Apr 2019 06:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfD2GFf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:05:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:47356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727016AbfD2GFe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Apr 2019 02:05:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BA09CABD5;
        Mon, 29 Apr 2019 06:05:31 +0000 (UTC)
Subject: Re: [PATCH V8 4/7] blk-mq: split blk_mq_alloc_and_init_hctx into two
 parts
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
References: <20190428081408.27331-1-ming.lei@redhat.com>
 <20190428081408.27331-5-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <24ecd123-5707-9b70-d284-b3228951813f@suse.de>
Date:   Mon, 29 Apr 2019 08:05:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428081408.27331-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/28/19 10:14 AM, Ming Lei wrote:
> Split blk_mq_alloc_and_init_hctx into two parts, and one is
> blk_mq_alloc_hctx() for allocating all hctx resources, another
> is blk_mq_init_hctx() for initializing hctx, which serves as
> counter-part of blk_mq_exit_hctx().
> 
> Cc: Dongli Zhang <dongli.zhang@oracle.com>
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: linux-scsi@vger.kernel.org,
> Cc: Martin K . Petersen <martin.petersen@oracle.com>,
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: James E . J . Bottomley <jejb@linux.vnet.ibm.com>,
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Tested-by: James Smart <james.smart@broadcom.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 138 ++++++++++++++++++++++++++++++++-------------------------
>   1 file changed, 77 insertions(+), 61 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d98cb9614dfa..44ecca6b0cac 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2284,15 +2284,70 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
>   	}
>   }
>   
> +static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
> +{
> +	int hw_ctx_size = sizeof(struct blk_mq_hw_ctx);
> +
> +	BUILD_BUG_ON(ALIGN(offsetof(struct blk_mq_hw_ctx, srcu),
> +			   __alignof__(struct blk_mq_hw_ctx)) !=
> +		     sizeof(struct blk_mq_hw_ctx));
> +
> +	if (tag_set->flags & BLK_MQ_F_BLOCKING)
> +		hw_ctx_size += sizeof(struct srcu_struct);
> +
> +	return hw_ctx_size;
> +}
> +
>   static int blk_mq_init_hctx(struct request_queue *q,
>   		struct blk_mq_tag_set *set,
>   		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
>   {
> -	int node;
> +	hctx->queue_num = hctx_idx;
>   
> -	node = hctx->numa_node;
> +	cpuhp_state_add_instance_nocalls(CPUHP_BLK_MQ_DEAD, &hctx->cpuhp_dead);
> +
> +	hctx->tags = set->tags[hctx_idx];
> +
> +	if (set->ops->init_hctx &&
> +	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
> +		goto unregister_cpu_notifier;
> +
> +	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx,
> +				hctx->numa_node))
> +		goto exit_hctx;
> +	return 0;
> +
> + exit_hctx:
> +	if (set->ops->exit_hctx)
> +		set->ops->exit_hctx(hctx, hctx_idx);
> + unregister_cpu_notifier:
> +	blk_mq_remove_cpuhp(hctx);
> +	return -1;
> +}
> +
> +static struct blk_mq_hw_ctx *
> +blk_mq_alloc_hctx(struct request_queue *q,
> +		struct blk_mq_tag_set *set,
> +		unsigned hctx_idx, int node)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +
> +	hctx = kzalloc_node(blk_mq_hw_ctx_size(set),
> +			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
> +			node);
> +	if (!hctx)
> +		goto fail_alloc_hctx;
> +
> +	if (!zalloc_cpumask_var_node(&hctx->cpumask,
> +				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
> +				node))
> +		goto free_hctx;
> +
> +	atomic_set(&hctx->nr_active, 0);
> +	hctx->numa_node = node;
>   	if (node == NUMA_NO_NODE)
> -		node = hctx->numa_node = set->numa_node;
> +		hctx->numa_node = set->numa_node;
> +	node = hctx->numa_node;
>   
>   	INIT_DELAYED_WORK(&hctx->run_work, blk_mq_run_work_fn);
>   	spin_lock_init(&hctx->lock);
The 'hctx_idx' argument is now unused, and should be removed from the 
function definition.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
