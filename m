Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3715DC04AA5
	for <linux-block@archiver.kernel.org>; Thu, 25 Aug 2022 06:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiHYGJ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Aug 2022 02:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiHYGJz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Aug 2022 02:09:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16083CBF2
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 23:09:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 73F715C7BA;
        Thu, 25 Aug 2022 06:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661407791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwcOpY3F5XtP0jX7EiZRywIo9Gg4HIyiw9AuiEK6394=;
        b=kyb2dsCTepC2JWS2UKDLBuTK8LaKYRFCu65paR13HEBj/mOv3NG16TvAjjkx7+Hj4qAMYg
        Bl4ngRgIzaFV1PjkaK2vLtbanCow5sk/R0FSXFxKkZZiw89Nd4BdSgVwoAsotbb5BaQcsC
        rwg4Kx2ywqt85zufkBDqmTyZS7Ra8Lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661407791;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwcOpY3F5XtP0jX7EiZRywIo9Gg4HIyiw9AuiEK6394=;
        b=0F7hvm48xyqOEAb2aS3j6haWdLD0LBZmCtEuPnietPyJCbis0XjmpkgiQ+diK4cOV71Q8c
        REY8bzy4Do+erLAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5290213A89;
        Thu, 25 Aug 2022 06:09:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sjAkEy8SB2ObMQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 25 Aug 2022 06:09:51 +0000
Message-ID: <bda24921-8fcb-8e22-6685-2614ce1bec5f@suse.de>
Date:   Thu, 25 Aug 2022 08:09:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv2] sbitmap: fix batched wait_cnt accounting
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>
References: <20220824201440.127782-1-kbusch@fb.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220824201440.127782-1-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/24/22 22:14, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Batched completions can clear multiple bits, but we're only decrementing
> the wait_cnt by one each time. This can cause waiters to never be woken,
> stalling IO. Use the batched count instead.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215679
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>    Use atomic_try_cmpxchg instead of direct subtraction to prevent a race
>    between two batched completions.
> 
>    Remove 'wait_cnt < 0' condition since it's not possible anymore.
> 
>    Repeat wake up while waiters exist and more bits are unaccounted.
> 
>   block/blk-mq-tag.c      |  2 +-
>   include/linux/sbitmap.h |  3 ++-
>   lib/sbitmap.c           | 32 ++++++++++++++++++--------------
>   3 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 8e3b36d1cb57..9eb968e14d31 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -196,7 +196,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
>   		 * other allocations on previous queue won't be starved.
>   		 */
>   		if (bt != bt_prev)
> -			sbitmap_queue_wake_up(bt_prev);
> +			sbitmap_queue_wake_up(bt_prev, 1);
>   
>   		ws = bt_wait_ptr(bt, data->hctx);
>   	} while (1);
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index 8f5a86e210b9..4d2d5205ab58 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -575,8 +575,9 @@ void sbitmap_queue_wake_all(struct sbitmap_queue *sbq);
>    * sbitmap_queue_wake_up() - Wake up some of waiters in one waitqueue
>    * on a &struct sbitmap_queue.
>    * @sbq: Bitmap queue to wake up.
> + * @nr: Number of bits cleared.
>    */
> -void sbitmap_queue_wake_up(struct sbitmap_queue *sbq);
> +void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr);
>   
>   /**
>    * sbitmap_queue_show() - Dump &struct sbitmap_queue information to a &struct
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 1f31147872e6..6fd3bc22c2e7 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -600,28 +600,33 @@ static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
>   	return NULL;
>   }
>   
> -static bool __sbq_wake_up(struct sbitmap_queue *sbq)
> +static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)

Why is '*nr' a pointer? It's always used as a value, so what does 
promoting it to a point buys you?

>   {
>   	struct sbq_wait_state *ws;
> -	unsigned int wake_batch;
> -	int wait_cnt;
> +	int wake_batch, wait_cnt, sub, cur;
>   
>   	ws = sbq_wake_ptr(sbq);
>   	if (!ws)
>   		return false;
>   
> -	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> +	wake_batch = READ_ONCE(sbq->wake_batch);
> +	do {
> +		cur = atomic_read(&ws->wait_cnt);
> +		sub = min3(wake_batch, *nr, cur);
> +		wait_cnt = cur - sub;
> +	} while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));
> +
> +	*nr -= sub;
> +
>   	/*
>   	 * For concurrent callers of this, callers should call this function
>   	 * again to wakeup a new batch on a different 'ws'.
>   	 */
> -	if (wait_cnt < 0 || !waitqueue_active(&ws->wait))
> +	if (!waitqueue_active(&ws->wait))
>   		return true;
>   
>   	if (wait_cnt > 0)
> -		return false;
> -
> -	wake_batch = READ_ONCE(sbq->wake_batch);
> +		return *nr > 0;
>   
>   	/*
>   	 * Wake up first in case that concurrent callers decrease wait_cnt
> @@ -649,15 +654,14 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>   	sbq_index_atomic_inc(&sbq->wake_index);
>   	atomic_set(&ws->wait_cnt, wake_batch);
>   
> -	return false;
> +	return *nr > 0;
>   }
>   
> -void sbitmap_queue_wake_up(struct sbitmap_queue *sbq)
> +void sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
>   {
> -	while (__sbq_wake_up(sbq))
> +	while (__sbq_wake_up(sbq, &nr))
>   		;
>   }
> -EXPORT_SYMBOL_GPL(sbitmap_queue_wake_up);
>   
>   static inline void sbitmap_update_cpu_hint(struct sbitmap *sb, int cpu, int tag)
>   {
> @@ -694,7 +698,7 @@ void sbitmap_queue_clear_batch(struct sbitmap_queue *sbq, int offset,
>   		atomic_long_andnot(mask, (atomic_long_t *) addr);
>   
>   	smp_mb__after_atomic();
> -	sbitmap_queue_wake_up(sbq);
> +	sbitmap_queue_wake_up(sbq, nr_tags);
>   	sbitmap_update_cpu_hint(&sbq->sb, raw_smp_processor_id(),
>   					tags[nr_tags - 1] - offset);
>   }
> @@ -722,7 +726,7 @@ void sbitmap_queue_clear(struct sbitmap_queue *sbq, unsigned int nr,
>   	 * waiter. See the comment on waitqueue_active().
>   	 */
>   	smp_mb__after_atomic();
> -	sbitmap_queue_wake_up(sbq);
> +	sbitmap_queue_wake_up(sbq, 1);
>   	sbitmap_update_cpu_hint(&sbq->sb, cpu, nr);
>   }
>   EXPORT_SYMBOL_GPL(sbitmap_queue_clear);

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
