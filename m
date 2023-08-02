Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92278C04A6A
	for <linux-block@archiver.kernel.org>; Wed,  2 Aug 2023 16:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjHBQF5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Aug 2023 12:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbjHBQF4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Aug 2023 12:05:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085051717
        for <linux-block@vger.kernel.org>; Wed,  2 Aug 2023 09:05:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8BC211F37C;
        Wed,  2 Aug 2023 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690992353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kqi9YBGYn9nvAOhtQwL08OVhTuphxSAzwlTF3Q9+mPg=;
        b=BwHRPRWjLyClOS3tSA5tEgPQKsiLjdO0uJotzCS1eVe6X0Zdfkbu/RoIGkloDBndOkKV84
        R7g+rW46IoJSQ1Q7aBp305RpSkycn7EEFQLgLdpQ18Ph9teX7OTps5VPEVS+jt7W45a5d9
        JGa13grimFQGoVXTkGJ7iCg8I/Fkiyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690992353;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kqi9YBGYn9nvAOhtQwL08OVhTuphxSAzwlTF3Q9+mPg=;
        b=fxWCJL0R9cmhwF464ufNNQN20NqvrYO2QZfPU/yuOhhKJBQgDkU6UDINcZ1EApFlXsWrqJ
        ZadhLfHAohMEdrBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7870F13909;
        Wed,  2 Aug 2023 16:05:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 51FiHeF+ymSsQAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 02 Aug 2023 16:05:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0A544A076B; Wed,  2 Aug 2023 18:05:53 +0200 (CEST)
Date:   Wed, 2 Aug 2023 18:05:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        David Jeffery <djeffery@redhat.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] sbitmap: fix batching wakeup
Message-ID: <20230802160553.uv5wn6nfjseniyxx@quack3>
References: <20230721095715.232728-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721095715.232728-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 21-07-23 17:57:15, Ming Lei wrote:
> From: David Jeffery <djeffery@redhat.com>
> 
> Current code supposes that it is enough to provide forward progress by just
> waking up one wait queue after one completion batch is done.
> 
> Unfortunately this way isn't enough, cause waiter can be added to
> wait queue just after it is woken up.
> 
> Follows one example(64 depth, wake_batch is 8)
> 
> 1) all 64 tags are active
> 
> 2) in each wait queue, there is only one single waiter
> 
> 3) each time one completion batch(8 completions) wakes up just one waiter in each wait
> queue, then immediately one new sleeper is added to this wait queue
> 
> 4) after 64 completions, 8 waiters are wakeup, and there are still 8 waiters in each
> wait queue
> 
> 5) after another 8 active tags are completed, only one waiter can be wakeup, and the other 7
> can't be waken up anymore.
> 
> Turns out it isn't easy to fix this problem, so simply wakeup enough waiters for
> single batch.
> 
> Cc: David Jeffery <djeffery@redhat.com>
> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> Cc: Gabriel Krisman Bertazi <krisman@suse.de>
> Cc: Chengming Zhou <zhouchengming@bytedance.com>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I'm sorry for the delay - I was on vacation. I can see the patch got
already merged and I'm not strictly against that (although I think Gabriel
was experimenting with this exact wakeup scheme and as far as I remember
the more eager waking up was causing performance decrease for some
configurations). But let me challenge the analysis above a bit. For the
sleeper to be added to a waitqueue in step 3), blk_mq_mark_tag_wait() must
fail the blk_mq_get_driver_tag() call. Which means that all tags were used
at that moment. To summarize, anytime we add any new waiter to the
waitqueue, all tags are used and thus we should eventually receive enough
wakeups to wake all of them. What am I missing?

								Honza

> ---
>  lib/sbitmap.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index eff4e42c425a..d0a5081dfd12 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -550,7 +550,7 @@ EXPORT_SYMBOL_GPL(sbitmap_queue_min_shallow_depth);
>  
>  static void __sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
>  {
> -	int i, wake_index;
> +	int i, wake_index, woken;
>  
>  	if (!atomic_read(&sbq->ws_active))
>  		return;
> @@ -567,13 +567,12 @@ static void __sbitmap_queue_wake_up(struct sbitmap_queue *sbq, int nr)
>  		 */
>  		wake_index = sbq_index_inc(wake_index);
>  
> -		/*
> -		 * It is sufficient to wake up at least one waiter to
> -		 * guarantee forward progress.
> -		 */
> -		if (waitqueue_active(&ws->wait) &&
> -		    wake_up_nr(&ws->wait, nr))
> -			break;
> +		if (waitqueue_active(&ws->wait)) {
> +			woken = wake_up_nr(&ws->wait, nr);
> +			if (woken == nr)
> +				break;
> +			nr -= woken;
> +		}
>  	}
>  
>  	if (wake_index != atomic_read(&sbq->wake_index))
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
