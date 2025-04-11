Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FFC27BF94
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 02:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744340002; cv=none; b=IW9K1SujKXhhI+eo5sPXNrt1+qmepFc7BqKO7pvdWvhKajhMByRvFuyBZq7MrhlFyS55rmTEy9UA+ErgbMO4nA2o2o2Emwid+s1Pj/G3/u59RHHkwZppg1yq4hreb/4DP6koeYvLupgefAyqB76/hc2XPg36AuoLOkbu4vVecXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744340002; c=relaxed/simple;
	bh=7mbJFZIfk8QKNWHsL0zjjgAbFJnv4uH5nToB/cdTR7k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oyEExUerWRUvfl7U0Uozq3DsrvCvJuHvNTbOoApXIFMfMqSEieUzYH2wN2n8YSYwGAIMsYQ+7Bc4V9IyoNdi1wAzbc2vCyXOe3lT6YXIqCLPXTBx9cKI79E6eMDBvK3pb9nibzkKHoyr1cvPB6YRN1qgihY4Gkdfo/tChcWJQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZYh7X5ZWGz4f3jYl
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 10:52:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DF8BF1A06DD
	for <linux-block@vger.kernel.org>; Fri, 11 Apr 2025 10:53:14 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAHa18ZhPhnO6WCJA--.42120S3;
	Fri, 11 Apr 2025 10:53:14 +0800 (CST)
Subject: Re: [PATCH 3/3] blk-throttle: carry over directly
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 "yukuai (C)" <yukuai3@huawei.com>, WoZ1zh1 <wozizhi@huawei.com>
References: <20250305043123.3938491-1-ming.lei@redhat.com>
 <20250305043123.3938491-4-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <14e6c54f-d0d9-0122-1e47-c8a56adbd5db@huaweicloud.com>
Date: Fri, 11 Apr 2025 10:53:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250305043123.3938491-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHa18ZhPhnO6WCJA--.42120S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WFyfCFyUuFWfury8WF17Jrb_yoWxAFyxpF
	WrAF42gw4FqFn7G3ZxA3ZYyay8Xay7AryUJ3yUWwn5AFn0krykKrn8WrZYyayxAF97Aa1I
	yw1jgr98Jr42kFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi, Ming

ÔÚ 2025/03/05 12:31, Ming Lei Ð´µÀ:
> Now ->carryover_bytes[] and ->carryover_ios[] only covers limit/config
> update.
> 
> Actually the carryover bytes/ios can be carried to ->bytes_disp[] and
> ->io_disp[] directly, since the carryover is one-shot thing and only valid
> in current slice.
> 
> Then we can remove the two fields and simplify code much.
> 
> Type of ->bytes_disp[] and ->io_disp[] has to change as signed because the
> two fields may become negative when updating limits or config, but both are
> big enough for holding bytes/ios dispatched in single slice
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-throttle.c | 49 +++++++++++++++++++-------------------------
>   block/blk-throttle.h |  4 ++--
>   2 files changed, 23 insertions(+), 30 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 7271aee94faf..91dab43c65ab 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -478,8 +478,6 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
>   {
>   	tg->bytes_disp[rw] = 0;
>   	tg->io_disp[rw] = 0;
> -	tg->carryover_bytes[rw] = 0;
> -	tg->carryover_ios[rw] = 0;
>   
>   	/*
>   	 * Previous slice has expired. We must have trimmed it after last
> @@ -498,16 +496,14 @@ static inline void throtl_start_new_slice_with_credit(struct throtl_grp *tg,
>   }
>   
>   static inline void throtl_start_new_slice(struct throtl_grp *tg, bool rw,
> -					  bool clear_carryover)
> +					  bool clear)
>   {
> -	tg->bytes_disp[rw] = 0;
> -	tg->io_disp[rw] = 0;
> +	if (clear) {
> +		tg->bytes_disp[rw] = 0;
> +		tg->io_disp[rw] = 0;
> +	}
>   	tg->slice_start[rw] = jiffies;
>   	tg->slice_end[rw] = jiffies + tg->td->throtl_slice;
> -	if (clear_carryover) {
> -		tg->carryover_bytes[rw] = 0;
> -		tg->carryover_ios[rw] = 0;
> -	}
>   
>   	throtl_log(&tg->service_queue,
>   		   "[%c] new slice start=%lu end=%lu jiffies=%lu",
> @@ -617,20 +613,16 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>   	 */
>   	time_elapsed -= tg->td->throtl_slice;
>   	bytes_trim = calculate_bytes_allowed(tg_bps_limit(tg, rw),
> -					     time_elapsed) +
> -		     tg->carryover_bytes[rw];
> -	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed) +
> -		  tg->carryover_ios[rw];
> +					     time_elapsed);
> +	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed);
>   	if (bytes_trim <= 0 && io_trim <= 0)
>   		return;
>   
> -	tg->carryover_bytes[rw] = 0;
>   	if ((long long)tg->bytes_disp[rw] >= bytes_trim)
>   		tg->bytes_disp[rw] -= bytes_trim;
>   	else
>   		tg->bytes_disp[rw] = 0;
>   
> -	tg->carryover_ios[rw] = 0;
>   	if ((int)tg->io_disp[rw] >= io_trim)
>   		tg->io_disp[rw] -= io_trim;
>   	else
> @@ -645,7 +637,8 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>   		   jiffies);
>   }
>   
> -static void __tg_update_carryover(struct throtl_grp *tg, bool rw)
> +static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
> +				  long long *bytes, int *ios)
>   {
>   	unsigned long jiffy_elapsed = jiffies - tg->slice_start[rw];
>   	u64 bps_limit = tg_bps_limit(tg, rw);
> @@ -658,26 +651,28 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw)
>   	 * configuration.
>   	 */
>   	if (bps_limit != U64_MAX)
> -		tg->carryover_bytes[rw] +=
> -			calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
> +		*bytes = calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
>   			tg->bytes_disp[rw];
>   	if (iops_limit != UINT_MAX)
> -		tg->carryover_ios[rw] +=
> -			calculate_io_allowed(iops_limit, jiffy_elapsed) -
> +		*ios = calculate_io_allowed(iops_limit, jiffy_elapsed) -
>   			tg->io_disp[rw];
> +	tg->bytes_disp[rw] -= *bytes;
> +	tg->io_disp[rw] -= *ios;

This patch is applied before I get a chance to review. :( I think the
above update should be:

tg->bytes_disp[rw] = -*bytes;
tg->io_disp[rw] = -*ios;

Otherwise, the result is actually (2 * disp - allowed), which might be a
huge value, causing long dealy for the next dispatch.

This is what the old carryover fileds do, above change will work, but
look wried.

Thanks,
Kuai

>   }
>   
>   static void tg_update_carryover(struct throtl_grp *tg)
>   {
> +	long long bytes[2] = {0};
> +	int ios[2] = {0};
> +
>   	if (tg->service_queue.nr_queued[READ])
> -		__tg_update_carryover(tg, READ);
> +		__tg_update_carryover(tg, READ, &bytes[READ], &ios[READ]);
>   	if (tg->service_queue.nr_queued[WRITE])
> -		__tg_update_carryover(tg, WRITE);
> +		__tg_update_carryover(tg, WRITE, &bytes[WRITE], &ios[WRITE]);
>   
>   	/* see comments in struct throtl_grp for meaning of these fields. */
>   	throtl_log(&tg->service_queue, "%s: %lld %lld %d %d\n", __func__,
> -		   tg->carryover_bytes[READ], tg->carryover_bytes[WRITE],
> -		   tg->carryover_ios[READ], tg->carryover_ios[WRITE]);
> +		   bytes[READ], bytes[WRITE], ios[READ], ios[WRITE]);
>   }
>   
>   static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio,
> @@ -695,8 +690,7 @@ static unsigned long tg_within_iops_limit(struct throtl_grp *tg, struct bio *bio
>   
>   	/* Round up to the next throttle slice, wait time must be nonzero */
>   	jiffy_elapsed_rnd = roundup(jiffy_elapsed + 1, tg->td->throtl_slice);
> -	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd) +
> -		     tg->carryover_ios[rw];
> +	io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed_rnd);
>   	if (io_allowed > 0 && tg->io_disp[rw] + 1 <= io_allowed)
>   		return 0;
>   
> @@ -729,8 +723,7 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
>   		jiffy_elapsed_rnd = tg->td->throtl_slice;
>   
>   	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
> -	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd) +
> -			tg->carryover_bytes[rw];
> +	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
>   	if (bytes_allowed > 0 && tg->bytes_disp[rw] + bio_size <= bytes_allowed)
>   		return 0;
>   
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index ba8f6e986994..7964cc041e06 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -102,9 +102,9 @@ struct throtl_grp {
>   	unsigned int iops[2];
>   
>   	/* Number of bytes dispatched in current slice */
> -	uint64_t bytes_disp[2];
> +	int64_t bytes_disp[2];
>   	/* Number of bio's dispatched in current slice */
> -	unsigned int io_disp[2];
> +	int io_disp[2];
>   
>   	/*
>   	 * The following two fields are updated when new configuration is
> 

