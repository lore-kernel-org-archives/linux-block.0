Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D755C47087
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 09:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2021C60E0B
	for <linux-block@archiver.kernel.org>; Fri, 28 May 2021 09:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhE1JfG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 May 2021 05:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbhE1JfC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 May 2021 05:35:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF57C061763
        for <linux-block@vger.kernel.org>; Fri, 28 May 2021 02:33:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f17so317443wmf.2
        for <linux-block@vger.kernel.org>; Fri, 28 May 2021 02:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qI80K2AH8M5E/gOyv0r5yZj6mzImIecz2Ms4kDGaT8A=;
        b=Ik/OYOKag/YpJjx2cFGQCiYvGzM1Y4AwB0GGozbD5L7hOaLFcnhaJ1AQUvloFQwKc/
         30IHDYI5JDCjUy9cpS4JIpkTzYJ7HD+mJh8WHz5Ai8TDRX7M7NbQ43IHtfnl49PvHiqI
         k/9kDf59Xcv0rysxcRH1A4siIf80uLB+HB7Xc6X+qg3oV4suOvYxfJI1Zx4Hmfa73UvU
         YugRrdwzDuzJ2E2N2RHEnlDgCl3lF//Y7BPuHnBcESB96wCmCWGa/CakYZsYOZYMYkFq
         KkTnos8sQz2N+Hiw7Xjzc/hEzyo49GmotmU9N1SvCZCqpiIQgpo8uclbwJAIEyz2kJ/N
         Aydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qI80K2AH8M5E/gOyv0r5yZj6mzImIecz2Ms4kDGaT8A=;
        b=AC0Pk2QtWq6WhJqEQ6sUdI7hGgDvh00BOAzADS7FgtwvHXl0EI2uJ9X8UcxhAnXhTd
         Y2GfC/bwTxqrJA0kRdu3/sFwjY90kPwVqaX8H6eqc6T+1I6LmnLnW+npby77Nab/84DR
         oUpbXfB9M9AuwRW3qxxzJFzlvDV9McbnqThnNy47Vwt9xXiYsgZ7Om58YiyVCqppAyE6
         q4JdvGTZFdkIxBfIcaFzQZZKDr/3PcRYlD5ROEdf1fo8aZdysqvZLscs8vk/HxtXsl5i
         MXaDXcD9KU9iH6vpDlxDp0RJPXMbXMPDLAx8d5W2C7BO7TRqKUSC8KDnz1zIe/Ii8ovp
         t5UQ==
X-Gm-Message-State: AOAM531JCWVjDqr+b/9ae1327rAAZg06RNKxlb7UnqSdwFZKoE1CiOTs
        eYXJo61v7cO3B5PsTTwzcFqpkCDpOlTWUrFN
X-Google-Smtp-Source: ABdhPJwerCzAC+wR1QZgMHbO5S2LtLNISwhmdWZgyRpIlN7Ne/3P4p7WG+oPLvM9t2IeOPag7fiiKQ==
X-Received: by 2002:a7b:cc10:: with SMTP id f16mr7773809wmh.24.1622194406243;
        Fri, 28 May 2021 02:33:26 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id t14sm6372356wra.60.2021.05.28.02.33.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 May 2021 02:33:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/2] blk: Fix lock inversion between ioc lock and bfqd
 lock
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20210524100416.3578-3-jack@suse.cz>
Date:   Fri, 28 May 2021 11:33:24 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Khazhy Kumykov <khazhy@google.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C330252-E3D5-4274-B377-39FF6DBBD9C2@linaro.org>
References: <20210524100416.3578-1-jack@suse.cz>
 <20210524100416.3578-3-jack@suse.cz>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 24 mag 2021, alle ore 12:04, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> Lockdep complains about lock inversion between ioc->lock and =
bfqd->lock:
>=20
> bfqd -> ioc:
> put_io_context+0x33/0x90 -> ioc->lock grabbed
> blk_mq_free_request+0x51/0x140
> blk_put_request+0xe/0x10
> blk_attempt_req_merge+0x1d/0x30
> elv_attempt_insert_merge+0x56/0xa0
> blk_mq_sched_try_insert_merge+0x4b/0x60
> bfq_insert_requests+0x9e/0x18c0 -> bfqd->lock grabbed
> blk_mq_sched_insert_requests+0xd6/0x2b0
> blk_mq_flush_plug_list+0x154/0x280
> blk_finish_plug+0x40/0x60
> ext4_writepages+0x696/0x1320
> do_writepages+0x1c/0x80
> __filemap_fdatawrite_range+0xd7/0x120
> sync_file_range+0xac/0xf0
>=20
> ioc->bfqd:
> bfq_exit_icq+0xa3/0xe0 -> bfqd->lock grabbed
> put_io_context_active+0x78/0xb0 -> ioc->lock grabbed
> exit_io_context+0x48/0x50
> do_exit+0x7e9/0xdd0
> do_group_exit+0x54/0xc0
>=20
> To avoid this inversion we change blk_mq_sched_try_insert_merge() to =
not
> free the merged request but rather leave that upto the caller =
similarly
> to blk_mq_sched_try_merge(). And in bfq_insert_requests() we make sure
> to free all the merged requests after dropping bfqd->lock.
>=20

I see you added a (short) loop. Apart from that,
Acked-by: Paolo Valente <paolo.valente@linaro.org>

Thanks,
Paolo

> Fixes: aee69d78dec0 ("block, bfq: introduce the BFQ-v0 I/O scheduler =
as an extra scheduler")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> block/bfq-iosched.c      |  6 ++++--
> block/blk-merge.c        | 19 ++++++++-----------
> block/blk-mq-sched.c     |  5 +++--
> block/blk-mq-sched.h     |  3 ++-
> block/blk-mq.h           | 11 +++++++++++
> block/blk.h              |  2 +-
> block/elevator.c         | 11 ++++++++---
> block/mq-deadline.c      |  5 ++++-
> include/linux/elevator.h |  3 ++-
> 9 files changed, 43 insertions(+), 22 deletions(-)
>=20
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 50a29fdf51da..5e076396b588 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2317,9 +2317,9 @@ static bool bfq_bio_merge(struct request_queue =
*q, struct bio *bio,
>=20
> 	ret =3D blk_mq_sched_try_merge(q, bio, nr_segs, &free);
>=20
> +	spin_unlock_irq(&bfqd->lock);
> 	if (free)
> 		blk_mq_free_request(free);
> -	spin_unlock_irq(&bfqd->lock);
>=20
> 	return ret;
> }
> @@ -5933,14 +5933,16 @@ static void bfq_insert_request(struct =
blk_mq_hw_ctx *hctx, struct request *rq,
> 	struct bfq_queue *bfqq;
> 	bool idle_timer_disabled =3D false;
> 	unsigned int cmd_flags;
> +	LIST_HEAD(free);
>=20
> #ifdef CONFIG_BFQ_GROUP_IOSCHED
> 	if (!cgroup_subsys_on_dfl(io_cgrp_subsys) && rq->bio)
> 		bfqg_stats_update_legacy_io(q, rq);
> #endif
> 	spin_lock_irq(&bfqd->lock);
> -	if (blk_mq_sched_try_insert_merge(q, rq)) {
> +	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
> 		spin_unlock_irq(&bfqd->lock);
> +		blk_mq_free_requests(&free);
> 		return;
> 	}
>=20
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 4d97fb6dd226..1398b52a24b4 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -846,18 +846,15 @@ static struct request =
*attempt_front_merge(struct request_queue *q,
> 	return NULL;
> }
>=20
> -int blk_attempt_req_merge(struct request_queue *q, struct request =
*rq,
> -			  struct request *next)
> +/*
> + * Try to merge 'next' into 'rq'. Return true if the merge happened, =
false
> + * otherwise. The caller is responsible for freeing 'next' if the =
merge
> + * happened.
> + */
> +bool blk_attempt_req_merge(struct request_queue *q, struct request =
*rq,
> +			   struct request *next)
> {
> -	struct request *free;
> -
> -	free =3D attempt_merge(q, rq, next);
> -	if (free) {
> -		blk_put_request(free);
> -		return 1;
> -	}
> -
> -	return 0;
> +	return attempt_merge(q, rq, next);
> }
>=20
> bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 714e678f516a..bf0a3dec8226 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -400,9 +400,10 @@ bool __blk_mq_sched_bio_merge(struct =
request_queue *q, struct bio *bio,
> 	return ret;
> }
>=20
> -bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct =
request *rq)
> +bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct =
request *rq,
> +				   struct list_head *free)
> {
> -	return rq_mergeable(rq) && elv_attempt_insert_merge(q, rq);
> +	return rq_mergeable(rq) && elv_attempt_insert_merge(q, rq, =
free);
> }
> EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
>=20
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 5b18ab915c65..8b70de4b8d23 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -11,7 +11,8 @@ bool blk_mq_sched_try_merge(struct request_queue *q, =
struct bio *bio,
> 		unsigned int nr_segs, struct request **merged_request);
> bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio =
*bio,
> 		unsigned int nr_segs);
> -bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct =
request *rq);
> +bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct =
request *rq,
> +				   struct list_head *free);
> void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx);
> void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
>=20
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 81a775171be7..20ef743a3ff6 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -301,6 +301,17 @@ static inline struct blk_plug *blk_mq_plug(struct =
request_queue *q,
> 	return NULL;
> }
>=20
> +/* Free all requests on the list */
> +static inline void blk_mq_free_requests(struct list_head *list)
> +{
> +	while (!list_empty(list)) {
> +		struct request *rq =3D list_entry_rq(list->next);
> +
> +		list_del_init(&rq->queuelist);
> +		blk_mq_free_request(rq);
> +	}
> +}
> +
> /*
>  * For shared tag users, we track the number of currently active users
>  * and attempt to provide a fair share of the tag depth for each of =
them.
> diff --git a/block/blk.h b/block/blk.h
> index 8b3591aee0a5..99ef4f7e7a70 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -225,7 +225,7 @@ ssize_t part_timeout_store(struct device *, struct =
device_attribute *,
> void __blk_queue_split(struct bio **bio, unsigned int *nr_segs);
> int ll_back_merge_fn(struct request *req, struct bio *bio,
> 		unsigned int nr_segs);
> -int blk_attempt_req_merge(struct request_queue *q, struct request =
*rq,
> +bool blk_attempt_req_merge(struct request_queue *q, struct request =
*rq,
> 				struct request *next);
> unsigned int blk_recalc_rq_segments(struct request *rq);
> void blk_rq_set_mixed_merge(struct request *rq);
> diff --git a/block/elevator.c b/block/elevator.c
> index 440699c28119..62e9c672da7c 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -350,9 +350,11 @@ enum elv_merge elv_merge(struct request_queue *q, =
struct request **req,
>  * we can append 'rq' to an existing request, so we can throw 'rq' =
away
>  * afterwards.
>  *
> - * Returns true if we merged, false otherwise
> + * Returns true if we merged, false otherwise. 'free' will contain =
all
> + * requests that need to be freed.
>  */
> -bool elv_attempt_insert_merge(struct request_queue *q, struct request =
*rq)
> +bool elv_attempt_insert_merge(struct request_queue *q, struct request =
*rq,
> +			      struct list_head *free)
> {
> 	struct request *__rq;
> 	bool ret;
> @@ -363,8 +365,10 @@ bool elv_attempt_insert_merge(struct =
request_queue *q, struct request *rq)
> 	/*
> 	 * First try one-hit cache.
> 	 */
> -	if (q->last_merge && blk_attempt_req_merge(q, q->last_merge, =
rq))
> +	if (q->last_merge && blk_attempt_req_merge(q, q->last_merge, =
rq)) {
> +		list_add(&rq->queuelist, free);
> 		return true;
> +	}
>=20
> 	if (blk_queue_noxmerges(q))
> 		return false;
> @@ -378,6 +382,7 @@ bool elv_attempt_insert_merge(struct request_queue =
*q, struct request *rq)
> 		if (!__rq || !blk_attempt_req_merge(q, __rq, rq))
> 			break;
>=20
> +		list_add(&rq->queuelist, free);
> 		/* The merged request could be merged with others, try =
again */
> 		ret =3D true;
> 		rq =3D __rq;
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 8eea2cbf2bf4..7136262819f1 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -487,6 +487,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx =
*hctx, struct request *rq,
> 	struct request_queue *q =3D hctx->queue;
> 	struct deadline_data *dd =3D q->elevator->elevator_data;
> 	const int data_dir =3D rq_data_dir(rq);
> +	LIST_HEAD(free);
>=20
> 	/*
> 	 * This may be a requeue of a write request that has locked its
> @@ -494,8 +495,10 @@ static void dd_insert_request(struct =
blk_mq_hw_ctx *hctx, struct request *rq,
> 	 */
> 	blk_req_zone_write_unlock(rq);
>=20
> -	if (blk_mq_sched_try_insert_merge(q, rq))
> +	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
> +		blk_mq_free_requests(&free);
> 		return;
> +	}
>=20
> 	trace_block_rq_insert(rq);
>=20
> diff --git a/include/linux/elevator.h b/include/linux/elevator.h
> index dcb2f9022c1d..1a5965174f5b 100644
> --- a/include/linux/elevator.h
> +++ b/include/linux/elevator.h
> @@ -117,7 +117,8 @@ extern void elv_merge_requests(struct =
request_queue *, struct request *,
> 			       struct request *);
> extern void elv_merged_request(struct request_queue *, struct request =
*,
> 		enum elv_merge);
> -extern bool elv_attempt_insert_merge(struct request_queue *, struct =
request *);
> +extern bool elv_attempt_insert_merge(struct request_queue *, struct =
request *,
> +				     struct list_head *);
> extern struct request *elv_former_request(struct request_queue *, =
struct request *);
> extern struct request *elv_latter_request(struct request_queue *, =
struct request *);
>=20
> --=20
> 2.26.2
>=20

