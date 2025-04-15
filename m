Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9E320AF9C
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744684243; cv=none; b=uq2Ijq7Bs29d/RcTZ+EO8y0pbFTuuPBAdagb5dkquTeTPv0Spier/8xnU5SSB084Da3fiP1zh4m8OCgi0ZTWO2zj4EuYVS+ulSy6hKWH15CyHkd7/rPB1ohuhtFk0MeKoVbaJmomLl9Fb2Y+mBNOZ2Io+KR4UpZuQ5OwgL/LS3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744684243; c=relaxed/simple;
	bh=xHSLDoDoTnMedKCW7meXaEYvwjEkNCsGLHqVlfuciJo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TYdcWhCtkrtOaXSwemSc6rVs/3k2q/aeiRxOq57CS/rfFPVLgRTpzkvLA8swMe+7bNvqZZdlAipGZOH9aVGzMwRzqayX/Ur2P0ruEVCSe2Q2Aq9YjA1F1lWWDcoU5X9kLXUITTE2sNxaj3CuxiEJyDXSKVd0j2Lj6duBXu0qos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zc7RX6qMsz4f3jqq
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 10:30:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3EA5C1A0F30
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 10:30:35 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl_JxP1n6D0SJg--.36388S3;
	Tue, 15 Apr 2025 10:30:35 +0800 (CST)
Subject: Re: [PATCH 5/7] blk-throttle: Split the blkthrotl queue
To: Zizhi Wo <wozizhi@huawei.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, ming.lei@redhat.com, tj@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250414132731.167620-1-wozizhi@huawei.com>
 <20250414132731.167620-6-wozizhi@huawei.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b03979a8-d933-15d1-3817-966b1cfad4ea@huaweicloud.com>
Date: Tue, 15 Apr 2025 10:30:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250414132731.167620-6-wozizhi@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl_JxP1n6D0SJg--.36388S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4kAryDAFWUuFWfXw15CFg_yoWxXrWDpF
	W3GF45Ja1kJrs2gr1aqF47CFySqa17ZrZrtr93C3yYyrW3Zr47XFn8Xry8AFWrAFZ7Wa1I
	vrn0grsxGa1UJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZSd
	gUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/04/14 21:27, Zizhi Wo Ð´µÀ:
> This patch splits the single queue into separate bps and iops queues. Now,
> an IO request must first pass through the bps queue, then the iops queue,
> and finally be dispatched. Due to the queue splitting, we need to modify
> the throtl add/peek/pop function.
> 
> Additionally, the patch modifies the logic related to tg_dispatch_time().
> If bio needs to wait for bps, function directly returns the bps wait time;
> otherwise, it charges bps and returns the iops wait time so that bio can be
> directly placed into the iops queue afterward. Note that this may lead to
> more frequent updates to disptime, but the overhead is negligible for the
> slow path.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   block/blk-throttle.c | 49 ++++++++++++++++++++++++++++++--------------
>   block/blk-throttle.h |  3 ++-
>   2 files changed, 36 insertions(+), 16 deletions(-)
> 

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index caae2e3b7534..542db54f995c 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -143,7 +143,8 @@ static inline unsigned int throtl_bio_data_size(struct bio *bio)
>   static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
>   {
>   	INIT_LIST_HEAD(&qn->node);
> -	bio_list_init(&qn->bios);
> +	bio_list_init(&qn->bios_bps);
> +	bio_list_init(&qn->bios_iops);
>   	qn->tg = tg;
>   }
>   
> @@ -160,7 +161,11 @@ static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
>   static void throtl_qnode_add_bio(struct bio *bio, struct throtl_qnode *qn,
>   				 struct list_head *queued)
>   {
> -	bio_list_add(&qn->bios, bio);
> +	if (bio_flagged(bio, BIO_TG_BPS_THROTTLED))
> +		bio_list_add(&qn->bios_iops, bio);
> +	else
> +		bio_list_add(&qn->bios_bps, bio);
> +
>   	if (list_empty(&qn->node)) {
>   		list_add_tail(&qn->node, queued);
>   		blkg_get(tg_to_blkg(qn->tg));
> @@ -170,6 +175,10 @@ static void throtl_qnode_add_bio(struct bio *bio, struct throtl_qnode *qn,
>   /**
>    * throtl_peek_queued - peek the first bio on a qnode list
>    * @queued: the qnode list to peek
> + *
> + * Always take a bio from the head of the iops queue first. If the queue
> + * is empty, we then take it from the bps queue to maintain the overall
> + * idea of fetching bios from the head.
>    */
>   static struct bio *throtl_peek_queued(struct list_head *queued)
>   {
> @@ -180,7 +189,9 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
>   		return NULL;
>   
>   	qn = list_first_entry(queued, struct throtl_qnode, node);
> -	bio = bio_list_peek(&qn->bios);
> +	bio = bio_list_peek(&qn->bios_iops);
> +	if (!bio)
> +		bio = bio_list_peek(&qn->bios_bps);
>   	WARN_ON_ONCE(!bio);
>   	return bio;
>   }
> @@ -190,9 +201,10 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
>    * @queued: the qnode list to pop a bio from
>    * @tg_to_put: optional out argument for throtl_grp to put
>    *
> - * Pop the first bio from the qnode list @queued.  After popping, the first
> - * qnode is removed from @queued if empty or moved to the end of @queued so
> - * that the popping order is round-robin.
> + * Pop the first bio from the qnode list @queued.  Note that we firstly focus
> + * on the iops list here because bios are ultimately dispatched from it.
> + * After popping, the first qnode is removed from @queued if empty or moved to
> + * the end of @queued so that the popping order is round-robin.
>    *
>    * When the first qnode is removed, its associated throtl_grp should be put
>    * too.  If @tg_to_put is NULL, this function automatically puts it;
> @@ -209,10 +221,12 @@ static struct bio *throtl_pop_queued(struct list_head *queued,
>   		return NULL;
>   
>   	qn = list_first_entry(queued, struct throtl_qnode, node);
> -	bio = bio_list_pop(&qn->bios);
> +	bio = bio_list_pop(&qn->bios_iops);
> +	if (!bio)
> +		bio = bio_list_pop(&qn->bios_bps);
>   	WARN_ON_ONCE(!bio);
>   
> -	if (bio_list_empty(&qn->bios)) {
> +	if (bio_list_empty(&qn->bios_bps) && bio_list_empty(&qn->bios_iops)) {
>   		list_del_init(&qn->node);
>   		if (tg_to_put)
>   			*tg_to_put = qn->tg;
> @@ -805,12 +819,12 @@ static unsigned long tg_dispatch_iops_time(struct throtl_grp *tg, struct bio *bi
>   
>   /*
>    * Returns approx number of jiffies to wait before this bio is with-in IO rate
> - * and can be dispatched.
> + * and can be moved to other queue or dispatched.
>    */
>   static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
>   {
>   	bool rw = bio_data_dir(bio);
> -	unsigned long bps_wait, iops_wait;
> +	unsigned long wait;
>   
>   	/*
>    	 * Currently whole state machine of group depends on first bio
> @@ -821,10 +835,17 @@ static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
>   	BUG_ON(tg->service_queue.nr_queued[rw] &&
>   	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
>   
> -	bps_wait = tg_dispatch_bps_time(tg, bio);
> -	iops_wait = tg_dispatch_iops_time(tg, bio);
> +	wait = tg_dispatch_bps_time(tg, bio);
> +	if (wait != 0)
> +		return wait;
>   
> -	return max(bps_wait, iops_wait);
> +	/*
> +	 * Charge bps here because @bio will be directly placed into the
> +	 * iops queue afterward.
> +	 */
> +	throtl_charge_bps_bio(tg, bio);
> +
> +	return tg_dispatch_iops_time(tg, bio);
>   }
>   
>   /**
> @@ -913,7 +934,6 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
>   	bio = throtl_pop_queued(&sq->queued[rw], &tg_to_put);
>   	sq->nr_queued[rw]--;
>   
> -	throtl_charge_bps_bio(tg, bio);
>   	throtl_charge_iops_bio(tg, bio);
>   
>   	/*
> @@ -1641,7 +1661,6 @@ bool __blk_throtl_bio(struct bio *bio)
>   	while (true) {
>   		if (tg_within_limit(tg, bio, rw)) {
>   			/* within limits, let's charge and dispatch directly */
> -			throtl_charge_bps_bio(tg, bio);
>   			throtl_charge_iops_bio(tg, bio);
>   
>   			/*
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index 7964cc041e06..5257e5c053e6 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -28,7 +28,8 @@
>    */
>   struct throtl_qnode {
>   	struct list_head	node;		/* service_queue->queued[] */
> -	struct bio_list		bios;		/* queued bios */
> +	struct bio_list		bios_bps;	/* queued bios for bps limit */
> +	struct bio_list		bios_iops;	/* queued bios for iops limit */
>   	struct throtl_grp	*tg;		/* tg this qnode belongs to */
>   };
>   
> 

