Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220DF2356CC
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888117; cv=none; b=lAVVyBsl4XXXaaL8bigLmmWohWciWFgx0Efcq/5IyJEuGny9qOElt7ufjmjAfDSmytnQWZ5w5CiE3EDw1dfV2uwOvPjcSW5BYoR9oPcWBjvYD8MGkyYBp2c++cyla2SfRqMFaBR4sNEIiUByw9ydrqPMeHPw3hWbe57xJYa4peI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888117; c=relaxed/simple;
	bh=hpN27cK8ZTlZcMnSjcLPkBBPWb3mhrsfrucA7TbsWCo=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ORG4Z0VbV2BNfcz7Hdb9CaOOTE3yfhFpLlH/47aEJupH1481K9qc9FDLe1SGUMXxBg7iV2RWEDcEB2VVfZ3BwTfDJHZK4vZ8cDKnCEs3ZTWpwidjxtRpVy55CRm5Qo0u2R/P47ECJgRR/UYjzZIuvEZimVo5Ft7Vz6zvpGw2TKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZdZqz4gQTz4f3jsp
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 19:07:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 62C181A06D7
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 19:08:23 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2Al4QBo0zL8Jg--.5423S3;
	Thu, 17 Apr 2025 19:08:23 +0800 (CST)
Subject: Re: [PATCH] block: blk-rq-qos: guard rq-qos helpers by static key
To: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <ee26d050-dd58-4672-93c2-d5b3fa63bbae@kernel.dk>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <207f1ba2-125c-66b1-a5e5-d336f3705ad9@huaweicloud.com>
Date: Thu, 17 Apr 2025 19:08:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ee26d050-dd58-4672-93c2-d5b3fa63bbae@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2Al4QBo0zL8Jg--.5423S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWry3KrWrtr1ruw18CFWUCFg_yoWrCw4xpa
	yUKF47ArWUWFs5WaykGw4ku39xJrnIkry7ArW3J3yfAFn8Jr12yF18JFy0qrZ2yrWUCr48
	Xrs5trs3Jrs0qrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

在 2025/04/15 22:52, Jens Axboe 写道:
> Even if blk-rq-qos isn't used or configured, dipping into the queue to
> fetch ->rq_qos is a noticeable slowdown and visible in profiles. Add an
> unlikely static key around blk-rq-qos, to avoid fetching this cacheline
> if blk-iolatency or blk-wbt isn't configured or used.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
LGTM

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

BTW, do we want the same thing for q->td?

Thanks,
Kuai

> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index 95982bc46ba1..848591fb3c57 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -2,6 +2,8 @@
>   
>   #include "blk-rq-qos.h"
>   
> +__read_mostly DEFINE_STATIC_KEY_FALSE(block_rq_qos);
> +
>   /*
>    * Increment 'v', if 'v' is below 'below'. Returns true if we succeeded,
>    * false if 'v' + 1 would be bigger than 'below'.
> @@ -317,6 +319,7 @@ void rq_qos_exit(struct request_queue *q)
>   		struct rq_qos *rqos = q->rq_qos;
>   		q->rq_qos = rqos->next;
>   		rqos->ops->exit(rqos);
> +		static_branch_dec(&block_rq_qos);
>   	}
>   	mutex_unlock(&q->rq_qos_mutex);
>   }
> @@ -343,6 +346,7 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
>   		goto ebusy;
>   	rqos->next = q->rq_qos;
>   	q->rq_qos = rqos;
> +	static_branch_inc(&block_rq_qos);
>   
>   	blk_mq_unfreeze_queue(q, memflags);
>   
> diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
> index 37245c97ee61..39749f4066fb 100644
> --- a/block/blk-rq-qos.h
> +++ b/block/blk-rq-qos.h
> @@ -12,6 +12,7 @@
>   #include "blk-mq-debugfs.h"
>   
>   struct blk_mq_debugfs_attr;
> +extern struct static_key_false block_rq_qos;
>   
>   enum rq_qos_id {
>   	RQ_QOS_WBT,
> @@ -112,31 +113,33 @@ void __rq_qos_queue_depth_changed(struct rq_qos *rqos);
>   
>   static inline void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
>   {
> -	if (q->rq_qos)
> +	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
>   		__rq_qos_cleanup(q->rq_qos, bio);
>   }
>   
>   static inline void rq_qos_done(struct request_queue *q, struct request *rq)
>   {
> -	if (q->rq_qos && !blk_rq_is_passthrough(rq))
> +	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos &&
> +	    !blk_rq_is_passthrough(rq))
>   		__rq_qos_done(q->rq_qos, rq);
>   }
>   
>   static inline void rq_qos_issue(struct request_queue *q, struct request *rq)
>   {
> -	if (q->rq_qos)
> +	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
>   		__rq_qos_issue(q->rq_qos, rq);
>   }
>   
>   static inline void rq_qos_requeue(struct request_queue *q, struct request *rq)
>   {
> -	if (q->rq_qos)
> +	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
>   		__rq_qos_requeue(q->rq_qos, rq);
>   }
>   
>   static inline void rq_qos_done_bio(struct bio *bio)
>   {
> -	if (bio->bi_bdev && (bio_flagged(bio, BIO_QOS_THROTTLED) ||
> +	if (static_branch_unlikely(&block_rq_qos) &&
> +	    bio->bi_bdev && (bio_flagged(bio, BIO_QOS_THROTTLED) ||
>   			     bio_flagged(bio, BIO_QOS_MERGED))) {
>   		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>   		if (q->rq_qos)
> @@ -146,7 +149,7 @@ static inline void rq_qos_done_bio(struct bio *bio)
>   
>   static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
>   {
> -	if (q->rq_qos) {
> +	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos) {
>   		bio_set_flag(bio, BIO_QOS_THROTTLED);
>   		__rq_qos_throttle(q->rq_qos, bio);
>   	}
> @@ -155,14 +158,14 @@ static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
>   static inline void rq_qos_track(struct request_queue *q, struct request *rq,
>   				struct bio *bio)
>   {
> -	if (q->rq_qos)
> +	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
>   		__rq_qos_track(q->rq_qos, rq, bio);
>   }
>   
>   static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
>   				struct bio *bio)
>   {
> -	if (q->rq_qos) {
> +	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos) {
>   		bio_set_flag(bio, BIO_QOS_MERGED);
>   		__rq_qos_merge(q->rq_qos, rq, bio);
>   	}
> @@ -170,7 +173,7 @@ static inline void rq_qos_merge(struct request_queue *q, struct request *rq,
>   
>   static inline void rq_qos_queue_depth_changed(struct request_queue *q)
>   {
> -	if (q->rq_qos)
> +	if (static_branch_unlikely(&block_rq_qos) && q->rq_qos)
>   		__rq_qos_queue_depth_changed(q->rq_qos);
>   }
>   
> 

