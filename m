Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF192AF1D
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763709261; cv=none; b=H/jA2CBsPCGMRydXiulQAqqCa7EsiZ5fUi2O0z0Cvdlgc30tmmXknYz4pVVZ0Xo2qfjScjtdFmJQkswMgcA80V37HyHNErK4GqsHuMNodLvOhkxlYOOsNG6oNr7jUJbpqv+X+CQuI7HB8t1/3fmyNA3G1OtQSG3Wk8GwnBTG0pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763709261; c=relaxed/simple;
	bh=Dvi+gyhEDZi5kajpXrlJ9sVvMtBBrPdqCHotb2Kdz+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ub+TYdVMnCn8cJ0UwOGINWohnCvW//BRvtxhFAq50YdXAmYrP4rSRTiIJ4Os8yRJY3FYhBShP+WDw9xdUTgqY77Ah+NJPd0hT6Lk9lI73v6TKzpq7R9KNftMlk5KJ+bzFS8l9jJ4zYqdXQFyOgIQEiccI3Bz/t6+XqnK0q+1Xno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OQc2v5MK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r+r8O4gZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OQc2v5MK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r+r8O4gZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OQc2v5MK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r+r8O4gZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OQc2v5MK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r+r8O4gZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DBC6218B1;
	Fri, 21 Nov 2025 07:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763709257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3c95gZxL5s9OwNG7VoSeITdQj+dp1ojUTLdDoFGf22I=;
	b=OQc2v5MKKHtUIpauHd+5h1P8Fg1iXNkkvZ5oDE7G5KGRykKze1Qqh4e8dTgqQuZivvjOD+
	cF+Q0dSU1vusRWj93gRqfjlYtiiBvU9MgdOCQXUcSSFdQNHBBEdMDLPtpyK3hH/995tAE5
	IPI0OH1FoFirwDfPpavH30gJJkfQzKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763709257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3c95gZxL5s9OwNG7VoSeITdQj+dp1ojUTLdDoFGf22I=;
	b=r+r8O4gZOyuXOscujNdj0fDbvnnyh9f9uCbzMcbEQd1BvmNVaXYAKEd0IUfLgxAJFk59ve
	sAfuwvGmY7sFlVCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OQc2v5MK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=r+r8O4gZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763709257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3c95gZxL5s9OwNG7VoSeITdQj+dp1ojUTLdDoFGf22I=;
	b=OQc2v5MKKHtUIpauHd+5h1P8Fg1iXNkkvZ5oDE7G5KGRykKze1Qqh4e8dTgqQuZivvjOD+
	cF+Q0dSU1vusRWj93gRqfjlYtiiBvU9MgdOCQXUcSSFdQNHBBEdMDLPtpyK3hH/995tAE5
	IPI0OH1FoFirwDfPpavH30gJJkfQzKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763709257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3c95gZxL5s9OwNG7VoSeITdQj+dp1ojUTLdDoFGf22I=;
	b=r+r8O4gZOyuXOscujNdj0fDbvnnyh9f9uCbzMcbEQd1BvmNVaXYAKEd0IUfLgxAJFk59ve
	sAfuwvGmY7sFlVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F009D3EA61;
	Fri, 21 Nov 2025 07:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bz8VOEgRIGm8cwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 21 Nov 2025 07:14:16 +0000
Message-ID: <bf84ef70-9715-4722-b693-6e8519595b0c@suse.de>
Date: Fri, 21 Nov 2025 08:14:16 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] blk-mq: add a new queue sysfs attribute
 async_depth
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, nilay@linux.ibm.com,
 bvanassche@acm.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251121052901.1341976-1-yukuai@fnnas.com>
 <20251121052901.1341976-5-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251121052901.1341976-5-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5DBC6218B1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas.com:email,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 11/21/25 06:28, Yu Kuai wrote:
> Add a new field async_depth to request_queue and related APIs, this is
> currently not used, following patches will convert elevators to use
> this instead of internal async_depth.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-core.c       |  1 +
>   block/blk-mq.c         |  6 ++++++
>   block/blk-sysfs.c      | 42 ++++++++++++++++++++++++++++++++++++++++++
>   block/elevator.c       |  1 +
>   include/linux/blkdev.h |  1 +
>   5 files changed, 51 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 14ae73eebe0d..cc5c9ced8e6f 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -463,6 +463,7 @@ struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
>   	fs_reclaim_release(GFP_KERNEL);
>   
>   	q->nr_requests = BLKDEV_DEFAULT_RQ;
> +	q->async_depth = BLKDEV_DEFAULT_RQ;
>   
>   	return q;
>   
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 6c505ebfab65..ae6ce68f4786 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4628,6 +4628,7 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>   	spin_lock_init(&q->requeue_lock);
>   
>   	q->nr_requests = set->queue_depth;
> +	q->async_depth = set->queue_depth;
>   
>   	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
>   	blk_mq_map_swqueue(q);
> @@ -4994,6 +4995,11 @@ struct elevator_tags *blk_mq_update_nr_requests(struct request_queue *q,
>   		q->elevator->et = et;
>   	}
>   
> +	/*
> +	 * Preserve relative value, both nr and async_depth are at most 16 bit
> +	 * value, no need to worry about overflow.
> +	 */
> +	q->async_depth = max(q->async_depth * nr / q->nr_requests, 1);
>   	q->nr_requests = nr;
>   	if (q->elevator && q->elevator->type->ops.depth_updated)
>   		q->elevator->type->ops.depth_updated(q);
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 8684c57498cc..5c2d29ac6570 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -127,6 +127,46 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
>   	return ret;
>   }
>   
> +static ssize_t queue_async_depth_show(struct gendisk *disk, char *page)
> +{
> +	guard(mutex)(&disk->queue->elevator_lock);
> +
> +	return queue_var_show(disk->queue->async_depth, page);
> +}
> +
> +static ssize_t
> +queue_async_depth_store(struct gendisk *disk, const char *page, size_t count)
> +{
> +	struct request_queue *q = disk->queue;
> +	unsigned int memflags;
> +	unsigned long nr;
> +	int ret;
> +
> +	if (!queue_is_mq(q))
> +		return -EINVAL;
> +
> +	ret = queue_var_store(&nr, page, count);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (nr == 0)
> +		return -EINVAL;
> +
> +	memflags = blk_mq_freeze_queue(q);
> +	scoped_guard(mutex, &q->elevator_lock) {
> +		if (q->elevator) {
> +			q->async_depth = min(q->nr_requests, nr);
> +			if (q->elevator->type->ops.depth_updated)
> +				q->elevator->type->ops.depth_updated(q);
> +		} else {
> +			ret = -EINVAL;
> +		}
> +	}
> +	blk_mq_unfreeze_queue(q, memflags);
> +
> +	return ret;
> +}
> +
>   static ssize_t queue_ra_show(struct gendisk *disk, char *page)
>   {
>   	ssize_t ret;
> @@ -532,6 +572,7 @@ static struct queue_sysfs_entry _prefix##_entry = {	\
>   }
>   
>   QUEUE_RW_ENTRY(queue_requests, "nr_requests");
> +QUEUE_RW_ENTRY(queue_async_depth, "async_depth");
>   QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
>   QUEUE_LIM_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
>   QUEUE_LIM_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
> @@ -754,6 +795,7 @@ static struct attribute *blk_mq_queue_attrs[] = {
>   	 */
>   	&elv_iosched_entry.attr,
>   	&queue_requests_entry.attr,
> +	&queue_async_depth_entry.attr,
>   #ifdef CONFIG_BLK_WBT
>   	&queue_wb_lat_entry.attr,
>   #endif
> diff --git a/block/elevator.c b/block/elevator.c
> index 5b37ef44f52d..5ff21075a84a 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -589,6 +589,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
>   		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
>   		q->elevator = NULL;
>   		q->nr_requests = q->tag_set->queue_depth;
> +		q->async_depth = q->tag_set->queue_depth;
>   	}
>   	blk_add_trace_msg(q, "elv switch: %s", ctx->name);
>   
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index cdc68c41fa96..edddf17f8304 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -552,6 +552,7 @@ struct request_queue {
>   	 * queue settings
>   	 */
>   	unsigned int		nr_requests;	/* Max # of requests */
> +	unsigned int		async_depth;	/* Max # of async requests */
>   
>   #ifdef CONFIG_BLK_INLINE_ENCRYPTION
>   	struct blk_crypto_profile *crypto_profile;

Hmm. Makes me wonder: async_depth is only used within the elevators, so
maybe we should restrict visibility of that attribute when an elevator
is selected?
It feels kinda awkward having an attribute which does nothing if no
elevator is loaded ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
