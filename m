Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC65C54FD0
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 13:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B1220776
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 13:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDXN4h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:56:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:60166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgDXN4h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 09:56:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 46121ACD0;
        Fri, 24 Apr 2020 13:56:34 +0000 (UTC)
Subject: Re: [PATCH V8 11/11] block: deactivate hctx when the hctx is actually
 inactive
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200424102351.475641-1-ming.lei@redhat.com>
 <20200424102351.475641-12-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0638a28c-9cbe-fbd2-9123-69efee737565@suse.de>
Date:   Fri, 24 Apr 2020 15:56:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424102351.475641-12-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/24/20 12:23 PM, Ming Lei wrote:
> Run queue on dead CPU still may be triggered in some corner case,
> such as one request is requeued after CPU hotplug is handled.
> 
> So handle this corner case during run queue.
> 
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 30 ++++++++++--------------------
>   1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a4a26bb23533..68088ff5460c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -43,6 +43,8 @@
>   static void blk_mq_poll_stats_start(struct request_queue *q);
>   static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
>   
> +static void blk_mq_hctx_deactivate(struct blk_mq_hw_ctx *hctx);
> +
>   static int blk_mq_poll_stats_bkt(const struct request *rq)
>   {
>   	int ddir, sectors, bucket;
> @@ -1376,28 +1378,16 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>   	int srcu_idx;
>   
>   	/*
> -	 * We should be running this queue from one of the CPUs that
> -	 * are mapped to it.
> -	 *
> -	 * There are at least two related races now between setting
> -	 * hctx->next_cpu from blk_mq_hctx_next_cpu() and running
> -	 * __blk_mq_run_hw_queue():
> -	 *
> -	 * - hctx->next_cpu is found offline in blk_mq_hctx_next_cpu(),
> -	 *   but later it becomes online, then this warning is harmless
> -	 *   at all
> -	 *
> -	 * - hctx->next_cpu is found online in blk_mq_hctx_next_cpu(),
> -	 *   but later it becomes offline, then the warning can't be
> -	 *   triggered, and we depend on blk-mq timeout handler to
> -	 *   handle dispatched requests to this hctx
> +	 * BLK_MQ_S_INACTIVE may not deal with some requeue corner case:
> +	 * one request is requeued after cpu unplug is handled, so check
> +	 * if the hctx is actually inactive. If yes, deactive it and
> +	 * re-submit all requests in the queue.
>   	 */
>   	if (!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
> -		cpu_online(hctx->next_cpu)) {
> -		printk(KERN_WARNING "run queue from wrong CPU %d, hctx %s\n",
> -			raw_smp_processor_id(),
> -			cpumask_empty(hctx->cpumask) ? "inactive": "active");
> -		dump_stack();
> +	    cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) >=
> +	    nr_cpu_ids) {
> +		blk_mq_hctx_deactivate(hctx);
> +		return;
>   	}
>   
>   	/*
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
