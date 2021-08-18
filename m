Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CB3C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 09:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0581960FBF
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 09:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhHRJkO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:40:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3658 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbhHRJix (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 05:38:53 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GqN915Tx3z6BHJ8;
        Wed, 18 Aug 2021 17:37:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 18 Aug 2021 11:38:17 +0200
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 18 Aug 2021 10:38:16 +0100
Subject: Re: [PATCH V6 3/3] blk-mq: don't deactivate hctx if managed irq isn't
 used
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Christoph Hellwig" <hch@lst.de>, <linux-block@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>
References: <20210722095246.1240526-1-ming.lei@redhat.com>
 <20210722095246.1240526-4-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <23acd521-dac3-068d-b82a-424c078e0ac0@huawei.com>
Date:   Wed, 18 Aug 2021 10:38:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210722095246.1240526-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/07/2021 10:52, Ming Lei wrote:
> blk-mq deactivates one hctx when the last CPU in hctx->cpumask become
> offline by draining all requests originated from this hctx and moving new
> allocation to other active hctx. This way is for avoiding inflight IO in
> case of managed irq because managed irq is shutdown when the last CPU in
> the irq's affinity becomes offline.
> 
> However, lots of drivers(nvme fc, rdma, tcp, loop, ...) don't use managed
> irq, so they needn't to deactivate hctx when the last CPU becomes offline.
> Also, some of them are the only user of blk_mq_alloc_request_hctx() which
> is used for connecting io queue. And their requirement is that the connect
> request needs to be submitted successfully via one specified hctx even though
> all CPUs in this hctx->cpumask have become offline.
> 
> Addressing the requirement for nvme fc/rdma/loop by allowing to
> allocate request from one hctx when all CPUs in this hctx are offline,
> since these drivers don't use managed irq.
> 
> Finally don't deactivate one hctx when it doesn't use managed irq.
> 
> Reviewed-by: Christoph Hellwig<hch@lst.de>
> Signed-off-by: Ming Lei<ming.lei@redhat.com>

Sorry for lateness. Just a few minor comments below, regardless:

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   block/blk-mq.c | 27 +++++++++++++++++----------
>   block/blk-mq.h |  8 ++++++++
>   2 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 2c4ac51e54eb..591ab07c64d8 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -427,6 +427,15 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
>   }
>   EXPORT_SYMBOL(blk_mq_alloc_request);
>   
> +static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)

I don't see why it needs to be inline. I think generally we leave it to 
the compiler to decide.

> +{
> +	int cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);
> +
> +	if (cpu >= nr_cpu_ids)
> +		cpu = cpumask_first(hctx->cpumask);
> +	return cpu;
> +}
> +
>   struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   	unsigned int op, blk_mq_req_flags_t flags, unsigned int hctx_idx)
>   {
> @@ -468,7 +477,10 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
>   	data.hctx = q->queue_hw_ctx[hctx_idx];
>   	if (!blk_mq_hw_queue_mapped(data.hctx))
>   		goto out_queue_exit;
> -	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> +
> +	WARN_ON_ONCE(blk_mq_hctx_use_managed_irq(data.hctx));
> +
> +	cpu = blk_mq_first_mapped_cpu(data.hctx);
>   	data.ctx = __blk_mq_get_ctx(q, cpu);
>   
>   	if (!q->elevator)
> @@ -1501,15 +1513,6 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>   	hctx_unlock(hctx, srcu_idx);
>   }
>   
> -static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
> -{
> -	int cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);
> -
> -	if (cpu >= nr_cpu_ids)
> -		cpu = cpumask_first(hctx->cpumask);
> -	return cpu;
> -}
> -
>   /*
>    * It'd be great if the workqueue API had a way to pass
>    * in a mask and had some smarts for more clever placement.
> @@ -2556,6 +2559,10 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>   	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
>   			struct blk_mq_hw_ctx, cpuhp_online);
>   
> +	/* hctx needn't to be deactivated in case managed irq isn't used */
> +	if (!blk_mq_hctx_use_managed_irq(hctx))
> +		return 0;

In a previous version (v2) I think that we just didn't register the cpu 
hotplug handlers, so not sure why that changed.

> +
>   	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
>   	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
>   		return 0;
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index d08779f77a26..7333b659d8f5 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -119,6 +119,14 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
>   	return ctx->hctxs[type];
>   }
>   
> +static inline bool blk_mq_hctx_use_managed_irq(struct blk_mq_hw_ctx *hctx)
> +{
> +	if (hctx->type == HCTX_TYPE_POLL)
> +		return false;
> +
> +	return hctx->queue->tag_set->map[hctx->type].use_managed_irq;
> +}

This function only seems to be used in blk-mq.c, so not sure why you put 
it in .h file.
