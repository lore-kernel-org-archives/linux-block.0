Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2318027
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750226689; cv=none; b=GGtOtxBFYBFitElXzVvTc4HmYqESS3fpXymJr51xzfWShhtkh4g78cE+sINYIswLEThBg4KBDA3Z1rGpW3C1IDr7MynkBus/BLtcm0MJ5xm2u4ERWoridXHaAARG9EyIzHUfkg1VnBa2G2U2BXU/cETwyKDIPh8xEbkLKu1fn18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750226689; c=relaxed/simple;
	bh=vaTOy2VV95d3B//0zl0u2/kLrmyNUdfxRTD7riltf1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYa7EbGw/5EH6Iyy9U5Mbn7Enq1akBTnBWaJtp/x4p2ZQXQvQM3L2CxfvnkK1FV8575LxGozEoxhl88wYHNyzIRCAB9HCxfx5lTb9+FuYHyJLYP8TALJbuOhUVemMaPGKtppgHiq8kGsNls4ajiMyMSlHdFpziq0qJkWh8xeNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UQYyr4lr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T7kTxw4t; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UQYyr4lr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T7kTxw4t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UQYyr4lr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T7kTxw4t";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UQYyr4lr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T7kTxw4t"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F49621174;
	Wed, 18 Jun 2025 06:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750226685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fajcRTDywVjK5YR/W2QrgeCI39XIi6mk6CWVUlFt4V8=;
	b=UQYyr4lrG/VIhPiHN49kmKAOqsZcuGVHauYkU2haUeRSm7iga+r0UnLjqGQGvtFOXLHCzl
	Z8jp/5Ah0tsyIqTaJIfeXsXJfBB7UXj6LVu4hm4mjXy1BHd9yWHv8iCYGBNT7XNp2mmXZZ
	F8Rg/CbKXimkAvDdoL7vvoFJhEad/4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750226685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fajcRTDywVjK5YR/W2QrgeCI39XIi6mk6CWVUlFt4V8=;
	b=T7kTxw4tBmkXLn8d/BVqERmW3PT3QwqBA34Rix39aGV2gz8+pfdGXXpQuoq7ZSa7Kx1hOE
	Q5nILYSdeQpKI+AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UQYyr4lr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=T7kTxw4t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750226685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fajcRTDywVjK5YR/W2QrgeCI39XIi6mk6CWVUlFt4V8=;
	b=UQYyr4lrG/VIhPiHN49kmKAOqsZcuGVHauYkU2haUeRSm7iga+r0UnLjqGQGvtFOXLHCzl
	Z8jp/5Ah0tsyIqTaJIfeXsXJfBB7UXj6LVu4hm4mjXy1BHd9yWHv8iCYGBNT7XNp2mmXZZ
	F8Rg/CbKXimkAvDdoL7vvoFJhEad/4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750226685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fajcRTDywVjK5YR/W2QrgeCI39XIi6mk6CWVUlFt4V8=;
	b=T7kTxw4tBmkXLn8d/BVqERmW3PT3QwqBA34Rix39aGV2gz8+pfdGXXpQuoq7ZSa7Kx1hOE
	Q5nILYSdeQpKI+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8E5313A3F;
	Wed, 18 Jun 2025 06:04:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kaRvNvxWUmgTXgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 18 Jun 2025 06:04:44 +0000
Message-ID: <7164d99f-f2e3-43cf-bfa8-964d0d913d05@suse.de>
Date: Wed, 18 Jun 2025 08:04:44 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: use plug request list tail for one-shot backmerge
 attempt
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <4856d1fc-543d-4622-9872-6ca66e8e7352@kernel.dk>
 <82020a7f-adbc-4b3e-8edd-99aba5172510@amazon.com>
 <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
 <aEpkIxvuTWgY5BnO@infradead.org>
 <045d300e-9b52-4ead-8664-2cea6354f5bf@kernel.dk>
 <aErAYSg6f10p_WJK@infradead.org>
 <505e4900-b814-47cd-9572-c0172fa0d01e@kernel.dk>
 <aErGpBWAMPyT2un9@infradead.org>
 <2de604b5-0f57-4f41-84a1-aa6f3130d7c8@kernel.dk>
 <aFAYDPrW4THB0ga7@infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <aFAYDPrW4THB0ga7@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3F49621174
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 6/16/25 15:11, Christoph Hellwig wrote:
> On Thu, Jun 12, 2025 at 06:28:47AM -0600, Jens Axboe wrote:
>> But ideally we'd have that, and just a plain doubly linked list on the
>> queue/dispatch side. Which makes the list handling there much easier to
>> follow, as per your patch.
> 
> Quick hack from the weekend.  This also never deletes the requests from
> the submission list for the queue_rqs case, so depending on the workload
> it should touch either the same amount of less cache lines as the
> existing version.  Only very lightly tested, and ublk is broken and
> doesn't even compile as it's running out space in the io_uring pdu.
> I'll need help from someone who knows ublk for that.
> 
> ---
>  From 07e283303c63fcb694e828380a24ad51f225a228 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 13 Jun 2025 09:48:40 +0200
> Subject: block: always use a list_head for requests
> 
> Use standard double linked lists for the remaining lists of queued up
> requests. This removes a lot of hairy list manipulation code and allows
> east reverse walking of the lists, which is used in
> blk_attempt_plug_merge to improve the merging, and in blk_add_rq_to_plug
> to look at the correct request.
> 
> XXX: ublk is broken right now, because there is no space in the io_uring
> pdu for the list backpointer.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c              |  2 +-
>   block/blk-merge.c             | 11 +---
>   block/blk-mq.c                | 97 ++++++++++++++---------------------
>   drivers/block/null_blk/main.c | 16 +++---
>   drivers/block/ublk_drv.c      | 43 +++++++---------
>   drivers/block/virtio_blk.c    | 31 +++++------
>   drivers/nvme/host/pci.c       | 32 ++++++------
>   include/linux/blk-mq.h        |  2 +-
>   include/linux/blkdev.h        |  2 +-
>   9 files changed, 103 insertions(+), 133 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b862c66018f2..29aad939a1e3 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1127,7 +1127,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
>   		return;
>   
>   	plug->cur_ktime = 0;
> -	rq_list_init(&plug->mq_list);
> +	INIT_LIST_HEAD(&plug->mq_list);
>   	rq_list_init(&plug->cached_rqs);
>   	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
>   	plug->rq_count = 0;
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 70d704615be5..223941e9ec08 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -995,17 +995,10 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
>   	struct blk_plug *plug = current->plug;
>   	struct request *rq;
>   
> -	if (!plug || rq_list_empty(&plug->mq_list))
> +	if (!plug)
>   		return false;
>   
> -	rq = plug->mq_list.tail;
> -	if (rq->q == q)
> -		return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
> -			BIO_MERGE_OK;
> -	else if (!plug->multiple_queues)
> -		return false;
> -
> -	rq_list_for_each(&plug->mq_list, rq) {
> +	list_for_each_entry_reverse(rq, &plug->mq_list, queuelist) {
>   		if (rq->q != q)
>   			continue;
>   		if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4806b867e37d..6d56471d4346 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1378,7 +1378,8 @@ static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
>   
>   static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>   {
> -	struct request *last = rq_list_peek(&plug->mq_list);
> +	struct request *last =
> +		list_last_entry(&plug->mq_list, struct request, queuelist);
>   
>   	if (!plug->rq_count) {
>   		trace_block_plug(rq->q);
> @@ -1398,7 +1399,7 @@ static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
>   	 */
>   	if (!plug->has_elevator && (rq->rq_flags & RQF_SCHED_TAGS))
>   		plug->has_elevator = true;
> -	rq_list_add_tail(&plug->mq_list, rq);
> +	list_add_tail(&rq->queuelist, &plug->mq_list);
>   	plug->rq_count++;
>   }
>   
> @@ -2780,15 +2781,15 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
>   	return __blk_mq_issue_directly(hctx, rq, last);
>   }
>   
> -static void blk_mq_issue_direct(struct rq_list *rqs)
> +static void blk_mq_issue_direct(struct list_head *rqs)
>   {
>   	struct blk_mq_hw_ctx *hctx = NULL;
> -	struct request *rq;
> +	struct request *rq, *n;
>   	int queued = 0;
>   	blk_status_t ret = BLK_STS_OK;
>   
> -	while ((rq = rq_list_pop(rqs))) {
> -		bool last = rq_list_empty(rqs);
> +	list_for_each_entry_safe(rq, n, rqs, queuelist) {
> +		list_del_init(&rq->queuelist);
>   
>   		if (hctx != rq->mq_hctx) {
>   			if (hctx) {
> @@ -2798,7 +2799,7 @@ static void blk_mq_issue_direct(struct rq_list *rqs)
>   			hctx = rq->mq_hctx;
>   		}
>   
> -		ret = blk_mq_request_issue_directly(rq, last);
> +		ret = blk_mq_request_issue_directly(rq, list_empty(rqs));
>   		switch (ret) {
>   		case BLK_STS_OK:
>   			queued++;
> @@ -2819,45 +2820,18 @@ static void blk_mq_issue_direct(struct rq_list *rqs)
>   		blk_mq_commit_rqs(hctx, queued, false);
>   }
>   
> -static void __blk_mq_flush_list(struct request_queue *q, struct rq_list *rqs)
> +static void __blk_mq_flush_list(struct request_queue *q, struct list_head *rqs)
>   {
>   	if (blk_queue_quiesced(q))
>   		return;
>   	q->mq_ops->queue_rqs(rqs);
>   }
>   
> -static unsigned blk_mq_extract_queue_requests(struct rq_list *rqs,
> -					      struct rq_list *queue_rqs)
> -{
> -	struct request *rq = rq_list_pop(rqs);
> -	struct request_queue *this_q = rq->q;
> -	struct request **prev = &rqs->head;
> -	struct rq_list matched_rqs = {};
> -	struct request *last = NULL;
> -	unsigned depth = 1;
> -
> -	rq_list_add_tail(&matched_rqs, rq);
> -	while ((rq = *prev)) {
> -		if (rq->q == this_q) {
> -			/* move rq from rqs to matched_rqs */
> -			*prev = rq->rq_next;
> -			rq_list_add_tail(&matched_rqs, rq);
> -			depth++;
> -		} else {
> -			/* leave rq in rqs */
> -			prev = &rq->rq_next;
> -			last = rq;
> -		}
> -	}
> -
> -	rqs->tail = last;
> -	*queue_rqs = matched_rqs;
> -	return depth;
> -}
> -
> -static void blk_mq_dispatch_queue_requests(struct rq_list *rqs, unsigned depth)
> +static void blk_mq_dispatch_queue_requests(struct list_head *rqs,
> +					   unsigned depth)
>   {
> -	struct request_queue *q = rq_list_peek(rqs)->q;
> +	struct request *rq = list_first_entry(rqs, struct request, queuelist);
> +	struct request_queue *q = rq->q;
>   
>   	trace_block_unplug(q, depth, true);
>   
> @@ -2869,39 +2843,35 @@ static void blk_mq_dispatch_queue_requests(struct rq_list *rqs, unsigned depth)
>   	 */
>   	if (q->mq_ops->queue_rqs) {
>   		blk_mq_run_dispatch_ops(q, __blk_mq_flush_list(q, rqs));
> -		if (rq_list_empty(rqs))
> +		if (list_empty(rqs))
>   			return;
>   	}
>   
>   	blk_mq_run_dispatch_ops(q, blk_mq_issue_direct(rqs));
>   }
>   
> -static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
> +static void blk_mq_dispatch_list(struct list_head *rqs, bool from_sched)
>   {
>   	struct blk_mq_hw_ctx *this_hctx = NULL;
>   	struct blk_mq_ctx *this_ctx = NULL;
> -	struct rq_list requeue_list = {};
> +	LIST_HEAD(list);
> +	struct request *rq, *n;
>   	unsigned int depth = 0;
>   	bool is_passthrough = false;
> -	LIST_HEAD(list);
> -
> -	do {
> -		struct request *rq = rq_list_pop(rqs);
>   
> +	list_for_each_entry_safe(rq, n, rqs, queuelist) {
>   		if (!this_hctx) {
>   			this_hctx = rq->mq_hctx;
>   			this_ctx = rq->mq_ctx;
>   			is_passthrough = blk_rq_is_passthrough(rq);
>   		} else if (this_hctx != rq->mq_hctx || this_ctx != rq->mq_ctx ||
>   			   is_passthrough != blk_rq_is_passthrough(rq)) {
> -			rq_list_add_tail(&requeue_list, rq);
>   			continue;
>   		}
> -		list_add_tail(&rq->queuelist, &list);
> +		list_move_tail(&rq->queuelist, &list);
>   		depth++;
> -	} while (!rq_list_empty(rqs));
> +	}
>   
> -	*rqs = requeue_list;
>   	trace_block_unplug(this_hctx->queue, depth, !from_sched);
>   
>   	percpu_ref_get(&this_hctx->queue->q_usage_counter);
> @@ -2921,17 +2891,27 @@ static void blk_mq_dispatch_list(struct rq_list *rqs, bool from_sched)
>   	percpu_ref_put(&this_hctx->queue->q_usage_counter);
>   }
>   
> -static void blk_mq_dispatch_multiple_queue_requests(struct rq_list *rqs)
> +static void blk_mq_dispatch_multiple_queue_requests(struct list_head *rqs)
>   {
>   	do {
> -		struct rq_list queue_rqs;
> -		unsigned depth;
> +		struct request_queue *this_q = NULL;
> +		struct request *rq, *n;
> +		LIST_HEAD(queue_rqs);
> +		unsigned depth = 0;
> +
> +		list_for_each_entry_safe(rq, n, rqs, queuelist) {
> +			if (!this_q)
> +				this_q = rq->q;
> +			if (this_q == rq->q) {
> +				list_move_tail(&rq->queuelist, &queue_rqs);
> +				depth++;
> +			}
> +		}
>   
> -		depth = blk_mq_extract_queue_requests(rqs, &queue_rqs);
>   		blk_mq_dispatch_queue_requests(&queue_rqs, depth);
> -		while (!rq_list_empty(&queue_rqs))
> +		while (!list_empty(&queue_rqs))
>   			blk_mq_dispatch_list(&queue_rqs, false);
> -	} while (!rq_list_empty(rqs));
> +	} while (!list_empty(rqs));
>   }
>   
>   void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
> @@ -2955,15 +2935,14 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>   			blk_mq_dispatch_multiple_queue_requests(&plug->mq_list);
>   			return;
>   		}
> -
>   		blk_mq_dispatch_queue_requests(&plug->mq_list, depth);
> -		if (rq_list_empty(&plug->mq_list))
> +		if (list_empty(&plug->mq_list))
>   			return;
>   	}
>   
>   	do {
>   		blk_mq_dispatch_list(&plug->mq_list, from_schedule);
> -	} while (!rq_list_empty(&plug->mq_list));
> +	} while (!list_empty(&plug->mq_list));
>   }
>   
>   static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index aa163ae9b2aa..ce3ac928122f 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1694,22 +1694,22 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	return BLK_STS_OK;
>   }
>   
> -static void null_queue_rqs(struct rq_list *rqlist)
> +static void null_queue_rqs(struct list_head *rqlist)
>   {
> -	struct rq_list requeue_list = {};
>   	struct blk_mq_queue_data bd = { };
> +	LIST_HEAD(requeue_list);
> +	struct request *rq, *n;
>   	blk_status_t ret;
>   
> -	do {
> -		struct request *rq = rq_list_pop(rqlist);
> -
> +	list_for_each_entry_safe(rq, n, rqlist, queuelist) {
>   		bd.rq = rq;
>   		ret = null_queue_rq(rq->mq_hctx, &bd);
>   		if (ret != BLK_STS_OK)
> -			rq_list_add_tail(&requeue_list, rq);
> -	} while (!rq_list_empty(rqlist));
> +			list_move_tail(&rq->queuelist, &requeue_list);
> +	}
>   
> -	*rqlist = requeue_list;
> +	INIT_LIST_HEAD(rqlist);
> +	list_splice(&requeue_list, rqlist);
>   }
>   
>   static void null_init_queue(struct nullb *nullb, struct nullb_queue *nq)
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index c637ea010d34..4d5b88ca7b1b 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -101,7 +101,7 @@ struct ublk_uring_cmd_pdu {
>   	 */
>   	union {
>   		struct request *req;
> -		struct request *req_list;
> +		struct list_head req_list;
>   	};
>   
>   	/*
> @@ -1325,24 +1325,18 @@ static void ublk_cmd_list_tw_cb(struct io_uring_cmd *cmd,
>   		unsigned int issue_flags)
>   {
>   	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
> -	struct request *rq = pdu->req_list;
> -	struct request *next;
> +	struct request *rq, *n;
>   
> -	do {
> -		next = rq->rq_next;
> -		rq->rq_next = NULL;
> +	list_for_each_entry_safe(rq, n, &pdu->req_list, queuelist)
>   		ublk_dispatch_req(rq->mq_hctx->driver_data, rq, issue_flags);
> -		rq = next;
> -	} while (rq);
>   }
>   
> -static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
> +static void ublk_queue_cmd_list(struct ublk_io *io, struct list_head *rqlist)
>   {
>   	struct io_uring_cmd *cmd = io->cmd;
>   	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
>   
> -	pdu->req_list = rq_list_peek(l);
> -	rq_list_init(l);
> +	list_splice(&pdu->req_list, rqlist);
>   	io_uring_cmd_complete_in_task(cmd, ublk_cmd_list_tw_cb);
>   }
>   
> @@ -1416,30 +1410,31 @@ static blk_status_t ublk_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	return BLK_STS_OK;
>   }
>   
> -static void ublk_queue_rqs(struct rq_list *rqlist)
> +static void ublk_queue_rqs(struct list_head *rqlist)
>   {
> -	struct rq_list requeue_list = { };
> -	struct rq_list submit_list = { };
>   	struct ublk_io *io = NULL;
> -	struct request *req;
> +	struct request *req, *n;
> +	LIST_HEAD(requeue_list);
>   
> -	while ((req = rq_list_pop(rqlist))) {
> +	list_for_each_entry_safe(req, n, rqlist, queuelist) {
>   		struct ublk_queue *this_q = req->mq_hctx->driver_data;
>   		struct ublk_io *this_io = &this_q->ios[req->tag];
>   
> -		if (io && io->task != this_io->task && !rq_list_empty(&submit_list))
> +		if (io && io->task != this_io->task) {
> +			LIST_HEAD(submit_list);
> +
> +			list_cut_before(&submit_list, rqlist, &req->queuelist);
>   			ublk_queue_cmd_list(io, &submit_list);
> +		}
>   		io = this_io;
>   
> -		if (ublk_prep_req(this_q, req, true) == BLK_STS_OK)
> -			rq_list_add_tail(&submit_list, req);
> -		else
> -			rq_list_add_tail(&requeue_list, req);
> +		if (ublk_prep_req(this_q, req, true) != BLK_STS_OK)
> +			list_move_tail(&req->queuelist, &requeue_list);
>   	}
>   
> -	if (!rq_list_empty(&submit_list))
> -		ublk_queue_cmd_list(io, &submit_list);
> -	*rqlist = requeue_list;
> +	if (!list_empty(rqlist))
> +		ublk_queue_cmd_list(io, rqlist);
> +	list_splice(&requeue_list, rqlist);
>   }
>   
>   static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 30bca8cb7106..29f900eada0f 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -471,15 +471,14 @@ static bool virtblk_prep_rq_batch(struct request *req)
>   }
>   
>   static void virtblk_add_req_batch(struct virtio_blk_vq *vq,
> -		struct rq_list *rqlist)
> +		struct list_head *rqlist)
>   {
>   	struct request *req;
>   	unsigned long flags;
>   	bool kick;
>   
>   	spin_lock_irqsave(&vq->lock, flags);
> -
> -	while ((req = rq_list_pop(rqlist))) {
> +	list_for_each_entry(req, rqlist, queuelist) {
>   		struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
>   		int err;
>   

Arguably this changes the outcome; in the original code rq_list_pop()
would remove the bios from the list, with your conversion we're leaving
the list intact (even though the bios have been processed).
Shouldn't we be using 'list_del_init()' (or at least 'list_del()') here
to clear out the list?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
