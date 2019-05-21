Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5397FC04AAF
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 13:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327B021019
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 13:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfEUNuU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 09:50:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7668 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728142AbfEUNuS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 09:50:18 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 68B601DAB09CF16C5CFF;
        Tue, 21 May 2019 21:50:15 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 21 May 2019
 21:50:12 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] blk-mq: Wait for for hctx inflight requests on CPU unplug
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
References: <20190517091424.19751-1-ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Message-ID: <6e1d3b66-aaed-4f6f-da34-92a633ff4b44@huawei.com>
Date:   Tue, 21 May 2019 14:50:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190517091424.19751-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17/05/2019 10:14, Ming Lei wrote:
> Managed interrupts can not migrate affinity when their CPUs are offline.
> If the CPU is allowed to shutdown before they're returned, commands
> dispatched to managed queues won't be able to complete through their
> irq handlers.
>
> Wait in cpu hotplug handler until all inflight requests on the tags
> are completed or timeout. Wait once for each tags, so we can save time
> in case of shared tags.
>
> Based on the following patch from Keith, and use simple delay-spin
> instead.
>
> https://lore.kernel.org/linux-block/20190405215920.27085-1-keith.busch@intel.com/
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-tag.c |  2 +-
>  block/blk-mq-tag.h |  5 ++++
>  block/blk-mq.c     | 65 +++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 7513c8eaabee..b24334f99c5d 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -332,7 +332,7 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
>   *		true to continue iterating tags, false to stop.
>   * @priv:	Will be passed as second argument to @fn.
>   */
> -static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
>  		busy_tag_iter_fn *fn, void *priv)
>  {
>  	if (tags->nr_reserved_tags)
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 61deab0b5a5a..f8de50485b42 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -19,6 +19,9 @@ struct blk_mq_tags {
>  	struct request **rqs;
>  	struct request **static_rqs;
>  	struct list_head page_list;
> +
> +	#define BLK_MQ_TAGS_DRAINED           0
> +	unsigned long flags;
>  };
>
>
> @@ -35,6 +38,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>  extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
>  void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
>  		void *priv);
> +void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
> +		busy_tag_iter_fn *fn, void *priv);
>
>  static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
>  						 struct blk_mq_hw_ctx *hctx)
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 08a6248d8536..d1d1b1a9628f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2214,6 +2214,60 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>  	return -ENOMEM;
>  }
>
> +static int blk_mq_hctx_notify_prepare(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct blk_mq_hw_ctx	*hctx;
> +	struct blk_mq_tags	*tags;
> +
> +	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
> +	tags = hctx->tags;
> +
> +	if (tags)
> +		clear_bit(BLK_MQ_TAGS_DRAINED, &tags->flags);
> +

Hi Ming,

Thanks for the effort here.

I would like to make an assertion on a related topic, which I hope you 
can comment on:

For this drain mechanism to work, the blk_mq_hw_ctx’s (and related cpu 
masks) for a request queue are required to match the hw queues used in 
the LLDD (if using managed interrupts).

In others words, a SCSI LLDD needs to expose all hw queues for this to work.

The reason I say this is because if the LLDD does not expose the hw 
queues and manages them internally - as some SCSI LLDDs do - yet uses 
managed interrupts to spread the hw queue MSI vectors across all CPUs, 
then we still only have a single blk_mq_hw_ctx per rq with a cpumask 
covering all cpus, which is not what we would want.

Cheers,
John

> +	return 0;
> +}
> +
> +static bool blk_mq_count_inflight_rq(struct request *rq, void *data,
> +				     bool reserved)
> +{
> +	if (blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
> +		(*(unsigned long *)data)++;
> +
> +	return true;
> +}
> +
> +static unsigned blk_mq_tags_inflight_rqs(struct blk_mq_tags *tags)
> +{
> +	unsigned long cnt = 0;
> +
> +	blk_mq_all_tag_busy_iter(tags, blk_mq_count_inflight_rq, &cnt);
> +
> +	return cnt;
> +}
> +
> +static void blk_mq_drain_inflight_rqs(struct blk_mq_tags *tags, int dead_cpu)
> +{
> +	unsigned long msecs_left = 1000 * 5;
> +
> +	if (!tags)
> +		return;
> +
> +	if (test_and_set_bit(BLK_MQ_TAGS_DRAINED, &tags->flags))
> +		return;
> +
> +	while (msecs_left > 0) {
> +		if (!blk_mq_tags_inflight_rqs(tags))
> +			break;
> +		msleep(5);
> +		msecs_left -= 5;
> +	}
> +
> +	if (msecs_left > 0)
> +		printk(KERN_WARNING "requests not completed from dead "
> +				"CPU %d\n", dead_cpu);
> +}
> +
>  /*
>   * 'cpu' is going away. splice any existing rq_list entries from this
>   * software queue to the hw queue dispatch list, and ensure that it
> @@ -2245,6 +2299,14 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
>  	spin_unlock(&hctx->lock);
>
>  	blk_mq_run_hw_queue(hctx, true);
> +
> +	/*
> +	 * Interrupt for this queue will be shutdown, so wait until all
> +	 * requests from this hw queue is done or timeout.
> +	 */
> +	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) >= nr_cpu_ids)
> +		blk_mq_drain_inflight_rqs(hctx->tags, cpu);
> +
>  	return 0;
>  }
>
> @@ -3540,7 +3602,8 @@ EXPORT_SYMBOL(blk_mq_rq_cpu);
>
>  static int __init blk_mq_init(void)
>  {
> -	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
> +	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead",
> +				blk_mq_hctx_notify_prepare,
>  				blk_mq_hctx_notify_dead);
>  	return 0;
>  }
>


