Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7431DFFD
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965327; cv=none; b=TjNHl2cHRbbuEnVFEcHhkPVfjpGwvDtEBKysdBFFkm7zU9SBnTd2PP1ap5RqMZdOJof0acHOsHUc+WeGD0Nyd+7g3G8/eUuzkelu285XCNTKiXT9iqdmSTwPIvTHIdxzlEXkQF/j7fFIaNjr/FIXbsfkI06xq63jL4qjJd6SWns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965327; c=relaxed/simple;
	bh=ckaQZfN1mTP7VcG+6i5minZMWkas5dSVLhJxroGb2k4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Z47kSeJgi54kuVZnvgFDx7e1wbxuPaTQqAw8nrxs98ihru3QF3iCracPSOYQClMEXT5tItib2w35xN1w/mFc0bQLihvMexgwEHcvAeXnR323ECmRUP2GCtHEH4XUVKTNVZpw9K9F0LCYOl4Tdg26uBNqN14Cmx1W+hA4tyV0//Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zf7P12XGgz4f3jqb
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:35:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BCC681A140D
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:35:19 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHq1_FDgJo6iFVJw--.17280S3;
	Fri, 18 Apr 2025 16:35:19 +0800 (CST)
Subject: Re: [PATCH V3 6/7] blk-throttle: Split the service queue
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, ming.lei@redhat.com, tj@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250418040924.486324-1-wozizhi@huaweicloud.com>
 <20250418040924.486324-7-wozizhi@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7c1372c9-0ae4-caa2-f8c8-8ba67638fa4e@huaweicloud.com>
Date: Fri, 18 Apr 2025 16:35:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250418040924.486324-7-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHq1_FDgJo6iFVJw--.17280S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1fAw4xWr4UWFy7ZFy8uFg_yoWDJrWkpr
	yUCF43Jw4kJr4q9ry3tr42gFWSqw4xJrWfA3s3GrWSyrWaq3Z8Xr1UZryFvFWrAFn7uF48
	Zryqqrs8W3WUJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/04/18 12:09, Zizhi Wo Ð´µÀ:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> This patch splits throtl_service_queue->nr_queued into "nr_queued_bps" and
> "nr_queued_iops", allowing separate accounting of BPS and IOPS queued bios.
> This prepares for future changes that need to check whether the BPS or IOPS
> queues are empty.
> 
> To facilitate updating the number of IOs in the BPS and IOPS queues, the
> addition logic will be moved from throtl_add_bio_tg() to
> throtl_qnode_add_bio(), and similarly, the removal logic will be moved from
> tg_dispatch_one_bio() to throtl_pop_queued().
> 
> And introduce sq_queued() to calculate the total sum of sq->nr_queued.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   block/blk-throttle.c | 76 +++++++++++++++++++++++++++-----------------
>   block/blk-throttle.h |  3 +-
>   2 files changed, 49 insertions(+), 30 deletions(-)
> 
LGTM

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 1cfd226c3b39..0f113b2441aa 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -152,22 +152,27 @@ static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
>    * throtl_qnode_add_bio - add a bio to a throtl_qnode and activate it
>    * @bio: bio being added
>    * @qn: qnode to add bio to
> - * @queued: the service_queue->queued[] list @qn belongs to
> + * @sq: the service_queue @qn belongs to
>    *
> - * Add @bio to @qn and put @qn on @queued if it's not already on.
> + * Add @bio to @qn and put @qn on @sq->queued if it's not already on.
>    * @qn->tg's reference count is bumped when @qn is activated.  See the
>    * comment on top of throtl_qnode definition for details.
>    */
>   static void throtl_qnode_add_bio(struct bio *bio, struct throtl_qnode *qn,
> -				 struct list_head *queued)
> +				 struct throtl_service_queue *sq)
>   {
> -	if (bio_flagged(bio, BIO_TG_BPS_THROTTLED))
> +	bool rw = bio_data_dir(bio);
> +
> +	if (bio_flagged(bio, BIO_TG_BPS_THROTTLED)) {
>   		bio_list_add(&qn->bios_iops, bio);
> -	else
> +		sq->nr_queued_iops[rw]++;
> +	} else {
>   		bio_list_add(&qn->bios_bps, bio);
> +		sq->nr_queued_bps[rw]++;
> +	}
>   
>   	if (list_empty(&qn->node)) {
> -		list_add_tail(&qn->node, queued);
> +		list_add_tail(&qn->node, &sq->queued[rw]);
>   		blkg_get(tg_to_blkg(qn->tg));
>   	}
>   }
> @@ -198,22 +203,24 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
>   
>   /**
>    * throtl_pop_queued - pop the first bio form a qnode list
> - * @queued: the qnode list to pop a bio from
> + * @sq: the service_queue to pop a bio from
>    * @tg_to_put: optional out argument for throtl_grp to put
> + * @rw: read/write
>    *
> - * Pop the first bio from the qnode list @queued. Note that we firstly
> + * Pop the first bio from the qnode list @sq->queued. Note that we firstly
>    * focus on the iops list because bios are ultimately dispatched from it.
> - * After popping, the first qnode is removed from @queued if empty or moved to
> - * the end of @queued so that the popping order is round-robin.
> + * After popping, the first qnode is removed from @sq->queued if empty or
> + * moved to the end of @queued so that the popping order is round-robin.
>    *
>    * When the first qnode is removed, its associated throtl_grp should be put
>    * too.  If @tg_to_put is NULL, this function automatically puts it;
>    * otherwise, *@tg_to_put is set to the throtl_grp to put and the caller is
>    * responsible for putting it.
>    */
> -static struct bio *throtl_pop_queued(struct list_head *queued,
> -				     struct throtl_grp **tg_to_put)
> +static struct bio *throtl_pop_queued(struct throtl_service_queue *sq,
> +				     struct throtl_grp **tg_to_put, bool rw)
>   {
> +	struct list_head *queued = &sq->queued[rw];
>   	struct throtl_qnode *qn;
>   	struct bio *bio;
>   
> @@ -222,8 +229,13 @@ static struct bio *throtl_pop_queued(struct list_head *queued,
>   
>   	qn = list_first_entry(queued, struct throtl_qnode, node);
>   	bio = bio_list_pop(&qn->bios_iops);
> -	if (!bio)
> +	if (bio) {
> +		sq->nr_queued_iops[rw]--;
> +	} else {
>   		bio = bio_list_pop(&qn->bios_bps);
> +		if (bio)
> +			sq->nr_queued_bps[rw]--;
> +	}
>   	WARN_ON_ONCE(!bio);
>   
>   	if (bio_list_empty(&qn->bios_bps) && bio_list_empty(&qn->bios_iops)) {
> @@ -553,6 +565,11 @@ static bool throtl_slice_used(struct throtl_grp *tg, bool rw)
>   	return true;
>   }
>   
> +static unsigned int sq_queued(struct throtl_service_queue *sq, int type)
> +{
> +	return sq->nr_queued_bps[type] + sq->nr_queued_iops[type];
> +}
> +
>   static unsigned int calculate_io_allowed(u32 iops_limit,
>   					 unsigned long jiffy_elapsed)
>   {
> @@ -682,9 +699,9 @@ static void tg_update_carryover(struct throtl_grp *tg)
>   	long long bytes[2] = {0};
>   	int ios[2] = {0};
>   
> -	if (tg->service_queue.nr_queued[READ])
> +	if (sq_queued(&tg->service_queue, READ))
>   		__tg_update_carryover(tg, READ, &bytes[READ], &ios[READ]);
> -	if (tg->service_queue.nr_queued[WRITE])
> +	if (sq_queued(&tg->service_queue, WRITE))
>   		__tg_update_carryover(tg, WRITE, &bytes[WRITE], &ios[WRITE]);
>   
>   	/* see comments in struct throtl_grp for meaning of these fields. */
> @@ -776,7 +793,8 @@ static void throtl_charge_iops_bio(struct throtl_grp *tg, struct bio *bio)
>    */
>   static void tg_update_slice(struct throtl_grp *tg, bool rw)
>   {
> -	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
> +	if (throtl_slice_used(tg, rw) &&
> +	    sq_queued(&tg->service_queue, rw) == 0)
>   		throtl_start_new_slice(tg, rw, true);
>   	else
>   		throtl_extend_slice(tg, rw, jiffies + tg->td->throtl_slice);
> @@ -832,7 +850,7 @@ static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
>   	 * this function with a different bio if there are other bios
>   	 * queued.
>   	 */
> -	BUG_ON(tg->service_queue.nr_queued[rw] &&
> +	BUG_ON(sq_queued(&tg->service_queue, rw) &&
>   	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
>   
>   	wait = tg_dispatch_bps_time(tg, bio);
> @@ -872,12 +890,11 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
>   	 * dispatched.  Mark that @tg was empty.  This is automatically
>   	 * cleared on the next tg_update_disptime().
>   	 */
> -	if (!sq->nr_queued[rw])
> +	if (sq_queued(sq, rw) == 0)
>   		tg->flags |= THROTL_TG_WAS_EMPTY;
>   
> -	throtl_qnode_add_bio(bio, qn, &sq->queued[rw]);
> +	throtl_qnode_add_bio(bio, qn, sq);
>   
> -	sq->nr_queued[rw]++;
>   	throtl_enqueue_tg(tg);
>   }
>   
> @@ -931,8 +948,7 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
>   	 * getting released prematurely.  Remember the tg to put and put it
>   	 * after @bio is transferred to @parent_sq.
>   	 */
> -	bio = throtl_pop_queued(&sq->queued[rw], &tg_to_put);
> -	sq->nr_queued[rw]--;
> +	bio = throtl_pop_queued(sq, &tg_to_put, rw);
>   
>   	throtl_charge_iops_bio(tg, bio);
>   
> @@ -949,7 +965,7 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
>   	} else {
>   		bio_set_flag(bio, BIO_BPS_THROTTLED);
>   		throtl_qnode_add_bio(bio, &tg->qnode_on_parent[rw],
> -				     &parent_sq->queued[rw]);
> +				     parent_sq);
>   		BUG_ON(tg->td->nr_queued[rw] <= 0);
>   		tg->td->nr_queued[rw]--;
>   	}
> @@ -1014,7 +1030,7 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
>   		nr_disp += throtl_dispatch_tg(tg);
>   
>   		sq = &tg->service_queue;
> -		if (sq->nr_queued[READ] || sq->nr_queued[WRITE])
> +		if (sq_queued(sq, READ) || sq_queued(sq, WRITE))
>   			tg_update_disptime(tg);
>   		else
>   			throtl_dequeue_tg(tg);
> @@ -1067,9 +1083,11 @@ static void throtl_pending_timer_fn(struct timer_list *t)
>   	dispatched = false;
>   
>   	while (true) {
> +		unsigned int bio_cnt_r = sq_queued(sq, READ);
> +		unsigned int bio_cnt_w = sq_queued(sq, WRITE);
> +
>   		throtl_log(sq, "dispatch nr_queued=%u read=%u write=%u",
> -			   sq->nr_queued[READ] + sq->nr_queued[WRITE],
> -			   sq->nr_queued[READ], sq->nr_queued[WRITE]);
> +			   bio_cnt_r + bio_cnt_w, bio_cnt_r, bio_cnt_w);
>   
>   		ret = throtl_select_dispatch(sq);
>   		if (ret) {
> @@ -1131,7 +1149,7 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
>   
>   	spin_lock_irq(&q->queue_lock);
>   	for (rw = READ; rw <= WRITE; rw++)
> -		while ((bio = throtl_pop_queued(&td_sq->queued[rw], NULL)))
> +		while ((bio = throtl_pop_queued(td_sq, NULL, rw)))
>   			bio_list_add(&bio_list_on_stack, bio);
>   	spin_unlock_irq(&q->queue_lock);
>   
> @@ -1637,7 +1655,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
>   static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
>   {
>   	/* throtl is FIFO - if bios are already queued, should queue */
> -	if (tg->service_queue.nr_queued[rw])
> +	if (sq_queued(&tg->service_queue, rw))
>   		return false;
>   
>   	return tg_dispatch_time(tg, bio) == 0;
> @@ -1711,7 +1729,7 @@ bool __blk_throtl_bio(struct bio *bio)
>   		   tg->bytes_disp[rw], bio->bi_iter.bi_size,
>   		   tg_bps_limit(tg, rw),
>   		   tg->io_disp[rw], tg_iops_limit(tg, rw),
> -		   sq->nr_queued[READ], sq->nr_queued[WRITE]);
> +		   sq_queued(sq, READ), sq_queued(sq, WRITE));
>   
>   	td->nr_queued[rw]++;
>   	throtl_add_bio_tg(bio, qn, tg);
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index 5257e5c053e6..04e92cfd0ab1 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -41,7 +41,8 @@ struct throtl_service_queue {
>   	 * children throtl_grp's.
>   	 */
>   	struct list_head	queued[2];	/* throtl_qnode [READ/WRITE] */
> -	unsigned int		nr_queued[2];	/* number of queued bios */
> +	unsigned int		nr_queued_bps[2];	/* number of queued bps bios */
> +	unsigned int		nr_queued_iops[2];	/* number of queued iops bios */
>   
>   	/*
>   	 * RB tree of active children throtl_grp's, which are sorted by
> 

