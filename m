Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514B275114
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702132; cv=none; b=RgR1orRqMDcEgpVeiJK6k3ntD5BVozWKiPx7lPG/pT/ACA/Lex9m9QM/XWgcXGf+urlNaBGIrnQyM3XJ4ZnvGa9FDYSVZCpNR1X9Pre7x56qsuJP0yB5fZE5i8nrPh/MDck2UApM4Qy7bvUWeNJVNTRvfBgQQ+EZjReaNKhP5qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702132; c=relaxed/simple;
	bh=EjxugM8oA78GfMRz+8m1GxTZGzwYLXusqpUj3CLR/nE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eql0Bruc65rhi1fM3dGW3+uxPtP0FEBLIoQmfij7IWvFS0BXYRqDAHr2nBPkpIe3JCVwHp0XdKY58t8/YutcZ9b0tzXrITSSRbmX8AcatI7KD9wg5YSGjaS9O89mQAa/SYCyikfZpHxT59EOXt2XQrPCuf+BIrh0qwF2o34eVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZcG3K52tBz4f3m6S
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 15:28:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E16C31A1687
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 15:28:38 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl+lCv5nmDEnJg--.45187S3;
	Tue, 15 Apr 2025 15:28:38 +0800 (CST)
Subject: Re: [PATCH 7/7] blk-throttle: Prevents the bps restricted io from
 entering the bps queue again
To: Zizhi Wo <wozizhi@huawei.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, ming.lei@redhat.com, tj@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250414132731.167620-1-wozizhi@huawei.com>
 <20250414132731.167620-8-wozizhi@huawei.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2098dfd2-1ad5-e3c0-08bc-fa8ee84e8df8@huaweicloud.com>
Date: Tue, 15 Apr 2025 15:28:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250414132731.167620-8-wozizhi@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl+lCv5nmDEnJg--.45187S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr47ur4fWrWrXF4kXF1UKFg_yoWxAryDpF
	y8CF4rJa1ktrsFkr13XF17KFWSqw4fXry3Ar93J34SyrW2qr1vgF1DZryrZF4rAFZxur43
	ZF4UKrZ3C3Wjy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/04/14 21:27, Zizhi Wo Ð´µÀ:
> [BUG]
> There has an issue of io delayed dispatch caused by io splitting. Consider
> the following scenario:
> 1) If we set a BPS limit of 1MB/s and restrict the maximum IO size per
> dispatch to 4KB, submitting -two- 1MB IO requests results in completion
> times of 1s and 2s, which is expected.
> 2) However, if we additionally set an IOPS limit of 1,000,000/s with the
> same BPS limit of 1MB/s, submitting -two- 1MB IO requests again results in
> both completing in 2s, even though the IOPS constraint is being met.
> 
> [CAUSE]
> This issue arises because BPS and IOPS currently share the same queue in
> the blkthrotl mechanism:
> 1) This issue does not occur when only BPS is limited because the split IOs
> return false in blk_should_throtl() and do not go through to throtl again.
> 2) For split IOs, even if they have been tagged with BIO_BPS_THROTTLED,
> they still get queued alternately in the same list due to continuous
> splitting and reordering. As a result, the two IO requests are both
> completed at the 2-second mark, causing an unintended delay.
> 3) It is not difficult to imagine that in this scenario, if N 1MB IOs are
> issued at once, all IOs will eventually complete together in N seconds.
> 
> [FIX]
> With the queue separation introduced in the previous patch, we now have
> separate BPS and IOPS queues. For IOs that have already passed the BPS
> limitation, they do not need to re-enter the BPS queue and can directly
> placed to the IOPS queue.
> 
> Since we have split the queues, when the IOPS queue is previously empty
> and a new bio is added to the first qnode in the service_queue, we also
> need to update the disptime. This patch introduces
> "THROTL_TG_IOPS_WAS__EMPTY" flag to mark it.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   block/blk-throttle.c | 53 +++++++++++++++++++++++++++++++++++++-------
>   block/blk-throttle.h |  8 ++++---
>   2 files changed, 50 insertions(+), 11 deletions(-)
> 

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index faae10e2e6e3..b82ce8e927d3 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -165,7 +165,12 @@ static void throtl_qnode_add_bio(struct bio *bio, struct throtl_qnode *qn,
>   	struct throtl_service_queue *sq = container_of(queued,
>   				struct throtl_service_queue, queued[rw]);
>   
> -	if (bio_flagged(bio, BIO_TG_BPS_THROTTLED)) {
> +	/*
> +	 * Split bios have already been throttled by bps, so they are
> +	 * directly queued into the iops path.
> +	 */
> +	if (bio_flagged(bio, BIO_TG_BPS_THROTTLED) ||
> +	    bio_flagged(bio, BIO_BPS_THROTTLED)) {
>   		bio_list_add(&qn->bios_iops, bio);
>   		sq->nr_queued_iops[rw]++;
>   	} else {
> @@ -897,6 +902,15 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
>   
>   	throtl_qnode_add_bio(bio, qn, &sq->queued[rw]);
>   
> +	/*
> +	 * Since we have split the queues, when the iops queue is
> +	 * previously empty and a new @bio is added into the first @qn,
> +	 * we also need to update the @tg->disptime.
> +	 */
> +	if (bio_flagged(bio, BIO_BPS_THROTTLED) &&
> +	    bio == throtl_peek_queued(&sq->queued[rw]))
> +		tg->flags |= THROTL_TG_IOPS_WAS_EMPTY;
> +
>   	throtl_enqueue_tg(tg);
>   }
>   
> @@ -924,6 +938,7 @@ static void tg_update_disptime(struct throtl_grp *tg)
>   
>   	/* see throtl_add_bio_tg() */
>   	tg->flags &= ~THROTL_TG_WAS_EMPTY;
> +	tg->flags &= ~THROTL_TG_IOPS_WAS_EMPTY;
>   }
>   
>   static void start_parent_slice_with_credit(struct throtl_grp *child_tg,
> @@ -1111,7 +1126,8 @@ static void throtl_pending_timer_fn(struct timer_list *t)
>   
>   	if (parent_sq) {
>   		/* @parent_sq is another throl_grp, propagate dispatch */
> -		if (tg->flags & THROTL_TG_WAS_EMPTY) {
> +		if (tg->flags & THROTL_TG_WAS_EMPTY ||
> +		    tg->flags & THROTL_TG_IOPS_WAS_EMPTY) {
>   			tg_update_disptime(tg);
>   			if (!throtl_schedule_next_dispatch(parent_sq, false)) {
>   				/* window is already open, repeat dispatching */
> @@ -1656,9 +1672,28 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
>   
>   static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
>   {
> -	/* throtl is FIFO - if bios are already queued, should queue */
> -	if (sq_queued(&tg->service_queue, rw))
> +	struct throtl_service_queue *sq = &tg->service_queue;
> +
> +	/*
> +	 * For a split bio, we need to specifically distinguish whether the
> +	 * iops queue is empty.
> +	 */
> +	if (bio_flagged(bio, BIO_BPS_THROTTLED))
> +		return sq->nr_queued_iops[rw] == 0 &&
> +				tg_dispatch_iops_time(tg, bio) == 0;
> +
> +	/*
> +	 * Throtl is FIFO - if bios are already queued, should queue.
> +	 * If the bps queue is empty and @bio is within the bps limit, charge
> +	 * bps here for direct placement into the iops queue.
> +	 */
> +	if (sq_queued(&tg->service_queue, rw)) {
> +		if (sq->nr_queued_bps[rw] == 0 &&
> +		    tg_dispatch_bps_time(tg, bio) == 0)
> +			throtl_charge_bps_bio(tg, bio);
> +
>   		return false;
> +	}
>   
>   	return tg_dispatch_time(tg, bio) == 0;
>   }
> @@ -1739,11 +1774,13 @@ bool __blk_throtl_bio(struct bio *bio)
>   
>   	/*
>   	 * Update @tg's dispatch time and force schedule dispatch if @tg
> -	 * was empty before @bio.  The forced scheduling isn't likely to
> -	 * cause undue delay as @bio is likely to be dispatched directly if
> -	 * its @tg's disptime is not in the future.
> +	 * was empty before @bio, or the iops queue is empty and @bio will
> +	 * add to.  The forced scheduling isn't likely to cause undue
> +	 * delay as @bio is likely to be dispatched directly if its @tg's
> +	 * disptime is not in the future.
>   	 */
> -	if (tg->flags & THROTL_TG_WAS_EMPTY) {
> +	if (tg->flags & THROTL_TG_WAS_EMPTY ||
> +	    tg->flags & THROTL_TG_IOPS_WAS_EMPTY) {
>   		tg_update_disptime(tg);
>   		throtl_schedule_next_dispatch(tg->service_queue.parent_sq, true);
>   	}
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index 04e92cfd0ab1..6f11aaabe7e7 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -55,9 +55,11 @@ struct throtl_service_queue {
>   };
>   
>   enum tg_state_flags {
> -	THROTL_TG_PENDING	= 1 << 0,	/* on parent's pending tree */
> -	THROTL_TG_WAS_EMPTY	= 1 << 1,	/* bio_lists[] became non-empty */
> -	THROTL_TG_CANCELING	= 1 << 2,	/* starts to cancel bio */
> +	THROTL_TG_PENDING		= 1 << 0,	/* on parent's pending tree */
> +	THROTL_TG_WAS_EMPTY		= 1 << 1,	/* bio_lists[] became non-empty */
> +	/* iops queue is empty, and a bio is about to be enqueued to the first qnode. */
> +	THROTL_TG_IOPS_WAS_EMPTY	= 1 << 2,
> +	THROTL_TG_CANCELING		= 1 << 3,	/* starts to cancel bio */
>   };
>   
>   struct throtl_grp {
> 

