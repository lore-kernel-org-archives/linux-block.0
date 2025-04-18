Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F944A2D
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744939151; cv=none; b=CGiHmZZ0SxHiXIaY8ieIn4p+Jl07yrCERWMgbavVaXOCeMQRGhBxWFycGdMQQ7c6ce7w9LXYuRwZ8PlN1h47m2QozTuAhnC0qVdfvu05zWXvK/bCELm9HHBvitXrN6CAEQXpG2p6GLF5g+2qGEs298xX4eDknSdZmgI1tJrMhEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744939151; c=relaxed/simple;
	bh=+QdQPgPK/8TCx+tAddL66AAsDdcYrqCQldvsqEXMoXA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XNHyRFgnWRSbGnXzxUg9QNU7eIllxT99KXmmcbp2ACqD5NiRSgF8VBtAjiKLEft99L2j2s3lb5CoZYOzg4r3bBfnGMO4uyqmRI4UoLrDLlYVv3WZLsjJPvRg3DunaximLTz/88g+9hJFGarVcOldiWT4pZOh9CUsMBBwmX0cRXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zdxjg1xrTz4f3jtW
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 09:18:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A9F701A1CBF
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 09:19:05 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2CHqAFoi8Q2Jw--.15817S3;
	Fri, 18 Apr 2025 09:19:05 +0800 (CST)
Subject: Re: [PATCH V2 1/3] blk-throttle: Fix wrong tg->[bytes/io]_disp update
 in __tg_update_carryover()
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, ming.lei@redhat.com, tj@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250417132054.2866409-1-wozizhi@huaweicloud.com>
 <20250417132054.2866409-2-wozizhi@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0e54bdf1-278a-dfd2-b6ed-742baf86b49b@huaweicloud.com>
Date: Fri, 18 Apr 2025 09:19:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250417132054.2866409-2-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnC2CHqAFoi8Q2Jw--.15817S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF13JFyUXrWrur17Cr18uFg_yoW5WryDpF
	yYka13Jw1kXF47W3sxA3Z7KFW8XayxAry3JrZ3Kw45AFnIk3s5KrWUCr90kayIvFn3KF48
	AwnFqrZxur1F9rDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUwxhLUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/04/17 21:20, Zizhi Wo Ð´µÀ:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> In commit 6cc477c36875 ("blk-throttle: carry over directly"), the carryover
> bytes/ios was be carried to [bytes/io]_disp. However, its update mechanism
> has some issues.
> 
> In __tg_update_carryover(), we calculate "bytes" and "ios" to represent the
> carryover, but the computation when updating [bytes/io]_disp is incorrect.
> And if the sq->nr_queued is empty, we may not update tg->[bytes/io]_disp to
> 0 in tg_update_carryover(). We should set it to 0 in non carryover case.
> This patch fixes the issue.
> 
> Fixes: 6cc477c36875 ("blk-throttle: carry over directly")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   block/blk-throttle.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
> 
LGTM

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 91dab43c65ab..8ac8db116520 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -644,6 +644,18 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
>   	u64 bps_limit = tg_bps_limit(tg, rw);
>   	u32 iops_limit = tg_iops_limit(tg, rw);
>   
> +	/*
> +	 * If the queue is empty, carryover handling is not needed. In such cases,
> +	 * tg->[bytes/io]_disp should be reset to 0 to avoid impacting the dispatch
> +	 * of subsequent bios. The same handling applies when the previous BPS/IOPS
> +	 * limit was set to max.
> +	 */
> +	if (tg->service_queue.nr_queued[rw] == 0) {
> +		tg->bytes_disp[rw] = 0;
> +		tg->io_disp[rw] = 0;
> +		return;
> +	}
> +
>   	/*
>   	 * If config is updated while bios are still throttled, calculate and
>   	 * accumulate how many bytes/ios are waited across changes. And
> @@ -656,8 +668,8 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
>   	if (iops_limit != UINT_MAX)
>   		*ios = calculate_io_allowed(iops_limit, jiffy_elapsed) -
>   			tg->io_disp[rw];
> -	tg->bytes_disp[rw] -= *bytes;
> -	tg->io_disp[rw] -= *ios;
> +	tg->bytes_disp[rw] = -*bytes;
> +	tg->io_disp[rw] = -*ios;
>   }
>   
>   static void tg_update_carryover(struct throtl_grp *tg)
> @@ -665,10 +677,8 @@ static void tg_update_carryover(struct throtl_grp *tg)
>   	long long bytes[2] = {0};
>   	int ios[2] = {0};
>   
> -	if (tg->service_queue.nr_queued[READ])
> -		__tg_update_carryover(tg, READ, &bytes[READ], &ios[READ]);
> -	if (tg->service_queue.nr_queued[WRITE])
> -		__tg_update_carryover(tg, WRITE, &bytes[WRITE], &ios[WRITE]);
> +	__tg_update_carryover(tg, READ, &bytes[READ], &ios[READ]);
> +	__tg_update_carryover(tg, WRITE, &bytes[WRITE], &ios[WRITE]);
>   
>   	/* see comments in struct throtl_grp for meaning of these fields. */
>   	throtl_log(&tg->service_queue, "%s: %lld %lld %d %d\n", __func__,
> 

