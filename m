Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB7E8460
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744683600; cv=none; b=SKn+62YvoyjtzfaEZYOPhbdCN0UsNL+472Nz/ACoHwK7jxdbCKmVwdNlkMM30B1ktkwOPZNdFfj/xTaqGrSrNGYyHoifdwJvOT359HWzq1/izoGNfDe1a7QQzdBqhzjUoZHOL2Cof1shy4SFbaMn818j0gDXopg5KMgD/86hEg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744683600; c=relaxed/simple;
	bh=1Vo3YLeWS0IHzShVaX51Jrrhdx3GnJ8phq7ydaTEncY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WyPaB0QQqMt408Dj+eEXEhSK04izA09M/8iCce3A9GvophbGtT+zVn3Gsoi0FVT0Drk1s15mazj7zc/i8wkohjEQsNYRrHGC56BDZLnbrvuU5z45qUwg888cVxw6IEUoPQnq8038ypePc463PFMS1oWKp8lcUA+SpFR+xMBABFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zc7CD0kltz4f3jLm
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 10:19:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5F5111A06D7
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 10:19:54 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgC3Gl9Iwv1nYX4RJg--.35839S3;
	Tue, 15 Apr 2025 10:19:54 +0800 (CST)
Subject: Re: [PATCH 2/7] blk-throttle: Refactor tg_dispatch_time by extracting
 tg_dispatch_bps/iops_time
To: Zizhi Wo <wozizhi@huawei.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, ming.lei@redhat.com, tj@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250414132731.167620-1-wozizhi@huawei.com>
 <20250414132731.167620-3-wozizhi@huawei.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <58cabe9f-86c6-d26a-d27b-0a138b00e7ec@huaweicloud.com>
Date: Tue, 15 Apr 2025 10:19:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250414132731.167620-3-wozizhi@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Gl9Iwv1nYX4RJg--.35839S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WF4fKFWDGr4kCFW8Wry5twb_yoWxJr1rpF
	W3CF4jqF48XFn2kF13Zws8GFWFkws7AF9rJasrG34DAF4YvryDKF1DZrW5AayrAFZ7ua1x
	Aa4qv3srCanFyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

Hi, one nit below:

ÔÚ 2025/04/14 21:27, Zizhi Wo Ð´µÀ:
> tg_dispatch_time() contained both bps and iops throttling logic. We now
> split its internal logic into tg_dispatch_bps/iops_time() to improve code
> consistency for future separation of the bps and iops queues.
> 
> Besides, merge time_before() from caller into throtl_extend_slice() to make
> code cleaner.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   block/blk-throttle.c | 98 +++++++++++++++++++++++++-------------------
>   1 file changed, 55 insertions(+), 43 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index dc23c961c028..0633ae0cce90 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -520,6 +520,9 @@ static inline void throtl_set_slice_end(struct throtl_grp *tg, bool rw,
>   static inline void throtl_extend_slice(struct throtl_grp *tg, bool rw,
>   				       unsigned long jiffy_end)
>   {
> +	if (!time_before(tg->slice_end[rw], jiffy_end))
> +		return;
> +
>   	throtl_set_slice_end(tg, rw, jiffy_end);
>   	throtl_log(&tg->service_queue,
>   		   "[%c] extend slice start=%lu end=%lu jiffies=%lu",
> @@ -682,10 +685,6 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
>   	int io_allowed;
>   	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
>   
> -	if (iops_limit == UINT_MAX) {
> -		return 0;
> -	}
> -
>   	jiffy_elapsed = jiffies - tg->slice_start[rw];
>   
>   	/* Round up to the next throttle slice, wait time must be nonzero */
> @@ -711,11 +710,6 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
>   	unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
>   	unsigned int bio_size = throtl_bio_data_size(bio);
>   
> -	/* no need to throttle if this bio's bytes have been accounted */
> -	if (bps_limit == U64_MAX || bio_flagged(bio, BIO_BPS_THROTTLED)) {
> -		return 0;
> -	}
> -
>   	jiffy_elapsed = jiffy_elapsed_rnd = jiffies - tg->slice_start[rw];
>   
>   	/* Slice has just started. Consider one slice interval */
> @@ -742,6 +736,54 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
>   	return jiffy_wait;
>   }
>   
> +/*
> + * If previous slice expired, start a new one otherwise renew/extend existing
> + * slice to make sure it is at least throtl_slice interval long since now.
> + * New slice is started only for empty throttle group. If there is queued bio,
> + * that means there should be an active slice and it should be extended instead.
> + */
> +static void tg_update_slice(struct throtl_grp *tg, bool rw)
> +{
> +	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
> +		throtl_start_new_slice(tg, rw, true);
> +	else
> +		throtl_extend_slice(tg, rw, jiffies + tg->td->throtl_slice);
> +}
> +
> +static unsigned long tg_dispatch_bps_time(struct throtl_grp *tg, struct bio *bio)
> +{
> +	bool rw = bio_data_dir(bio);
> +	u64 bps_limit = tg_bps_limit(tg, rw);
> +	unsigned long bps_wait;
> +
> +	/* no need to throttle if this bio's bytes have been accounted */
> +	if (bps_limit == U64_MAX || tg->flags & THROTL_TG_CANCELING ||
> +	    bio_flagged(bio, BIO_BPS_THROTTLED))
> +		return 0;
> +
> +	tg_update_slice(tg, rw);
> +	bps_wait = tg_within_bps_limit(tg, bio, bps_limit);

if (bps_wait > 0)
> +	throtl_extend_slice(tg, rw, jiffies + bps_wait);
> +
> +	return bps_wait;
> +}
> +
> +static unsigned long tg_dispatch_iops_time(struct throtl_grp *tg, struct bio *bio)
> +{
> +	bool rw = bio_data_dir(bio);
> +	u32 iops_limit = tg_iops_limit(tg, rw);
> +	unsigned long iops_wait;
> +
> +	if (iops_limit == UINT_MAX || tg->flags & THROTL_TG_CANCELING)
> +		return 0;
> +
> +	tg_update_slice(tg, rw);
> +	iops_wait = tg_within_iops_limit(tg, bio, iops_limit);

if (iops_wait > 0)

Otherwise, LGTM

Thanks,
Kuai
> +	throtl_extend_slice(tg, rw, jiffies + iops_wait);
> +
> +	return iops_wait;
> +}
> +
>   /*
>    * Returns approx number of jiffies to wait before this bio is with-in IO rate
>    * and can be dispatched.
> @@ -749,9 +791,7 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
>   static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
>   {
>   	bool rw = bio_data_dir(bio);
> -	unsigned long bps_wait, iops_wait, max_wait;
> -	u64 bps_limit = tg_bps_limit(tg, rw);
> -	u32 iops_limit = tg_iops_limit(tg, rw);
> +	unsigned long bps_wait, iops_wait;
>   
>   	/*
>    	 * Currently whole state machine of group depends on first bio
> @@ -762,38 +802,10 @@ static unsigned long tg_dispatch_time(struct throtl_grp *tg, struct bio *bio)
>   	BUG_ON(tg->service_queue.nr_queued[rw] &&
>   	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
>   
> -	/* If tg->bps = -1, then BW is unlimited */
> -	if ((bps_limit == U64_MAX && iops_limit == UINT_MAX) ||
> -	    tg->flags & THROTL_TG_CANCELING)
> -		return 0;
> -
> -	/*
> -	 * If previous slice expired, start a new one otherwise renew/extend
> -	 * existing slice to make sure it is at least throtl_slice interval
> -	 * long since now. New slice is started only for empty throttle group.
> -	 * If there is queued bio, that means there should be an active
> -	 * slice and it should be extended instead.
> -	 */
> -	if (throtl_slice_used(tg, rw) && !(tg->service_queue.nr_queued[rw]))
> -		throtl_start_new_slice(tg, rw, true);
> -	else {
> -		if (time_before(tg->slice_end[rw],
> -		    jiffies + tg->td->throtl_slice))
> -			throtl_extend_slice(tg, rw,
> -				jiffies + tg->td->throtl_slice);
> -	}
> -
> -	bps_wait = tg_within_bps_limit(tg, bio, bps_limit);
> -	iops_wait = tg_within_iops_limit(tg, bio, iops_limit);
> -	if (bps_wait + iops_wait == 0)
> -		return 0;
> -
> -	max_wait = max(bps_wait, iops_wait);
> -
> -	if (time_before(tg->slice_end[rw], jiffies + max_wait))
> -		throtl_extend_slice(tg, rw, jiffies + max_wait);
> +	bps_wait = tg_dispatch_bps_time(tg, bio);
> +	iops_wait = tg_dispatch_iops_time(tg, bio);
>   
> -	return max_wait;
> +	return max(bps_wait, iops_wait);
>   }
>   
>   static void throtl_charge_bio(struct throtl_grp *tg, struct bio *bio)
> 

