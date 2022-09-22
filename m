Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EEBC6FA82
	for <linux-block@archiver.kernel.org>; Thu, 22 Sep 2022 06:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiIVG0L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Sep 2022 02:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiIVGZq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 02:25:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ED4AFAF2
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 23:25:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9EC5F68BEB; Thu, 22 Sep 2022 08:25:17 +0200 (CEST)
Date:   Thu, 22 Sep 2022 08:25:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>,
        homas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] blk-mq: avoid to hang in the cpuhp offline handler
Message-ID: <20220922062517.GB27946@lst.de>
References: <20220920021724.1841850-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920021724.1841850-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 20, 2022 at 10:17:24AM +0800, Ming Lei wrote:
> For avoiding to trigger io timeout when one hctx becomes inactive, we
> drain IOs when all CPUs of one hctx are offline. However, driver's
> timeout handler may require cpus_read_lock, such as nvme-pci,
> pci_alloc_irq_vectors_affinity() is called in nvme-pci reset context,
> and irq_build_affinity_masks() needs cpus_read_lock().
> 
> Meantime when blk-mq's cpuhp offline handler is called, cpus_write_lock
> is held, so deadlock is caused.
> 
> Fixes the issue by breaking the wait loop if enough long time elapses,
> and these in-flight not drained IO still can be handled by timeout
> handler.

I'm not sure that this actually is a good idea on its own, and it kinda
defeats the cpu hotplug processing.

So if I understand your log above correctly the problem is that
we have commands that would time out, and we exacalate to a
controller reset that is racing with the CPU unplug, or if not can
you explain the scenario a little more?

> Cc: linux-nvme@lists.infradead.org
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Fixes: bf0beec0607d ("blk-mq: drain I/O when all CPUs in a hctx are offline")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c96c8c4f751b..4585985b8537 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3301,6 +3301,7 @@ static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
>  	return true;
>  }
>  
> +#define BLK_MQ_MAX_OFFLINE_WAIT_MSECS 3000
>  static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> @@ -3326,8 +3327,13 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
>  	 * frozen and there are no requests.
>  	 */
>  	if (percpu_ref_tryget(&hctx->queue->q_usage_counter)) {
> -		while (blk_mq_hctx_has_requests(hctx))
> +		unsigned int wait_ms = 0;
> +
> +		while (blk_mq_hctx_has_requests(hctx) && wait_ms <
> +				BLK_MQ_MAX_OFFLINE_WAIT_MSECS) {
>  			msleep(5);
> +			wait_ms += 5;
> +		}
>  		percpu_ref_put(&hctx->queue->q_usage_counter);
>  	}
>  
> -- 
> 2.31.1
---end quoted text---
