Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083ADC433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8AB365101
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 16:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbhCPQSp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2702 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbhCPQSL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:11 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F0JCF1rclz680qK;
        Wed, 17 Mar 2021 00:09:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 17:18:07 +0100
Received: from [10.210.172.72] (10.210.172.72) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 16:18:06 +0000
Subject: Re: [RFC PATCH v3 2/3] blk-mq: Freeze and quiesce all queues for
 tagset in elevator_exit()
To:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
CC:     "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pragalla@codeaurora.org" <pragalla@codeaurora.org>,
        "kashyap.desai@broadcom.com" <kashyap.desai@broadcom.com>,
        yuyufen <yuyufen@huawei.com>
References: <1614957294-188540-1-git-send-email-john.garry@huawei.com>
 <1614957294-188540-3-git-send-email-john.garry@huawei.com>
 <YElrSFGyim3rjDN+@T590> <8c6c6783-6152-2332-2f50-14c409e40320@huawei.com>
 <2b0c66ba-03b3-844c-1684-f8e80d11cdbb@acm.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4ffaba53-100a-43a5-8746-b753d4153be5@huawei.com>
Date:   Tue, 16 Mar 2021 16:15:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <2b0c66ba-03b3-844c-1684-f8e80d11cdbb@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.72]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

I'll have a look at this ASAP -  a bit busy.

But a quick scan and I notice this:

 > @@ -226,6 +226,7 @@ static inline void __blk_mq_put_driver_tag(struct 
blk_mq_hw_ctx *hctx,
 >   					   struct request *rq)
 >   {
 >   	blk_mq_put_tag(hctx->tags, rq->mq_ctx, rq->tag);
 > +	rcu_assign_pointer(hctx->tags->rqs[rq->tag], NULL);

Wasn't a requirement to not touch the fastpath at all, including even if 
only NULLifying a pointer?

IIRC, Kashyap some time ago had a patch like above (but without RCU 
usage), but the request from Jens was to not touch the fastpath.

Maybe I'm mistaken - I will try to dig up the thread.

Thanks,
John

> How about replacing the entire patch series with the patch below? The
> patch below has the following advantages:
> - Instead of making the race window smaller, the race is fixed
>    completely.
> - No new atomic instructions are added to the block layer code.
> - No early return is inserted in blk_mq_tagset_busy_iter().
> 
> Thanks,
> 
> Bart.
> 
>  From a0e534012a766bd6e53cdd466eec0a811164c12a Mon Sep 17 00:00:00 2001
> From: Bart Van Assche<bvanassche@acm.org>
> Date: Wed, 10 Mar 2021 19:11:47 -0800
> Subject: [PATCH] blk-mq: Fix races between iterating over requests and freeing
>   requests
> 
> Multiple users have reported use-after-free complaints similar to the
> following (see alsohttps://lore.kernel.org/linux-block/1545261885.185366.488.camel@acm.org/):
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
> When multiple request queues share a tag set and when switching the I/O
> scheduler for one of the request queues that uses this tag set, the
> following race can happen:
> * blk_mq_tagset_busy_iter() calls bt_tags_iter() and bt_tags_iter() assigns
>    a pointer to a scheduler request to the local variable 'rq'.
> * blk_mq_sched_free_requests() is called to free hctx->sched_tags.
> * blk_mq_tagset_busy_iter() dereferences 'rq' and triggers a use-after-free.
> 
> Fix this race as follows:
> * Use rcu_assign_pointer() and rcu_dereference() to access hctx->tags->rqs[].
> * Protect hctx->tags->rqs[] reads with an RCU read-side lock.
> * No new rcu_barrier() call has been added because clearing the request
>    pointer in hctx->tags->rqs[] happens before blk_queue_exit() and the
>    blk_freeze_queue() call in blk_cleanup_queue() triggers an RCU barrier
>    after all scheduler request pointers assiociated with a request queue
>    have been removed from hctx->tags->rqs[] and before these scheduler
>    requests are freed.
> 
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>
> ---
>   block/blk-mq-tag.c | 27 +++++++++++++++++----------
>   block/blk-mq-tag.h |  2 +-
>   block/blk-mq.c     | 10 ++++++----
>   block/blk-mq.h     |  1 +
>   4 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 9c92053e704d..8351c3f2fe2d 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -206,18 +206,23 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   	struct blk_mq_tags *tags = hctx->tags;
>   	bool reserved = iter_data->reserved;
>   	struct request *rq;
> +	bool res = true;
> 
>   	if (!reserved)
>   		bitnr += tags->nr_reserved_tags;
> -	rq = tags->rqs[bitnr];
> +
> +	rcu_read_lock();
> +	rq = rcu_dereference(tags->rqs[bitnr]);
> 
>   	/*
>   	 * We can hit rq == NULL here, because the tagging functions
>   	 * test and set the bit before assigning ->rqs[].
>   	 */
>   	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
> -		return iter_data->fn(hctx, rq, iter_data->data, reserved);
> -	return true;
> +		res = iter_data->fn(hctx, rq, iter_data->data, reserved);
> +	rcu_read_unlock();
> +
> +	return res;
>   }
> 
>   /**
> @@ -264,10 +269,12 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   	struct blk_mq_tags *tags = iter_data->tags;
>   	bool reserved = iter_data->flags & BT_TAG_ITER_RESERVED;
>   	struct request *rq;
> +	bool res = true;
> 
>   	if (!reserved)
>   		bitnr += tags->nr_reserved_tags;
> 
> +	rcu_read_lock();
>   	/*
>   	 * We can hit rq == NULL here, because the tagging functions
>   	 * test and set the bit before assigning ->rqs[].
> @@ -275,13 +282,13 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
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
> +		rq = rcu_dereference(tags->rqs[bitnr]);
> +	if (rq && (!(iter_data->flags & BT_TAG_ITER_STARTED) ||
> +		   blk_mq_request_started(rq)))
> +		res = iter_data->fn(rq, iter_data->data, reserved);
> +	rcu_read_unlock();
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
> index d4d7c1caa439..594bf7f4ed9a 100644
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
> @@ -839,8 +841,8 @@ EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
>   struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
>   {
>   	if (tag < tags->nr_tags) {
> -		prefetch(tags->rqs[tag]);
> -		return tags->rqs[tag];
> +		prefetch((__force void *)tags->rqs[tag]);
> +		return rcu_dereference_check(tags->rqs[tag], true);
>   	}
> 
>   	return NULL;
> @@ -1111,7 +1113,7 @@ static bool blk_mq_get_driver_tag(struct request *rq)
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

