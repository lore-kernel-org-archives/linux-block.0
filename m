Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7911317B418
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763709499; cv=none; b=g/jncZ26ox2KDLxXVaWGoPkyGBfoPxxH62CkawvRbQemSuMyIpEY6R1fXj6IlDkCVb+oLH3x2LZr2bpwkBCbyxtsgedyd6ox2SmzsamKtcHBvtU0DSQZCf6jMkAu9lc5tix5d59e2HBtXvv8lIhZYUGQoNK463osmwEIY7L8zP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763709499; c=relaxed/simple;
	bh=g9L+EmEyGUlCl6r1C6gdErdkxR3Yz1ETyUC55ESYLEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IRewu6+jeMTUTGW1odMzNY/GCuILoBGl2sg4gG2gUKfn1gI4EjamJ1P8l7CNIjKvfxDg4XvTWCwyu/dXRoXrQfobH2VgwekxJrRv7MTYWZLUlzvKJ3Fu3yZx1Xt7wkTPt601lCWX66nPNTgub3uZIxJ2PWIyuQNEUmjC7Ew6UIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QvR/tOsS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o6974uA7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QvR/tOsS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o6974uA7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QvR/tOsS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o6974uA7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QvR/tOsS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o6974uA7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C9DE2127F;
	Fri, 21 Nov 2025 07:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763709495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIYTVIqwU0wmsptuSf9mReCAp7CWVEUMBg9JLnvijD8=;
	b=QvR/tOsSvIhg/g4VkwoF8COo2ogt6iaUpFA0XDiLlNP0koRy1LOFh0pxMDPNfh5tRRRzbO
	vODSmnoGd8+g0siuVnlXV6yWZk39HGdQm1WkX7xJWGivM70VfX0hU0UaH2U0p3NczYBaPP
	GzAHTTcyVTcPfO49Ybhj1UHLfLvFJug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763709495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIYTVIqwU0wmsptuSf9mReCAp7CWVEUMBg9JLnvijD8=;
	b=o6974uA7eYENFgYGQWtDLA96kvYyz9LiWINTb4OZeLtFV3gntH9RzrduQLDZY5jZsr6UsL
	WoMy/40giyJRGKDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="QvR/tOsS";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=o6974uA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1763709495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIYTVIqwU0wmsptuSf9mReCAp7CWVEUMBg9JLnvijD8=;
	b=QvR/tOsSvIhg/g4VkwoF8COo2ogt6iaUpFA0XDiLlNP0koRy1LOFh0pxMDPNfh5tRRRzbO
	vODSmnoGd8+g0siuVnlXV6yWZk39HGdQm1WkX7xJWGivM70VfX0hU0UaH2U0p3NczYBaPP
	GzAHTTcyVTcPfO49Ybhj1UHLfLvFJug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1763709495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIYTVIqwU0wmsptuSf9mReCAp7CWVEUMBg9JLnvijD8=;
	b=o6974uA7eYENFgYGQWtDLA96kvYyz9LiWINTb4OZeLtFV3gntH9RzrduQLDZY5jZsr6UsL
	WoMy/40giyJRGKDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 416013EA61;
	Fri, 21 Nov 2025 07:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zn3tDTcSIGk9dwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 21 Nov 2025 07:18:15 +0000
Message-ID: <c93e88cd-ade4-4264-8d80-a6669e361c32@suse.de>
Date: Fri, 21 Nov 2025 08:18:14 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] mq-deadline: covert to use
 request_queue->async_depth
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, nilay@linux.ibm.com,
 bvanassche@acm.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251121052901.1341976-1-yukuai@fnnas.com>
 <20251121052901.1341976-7-yukuai@fnnas.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251121052901.1341976-7-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7C9DE2127F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fnnas.com:email,acm.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 11/21/25 06:28, Yu Kuai wrote:
> In downstream kernel, we test with mq-deadline with many fio workloads, and
> we found a performance regression after commit 39823b47bbd4
> ("block/mq-deadline: Fix the tag reservation code") with following test:
> 
> [global]
> rw=randread
> direct=1
> ramp_time=1
> ioengine=libaio
> iodepth=1024
> numjobs=24
> bs=1024k
> group_reporting=1
> runtime=60
> 
> [job1]
> filename=/dev/sda
> 
> Root cause is that mq-deadline now support configuring async_depth,
> although the default value is nr_request, however the minimal value is
> 1, hence min_shallow_depth is set to 1, causing wake_batch to be 1. For
> consequence, sbitmap_queue will be waken up after each IO instead of
> 8 IO.
> 
> In this test case, sda is HDD and max_sectors is 128k, hence each
> submitted 1M io will be splited into 8 sequential 128k requests, however
> due to there are 24 jobs and total tags are exhausted, the 8 requests are
> unlikely to be dispatched sequentially, and changing wake_batch to 1
> will make this much worse, accounting blktrace D stage, the percentage
> of sequential io is decreased from 8% to 0.8%.
> 
> Fix this problem by converting to request_queue->async_depth, where
> min_shallow_depth is set each time async_depth is updated.
> 
> Noted elevator attribute async_depth is now removed, queue attribute
> with the same name is used instead.
> 
> Fixes: 39823b47bbd4 ("block/mq-deadline: Fix the tag reservation code")
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/mq-deadline.c | 39 +++++----------------------------------
>   1 file changed, 5 insertions(+), 34 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 29d00221fbea..95917a88976f 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -98,7 +98,6 @@ struct deadline_data {
>   	int fifo_batch;
>   	int writes_starved;
>   	int front_merges;
> -	u32 async_depth;
>   	int prio_aging_expire;
>   
>   	spinlock_t lock;
> @@ -486,32 +485,16 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>   	return rq;
>   }
>   
> -/*
> - * Called by __blk_mq_alloc_request(). The shallow_depth value set by this
> - * function is used by __blk_mq_get_tag().
> - */
>   static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
>   {
> -	struct deadline_data *dd = data->q->elevator->elevator_data;
> -
> -	/* Do not throttle synchronous reads. */
> -	if (blk_mq_is_sync_read(opf))
> -		return;
> -
> -	/*
> -	 * Throttle asynchronous requests and writes such that these requests
> -	 * do not block the allocation of synchronous requests.
> -	 */
> -	data->shallow_depth = dd->async_depth;
> +	if (!blk_mq_is_sync_read(opf))
> +		data->shallow_depth = data->q->async_depth;
>   }
>   
> -/* Called by blk_mq_update_nr_requests(). */
> +/* Called by blk_mq_init_sched() and blk_mq_update_nr_requests(). */
>   static void dd_depth_updated(struct request_queue *q)
>   {
> -	struct deadline_data *dd = q->elevator->elevator_data;
> -
> -	dd->async_depth = q->nr_requests;
> -	blk_mq_set_min_shallow_depth(q, 1);
> +	blk_mq_set_min_shallow_depth(q, q->async_depth);
>   }
>   
>   static void dd_exit_sched(struct elevator_queue *e)
> @@ -576,6 +559,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
>   	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
>   
>   	q->elevator = eq;
> +	q->async_depth = q->nr_requests;
>   	dd_depth_updated(q);
>   	return 0;
>   }
> @@ -763,7 +747,6 @@ SHOW_JIFFIES(deadline_write_expire_show, dd->fifo_expire[DD_WRITE]);
>   SHOW_JIFFIES(deadline_prio_aging_expire_show, dd->prio_aging_expire);
>   SHOW_INT(deadline_writes_starved_show, dd->writes_starved);
>   SHOW_INT(deadline_front_merges_show, dd->front_merges);
> -SHOW_INT(deadline_async_depth_show, dd->async_depth);
>   SHOW_INT(deadline_fifo_batch_show, dd->fifo_batch);
>   #undef SHOW_INT
>   #undef SHOW_JIFFIES
> @@ -793,7 +776,6 @@ STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MA
>   STORE_JIFFIES(deadline_prio_aging_expire_store, &dd->prio_aging_expire, 0, INT_MAX);
>   STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
>   STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
> -STORE_INT(deadline_async_depth_store, &dd->async_depth, 1, INT_MAX);
>   STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
>   #undef STORE_FUNCTION
>   #undef STORE_INT
> @@ -807,7 +789,6 @@ static const struct elv_fs_entry deadline_attrs[] = {
>   	DD_ATTR(write_expire),
>   	DD_ATTR(writes_starved),
>   	DD_ATTR(front_merges),
> -	DD_ATTR(async_depth),
>   	DD_ATTR(fifo_batch),
>   	DD_ATTR(prio_aging_expire),
>   	__ATTR_NULL
> @@ -894,15 +875,6 @@ static int deadline_starved_show(void *data, struct seq_file *m)
>   	return 0;
>   }
>   
> -static int dd_async_depth_show(void *data, struct seq_file *m)
> -{
> -	struct request_queue *q = data;
> -	struct deadline_data *dd = q->elevator->elevator_data;
> -
> -	seq_printf(m, "%u\n", dd->async_depth);
> -	return 0;
> -}
> -
>   static int dd_queued_show(void *data, struct seq_file *m)
>   {
>   	struct request_queue *q = data;
> @@ -1002,7 +974,6 @@ static const struct blk_mq_debugfs_attr deadline_queue_debugfs_attrs[] = {
>   	DEADLINE_NEXT_RQ_ATTR(write2),
>   	{"batching", 0400, deadline_batching_show},
>   	{"starved", 0400, deadline_starved_show},
> -	{"async_depth", 0400, dd_async_depth_show},
>   	{"dispatch", 0400, .seq_ops = &deadline_dispatch_seq_ops},
>   	{"owned_by_driver", 0400, dd_owned_by_driver_show},
>   	{"queued", 0400, dd_queued_show},

... and this is now the opposite. We are removing an existing attribute
(raising questions about userland ABI stability).
Wouldn't it be better to use the generic infrastructure (ie having a
per-request queue async_depth variable), but keep the per-elevator
sysfs attributes (which then just would display the per-queue variable).

That way we won't break userland and get around the awkward issue
of presenting a dummy attribute when no elevator is loaded.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
