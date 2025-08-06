Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A85E72622
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754444158; cv=none; b=nvDeTHKn+x41KPyXSAoj9mz/h9kshEV2an8x+zejfG+dYeE0MpAYF1ymoV11AdIqCiPoesH8CYvB4vVSy45XaymRE0AzBoxVVO+gAKaZ7iFwLIg5DPcj4IsvKEIY1d2pSCJDdvxuZ3FIMmc6IK7wWUmmZh3td1UoFcNhq975Zps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754444158; c=relaxed/simple;
	bh=y5mHdXQPv6xTsq/yQ2L3PL1fNpaVaLldJOoQXM9wIa4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nYZ/rD98sncpsaMGN2NeSZxsGV71Dxzrqfv9mZ/wMhEVLVs+vgbCMmsrgHJYPQyZc7N4QX5s8pMieXpslGKTIbeJCaZXFR2vIbKKdyq6BxWEy7DB74dAevdAKF+EQGDZucN7R5az4giSzh5Caemzdi2Parbt9FbVJihhoNXRmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bxXW41rPvzYQtyw
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 09:18:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DF52B1A07BB
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 09:18:54 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHwhJ7rZJotxzeCg--.6374S3;
	Wed, 06 Aug 2025 09:18:53 +0800 (CST)
Subject: Re: [PATCHv2 1/2] block: avoid cpu_hotplug_lock depedency on
 freeze_lock
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, yukuai1@huaweicloud.com, axboe@kernel.dk,
 hch@lst.de, kch@nvidia.com, shinichiro.kawasaki@wdc.com, gjoyce@ibm.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250805171749.3448694-1-nilay@linux.ibm.com>
 <20250805171749.3448694-2-nilay@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <5820a0d3-3035-6d4e-8c96-45154d8a1cd5@huaweicloud.com>
Date: Wed, 6 Aug 2025 09:18:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250805171749.3448694-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHwhJ7rZJotxzeCg--.6374S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKw17JFW5Gr4kWr1xuw4fGrg_yoW3tr45pa
	yvgF4xCayUGF4kWaykGw4ku3y3GrnYkry7Ar13K34fAFn8Ar12vF10yFy0yrZ7ZrZ7Ar40
	qr4UtrsxJ34Yg37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/06 1:17, Nilay Shroff Ð´µÀ:
> A recent lockdep[1] splat observed while running blktest block/005
> reveals a potential deadlock caused by the cpu_hotplug_lock dependency
> on ->freeze_lock. This dependency was introduced by commit 033b667a823e
> ("block: blk-rq-qos: guard rq-qos helpers by static key").
> 
> That change added a static key to avoid fetching q->rq_qos when neither
> blk-wbt nor blk-iolatency is configured. The static key dynamically
> patches kernel text to a NOP when disabled, eliminating overhead of
> fetching q->rq_qos in the I/O hot path. However, enabling a static key
> at runtime requires acquiring both cpu_hotplug_lock and jump_label_mutex.
> When this happens after the queue has already been frozen (i.e., while
> holding ->freeze_lock), it creates a locking dependency from cpu_hotplug_
> lock to ->freeze_lock, which leads to a potential deadlock reported by
> lockdep [1].
> 
> To resolve this, replace the static key mechanism with q->queue_flags:
> QUEUE_FLAG_QOS_ENABLED. This flag is evaluated in the fast path before
> accessing q->rq_qos. If the flag is set, we proceed to fetch q->rq_qos;
> otherwise, the access is skipped.
> 
> Since q->queue_flags is commonly accessed in IO hotpath and resides in
> the first cacheline of struct request_queue, checking it imposes minimal
> overhead while eliminating the deadlock risk.
> 
> This change avoids the lockdep splat without introducing performance
> regressions.
> 
> [1] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> 
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
> Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-mq-debugfs.c |  1 +
>   block/blk-rq-qos.c     |  6 ++----
>   block/blk-rq-qos.h     | 43 +++++++++++++++++++++++++-----------------
>   include/linux/blkdev.h |  1 +
>   4 files changed, 30 insertions(+), 21 deletions(-)
> 
This patch LGTM, just one nit below.

> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 7ed3e71f2fc0..32c65efdda46 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -95,6 +95,7 @@ static const char *const blk_queue_flag_name[] = {
>   	QUEUE_FLAG_NAME(SQ_SCHED),
>   	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
>   	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
> +	QUEUE_FLAG_NAME(QOS_ENABLED),
>   };
>   #undef QUEUE_FLAG_NAME
>   
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index 848591fb3c57..460c04715321 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -2,8 +2,6 @@
>   
>   #include "blk-rq-qos.h"
>   
> -__read_mostly DEFINE_STATIC_KEY_FALSE(block_rq_qos);
> -
>   /*
>    * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
>    * false if 'v' + 1 would be bigger than 'below'.
> @@ -319,8 +317,8 @@ void rq_qos_exit(struct request_queue *q)
>   		struct rq_qos *rqos = q->rq_qos;
>   		q->rq_qos = rqos->next;
>   		rqos->ops->exit(rqos);
> -		static_branch_dec(&block_rq_qos);
>   	}
> +	blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
>   	mutex_unlock(&q->rq_qos_mutex);
>   }
>   
> @@ -346,7 +344,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
>   		goto ebusy;
>   	rqos->next = q->rq_qos;
>   	q->rq_qos = rqos;
> -	static_branch_inc(&block_rq_qos);
> +	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
>   
>   	blk_mq_unfreeze_queue(q, memflags);
>   
> diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
> index 39749f4066fb..c4242508fa5e 100644
> --- a/block/blk-rq-qos.h
> +++ b/block/blk-rq-qos.h
> @@ -12,7 +12,6 @@
>   #include "blk-mq-debugfs.h"
>   
>   struct blk_mq_debugfs_attr;
> -extern struct static_key_false block_rq_qos;
>   
>   enum rq_qos_id {
>   	RQ_QOS_WBT,
> @@ -113,43 +112,50 @@ void __rq_qos_queue_depth_changed(struct rq_qos *rqos);
>   
>   static inline void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
>   {
> -	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
> +	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
> +			q->rq_qos)
>   		__rq_qos_cleanup(q->rq_qos, bio);
>   }
>   
>   static inline void rq_qos_done(struct request_queue *q, struct request *rq)
>   {
> -	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos &&
> -	    !blk_rq_is_passthrough(rq))
> +	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
> +			q->rq_qos && !blk_rq_is_passthrough(rq))
>   		__rq_qos_done(q->rq_qos, rq);
>   }
>   
>   static inline void rq_qos_issue(struct request_queue *q, struct request *rq)
>   {
> -	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
> +	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
> +			q->rq_qos)
>   		__rq_qos_issue(q->rq_qos, rq);
>   }
>   
>   static inline void rq_qos_requeue(struct request_queue *q, struct request *rq)
>   {
> -	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
> +	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
> +			q->rq_qos)
>   		__rq_qos_requeue(q->rq_qos, rq);
>   }
>   
>   static inline void rq_qos_done_bio(struct bio *bio)
>   {
> -	if (static_branch_unlikely(&block_rq_qos) &&
> -	    bio->bi_bdev && (bio_flagged(bio, BIO_QOS_THROTTLED) ||
> -			     bio_flagged(bio, BIO_QOS_MERGED))) {
> -		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> -		if (q->rq_qos)
> -			__rq_qos_done_bio(q->rq_qos, bio);
> -	}
> +	struct request_queue *q;
> +
> +	if (!bio->bi_bdev || (!bio_flagged(bio, BIO_QOS_THROTTLED) &&
> +			     !bio_flagged(bio, BIO_QOS_MERGED)))
> +		return;
> +
> +	q = bdev_get_queue(bio->bi_bdev);
> +	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
> +			q->rq_qos)
This unlinkey doesn't make sense, BIO_QOS_THROTTLED or BIO_QOS_MERGED
already indicates rq_qos is enabled while issuing IO, and rq_qos should
still be valid until this IO is done.

Perhaps a prep cleanup patch to remove this checking?

Thanks,
Kuai

> +		__rq_qos_done_bio(q->rq_qos, bio);
>   }
>   
>   static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
>   {
> -	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos) {
> +	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
> +			q->rq_qos) {
>   		bio_set_flag(bio, BIO_QOS_THROTTLED);
>   		__rq_qos_throttle(q->rq_qos, bio);
>   	}
> @@ -158,14 +164,16 @@ static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
>   static inline void rq_qos_track(struct request_queue *q, struct request *rq,
>   				struct bio *bio)
>   {
> -	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
> +	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
> +			q->rq_qos)
>   		__rq_qos_track(q->rq_qos, rq, bio);
>   }
>   
>   static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
>   				struct bio *bio)
>   {
> -	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos) {
> +	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
> +			q->rq_qos) {
>   		bio_set_flag(bio, BIO_QOS_MERGED);
>   		__rq_qos_merge(q->rq_qos, rq, bio);
>   	}
> @@ -173,7 +181,8 @@ static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
>   
>   static inline void rq_qos_queue_depth_changed(struct request_queue *q)
>   {
> -	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
> +	if (unlikely(test_bit(QUEUE_FLAG_QOS_ENABLED, &q->queue_flags)) &&
> +			q->rq_qos)
>   		__rq_qos_queue_depth_changed(q->rq_qos);
>   }
>   
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 95886b404b16..fe1797bbec42 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -656,6 +656,7 @@ enum {
>   	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
>   	QUEUE_FLAG_DISABLE_WBT_DEF,	/* for sched to disable/enable wbt */
>   	QUEUE_FLAG_NO_ELV_SWITCH,	/* can't switch elevator any more */
> +	QUEUE_FLAG_QOS_ENABLED,		/* qos is enabled */
>   	QUEUE_FLAG_MAX
>   };
>   
> 

