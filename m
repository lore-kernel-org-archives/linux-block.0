Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A624C04AAF
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 07:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683F621019
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 07:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfEUHko (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 03:40:44 -0400
Received: from verein.lst.de ([213.95.11.211]:58012 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfEUHko (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 03:40:44 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3A8C168B05; Tue, 21 May 2019 09:40:20 +0200 (CEST)
Date:   Tue, 21 May 2019 09:40:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] blk-mq: Wait for for hctx inflight requests on CPU
 unplug
Message-ID: <20190521074019.GA31265@lst.de>
References: <20190517091424.19751-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517091424.19751-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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

How about moving blk_mq_tags_inflight_rqs to blk-mq-tag.c instead?

> +	#define BLK_MQ_TAGS_DRAINED           0

Please don't indent #defines.

>  
> +static int blk_mq_hctx_notify_prepare(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct blk_mq_hw_ctx	*hctx;
> +	struct blk_mq_tags	*tags;
> +
> +	tags = hctx->tags;
> +
> +	if (tags)
> +		clear_bit(BLK_MQ_TAGS_DRAINED, &tags->flags);
> +
> +	return 0;

I'd write this as:

{
	struct blk_mq_hw_ctx	*hctx = 
		hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);

	if (hctx->tags)
		clear_bit(BLK_MQ_TAGS_DRAINED, &hctx->tags->flags);
	return 0;
}

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

Isn't this condition inverted?  If we break out early msecs_left will
be larger than 0 and we are fine.

Why not:

	for (attempts = 0; attempts < 1000; attempts++) {
		if (!blk_mq_tags_inflight_rqs(tags))
			return;
	}

	...

But more importantly I'm not sure we can just give up that easily.
Shouldn't we at lest wait the same timeout we otherwise have for
requests, and if the command isn't finished in time kick off error
handling?
