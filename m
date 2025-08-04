Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA5D8F4A
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291593; cv=none; b=gJHxVfMWr2b9+VTabZIbmHZm2lMZa2Ygn2GbRNZZja1Oobsb4e0CrIFv/IeBSs950IGjA7h4vpJABmhSbPIWCkMLf/F8FH04Excm/8leC+PgdW38paE98hWKY3JmCvWV8009CkVbISiFC/eWNEae7iw26//GV8J4WMwRbrGzinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291593; c=relaxed/simple;
	bh=Y2jcDDGPpXhb+etvrqDfIrtFYWOKQ2XdKFZ7/0SM+o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/UCfrtsUzd3r/Rg7AfbOqzkAhBlqozapyrRjruwGsSk1mNlXSYj1dThrRlIFN8Gs/w1aDRVnIMC+1exfjT07owSKpnbw7+54D7mlo+RPUsYRZt6k8T+hf++6fJG7JJrdNCvkq85zieJbBepGYQWxjAtO8c7FM/gP4JcITS0YTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bQ7xaq0R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YxSQYa4x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bQ7xaq0R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YxSQYa4x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bQ7xaq0R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YxSQYa4x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bQ7xaq0R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YxSQYa4x"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 995921F443;
	Mon,  4 Aug 2025 07:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754291589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6LmZ5rw6fXFp43lSmbzKCWs32p3Z1C7P4QCkgaUi4E=;
	b=bQ7xaq0Rza0jgq6DNMqVUieBG6G037xl1Q1DIAgI6A2cekGXoD+4OciWBQOnq4sofpPID7
	k7q6S+2fEL4TfVwDPePdXiic54yOAMEvpJyLFi2PqrrrDlZTaUERuyUmxJXb3ektHGRV6q
	TtQ4w9OKYZAym+dl4ervFuayzDBfcgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754291589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6LmZ5rw6fXFp43lSmbzKCWs32p3Z1C7P4QCkgaUi4E=;
	b=YxSQYa4x5AjVi3b4SHSl8UWvak5g3qeJ4YQRT1ZBOnp0rMCckOhXCEBvFZjisq2nRKPf9r
	XDFXEhOPNUmcyKBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bQ7xaq0R;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YxSQYa4x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754291589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6LmZ5rw6fXFp43lSmbzKCWs32p3Z1C7P4QCkgaUi4E=;
	b=bQ7xaq0Rza0jgq6DNMqVUieBG6G037xl1Q1DIAgI6A2cekGXoD+4OciWBQOnq4sofpPID7
	k7q6S+2fEL4TfVwDPePdXiic54yOAMEvpJyLFi2PqrrrDlZTaUERuyUmxJXb3ektHGRV6q
	TtQ4w9OKYZAym+dl4ervFuayzDBfcgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754291589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6LmZ5rw6fXFp43lSmbzKCWs32p3Z1C7P4QCkgaUi4E=;
	b=YxSQYa4x5AjVi3b4SHSl8UWvak5g3qeJ4YQRT1ZBOnp0rMCckOhXCEBvFZjisq2nRKPf9r
	XDFXEhOPNUmcyKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59E7E13A7E;
	Mon,  4 Aug 2025 07:13:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6sIhFIVdkGgLVgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Aug 2025 07:13:09 +0000
Message-ID: <028ba177-da0c-465e-ab34-ec18039395e8@suse.de>
Date: Mon, 4 Aug 2025 09:13:08 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>, John Garry <john.garry@huawei.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-6-ming.lei@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250801114440.722286-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 995921F443
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 8/1/25 13:44, Ming Lei wrote:
> Replace the spinlock in blk_mq_find_and_get_req() with an SRCU read lock
> around the tag iterators.
> 
> This is done by:
> 
> - Holding the SRCU read lock in blk_mq_queue_tag_busy_iter(),
> blk_mq_tagset_busy_iter(), and blk_mq_hctx_has_requests().
> 
> - Removing the now-redundant tags->lock from blk_mq_find_and_get_req().
> 
> This change improves performance by replacing a spinlock with a more
> scalable SRCU lock, and fixes lockup issue in scsi_host_busy() in case of
> shost->host_blocked.
> 
> Meantime it becomes possible to use blk_mq_in_driver_rw() for io
> accounting.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq-tag.c | 12 ++++++++----
>   block/blk-mq.c     | 24 ++++--------------------
>   2 files changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 6c2f5881e0de..7ae431077a32 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -256,13 +256,10 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
>   		unsigned int bitnr)
>   {
>   	struct request *rq;
> -	unsigned long flags;
>   
> -	spin_lock_irqsave(&tags->lock, flags);
>   	rq = tags->rqs[bitnr];
>   	if (!rq || rq->tag != bitnr || !req_ref_inc_not_zero(rq))
>   		rq = NULL;
> -	spin_unlock_irqrestore(&tags->lock, flags);
>   	return rq;
>   }
>   
> @@ -440,7 +437,9 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>   		busy_tag_iter_fn *fn, void *priv)
>   {
>   	unsigned int flags = tagset->flags;
> -	int i, nr_tags;
> +	int i, nr_tags, srcu_idx;
> +
> +	srcu_idx = srcu_read_lock(&tagset->tags_srcu);
>   
>   	nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
>   
> @@ -449,6 +448,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>   			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
>   					      BT_TAG_ITER_STARTED);
>   	}
> +	srcu_read_unlock(&tagset->tags_srcu, srcu_idx);
>   }
>   EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
>   
> @@ -499,6 +499,8 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
>   void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
>   		void *priv)
>   {
> +	int srcu_idx;
> +
>   	/*
>   	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and hctx_table
>   	 * while the queue is frozen. So we can use q_usage_counter to avoid
> @@ -507,6 +509,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
>   	if (!percpu_ref_tryget(&q->q_usage_counter))
>   		return;
>   
> +	srcu_idx = srcu_read_lock(&q->tag_set->tags_srcu);
>   	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
>   		struct blk_mq_tags *tags = q->tag_set->shared_tags;
>   		struct sbitmap_queue *bresv = &tags->breserved_tags;
> @@ -536,6 +539,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
>   			bt_for_each(hctx, q, btags, fn, priv, false);
>   		}
>   	}
> +	srcu_read_unlock(&q->tag_set->tags_srcu, srcu_idx);
>   	blk_queue_exit(q);
>   }
>   
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 7b4ab8e398b6..43b15e58ffe1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3415,7 +3415,6 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
>   				    struct blk_mq_tags *tags)
>   {
>   	struct page *page;
> -	unsigned long flags;
>   
>   	/*
>   	 * There is no need to clear mapping if driver tags is not initialized
> @@ -3439,15 +3438,6 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
>   			}
>   		}
>   	}
> -
> -	/*
> -	 * Wait until all pending iteration is done.
> -	 *
> -	 * Request reference is cleared and it is guaranteed to be observed
> -	 * after the ->lock is released.
> -	 */
> -	spin_lock_irqsave(&drv_tags->lock, flags);
> -	spin_unlock_irqrestore(&drv_tags->lock, flags);
>   }
>   
>   void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
> @@ -3670,8 +3660,12 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
>   	struct rq_iter_data data = {
>   		.hctx	= hctx,
>   	};
> +	int srcu_idx;
>   
> +	srcu_idx = srcu_read_lock(&hctx->queue->tag_set->tags_srcu);
>   	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
> +	srcu_read_unlock(&hctx->queue->tag_set->tags_srcu, srcu_idx);
> +
>   	return data.has_rq;
>   }
>   
> @@ -3891,7 +3885,6 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
>   		unsigned int queue_depth, struct request *flush_rq)
>   {
>   	int i;
> -	unsigned long flags;
>   
>   	/* The hw queue may not be mapped yet */
>   	if (!tags)
> @@ -3901,15 +3894,6 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
>   
>   	for (i = 0; i < queue_depth; i++)
>   		cmpxchg(&tags->rqs[i], flush_rq, NULL);
> -
> -	/*
> -	 * Wait until all pending iteration is done.
> -	 *
> -	 * Request reference is cleared and it is guaranteed to be observed
> -	 * after the ->lock is released.
> -	 */
> -	spin_lock_irqsave(&tags->lock, flags);
> -	spin_unlock_irqrestore(&tags->lock, flags);
>   }
>   
>   static void blk_free_flush_queue_callback(struct rcu_head *head)

While this looks good, I do wonder what happened to the 'fq' srcu.
Don't we need to insert an srcu_read_lock() when we're trying to
access it?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
