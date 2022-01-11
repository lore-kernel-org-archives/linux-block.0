Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF086C433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 18:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbiAKSLP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:11:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344600AbiAKSLM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 13:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641924671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nk+q8m9ky5pTPX+6o8N1V5u5NI0/FPXtRIjpZUtn01E=;
        b=CUWynFGv1KPwM2/76MFx5GqxPtajhsUOH3O4gmhCueCEUks+maEJyzcP4Hzs5M5qQdVTvw
        GB+AIASkyfDJdfl+xzofyyNpnmeE6m/S9kQnWFrE9wDCjgx+uWhqcpAnMIIDNUj+8JIDTE
        7q2hw1RzQq+USfFj1/Kyeq24DQcLz/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-d4c82tFCM92e531xU6LGhQ-1; Tue, 11 Jan 2022 13:11:09 -0500
X-MC-Unique: d4c82tFCM92e531xU6LGhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8A37190D34B;
        Tue, 11 Jan 2022 18:11:08 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CCD8A7FCCB;
        Tue, 11 Jan 2022 18:10:50 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH 1/3] block: split having srcu from queue blocking
References: <20211221141459.1368176-1-ming.lei@redhat.com>
        <20211221141459.1368176-2-ming.lei@redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 11 Jan 2022 13:13:21 -0500
In-Reply-To: <20211221141459.1368176-2-ming.lei@redhat.com> (Ming Lei's
        message of "Tue, 21 Dec 2021 22:14:57 +0800")
Message-ID: <x49r19ejg3i.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming Lei <ming.lei@redhat.com> writes:

> Now we reuse queue flag of QUEUE_FLAG_HAS_SRCU for both having srcu and
> BLK_MQ_F_BLOCKING. Actually they are two things: one is that srcu is
> allocated inside queue, another is that we need to handle blocking
> ->queue_rq. So far this way works as expected.
>
> dm-rq needs to set BLK_MQ_F_BLOCKING if any underlying queue is
> marked as BLK_MQ_F_BLOCKING. But dm queue is allocated before tagset
> is allocated, one doable way is to always allocate SRCU for dm
> queue, then set BLK_MQ_F_BLOCKING for the tagset if it is required,
> meantime we can mark the request queue as supporting blocking
> ->queue_rq.
>
> So add one new flag of QUEUE_FLAG_BLOCKING for supporting blocking
> ->queue_rq only, and use one private field to describe if request
> queue has allocated srcu instance.

OK, so you switched to has_srcu because it's an internaly only detail,
that makes sense.  I think testing for blocking makes more sense than
testing for the existence of srcu, so this actually makes the code a bit
more readable in my opinion.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-core.c       | 2 +-
>  block/blk-mq.c         | 6 +++---
>  block/blk-mq.h         | 2 +-
>  block/blk-sysfs.c      | 2 +-
>  include/linux/blkdev.h | 5 +++--
>  5 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 10619fd83c1b..7ba806a4e779 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -449,7 +449,7 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
>  		return NULL;
>  
>  	if (alloc_srcu) {
> -		blk_queue_flag_set(QUEUE_FLAG_HAS_SRCU, q);
> +		q->has_srcu = true;
>  		if (init_srcu_struct(q->srcu) != 0)
>  			goto fail_q;
>  	}
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 0d7c9d3e0329..1408a6b8ccdc 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -259,7 +259,7 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
>   */
>  void blk_mq_wait_quiesce_done(struct request_queue *q)
>  {
> -	if (blk_queue_has_srcu(q))
> +	if (blk_queue_blocking(q))
>  		synchronize_srcu(q->srcu);
>  	else
>  		synchronize_rcu();
> @@ -4024,8 +4024,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>  int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  		struct request_queue *q)
>  {
> -	WARN_ON_ONCE(blk_queue_has_srcu(q) !=
> -			!!(set->flags & BLK_MQ_F_BLOCKING));
> +	if (set->flags & BLK_MQ_F_BLOCKING)
> +		blk_queue_flag_set(QUEUE_FLAG_BLOCKING, q);
>  
>  	/* mark the queue as mq asap */
>  	q->mq_ops = set->ops;
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 948791ea2a3e..9601918e2034 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -377,7 +377,7 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
>  /* run the code block in @dispatch_ops with rcu/srcu read lock held */
>  #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops)	\
>  do {								\
> -	if (!blk_queue_has_srcu(q)) {				\
> +	if (!blk_queue_blocking(q)) {				\
>  		rcu_read_lock();				\
>  		(dispatch_ops);					\
>  		rcu_read_unlock();				\
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index e20eadfcf5c8..af89fabb58e3 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -736,7 +736,7 @@ static void blk_free_queue_rcu(struct rcu_head *rcu_head)
>  	struct request_queue *q = container_of(rcu_head, struct request_queue,
>  					       rcu_head);
>  
> -	kmem_cache_free(blk_get_queue_kmem_cache(blk_queue_has_srcu(q)), q);
> +	kmem_cache_free(blk_get_queue_kmem_cache(q->has_srcu), q);
>  }
>  
>  /* Unconfigure the I/O scheduler and dissociate from the cgroup controller. */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index c80cfaefc0a8..d84abdb294c4 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -365,6 +365,7 @@ struct request_queue {
>  #endif
>  
>  	bool			mq_sysfs_init_done;
> +	bool			has_srcu;
>  
>  #define BLK_MAX_WRITE_HINTS	5
>  	u64			write_hints[BLK_MAX_WRITE_HINTS];
> @@ -385,7 +386,7 @@ struct request_queue {
>  /* Keep blk_queue_flag_name[] in sync with the definitions below */
>  #define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
>  #define QUEUE_FLAG_DYING	1	/* queue being torn down */
> -#define QUEUE_FLAG_HAS_SRCU	2	/* SRCU is allocated */
> +#define QUEUE_FLAG_BLOCKING	2	/* ->queue_rq may block */
>  #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
>  #define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
>  #define QUEUE_FLAG_FAIL_IO	5	/* fake timeout */
> @@ -423,7 +424,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>  
>  #define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
>  #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
> -#define blk_queue_has_srcu(q)	test_bit(QUEUE_FLAG_HAS_SRCU, &(q)->queue_flags)
> +#define blk_queue_blocking(q)	test_bit(QUEUE_FLAG_BLOCKING, &(q)->queue_flags)
>  #define blk_queue_dead(q)	test_bit(QUEUE_FLAG_DEAD, &(q)->queue_flags)
>  #define blk_queue_init_done(q)	test_bit(QUEUE_FLAG_INIT_DONE, &(q)->queue_flags)
>  #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)

