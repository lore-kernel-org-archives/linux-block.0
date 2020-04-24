Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E333C54FD0
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 13:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A4820776
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 13:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgDXNsP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:48:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:57094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbgDXNsP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 09:48:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43EB6AD4B;
        Fri, 24 Apr 2020 13:48:13 +0000 (UTC)
Subject: Re: [PATCH V8 09/11] blk-mq: add blk_mq_hctx_handle_dead_cpu for
 handling cpu dead
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-10-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <10668d67-a850-343e-dbfa-2207bd0f6b33@suse.de>
Date:   Fri, 24 Apr 2020 15:48:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424102351.475641-10-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/20 12:23 PM, Ming Lei wrote:
> Add helper of blk_mq_hctx_handle_dead_cpu for handling cpu dead,
> and prepare for handling inactive hctx.
> 
> No functional change.
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 31 +++++++++++++++++++------------
>   1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4d0c271d9f6f..0759e0d606b3 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2370,22 +2370,13 @@ static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
>   	return 0;
>   }
>   
> -/*
> - * 'cpu' is going away. splice any existing rq_list entries from this
> - * software queue to the hw queue dispatch list, and ensure that it
> - * gets run.
> - */
> -static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
> +static void blk_mq_hctx_handle_dead_cpu(struct blk_mq_hw_ctx *hctx,
> +		unsigned int cpu)
>   {
> -	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> -			struct blk_mq_hw_ctx, cpuhp_dead);
>   	struct blk_mq_ctx *ctx;
>   	LIST_HEAD(tmp);
>   	enum hctx_type type;
>   
> -	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> -		return 0;
> -
>   	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
>   	type = hctx->type;
>   
> @@ -2397,13 +2388,29 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>   	spin_unlock(&ctx->lock);
>   
>   	if (list_empty(&tmp))
> -		return 0;
> +		return;
>   
>   	spin_lock(&hctx->lock);
>   	list_splice_tail_init(&tmp, &hctx->dispatch);
>   	spin_unlock(&hctx->lock);
>   
>   	blk_mq_run_hw_queue(hctx, true);
> +}
> +
> +/*
> + * 'cpu' is going away. splice any existing rq_list entries from this
> + * software queue to the hw queue dispatch list, and ensure that it
> + * gets run.
> + */
> +static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> +			struct blk_mq_hw_ctx, cpuhp_dead);
> +
> +	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> +		return 0;
> +
> +	blk_mq_hctx_handle_dead_cpu(hctx, cpu);
>   	return 0;
>   }
>   
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
