Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B95C433DB
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 11:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C813464F6A
	for <linux-block@archiver.kernel.org>; Wed,  3 Feb 2021 11:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhBCLs7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Feb 2021 06:48:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:59444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233972AbhBCLsv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Feb 2021 06:48:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39098AD62;
        Wed,  3 Feb 2021 11:48:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E3DEF1E14B6; Wed,  3 Feb 2021 12:48:06 +0100 (CET)
Date:   Wed, 3 Feb 2021 12:48:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 5/6] block, bfq: keep shared queues
 out of the waker mechanism
Message-ID: <20210203114806.GC7094@quack2.suse.cz>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
 <20210126105102.53102-6-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126105102.53102-6-paolo.valente@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 26-01-21 11:51:01, Paolo Valente wrote:
> Shared queues are likely to receive I/O at a high rate. This may
> deceptively let them be considered as wakers of other queues. But a
> false waker will unjustly steal bandwidth to its supposedly woken
> queue. So considering also shared queues in the waking mechanism may
> cause more control troubles than throughput benefits. This commit
> keeps shared queues out of the waker-detection mechanism.
> 
> Tested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>

Honestly this makes me somewhat nervous. It is just a band aid for a fact
that waker detection is unreliable? There's nothing which prevents
non-shared queue to submit high amounts of IO (e.g. when it uses AIO) as
well as there's nothing which says that shared queues have no wakers (e.g.
jbd2 thread can easily be a waker for a shared queue).

								Honza

> ---
>  block/bfq-iosched.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0c7e203085f1..23d0dd7bd90f 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -5825,7 +5825,17 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
>  			1UL<<(BFQ_RATE_SHIFT - 10))
>  		bfq_update_rate_reset(bfqd, NULL);
>  	bfqd->last_completion = now_ns;
> -	bfqd->last_completed_rq_bfqq = bfqq;
> +	/*
> +	 * Shared queues are likely to receive I/O at a high
> +	 * rate. This may deceptively let them be considered as wakers
> +	 * of other queues. But a false waker will unjustly steal
> +	 * bandwidth to its supposedly woken queue. So considering
> +	 * also shared queues in the waking mechanism may cause more
> +	 * control troubles than throughput benefits. Then do not set
> +	 * last_completed_rq_bfqq to bfqq if bfqq is a shared queue.
> +	 */
> +	if (!bfq_bfqq_coop(bfqq))
> +		bfqd->last_completed_rq_bfqq = bfqq;
>  
>  	/*
>  	 * If we are waiting to discover whether the request pattern
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
