Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB915A85E
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745053163; cv=none; b=jOPKDp2We5fYvAxg9eBsikLittc4xsHMLlYe/NK3w9m8QtXcuovWZzOEPJsb2oR6qji++HzUhWbfVuR1URSciWoI+lOWzj9wSqpNu8c7wEpm8e667jZ7KVHb/rVuUE2CLQGDUG9gN99Oistt65WB/HuKvC0gWnN288h+G1jDKVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745053163; c=relaxed/simple;
	bh=43fnOyDSHiKoD0Kd+OaYH8zu03CTphbjs1OSQj0X+ZA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LEQk6iMsyB14SnOzyB9t7PqX5BBoMVUFb1OBYte3nWoupv+11F0UPZnsvhLNAP/HtvmEQfn+mjG0gARVdowGd/VOd4R7OJCKQzSqrMoRgqzYRT6JJAb4bb9w/GHHPLZupfks1fEkK3lSV4zIalOr/3FEzqgKiXdTRHqk/nk4gnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zflt33hZ8z4f3lfH
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 16:58:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D4FFB1A018D
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 16:59:16 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl_kZQNo+7+4Jw--.34339S3;
	Sat, 19 Apr 2025 16:59:16 +0800 (CST)
Subject: Re: [PATCH V2 02/20] block: move ELEVATOR_FLAG_DISABLE_WBT as request
 queue flag
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas.hellstrom@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-3-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6d497b76-c128-259f-76af-6af184786b1f@huaweicloud.com>
Date: Sat, 19 Apr 2025 16:59:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250418163708.442085-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl_kZQNo+7+4Jw--.34339S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1UAFWrWw1kKF4Utry5Arb_yoWrXrWkp3
	ykGF40k3W2qF4vqFy8K3W3Zw17Gr1q9r13Cr4rCryYyw1SgrnIga10kFyUJF4kZrs7AFsI
	qr1rta4qva4Yg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZSd
	gUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/04/19 0:36, Ming Lei Ð´µÀ:
> ELEVATOR_FLAG_DISABLE_WBT is only used by BFQ to disallow wbt when BFQ is
> in use. The flag is set in BFQ's init(), and cleared in BFQ's exit().
> 
> Making it as request queue flag, so that we can avoid to deal with elevator
> switch race. Also it isn't graceful to checking one scheduler flag in
> wbt_enable_default().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/bfq-iosched.c    | 4 ++--
>   block/blk-mq-debugfs.c | 1 +
>   block/blk-wbt.c        | 3 +--
>   block/elevator.h       | 1 -
>   include/linux/blkdev.h | 3 +++
>   5 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index abd80dc13562..40e4106a71e7 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -7210,7 +7210,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
>   #endif
>   
>   	blk_stat_disable_accounting(bfqd->queue);
> -	clear_bit(ELEVATOR_FLAG_DISABLE_WBT, &e->flags);
> +	blk_queue_flag_clear(QUEUE_FLAG_DISABLE_WBT, bfqd->queue);
>   	wbt_enable_default(bfqd->queue->disk);
>   
>   	kfree(bfqd);
> @@ -7397,7 +7397,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
>   	/* We dispatch from request queue wide instead of hw queue */
>   	blk_queue_flag_set(QUEUE_FLAG_SQ_SCHED, q);
>   
> -	set_bit(ELEVATOR_FLAG_DISABLE_WBT, &eq->flags);
> +	blk_queue_flag_set(QUEUE_FLAG_DISABLE_WBT, q);
>   	wbt_disable_default(q->disk);
>   	blk_stat_enable_accounting(q);
>   
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 3421b5521fe2..31e249a18407 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -93,6 +93,7 @@ static const char *const blk_queue_flag_name[] = {
>   	QUEUE_FLAG_NAME(RQ_ALLOC_TIME),
>   	QUEUE_FLAG_NAME(HCTX_ACTIVE),
>   	QUEUE_FLAG_NAME(SQ_SCHED),
> +	QUEUE_FLAG_NAME(DISABLE_WBT),
>   };
>   #undef QUEUE_FLAG_NAME
>   
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index f1754d07f7e0..29cd2e33666f 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -704,8 +704,7 @@ void wbt_enable_default(struct gendisk *disk)
>   	struct rq_qos *rqos;
>   	bool enable = IS_ENABLED(CONFIG_BLK_WBT_MQ);
>   
> -	if (q->elevator &&
> -	    test_bit(ELEVATOR_FLAG_DISABLE_WBT, &q->elevator->flags))
> +	if (blk_queue_disable_wbt(q))
>   		enable = false;
>   
>   	/* Throttling already enabled? */
> diff --git a/block/elevator.h b/block/elevator.h
> index e4e44dfac503..e27af5492cdb 100644
> --- a/block/elevator.h
> +++ b/block/elevator.h
> @@ -121,7 +121,6 @@ struct elevator_queue
>   };
>   
>   #define ELEVATOR_FLAG_REGISTERED	0
> -#define ELEVATOR_FLAG_DISABLE_WBT	1
>   
>   /*
>    * block elevator interface
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index e39c45bc0a97..10410d9b03ad 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -644,6 +644,7 @@ enum {
>   	QUEUE_FLAG_RQ_ALLOC_TIME,	/* record rq->alloc_time_ns */
>   	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
>   	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
> +	QUEUE_FLAG_DISABLE_WBT,		/* for sched to disable/enable wbt */

In fact, user can still enabel wbt by sysfs api. Perhaps change the name
to QUEUE_FLAG_WBT_DISABLE_DEFAULT?

Thanks,
Kuai

>   	QUEUE_FLAG_MAX
>   };
>   
> @@ -679,6 +680,8 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
>   #define blk_queue_sq_sched(q)	test_bit(QUEUE_FLAG_SQ_SCHED, &(q)->queue_flags)
>   #define blk_queue_skip_tagset_quiesce(q) \
>   	((q)->limits.features & BLK_FEAT_SKIP_TAGSET_QUIESCE)
> +#define blk_queue_disable_wbt(q)	\
> +	test_bit(QUEUE_FLAG_DISABLE_WBT, &(q)->queue_flags)
>   
>   extern void blk_set_pm_only(struct request_queue *q);
>   extern void blk_clear_pm_only(struct request_queue *q);
> 

