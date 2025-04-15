Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7319BE552
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 01:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744681574; cv=none; b=ITQrk50POVB7MotisMVNEbk92qJcfLUXvJHskfPnrgZ61KFcj9uJ1e+afEVhmP/JsQMBQTI40ao5/AvSjVIk1NLodHSZL1tImZe4YOw3ZZSbJtYeRjRJub5QCHCJfHnZeh6gL6ZV78TdN4SKPipa4+g3E7fuWq0MDuyrHiakNR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744681574; c=relaxed/simple;
	bh=2AFW/qlt6uP4vYB4M/t3zhDe3MeFdaVHQ+QKptvtW6o=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kiGwIM9xpJjcau0Hh4FWanSjL5soF93Vi4i65ywSlSmZU/0y5rdqfK9keXqAEaDOh0T0a5q2feq1BSSsTqUesYt5la1B/ecHWw0hA1OifmATzdwZbatPal6/t+qfXxQ2/7eyMRdamP/SDFhQ22241MNFao30oOv/Cr0rwHWQAfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zc6S317Xtz4f3m6j
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 09:45:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5AB271A1176
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 09:46:04 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXu19buv1n6RMPJg--.45603S3;
	Tue, 15 Apr 2025 09:46:04 +0800 (CST)
Subject: Re: [PATCH 1/7] blk-throttle: Rename tg_may_dispatch() to
 tg_dispatch_time()
To: Zizhi Wo <wozizhi@huawei.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, ming.lei@redhat.com, tj@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250414132731.167620-1-wozizhi@huawei.com>
 <20250414132731.167620-2-wozizhi@huawei.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f20aef28-4515-debc-21cd-c6b4ab9ec81a@huaweicloud.com>
Date: Tue, 15 Apr 2025 09:46:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250414132731.167620-2-wozizhi@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXu19buv1n6RMPJg--.45603S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGr48tr4rZFW3Gr17Xr17trb_yoWrCw15pF
	WjkF4Yga18tF42kr13ZFnrCFyrtws7Z3srGrZ3GaySyw1jvr98KFn5ZryYyFWfAF93uF4x
	ZFWvv3srGa1jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUot
	CzDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/04/14 21:27, Zizhi Wo Ð´µÀ:
> tg_may_dispatch() can directly indicate whether bio can be dispatched by
> returning the time to wait, without the need for the redundant "wait"
> parameter. Remove it and modify the function's return type accordingly.
> 
> Since we have determined by the return time whether bio can be dispatched,
> rename tg_may_dispatch() to tg_dispatch_time().
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   block/blk-throttle.c | 40 +++++++++++++++-------------------------
>   1 file changed, 15 insertions(+), 25 deletions(-)
> 
LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 91dab43c65ab..dc23c961c028 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -743,14 +743,13 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
>   }
>   
>   /*
> - * Returns whether one can dispatch a bio or not. Also returns approx number
> - * of jiffies to wait before this bio is with-in IO rate and can be dispatched
> + * Returns approx number of jiffies to wait before this bio is with-in IO rate
> + * and can be dispatched.
>    */
> -static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
> -			    unsigned long *wait)
> +static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
>   {
>   	bool rw = bio_data_dir(bio);
> -	unsigned long bps_wait = 0, iops_wait = 0, max_wait = 0;
> +	unsigned long bps_wait, iops_wait, max_wait;
>   	u64 bps_limit = tg_bps_limit(tg, rw);
>   	u32 iops_limit = tg_iops_limit(tg, rw);
>   
> @@ -765,11 +764,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>   
>   	/* If tg->bps = -1, then BW is unlimited */
>   	if ((bps_limit == U64_MAX && iops_limit == UINT_MAX) ||
> -	    tg->flags & THROTL_TG_CANCELING) {
> -		if (wait)
> -			*wait = 0;
> -		return true;
> -	}
> +	    tg->flags & THROTL_TG_CANCELING)
> +		return 0;
>   
>   	/*
>   	 * If previous slice expired, start a new one otherwise renew/extend
> @@ -789,21 +785,15 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
>   
>   	bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
>   	iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
> -	if (bps_wait + iops_wait == 0) {
> -		if (wait)
> -			*wait = 0;
> -		return true;
> -	}
> +	if (bps_wait + iops_wait == 0)
> +		return 0;
>   
>   	max_wait = max(bps_wait, iops_wait);
>   
> -	if (wait)
> -		*wait = max_wait;
> -
>   	if (time_before(tg->slice_end[rw], jiffies + max_wait))
>   		throtl_extend_slice(tg, rw, jiffies + max_wait);
>   
> -	return false;
> +	return max_wait;
>   }
>   
>   static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
> @@ -854,16 +844,16 @@ static void throtl_add_bio_tg(struct bio *bio, struct throtl_qnode *qn,
>   static void tg_update_disptime(struct throtl_grp *tg)
>   {
>   	struct throtl_service_queue *sq = &tg->service_queue;
> -	unsigned long read_wait = -1, write_wait = -1, min_wait = -1, disptime;
> +	unsigned long read_wait = -1, write_wait = -1, min_wait, disptime;
>   	struct bio *bio;
>   
>   	bio = throtl_peek_queued(&sq->queued[READ]);
>   	if (bio)
> -		tg_may_dispatch(tg, bio, &read_wait);
> +		read_wait = tg_dispatch_time(tg, bio);
>   
>   	bio = throtl_peek_queued(&sq->queued[WRITE]);
>   	if (bio)
> -		tg_may_dispatch(tg, bio, &write_wait);
> +		write_wait = tg_dispatch_time(tg, bio);
>   
>   	min_wait = min(read_wait, write_wait);
>   	disptime = jiffies + min_wait;
> @@ -941,7 +931,7 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
>   	/* Try to dispatch 75% READS and 25% WRITES */
>   
>   	while ((bio = throtl_peek_queued(&sq->queued[READ])) &&
> -	       tg_may_dispatch(tg, bio, NULL)) {
> +	       tg_dispatch_time(tg, bio) == 0) {
>   
>   		tg_dispatch_one_bio(tg, READ);
>   		nr_reads++;
> @@ -951,7 +941,7 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
>   	}
>   
>   	while ((bio = throtl_peek_queued(&sq->queued[WRITE])) &&
> -	       tg_may_dispatch(tg, bio, NULL)) {
> +	       tg_dispatch_time(tg, bio) == 0) {
>   
>   		tg_dispatch_one_bio(tg, WRITE);
>   		nr_writes++;
> @@ -1610,7 +1600,7 @@ static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, bool rw)
>   	if (tg->service_queue.nr_queued[rw])
>   		return false;
>   
> -	return tg_may_dispatch(tg, bio, NULL);
> +	return tg_dispatch_time(tg, bio) == 0;
>   }
>   
>   bool __blk_throtl_bio(struct bio *bio)
> 

