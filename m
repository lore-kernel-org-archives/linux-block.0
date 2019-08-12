Return-Path: <SRS0=3NZC=WI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FACCC433FF
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 14:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDC420665
	for <linux-block@archiver.kernel.org>; Mon, 12 Aug 2019 14:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfHLOYF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:24:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:39540 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727805AbfHLOYE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 10:24:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18F75AEA5;
        Mon, 12 Aug 2019 14:24:03 +0000 (UTC)
Subject: Re: [PATCH V2 3/5] blk-mq: stop to handle IO before hctx's all CPUs
 become offline
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
References: <20190812134312.16732-1-ming.lei@redhat.com>
 <20190812134312.16732-4-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <7d757a7b-6e8f-3bb4-e9b9-7308cb86e2e3@suse.de>
Date:   Mon, 12 Aug 2019 16:24:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190812134312.16732-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/19 3:43 PM, Ming Lei wrote:
> Most of blk-mq drivers depend on managed IRQ's auto-affinity to setup
> up queue mapping. Thomas mentioned the following point[1]:
> 
> "
>  That was the constraint of managed interrupts from the very beginning:
> 
>   The driver/subsystem has to quiesce the interrupt line and the associated
>   queue _before_ it gets shutdown in CPU unplug and not fiddle with it
>   until it's restarted by the core when the CPU is plugged in again.
> "
> 
> However, current blk-mq implementation doesn't quiesce hw queue before
> the last CPU in the hctx is shutdown. Even worse, CPUHP_BLK_MQ_DEAD is
> one cpuhp state handled after the CPU is down, so there isn't any chance
> to quiesce hctx for blk-mq wrt. CPU hotplug.
> 
> Add new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE for blk-mq to stop queues
> and wait for completion of in-flight requests.
> 
> [1] https://lore.kernel.org/linux-block/alpine.DEB.2.21.1904051331270.1802@nanos.tec.linutronix.de/
> 
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-tag.c         |  2 +-
>  block/blk-mq-tag.h         |  2 ++
>  block/blk-mq.c             | 65 ++++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h     |  1 +
>  include/linux/cpuhotplug.h |  1 +
>  5 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 008388e82b5c..31828b82552b 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -325,7 +325,7 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
>   *		true to continue iterating tags, false to stop.
>   * @priv:	Will be passed as second argument to @fn.
>   */
> -static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
>  		busy_tag_iter_fn *fn, void *priv)
>  {
>  	if (tags->nr_reserved_tags)
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 61deab0b5a5a..321fd6f440e6 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -35,6 +35,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>  extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
>  void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>  		void *priv);
> +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> +		busy_tag_iter_fn *fn, void *priv);
>  
>  static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
>  						 struct blk_mq_hw_ctx *hctx)
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 6968de9d7402..6931b2ba2776 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2206,6 +2206,61 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>  	return -ENOMEM;
>  }
>  
> +static bool blk_mq_count_inflight_rq(struct request *rq, void *data,
> +				     bool reserved)
> +{
> +	unsigned *count = data;
> +
> +	if ((blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT))
> +		(*count)++;
> +
> +	return true;
> +}
> +
> +static unsigned blk_mq_tags_inflight_rqs(struct blk_mq_tags *tags)
> +{
> +	unsigned count = 0;
> +
> +	blk_mq_all_tag_busy_iter(tags, blk_mq_count_inflight_rq, &count);
> +
> +	return count;
> +}
> +
> +static void blk_mq_drain_inflight_rqs(struct blk_mq_hw_ctx *hctx)
> +{
> +	while (1) {
> +		if (!blk_mq_tags_inflight_rqs(hctx->tags))
> +			break;
> +		msleep(5);
> +	}
> +}
> +
> +static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
> +			struct blk_mq_hw_ctx, cpuhp_online);
> +	unsigned prev_cpu = -1;
> +
> +	while (true) {
> +		unsigned next_cpu = cpumask_next_and(prev_cpu, hctx->cpumask,
> +				cpu_online_mask);
> +
> +		if (next_cpu >= nr_cpu_ids)
> +			break;
> +
> +		/* return if there is other online CPU on this hctx */
> +		if (next_cpu != cpu)
> +			return 0;
> +
> +		prev_cpu = next_cpu;
> +	}
> +
> +	set_bit(BLK_MQ_S_INTERNAL_STOPPED, &hctx->state);
> +	blk_mq_drain_inflight_rqs(hctx);
> +
> +	return 0;
> +}
> +
>  /*
>   * 'cpu' is going away. splice any existing rq_list entries from this
>   * software queue to the hw queue dispatch list, and ensure that it

Isn't that inverted?
From the function I would assume it'll be called once the CPU is being
set toe 'online', yet from the description I would have assumed the
INTERNAL_STOPPED bit is set when the cpu goes offline.
Care to elaborate?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
