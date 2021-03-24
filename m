Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE9AC433C1
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 09:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F298461A02
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 09:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhCXJ2I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 05:28:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:42876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234820AbhCXJ1v (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 05:27:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE455AC16;
        Wed, 24 Mar 2021 09:27:49 +0000 (UTC)
Subject: Re: [PATCH v2] blk-mq: Fix races between iterating over requests and
 freeing requests
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>
References: <20210324040621.6781-1-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d1627890-fb10-7ebe-d805-621f925f80e7@suse.de>
Date:   Wed, 24 Mar 2021 10:27:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210324040621.6781-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/21 5:06 AM, Bart Van Assche wrote:
> Multiple users have reported use-after-free complaints similar to the
> complaint shown below. When multiple request queues share a tag set and
> when switching the I/O scheduler for one of the request queues that uses
> this tag set, the following race can happen:
> * blk_mq_tagset_busy_iter() calls bt_tags_iter() and bt_tags_iter() assigns
>    a pointer to a scheduler request to the local variable 'rq'.
> * blk_mq_sched_free_requests() is called to free hctx->sched_tags.
> * blk_mq_tagset_busy_iter() dereferences 'rq' and triggers a use-after-free.
> 
> Fix this race as follows:
> * Use rcu_assign_pointer() and srcu_dereference() to access hctx->tags->rqs[].
>    The performance impact of the assignments added to the hot path is minimal
>    (about 1% according to one particular test).
> * Protect hctx->tags->rqs[] reads with an SRCU read-side lock. Use a global
>    lock in order not to increase the size of struct tagset.
> * Call synchronize_srcu() before freeing scheduler requests.
> 
>  From https://lore.kernel.org/linux-block/1545261885.185366.488.camel@acm.org/:
> 
> BUG: KASAN: use-after-free in bt_iter+0x86/0xf0
> Read of size 8 at addr ffff88803b335240 by task fio/21412
> 
> CPU: 0 PID: 21412 Comm: fio Tainted: G        W         4.20.0-rc6-dbg+ #3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> Call Trace:
>   dump_stack+0x86/0xca
>   print_address_description+0x71/0x239
>   kasan_report.cold.5+0x242/0x301
>   __asan_load8+0x54/0x90
>   bt_iter+0x86/0xf0
>   blk_mq_queue_tag_busy_iter+0x373/0x5e0
>   blk_mq_in_flight+0x96/0xb0
>   part_in_flight+0x40/0x140
>   part_round_stats+0x18e/0x370
>   blk_account_io_start+0x3d7/0x670
>   blk_mq_bio_to_request+0x19c/0x3a0
>   blk_mq_make_request+0x7a9/0xcb0
>   generic_make_request+0x41d/0x960
>   submit_bio+0x9b/0x250
>   do_blockdev_direct_IO+0x435c/0x4c70
>   __blockdev_direct_IO+0x79/0x88
>   ext4_direct_IO+0x46c/0xc00
>   generic_file_direct_write+0x119/0x210
>   __generic_file_write_iter+0x11c/0x280
>   ext4_file_write_iter+0x1b8/0x6f0
>   aio_write+0x204/0x310
>   io_submit_one+0x9d3/0xe80
>   __x64_sys_io_submit+0x115/0x340
>   do_syscall_64+0x71/0x210
> 
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Reviewed-by: Khazhy Kumykov <khazhy@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
> 
> Changes compared to v1:
> - Reformatted patch description.
> - Added Tested-by/Reviewed-by tags.
> - Changed srcu_barrier() calls into synchronize_srcu() calls.
> 
>   block/blk-core.c   |  9 ++++++++-
>   block/blk-mq-tag.c | 29 +++++++++++++++++++----------
>   block/blk-mq-tag.h |  2 +-
>   block/blk-mq.c     | 22 ++++++++++++++++++----
>   block/blk-mq.h     |  1 +
>   block/blk.h        |  7 +++++++
>   6 files changed, 54 insertions(+), 16 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fc60ff208497..437ca1406c7c 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -52,6 +52,7 @@
>   #include "blk-pm.h"
>   #include "blk-rq-qos.h"
>   
> +DEFINE_SRCU(blk_sched_srcu);
>   struct dentry *blk_debugfs_root;
>   
>   EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_remap);
> @@ -412,8 +413,14 @@ void blk_cleanup_queue(struct request_queue *q)
>   	 * it is safe to free requests now.
>   	 */
>   	mutex_lock(&q->sysfs_lock);
> -	if (q->elevator)
> +	if (q->elevator) {
> +		/*
> +		 * Barrier between clearing hctx->tags->rqs[] and freeing
> +		 * scheduler requests.
> +		 */
> +		synchronize_srcu(&blk_sched_srcu);
>   		blk_mq_sched_free_requests(q);
> +	}
>   	mutex_unlock(&q->sysfs_lock);
>   
>   	percpu_ref_exit(&q->q_usage_counter);
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 9c92053e704d..f3afaf1520cd 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -206,18 +206,24 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   	struct blk_mq_tags *tags = hctx->tags;
>   	bool reserved = iter_data->reserved;
>   	struct request *rq;
> +	bool res = true;
> +	int idx;
>   
>   	if (!reserved)
>   		bitnr += tags->nr_reserved_tags;
> -	rq = tags->rqs[bitnr];
> +
> +	idx = srcu_read_lock(&blk_sched_srcu);
> +	rq = srcu_dereference(tags->rqs[bitnr], &blk_sched_srcu);
>   
>   	/*
>   	 * We can hit rq == NULL here, because the tagging functions
>   	 * test and set the bit before assigning ->rqs[].
>   	 */
>   	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
> -		return iter_data->fn(hctx, rq, iter_data->data, reserved);
> -	return true;
> +		res = iter_data->fn(hctx, rq, iter_data->data, reserved);
> +	srcu_read_unlock(&blk_sched_srcu, idx);
> +
> +	return res;
>   }
>   
>   /**
> @@ -264,10 +270,13 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   	struct blk_mq_tags *tags = iter_data->tags;
>   	bool reserved = iter_data->flags & BT_TAG_ITER_RESERVED;
>   	struct request *rq;
> +	bool res = true;
> +	int idx;
>   
>   	if (!reserved)
>   		bitnr += tags->nr_reserved_tags;
>   
> +	idx = srcu_read_lock(&blk_sched_srcu);
>   	/*
>   	 * We can hit rq == NULL here, because the tagging functions
>   	 * test and set the bit before assigning ->rqs[].
> @@ -275,13 +284,13 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   	if (iter_data->flags & BT_TAG_ITER_STATIC_RQS)
>   		rq = tags->static_rqs[bitnr];
>   	else
> -		rq = tags->rqs[bitnr];
> -	if (!rq)
> -		return true;
> -	if ((iter_data->flags & BT_TAG_ITER_STARTED) &&
> -	    !blk_mq_request_started(rq))
> -		return true;
> -	return iter_data->fn(rq, iter_data->data, reserved);
> +		rq = srcu_dereference(tags->rqs[bitnr], &blk_sched_srcu);
> +	if (rq && (!(iter_data->flags & BT_TAG_ITER_STARTED) ||
> +		   blk_mq_request_started(rq)))
> +		res = iter_data->fn(rq, iter_data->data, reserved);
> +	srcu_read_unlock(&blk_sched_srcu, idx);
> +
> +	return res;
>   }
>   
>   /**
> diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
> index 7d3e6b333a4a..7a6d04733261 100644
> --- a/block/blk-mq-tag.h
> +++ b/block/blk-mq-tag.h
> @@ -17,7 +17,7 @@ struct blk_mq_tags {
>   	struct sbitmap_queue __bitmap_tags;
>   	struct sbitmap_queue __breserved_tags;
>   
> -	struct request **rqs;
> +	struct request __rcu **rqs;
>   	struct request **static_rqs;
>   	struct list_head page_list;
>   };
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d4d7c1caa439..4a5ea6096f39 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -495,8 +495,10 @@ static void __blk_mq_free_request(struct request *rq)
>   	blk_crypto_free_request(rq);
>   	blk_pm_mark_last_busy(rq);
>   	rq->mq_hctx = NULL;
> -	if (rq->tag != BLK_MQ_NO_TAG)
> +	if (rq->tag != BLK_MQ_NO_TAG) {
>   		blk_mq_put_tag(hctx->tags, ctx, rq->tag);
> +		rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
> +	}
>   	if (sched_tag != BLK_MQ_NO_TAG)
>   		blk_mq_put_tag(hctx->sched_tags, ctx, sched_tag);
>   	blk_mq_sched_restart(hctx);
> @@ -838,9 +840,21 @@ EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
>   
>   struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
>   {
> +	struct request *rq;
> +
>   	if (tag < tags->nr_tags) {
> -		prefetch(tags->rqs[tag]);
> -		return tags->rqs[tag];
> +		/*
> +		 * Freeing tags happens with the request queue frozen so the
> +		 * srcu dereference below is protected by the request queue
> +		 * usage count. We can only verify that usage count after
> +		 * having read the request pointer.
> +		 */
> +		rq = srcu_dereference_check(tags->rqs[tag], &blk_sched_srcu,
> +					    true);
> +		WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && rq &&
> +			     percpu_ref_is_zero(&rq->q->q_usage_counter));
> +		prefetch(rq);
> +		return rq;
>   	}
>   
>   	return NULL;
> @@ -1111,7 +1125,7 @@ static bool blk_mq_get_driver_tag(struct request *rq)
>   		rq->rq_flags |= RQF_MQ_INFLIGHT;
>   		__blk_mq_inc_active_requests(hctx);
>   	}
> -	hctx->tags->rqs[rq->tag] = rq;
> +	rcu_assign_pointer(hctx->tags->rqs[rq->tag], rq);
>   	return true;
>   }
>   
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index 3616453ca28c..9ccb1818303b 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -226,6 +226,7 @@ static inline void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
>   					   struct request *rq)
>   {
>   	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
> +	rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);
>   	rq->tag = BLK_MQ_NO_TAG;
>   
>   	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
> diff --git a/block/blk.h b/block/blk.h
> index 3b53e44b967e..674c82d247c7 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -14,6 +14,8 @@
>   /* Max future timer expiry for timeouts */
>   #define BLK_MAX_TIMEOUT		(5 * HZ)
>   
> +extern struct srcu_struct blk_sched_srcu;
> +
>   extern struct dentry *blk_debugfs_root;
>   
>   struct blk_flush_queue {
> @@ -203,6 +205,11 @@ static inline void elevator_exit(struct request_queue *q,
>   {
>   	lockdep_assert_held(&q->sysfs_lock);
>   
> +	/*
> +	 * Barrier between clearing hctx->tags->rqs[] and freeing scheduler
> +	 * requests.
> +	 */
> +	synchronize_srcu(&blk_sched_srcu);
>   	blk_mq_sched_free_requests(q);
>   	__elevator_exit(q, e);
>   }
> 
What I don't particularly like is the global blk_sched_srcu here; can't 
we make it per tagset?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
