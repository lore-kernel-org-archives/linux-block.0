Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1521D018
	for <linux-block@vger.kernel.org>; Mon,  4 Aug 2025 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754307916; cv=none; b=rs0cLG58+MTOf4fAuSCfcgP7XFFP+JhEZgpsnYgPFvWyPLEGzPSKLYv9jHmpIyNx+KFSD2JOWkhWw1zmhxbyFvFe6D/IaL5XkCo1ZXNuwrbA8tdpERitTVvOKpeDPy6V9ZI4vh6u1TNaa15y8PW2h4WQh1Xjo6KN6dBiYGD53gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754307916; c=relaxed/simple;
	bh=fETMESDzAoVfu2SLD6IVe/F3MUQU31EsbLeTf0nFsvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtxWNJqcR4GGx+sDCOY1lCKE80wn8f1Oo9A/9LxIO3vShm80Z3/3b+2s/jBjyQt5zH/X1aekSnVwFe9jlTO9LJRmMJ6yh79ilgE/sXcWCYsmPT+9KeGgE+Snq8teeSANrXIwvOIa2xLLxfPZbWcghO2nBm0Ewv14gqp1FIoKuU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jENaJVti; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G872jB71; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jENaJVti; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G872jB71; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jENaJVti";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G872jB71";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jENaJVti";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G872jB71"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9D022117A;
	Mon,  4 Aug 2025 11:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754307912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Csr9JcaN6pFCQ2VGwH0kse/xsov/LlHqEAG1UADjVuI=;
	b=jENaJVti40m7UzTJHRsde+nZx2QZaMnbw8/9ntak/dHq8QvDknWDnoLIMWjDnC706P8gON
	mCtKjRaLPwpQYfb0XN9OxRjVqZxna8QFw1jyqDlNV4Irt1UcaIQ3DAmFpTtlRAIv74uqTZ
	c1hVrLuL9F2px1SNSElW1JfkxmGfE/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754307912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Csr9JcaN6pFCQ2VGwH0kse/xsov/LlHqEAG1UADjVuI=;
	b=G872jB71i6Ad10hQ0hew7+1RDCCb04OHJVBD1kAH6MhxksfURc53OnShz9fC3TvFVSE7EN
	tBO+F/FjL2FIoJDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754307912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Csr9JcaN6pFCQ2VGwH0kse/xsov/LlHqEAG1UADjVuI=;
	b=jENaJVti40m7UzTJHRsde+nZx2QZaMnbw8/9ntak/dHq8QvDknWDnoLIMWjDnC706P8gON
	mCtKjRaLPwpQYfb0XN9OxRjVqZxna8QFw1jyqDlNV4Irt1UcaIQ3DAmFpTtlRAIv74uqTZ
	c1hVrLuL9F2px1SNSElW1JfkxmGfE/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754307912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Csr9JcaN6pFCQ2VGwH0kse/xsov/LlHqEAG1UADjVuI=;
	b=G872jB71i6Ad10hQ0hew7+1RDCCb04OHJVBD1kAH6MhxksfURc53OnShz9fC3TvFVSE7EN
	tBO+F/FjL2FIoJDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4B5E13695;
	Mon,  4 Aug 2025 11:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1Ff/JkidkGicLgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 04 Aug 2025 11:45:12 +0000
Message-ID: <bfdb0c03-42fc-4ab7-875d-20a65b792b8c@suse.de>
Date: Mon, 4 Aug 2025 13:45:12 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Yu Kuai <yukuai3@huawei.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-6-ming.lei@redhat.com>
 <028ba177-da0c-465e-ab34-ec18039395e8@suse.de> <aJCa_Ef6U00CZbpf@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aJCa_Ef6U00CZbpf@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 8/4/25 13:35, Ming Lei wrote:
> On Mon, Aug 04, 2025 at 09:13:08AM +0200, Hannes Reinecke wrote:
>> On 8/1/25 13:44, Ming Lei wrote:
>>> Replace the spinlock in blk_mq_find_and_get_req() with an SRCU read lock
>>> around the tag iterators.
>>>
>>> This is done by:
>>>
>>> - Holding the SRCU read lock in blk_mq_queue_tag_busy_iter(),
>>> blk_mq_tagset_busy_iter(), and blk_mq_hctx_has_requests().
>>>
>>> - Removing the now-redundant tags->lock from blk_mq_find_and_get_req().
>>>
>>> This change improves performance by replacing a spinlock with a more
>>> scalable SRCU lock, and fixes lockup issue in scsi_host_busy() in case of
>>> shost->host_blocked.
>>>
>>> Meantime it becomes possible to use blk_mq_in_driver_rw() for io
>>> accounting.
>>>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    block/blk-mq-tag.c | 12 ++++++++----
>>>    block/blk-mq.c     | 24 ++++--------------------
>>>    2 files changed, 12 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>> index 6c2f5881e0de..7ae431077a32 100644
>>> --- a/block/blk-mq-tag.c
>>> +++ b/block/blk-mq-tag.c
>>> @@ -256,13 +256,10 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
>>>    		unsigned int bitnr)
>>>    {
>>>    	struct request *rq;
>>> -	unsigned long flags;
>>> -	spin_lock_irqsave(&tags->lock, flags);
>>>    	rq = tags->rqs[bitnr];
>>>    	if (!rq || rq->tag != bitnr || !req_ref_inc_not_zero(rq))
>>>    		rq = NULL;
>>> -	spin_unlock_irqrestore(&tags->lock, flags);
>>>    	return rq;
>>>    }
>>> @@ -440,7 +437,9 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>>>    		busy_tag_iter_fn *fn, void *priv)
>>>    {
>>>    	unsigned int flags = tagset->flags;
>>> -	int i, nr_tags;
>>> +	int i, nr_tags, srcu_idx;
>>> +
>>> +	srcu_idx = srcu_read_lock(&tagset->tags_srcu);
>>>    	nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
>>> @@ -449,6 +448,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
>>>    			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
>>>    					      BT_TAG_ITER_STARTED);
>>>    	}
>>> +	srcu_read_unlock(&tagset->tags_srcu, srcu_idx);
>>>    }
>>>    EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
>>> @@ -499,6 +499,8 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
>>>    void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
>>>    		void *priv)
>>>    {
>>> +	int srcu_idx;
>>> +
>>>    	/*
>>>    	 * __blk_mq_update_nr_hw_queues() updates nr_hw_queues and hctx_table
>>>    	 * while the queue is frozen. So we can use q_usage_counter to avoid
>>> @@ -507,6 +509,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
>>>    	if (!percpu_ref_tryget(&q->q_usage_counter))
>>>    		return;
>>> +	srcu_idx = srcu_read_lock(&q->tag_set->tags_srcu);
>>>    	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
>>>    		struct blk_mq_tags *tags = q->tag_set->shared_tags;
>>>    		struct sbitmap_queue *bresv = &tags->breserved_tags;
>>> @@ -536,6 +539,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
>>>    			bt_for_each(hctx, q, btags, fn, priv, false);
>>>    		}
>>>    	}
>>> +	srcu_read_unlock(&q->tag_set->tags_srcu, srcu_idx);
>>>    	blk_queue_exit(q);
>>>    }
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 7b4ab8e398b6..43b15e58ffe1 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -3415,7 +3415,6 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
>>>    				    struct blk_mq_tags *tags)
>>>    {
>>>    	struct page *page;
>>> -	unsigned long flags;
>>>    	/*
>>>    	 * There is no need to clear mapping if driver tags is not initialized
>>> @@ -3439,15 +3438,6 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
>>>    			}
>>>    		}
>>>    	}
>>> -
>>> -	/*
>>> -	 * Wait until all pending iteration is done.
>>> -	 *
>>> -	 * Request reference is cleared and it is guaranteed to be observed
>>> -	 * after the ->lock is released.
>>> -	 */
>>> -	spin_lock_irqsave(&drv_tags->lock, flags);
>>> -	spin_unlock_irqrestore(&drv_tags->lock, flags);
>>>    }
>>>    void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
>>> @@ -3670,8 +3660,12 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
>>>    	struct rq_iter_data data = {
>>>    		.hctx	= hctx,
>>>    	};
>>> +	int srcu_idx;
>>> +	srcu_idx = srcu_read_lock(&hctx->queue->tag_set->tags_srcu);
>>>    	blk_mq_all_tag_iter(tags, blk_mq_has_request, &data);
>>> +	srcu_read_unlock(&hctx->queue->tag_set->tags_srcu, srcu_idx);
>>> +
>>>    	return data.has_rq;
>>>    }
>>> @@ -3891,7 +3885,6 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
>>>    		unsigned int queue_depth, struct request *flush_rq)
>>>    {
>>>    	int i;
>>> -	unsigned long flags;
>>>    	/* The hw queue may not be mapped yet */
>>>    	if (!tags)
>>> @@ -3901,15 +3894,6 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
>>>    	for (i = 0; i < queue_depth; i++)
>>>    		cmpxchg(&tags->rqs[i], flush_rq, NULL);
>>> -
>>> -	/*
>>> -	 * Wait until all pending iteration is done.
>>> -	 *
>>> -	 * Request reference is cleared and it is guaranteed to be observed
>>> -	 * after the ->lock is released.
>>> -	 */
>>> -	spin_lock_irqsave(&tags->lock, flags);
>>> -	spin_unlock_irqrestore(&tags->lock, flags);
>>>    }
>>>    static void blk_free_flush_queue_callback(struct rcu_head *head)
>>
>> While this looks good, I do wonder what happened to the 'fq' srcu.
>> Don't we need to insert an srcu_read_lock() when we're trying to
>> access it?
> 
> That is exactly the srcu read lock added in this patch.
> 

Ah, indeed. Misread the patch.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
