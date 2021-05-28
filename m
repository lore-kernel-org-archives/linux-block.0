Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2026EC47087
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 09:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D1B6128B
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 09:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhE1JbO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 May 2021 05:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhE1JbO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 May 2021 05:31:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D179C061574
        for <linux-block@vger.kernel.org>; Fri, 28 May 2021 02:29:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n2so2677934wrm.0
        for <linux-block@vger.kernel.org>; Fri, 28 May 2021 02:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y1vlYKDI+52vWzlMTTJWQDk0AsKqpUApam7hveS8Lyk=;
        b=tUE4UA6dvxVW4EiZpUjZmbv16HoA255mc5TODbgGRoPHd69srCYk+9yQu6sU1bUivA
         jUhB0Z7g1PsgLGkjzJbRB+f6xG8mGuJXLXUfEaZp0RR4R7zYMUxzmLS8soTlaEGBkQh+
         zJmbdHk0tq36SM+Of80pRWzWexQE+Z7owU6dC2H2dHMxqbUj7xuCFN7F2ArT6Qxqa03y
         7EgIB023x9m9GnkTQ5ojLUAChUS0g5dEO5o0YV0ELlix/B5GoUam6i/AOsCbLtfUZPSy
         tCO0cOV2Ujxvqi797/SJrA/K/WE4igmE8PX36+mIVmB5IuHlwT1NNxln+mLT1XOruThL
         T8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y1vlYKDI+52vWzlMTTJWQDk0AsKqpUApam7hveS8Lyk=;
        b=mv1xb1MFZ2VIu6aNKgXmRsLmiICMjLST3W8WWN0RTH+b2yo/F5+jp9Y1bfhI5Uixw+
         isuTuw8q4U4cf854ZhCc49nsW3vQDZSzY8yB9twDBrkDoXvkmlBY2UeIzjr3k5j8g9am
         UDM/PjQdKkN0BZ9FCetp14kaqfolJIbL7ftKC9eWK+jYUQ2j31ik//FL0Ekwea68ZKsX
         JVQKjYOsy5Ta2POKrUeTTy+CQL6lrmCX+TDotlSXetPEvW1sPo0uRqHha8mowbuup1uo
         o5d6s0um0NK0YYH06IW0ebfYmD/74sIbLviCc1H065PHGZJUE6g1BuZEkUgvkUDtKYGL
         h2ZQ==
X-Gm-Message-State: AOAM531t44Sj1xZNxM/dZRAKHqG0OYLi37WvF/OPE6ftdc5P3yeV6LEM
        oiGa0tX/W1OdUJRUwtv1Qen1vw==
X-Google-Smtp-Source: ABdhPJy19tTJew3kMK4hGuiv98gi4h/Dq9biHzYMzkKyWIpbDbtGlmtRHhyjh91kAubZoxyqUt2JjA==
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr7907301wrs.154.1622194177914;
        Fri, 28 May 2021 02:29:37 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id p5sm7643538wrd.25.2021.05.28.02.29.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 May 2021 02:29:37 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] bfq: Remove merged request already in
 bfq_requests_merged()
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210524100416.3578-2-jack@suse.cz>
Date:   Fri, 28 May 2021 11:29:36 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <36A5F676-7720-400A-8127-CECF54FFA587@linaro.org>
References: <20210524100416.3578-1-jack@suse.cz>
 <20210524100416.3578-2-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 24 mag 2021, alle ore 12:04, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> Currently, bfq does very little in bfq_requests_merged() and handles =
all
> the request cleanup in bfq_finish_requeue_request() called from
> blk_mq_free_request(). That is currently safe only because
> blk_mq_free_request() is called shortly after bfq_requests_merged()
> while bfqd->lock is still held. However to fix a lock inversion =
between
> bfqd->lock and ioc->lock, we need to call blk_mq_free_request() after
> dropping bfqd->lock. That would mean that already merged request could
> be seen by other processes inside bfq queues and possibly dispatched =
to
> the device which is wrong. So move cleanup of the request from
> bfq_finish_requeue_request() to bfq_requests_merged().
>=20

I didn't even remember any longer why I had to handle that deferred
removal in bfq_finish_requeue_request() :)

Your solution seems very clean to me.

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> block/bfq-iosched.c | 41 +++++++++++++----------------------------
> 1 file changed, 13 insertions(+), 28 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index acd1f881273e..50a29fdf51da 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2405,7 +2405,7 @@ static void bfq_requests_merged(struct =
request_queue *q, struct request *rq,
> 		*next_bfqq =3D bfq_init_rq(next);
>=20
> 	if (!bfqq)
> -		return;
> +		goto remove;
>=20
> 	/*
> 	 * If next and rq belong to the same bfq_queue and next is older
> @@ -2428,6 +2428,14 @@ static void bfq_requests_merged(struct =
request_queue *q, struct request *rq,
> 		bfqq->next_rq =3D rq;
>=20
> 	bfqg_stats_update_io_merged(bfqq_group(bfqq), next->cmd_flags);
> +remove:
> +	/* Merged request may be in the IO scheduler. Remove it. */
> +	if (!RB_EMPTY_NODE(&next->rb_node)) {
> +		bfq_remove_request(next->q, next);
> +		if (next_bfqq)
> +			=
bfqg_stats_update_io_remove(bfqq_group(next_bfqq),
> +						    next->cmd_flags);
> +	}
> }
>=20
> /* Must be called with bfqq !=3D NULL */
> @@ -6376,6 +6384,7 @@ static void bfq_finish_requeue_request(struct =
request *rq)
> {
> 	struct bfq_queue *bfqq =3D RQ_BFQQ(rq);
> 	struct bfq_data *bfqd;
> +	unsigned long flags;
>=20
> 	/*
> 	 * rq either is not associated with any icq, or is an already
> @@ -6393,39 +6402,15 @@ static void bfq_finish_requeue_request(struct =
request *rq)
> 					     rq->io_start_time_ns,
> 					     rq->cmd_flags);
>=20
> +	spin_lock_irqsave(&bfqd->lock, flags);
> 	if (likely(rq->rq_flags & RQF_STARTED)) {
> -		unsigned long flags;
> -
> -		spin_lock_irqsave(&bfqd->lock, flags);
> -
> 		if (rq =3D=3D bfqd->waited_rq)
> 			bfq_update_inject_limit(bfqd, bfqq);
>=20
> 		bfq_completed_request(bfqq, bfqd);
> -		bfq_finish_requeue_request_body(bfqq);
> -
> -		spin_unlock_irqrestore(&bfqd->lock, flags);
> -	} else {
> -		/*
> -		 * Request rq may be still/already in the scheduler,
> -		 * in which case we need to remove it (this should
> -		 * never happen in case of requeue). And we cannot
> -		 * defer such a check and removal, to avoid
> -		 * inconsistencies in the time interval from the end
> -		 * of this function to the start of the deferred work.
> -		 * This situation seems to occur only in process
> -		 * context, as a consequence of a merge. In the
> -		 * current version of the code, this implies that the
> -		 * lock is held.
> -		 */
> -
> -		if (!RB_EMPTY_NODE(&rq->rb_node)) {
> -			bfq_remove_request(rq->q, rq);
> -			bfqg_stats_update_io_remove(bfqq_group(bfqq),
> -						    rq->cmd_flags);
> -		}
> -		bfq_finish_requeue_request_body(bfqq);
> 	}
> +	bfq_finish_requeue_request_body(bfqq);
> +	spin_unlock_irqrestore(&bfqd->lock, flags);
>=20
> 	/*
> 	 * Reset private fields. In case of a requeue, this allows
> --=20
> 2.26.2
>=20

