Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0381AA1DB
	for <linux-block@vger.kernel.org>; Mon, 30 Jun 2025 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751264438; cv=none; b=a9YFmPUV/d+qRjS6td5/q/R563OOs0gyGHWS9yUE8yoUt+XpcliTtAZMbQUxDteZgw2QjojquXKIFgnoMtkop9O+H7tBSBrV6hnzIMLcTsg/RK/muXtoEnuYH1PVn/gXo1H/NeLcvJwlTmxEqR8GZcaA+K+XF1KZbPThalzJkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751264438; c=relaxed/simple;
	bh=s0xyioboGWDchSPtEJk3/FOrELXBC7ur4e7YZtdTxFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrhoJZE1XwpnO2qxsXfb9F1YJT6rfyReu6+zuRJ9/9kwpFw0LMvQOdo7kGwvaWWlt9bHzNT+X6UuuoKzPuPeh9W6OYACUWd9yPAlhUYVfXBtvhokVGYMjPXaBOGrr2dvOUZhqzYOYQVj9dA1n3/cNZWyS6Dj3YmBXzTYMQlqm9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HCLsJgnL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BDnuQsZX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HCLsJgnL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BDnuQsZX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HCLsJgnL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BDnuQsZX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HCLsJgnL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BDnuQsZX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5DD551F397;
	Mon, 30 Jun 2025 06:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751264434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOZjhNtMGjK4zLwl58+nJ1+oKAZ8Fmo+SqkFQTBAdRI=;
	b=HCLsJgnLr5yTlfO9Z9V1IdOp0z3/Rx0WAgHD4GQAl4slAJzs8Sydu4Iqy8XCmZaZGm6ZBY
	v2aklFxAnP6hClsyMWLVecOaFKkdCk6/3C4k2j1QjH0+y/Cbkx9ZC+f2tYWiGOr/K1QjZv
	p8hDwpbeVWWj1kDe3AQhWDtWCxsATSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751264434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOZjhNtMGjK4zLwl58+nJ1+oKAZ8Fmo+SqkFQTBAdRI=;
	b=BDnuQsZXMjhPLA0+lxif5Tsfdhm7tQEKRTNmwhcAxzevA4zScIvBkGTW7VCyG9kLWZPEYw
	gZFvnEJ9SMQxYhDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751264434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOZjhNtMGjK4zLwl58+nJ1+oKAZ8Fmo+SqkFQTBAdRI=;
	b=HCLsJgnLr5yTlfO9Z9V1IdOp0z3/Rx0WAgHD4GQAl4slAJzs8Sydu4Iqy8XCmZaZGm6ZBY
	v2aklFxAnP6hClsyMWLVecOaFKkdCk6/3C4k2j1QjH0+y/Cbkx9ZC+f2tYWiGOr/K1QjZv
	p8hDwpbeVWWj1kDe3AQhWDtWCxsATSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751264434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOZjhNtMGjK4zLwl58+nJ1+oKAZ8Fmo+SqkFQTBAdRI=;
	b=BDnuQsZXMjhPLA0+lxif5Tsfdhm7tQEKRTNmwhcAxzevA4zScIvBkGTW7VCyG9kLWZPEYw
	gZFvnEJ9SMQxYhDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08DF913983;
	Mon, 30 Jun 2025 06:20:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AviAALIsYmifVQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 30 Jun 2025 06:20:34 +0000
Message-ID: <d8e6702d-8787-4e85-9770-e415f975e266@suse.de>
Date: Mon, 30 Jun 2025 08:20:28 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 2/3] block: fix lockdep warning caused by lock
 dependency in elv_iosched_store
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
 lkp@intel.com, gjoyce@ibm.com
References: <20250630054756.54532-1-nilay@linux.ibm.com>
 <20250630054756.54532-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250630054756.54532-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On 6/30/25 07:21, Nilay Shroff wrote:
> Recent lockdep reports [1] have revealed a potential deadlock caused by a
> lock dependency between the percpu allocator lock and the elevator lock.
> This issue can be avoided by ensuring that the allocation and release of
> scheduler tags (sched_tags) are performed outside the elevator lock.
> Furthermore, the queue does not need to be remain frozen during these
> operations.
> 
> To address this, move all sched_tags allocations and deallocations outside
> of both the ->elevator_lock and the ->freeze_lock. Since the lifetime of
> the elevator queue and its associated sched_tags is closely tied, the
> allocated sched_tags are now stored in the elevator queue structure. Then,
> during the actual elevator switch (which runs under ->freeze_lock and
> ->elevator_lock), the pre-allocated sched_tags are assigned to the
> appropriate q->hctx. Once the elevator switch is complete and the locks
> are released, the old elevator queue and its associated sched_tags are
> freed.
> 
> This commit specifically addresses the allocation/deallocation of sched_
> tags during elevator switching. Note that sched_tags may also be allocated
> in other contexts, such as during nr_hw_queues updates. Supporting that
> use case will require batch allocation/deallocation, which will be handled
> in a follow-up patch.
> 
> This restructuring ensures that sched_tags memory management occurs
> entirely outside of the ->elevator_lock and ->freeze_lock context,
> eliminating the lock dependency problem seen during scheduler updates.
> 
> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> 
> Reported-by: Stefan Haberland <sth@linux.ibm.com>
> Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-mq-sched.c | 155 +++++++++++++++++++++++--------------------
>   block/blk-mq-sched.h |   8 ++-
>   block/elevator.c     |  47 +++++++++++--
>   block/elevator.h     |  14 +++-
>   4 files changed, 144 insertions(+), 80 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 359e0704e09b..2d6d1ebdd8fb 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -374,64 +374,17 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
>   
> -static int blk_mq_sched_alloc_map_and_rqs(struct request_queue *q,
> -					  struct blk_mq_hw_ctx *hctx,
> -					  unsigned int hctx_idx)
> -{
> -	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
> -		hctx->sched_tags = q->sched_shared_tags;
> -		return 0;
> -	}
> -
> -	hctx->sched_tags = blk_mq_alloc_map_and_rqs(q->tag_set, hctx_idx,
> -						    q->nr_requests);
> -
> -	if (!hctx->sched_tags)
> -		return -ENOMEM;
> -	return 0;
> -}
> -
> -static void blk_mq_exit_sched_shared_tags(struct request_queue *queue)
> -{
> -	blk_mq_free_rq_map(queue->sched_shared_tags);
> -	queue->sched_shared_tags = NULL;
> -}
> -
>   /* called in queue's release handler, tagset has gone away */
>   static void blk_mq_sched_tags_teardown(struct request_queue *q, unsigned int flags)
>   {
>   	struct blk_mq_hw_ctx *hctx;
>   	unsigned long i;
>   
> -	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (hctx->sched_tags) {
> -			if (!blk_mq_is_shared_tags(flags))
> -				blk_mq_free_rq_map(hctx->sched_tags);
> -			hctx->sched_tags = NULL;
> -		}
> -	}
> +	queue_for_each_hw_ctx(q, hctx, i)
> +		hctx->sched_tags = NULL;
>   
>   	if (blk_mq_is_shared_tags(flags))
> -		blk_mq_exit_sched_shared_tags(q);
> -}
> -
> -static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
> -{
> -	struct blk_mq_tag_set *set = queue->tag_set;
> -
> -	/*
> -	 * Set initial depth at max so that we don't need to reallocate for
> -	 * updating nr_requests.
> -	 */
> -	queue->sched_shared_tags = blk_mq_alloc_map_and_rqs(set,
> -						BLK_MQ_NO_HCTX_IDX,
> -						MAX_SCHED_RQ);
> -	if (!queue->sched_shared_tags)
> -		return -ENOMEM;
> -
> -	blk_mq_tag_update_sched_shared_tags(queue);
> -
> -	return 0;
> +		q->sched_shared_tags = NULL;
>   }
>   
>   void blk_mq_sched_reg_debugfs(struct request_queue *q)
> @@ -458,8 +411,75 @@ void blk_mq_sched_unreg_debugfs(struct request_queue *q)
>   	mutex_unlock(&q->debugfs_mutex);
>   }
>   
> +void blk_mq_free_sched_tags(struct elevator_tags *et,
> +		struct blk_mq_tag_set *set)
> +{
> +	unsigned long i;
> +
> +	/* Shared tags are stored at index 0 in @tags. */
> +	if (blk_mq_is_shared_tags(set->flags))
> +		blk_mq_free_map_and_rqs(set, et->tags[0], BLK_MQ_NO_HCTX_IDX);
> +	else {
> +		for (i = 0; i < et->nr_hw_queues; i++)
> +			blk_mq_free_map_and_rqs(set, et->tags[i], i);
> +	}
> +
> +	kfree(et);
> +}
> +
> +struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
> +		unsigned int nr_hw_queues)
> +{
> +	unsigned int nr_tags;
> +	int i;
> +	struct elevator_tags *et;
> +	gfp_t gfp = GFP_NOIO | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
> +
> +	if (blk_mq_is_shared_tags(set->flags))
> +		nr_tags = 1;
> +	else
> +		nr_tags = nr_hw_queues;
> +
> +	et = kmalloc(sizeof(struct elevator_tags) +
> +			nr_tags * sizeof(struct blk_mq_tags *), gfp);
> +	if (!et)
> +		return NULL;
> +	/*
> +	 * Default to double of smaller one between hw queue_depth and
> +	 * 128, since we don't split into sync/async like the old code
> +	 * did. Additionally, this is a per-hw queue depth.
> +	 */
> +	et->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
> +			BLKDEV_DEFAULT_RQ);
> +	et->nr_hw_queues = nr_hw_queues;
> +
> +	if (blk_mq_is_shared_tags(set->flags)) {
> +		/* Shared tags are stored at index 0 in @tags. */
> +		et->tags[0] = blk_mq_alloc_map_and_rqs(set, BLK_MQ_NO_HCTX_IDX,
> +					MAX_SCHED_RQ);
> +		if (!et->tags[0])
> +			goto out;
> +	} else {
> +		for (i = 0; i < et->nr_hw_queues; i++) {
> +			et->tags[i] = blk_mq_alloc_map_and_rqs(set, i,
> +					et->nr_requests);
> +			if (!et->tags[i])
> +				goto out_unwind;
> +		}
> +	}
> +
> +	return et;
> +out_unwind:
> +	while (--i >= 0)
> +		blk_mq_free_map_and_rqs(set, et->tags[i], i);
> +out:
> +	kfree(et);
> +	return NULL;
> +}
> +

As smatch stated, the unwind pattern is a bit odd.
Maybe move the unwind into the 'else' branch, and us a conditional
to invoke it:

if (i < et->nr_hw_queues)
   while (--i >= 0)
     blk_mq_free_map_and_request()

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
