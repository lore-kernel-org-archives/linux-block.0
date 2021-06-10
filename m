Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5C9C47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E336601FA
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 06:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhFJG2T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 02:28:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54012 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhFJG2T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 02:28:19 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0E2431FD37;
        Thu, 10 Jun 2021 06:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623306383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5R1p9/RFfB7i+9bVe/p7sTlVxBoDQwROcS8/tMpvSZA=;
        b=QknWq8uLr7yywy1TBHC89MinGPIRBtKODQGg6xjUdbL8rsaq3oDAVcJ2xPuxIrwD9y33Ew
        jW2N74cUoHF0ohBJm52eUwtcNF0TlBpRX34OpZXIySxMpdhOIhhpU8CX88OWQUpkZy5laP
        OM3e/UWfFOTtBiDdhwCMiYlrxgwBij8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623306383;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5R1p9/RFfB7i+9bVe/p7sTlVxBoDQwROcS8/tMpvSZA=;
        b=PcznwwHgkwNCb7fZFJbNVl5Ik/h3zIxeZ6vYQkhtNqdUZEHNHYHfGZVLosHlt/pPSa3CGU
        AeqncJX8yZ2H4cBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id C9EB2118DD;
        Thu, 10 Jun 2021 06:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623306383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5R1p9/RFfB7i+9bVe/p7sTlVxBoDQwROcS8/tMpvSZA=;
        b=QknWq8uLr7yywy1TBHC89MinGPIRBtKODQGg6xjUdbL8rsaq3oDAVcJ2xPuxIrwD9y33Ew
        jW2N74cUoHF0ohBJm52eUwtcNF0TlBpRX34OpZXIySxMpdhOIhhpU8CX88OWQUpkZy5laP
        OM3e/UWfFOTtBiDdhwCMiYlrxgwBij8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623306383;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5R1p9/RFfB7i+9bVe/p7sTlVxBoDQwROcS8/tMpvSZA=;
        b=PcznwwHgkwNCb7fZFJbNVl5Ik/h3zIxeZ6vYQkhtNqdUZEHNHYHfGZVLosHlt/pPSa3CGU
        AeqncJX8yZ2H4cBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id SO/UL46wwWBRWwAALh3uQQ
        (envelope-from <hare@suse.de>); Thu, 10 Jun 2021 06:26:22 +0000
Subject: Re: [PATCH 11/14] block/mq-deadline: Reserve 25% of scheduler tags
 for synchronous requests
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-12-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <81ee9a14-77e1-f3a4-af28-ba06ba9f7413@suse.de>
Date:   Thu, 10 Jun 2021 08:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608230703.19510-12-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 1:07 AM, Bart Van Assche wrote:
> For interactive workloads it is important that synchronous requests are
> not delayed. Hence reserve 25% of scheduler tags for synchronous requests.
> This patch still allows asynchronous requests to fill the hardware queues
> since blk_mq_init_sched() makes sure that the number of scheduler requests
> is the double of the hardware queue depth. From blk_mq_init_sched():
> 
> 	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
> 				   BLKDEV_MAX_RQ);
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 1d1bb7a41d2a..a7d0584437d1 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -67,6 +67,7 @@ struct deadline_data {
>  	int fifo_batch;
>  	int writes_starved;
>  	int front_merges;
> +	u32 async_depth;
>  
>  	spinlock_t lock;
>  	spinlock_t zone_lock;
> @@ -397,6 +398,44 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  	return rq;
>  }
>  
> +/*
> + * Called by __blk_mq_alloc_request(). The shallow_depth value set by this
> + * function is used by __blk_mq_get_tag().
> + */
> +static void dd_limit_depth(unsigned int op, struct blk_mq_alloc_data *data)
> +{
> +	struct deadline_data *dd = data->q->elevator->elevator_data;
> +
> +	/* Do not throttle synchronous reads. */
> +	if (op_is_sync(op) && !op_is_write(op))
> +		return;
> +
> +	/*
> +	 * Throttle asynchronous requests and writes such that these requests
> +	 * do not block the allocation of synchronous requests.
> +	 */
> +	data->shallow_depth = dd->async_depth;
> +}
> +
> +/* Called by blk_mq_update_nr_requests(). */
> +static void dd_depth_updated(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct request_queue *q = hctx->queue;
> +	struct deadline_data *dd = q->elevator->elevator_data;
> +	struct blk_mq_tags *tags = hctx->sched_tags;
> +
> +	dd->async_depth = max(1UL, 3 * q->nr_requests / 4);
> +
> +	sbitmap_queue_min_shallow_depth(tags->bitmap_tags, dd->async_depth);
> +}
> +
> +/* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
> +static int dd_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
> +{
> +	dd_depth_updated(hctx);
> +	return 0;
> +}
> +
>  static void dd_exit_sched(struct elevator_queue *e)
>  {
>  	struct deadline_data *dd = e->elevator_data;
> @@ -733,6 +772,15 @@ static int deadline_starved_show(void *data, struct seq_file *m)
>  	return 0;
>  }
>  
> +static int dd_async_depth_show(void *data, struct seq_file *m)
> +{
> +	struct request_queue *q = data;
> +	struct deadline_data *dd = q->elevator->elevator_data;
> +
> +	seq_printf(m, "%u\n", dd->async_depth);
> +	return 0;
> +}
> +
>  static void *deadline_dispatch_start(struct seq_file *m, loff_t *pos)
>  	__acquires(&dd->lock)
>  {
> @@ -775,6 +823,7 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
>  	DEADLINE_QUEUE_DDIR_ATTRS(write),
>  	{"batching", 0400, deadline_batching_show},
>  	{"starved", 0400, deadline_starved_show},
> +	{"async_depth", 0400, dd_async_depth_show},
>  	{"dispatch", 0400, .seq_ops = &deadline_dispatch_seq_ops},
>  	{},
>  };
> @@ -783,6 +832,8 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
>  
>  static struct elevator_type mq_deadline = {
>  	.ops = {
> +		.depth_updated		= dd_depth_updated,
> +		.limit_depth		= dd_limit_depth,
>  		.insert_requests	= dd_insert_requests,
>  		.dispatch_request	= dd_dispatch_request,
>  		.prepare_request	= dd_prepare_request,
> @@ -796,6 +847,7 @@ static struct elevator_type mq_deadline = {
>  		.has_work		= dd_has_work,
>  		.init_sched		= dd_init_sched,
>  		.exit_sched		= dd_exit_sched,
> +		.init_hctx		= dd_init_hctx,
>  	},
>  
>  #ifdef CONFIG_BLK_DEBUG_FS
> 
Can't say I like heuristics. Might be needed, but there will always be
use-cases where the heuristics fail. Can't we make this value
configurable via sysfs?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
