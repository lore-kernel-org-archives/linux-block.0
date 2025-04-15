Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCDE1581E1
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744684461; cv=none; b=S80WmII16NmfNUvT0Pt8NA5oPXyIyI6PH2CflNKWEQBRF5X1C9BTdTTd5eOqD09xCM9J1GytvQyZvcjpbKyrbz0Ck4j96L6CH+k6MWlwAETc1p8p49Eja9hPvZcwkka/KEeEzES3CFXAKisVYFprGtEsMCE0uc0BsT7QvaiOrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744684461; c=relaxed/simple;
	bh=r0+PAm6/A3BE0oCF1B3FvoganLrF0zZerUrUAn9jSGI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sLIf0zy3/18XHetMPNoZj3HKMuOdiUz4WwGYpVImRILVJWS70mFzg9tvN63v1604za+brU2qfeDNdF3dDWTkEhNR+qxKwp7A/9xB+UGCz608KXQWDaLmbMDRiBnPeefM24zlqXfttOBXyPlck3NM9b543qWMUgwsDU+76Lbi5uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zc7Wm69Kkz4f3jtT
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 10:33:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5712A1A1A8C
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 10:34:10 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXvGChxf1n0H8SJg--.37421S3;
	Tue, 15 Apr 2025 10:34:10 +0800 (CST)
Subject: Re: [PATCH 6/7] blk-throttle: Split the service queue
To: Zizhi Wo <wozizhi@huawei.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, ming.lei@redhat.com, tj@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250414132731.167620-1-wozizhi@huawei.com>
 <20250414132731.167620-7-wozizhi@huawei.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <46268858-3300-caf1-4e9a-f731ebf812d5@huaweicloud.com>
Date: Tue, 15 Apr 2025 10:34:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250414132731.167620-7-wozizhi@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXvGChxf1n0H8SJg--.37421S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AF13uFW5WrWxCrWkZF4DXFb_yoW3Kr1Dpr
	WUCF43Jw4kJF4v9ry3tr47KFWSqw4xJrWfA3s3GrW7ArWaq3Z8WF1UZryFvFWrAFn7uF48
	Zryqqrs8Ka1UAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFB
	T5DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/04/14 21:27, Zizhi Wo Ð´µÀ:
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
>   block/blk-throttle.c | 56 ++++++++++++++++++++++++++++++--------------
>   block/blk-throttle.h |  3 ++-
>   2 files changed, 40 insertions(+), 19 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 542db54f995c..faae10e2e6e3 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -161,10 +161,17 @@ static void throtl_qnode_init(struct throtl_qnode *qn, struct throtl_grp *tg)
>   static void throtl_qnode_add_bio(struct bio *bio, struct throtl_qnode *qn,
>   				 struct list_head *queued)
>   {
> -	if (bio_flagged(bio, BIO_TG_BPS_THROTTLED))
> +	bool rw = bio_data_dir(bio);
> +	struct throtl_service_queue *sq = container_of(queued,
> +				struct throtl_service_queue, queued[rw]);

Instead of container_of(), I think directly pass in sq is better, the
queued list can be get by sq->queued[rw];

Otherwise LGTM.

Thanks,
Kuai

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
>   		list_add_tail(&qn->node, queued);
> @@ -200,6 +207,7 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
>    * throtl_pop_queued - pop the first bio form a qnode list
>    * @queued: the qnode list to pop a bio from
>    * @tg_to_put: optional out argument for throtl_grp to put
> + * @rw: read/write
>    *
>    * Pop the first bio from the qnode list @queued.  Note that we firstly focus
>    * on the iops list here because bios are ultimately dispatched from it.
> @@ -212,8 +220,10 @@ static struct bio *throtl_peek_queued(struct list_head *queued)
>    * responsible for putting it.
>    */
>   static struct bio *throtl_pop_queued(struct list_head *queued,
> -				     struct throtl_grp **tg_to_put)
> +				     struct throtl_grp **tg_to_put, bool rw)
>   {
> +	struct throtl_service_queue *sq = container_of(queued,
> +				struct throtl_service_queue, queued[rw]);
>   	struct throtl_qnode *qn;
>   	struct bio *bio;
>   
> @@ -222,8 +232,12 @@ static struct bio *throtl_pop_queued(struct list_head *queued,
>   
>   	qn = list_first_entry(queued, struct throtl_qnode, node);
>   	bio = bio_list_pop(&qn->bios_iops);
> -	if (!bio)
> +	if (!bio) {
>   		bio = bio_list_pop(&qn->bios_bps);
> +		sq->nr_queued_bps[rw]--;
> +	} else {
> +		sq->nr_queued_iops[rw]--;
> +	}
>   	WARN_ON_ONCE(!bio);
>   
>   	if (bio_list_empty(&qn->bios_bps) && bio_list_empty(&qn->bios_iops)) {
> @@ -553,6 +567,11 @@ static bool throtl_slice_used(struct throtl_grp *tg, bool rw)
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
> @@ -682,9 +701,9 @@ static void tg_update_carryover(struct throtl_grp *tg)
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
> @@ -776,7 +795,8 @@ static void throtl_charge_iops_bio(struct throtl_grp *tg, struct bio *bio)
>    */
>   static void tg_update_slice(struct throtl_grp *tg, bool rw)
>   {
> -	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
> +	if (throtl_slice_used(tg, rw) &&
> +	    sq_queued(&tg->service_queue, rw) == 0)
>   		throtl_start_new_slice(tg, rw, true);
>   	else
>   		throtl_extend_slice(tg, rw, jiffies + tg->td->throtl_slice);
> @@ -832,7 +852,7 @@ static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
>   	 * this function with a different bio if there are other bios
>   	 * queued.
>   	 */
> -	BUG_ON(tg->service_queue.nr_queued[rw] &&
> +	BUG_ON(sq_queued(&tg->service_queue, rw) &&
>   	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
>   
>   	wait = tg_dispatch_bps_time(tg, bio);
> @@ -872,12 +892,11 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
>   	 * dispatched.  Mark that @tg was empty.  This is automatically
>   	 * cleared on the next tg_update_disptime().
>   	 */
> -	if (!sq->nr_queued[rw])
> +	if (sq_queued(sq, rw) == 0)
>   		tg->flags |= THROTL_TG_WAS_EMPTY;
>   
>   	throtl_qnode_add_bio(bio, qn, &sq->queued[rw]);
>   
> -	sq->nr_queued[rw]++;
>   	throtl_enqueue_tg(tg);
>   }
>   
> @@ -931,8 +950,7 @@ static void tg_dispatch_one_bio(struct throtl_grp *tg, bool rw)
>   	 * getting released prematurely.  Remember the tg to put and put it
>   	 * after @bio is transferred to @parent_sq.
>   	 */
> -	bio = throtl_pop_queued(&sq->queued[rw], &tg_to_put);
> -	sq->nr_queued[rw]--;
> +	bio = throtl_pop_queued(&sq->queued[rw], &tg_to_put, rw);
>   
>   	throtl_charge_iops_bio(tg, bio);
>   
> @@ -1014,7 +1032,7 @@ static int throtl_select_dispatch(struct throtl_service_queue *parent_sq)
>   		nr_disp += throtl_dispatch_tg(tg);
>   
>   		sq = &tg->service_queue;
> -		if (sq->nr_queued[READ] || sq->nr_queued[WRITE])
> +		if (sq_queued(sq, READ) || sq_queued(sq, WRITE))
>   			tg_update_disptime(tg);
>   		else
>   			throtl_dequeue_tg(tg);
> @@ -1067,9 +1085,11 @@ static void throtl_pending_timer_fn(struct timer_list *t)
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
> @@ -1131,7 +1151,7 @@ static void blk_throtl_dispatch_work_fn(struct work_struct *work)
>   
>   	spin_lock_irq(&q->queue_lock);
>   	for (rw = READ; rw <= WRITE; rw++)
> -		while ((bio = throtl_pop_queued(&td_sq->queued[rw], NULL)))
> +		while ((bio = throtl_pop_queued(&td_sq->queued[rw], NULL, rw)))
>   			bio_list_add(&bio_list_on_stack, bio);
>   	spin_unlock_irq(&q->queue_lock);
>   
> @@ -1637,7 +1657,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
>   static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
>   {
>   	/* throtl is FIFO - if bios are already queued, should queue */
> -	if (tg->service_queue.nr_queued[rw])
> +	if (sq_queued(&tg->service_queue, rw))
>   		return false;
>   
>   	return tg_dispatch_time(tg, bio) == 0;
> @@ -1711,7 +1731,7 @@ bool __blk_throtl_bio(struct bio *bio)
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

