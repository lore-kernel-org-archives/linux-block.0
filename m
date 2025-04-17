Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187E920330
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 02:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744857587; cv=none; b=VFSztFmN99eBrPqHk6tdv8oVfPJB7Upj4ov6cbhr3eLOByukz1vQAX62jMMaOf2a9jKmahz2fsOnwgE/CNo3HY6+ezF/UIt020BRgtHzT0Rclir/JVBuymqikmYggtJS9v4aMwd/nXTj2hUfI7BLGvq6wLVbTvUiUg/mhAtUJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744857587; c=relaxed/simple;
	bh=NJk70WYNSFxYfO1E7eIVWWgT00zOg5A1CsYRJqEfvLw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=pucGVxSXIagM/TAmq2FXZK9uZwATD8wF3Ys13GxgXKWxjkk71eSIwKUFIbpMxL/quwHT9MpXN0POkA2Y7gkmyEErUlPkSt0QHAuqWURcrZADSJrhJoxrSRssjhztl8DlNnKR1bsC1uT0T91FILUuM0Q9qq7R6pPkUxihP9yv65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZdMXz5ln2z4f3lfH
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 10:39:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1581C1A018D
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 10:39:41 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl_saQBoLUXZJg--.699S3;
	Thu, 17 Apr 2025 10:39:40 +0800 (CST)
Subject: Re: [PATCH 3/3] blk-throttle: Add an additional overflow check to the
 call calculate_bytes/io_allowed
To: Zizhi Wo <wozizhi@huawei.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, ming.lei@redhat.com, tj@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250417015033.512940-1-wozizhi@huawei.com>
 <20250417015033.512940-4-wozizhi@huawei.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <b6eed403-07c5-9bc4-e61d-698e22b65873@huaweicloud.com>
Date: Thu, 17 Apr 2025 10:39:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250417015033.512940-4-wozizhi@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnSl_saQBoLUXZJg--.699S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFyDGr48urW8Xw1UCFyUZFb_yoW7Kr1fpr
	4xJF17GwsrXF17trn3X3ZavF10qr48AryUG3y5W34rAF98Kryvgrn8GrZ8tayxAr1xAayf
	A347uwnrCr4qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

ÔÚ 2025/04/17 9:50, Zizhi Wo Ð´µÀ:
> Now the tg->[bytes/io]_disp type is signed, and calculate_bytes/io_allowed
> return type is unsigned. Even if the bps/iops limit is not set to max, the
> return value of the function may still exceed INT_MAX or LLONG_MAX, which
> can cause overflow in outer variables. In such cases, we can add additional
> checks accordingly.
> 
> And in throtl_trim_slice(), if the BPS/IOPS limit is set to max, there's
> no need to call calculate_bytes/io_allowed(). Introduces the helper
> functions throtl_trim_bps/iops to simplifies the process. For cases when
> the calculated trim value exceeds INT_MAX (causing an overflow), we reset
> tg->[bytes/io]_disp to zero, so return original tg->[bytes/io]_disp because
> it is the size that is actually trimmed.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   block/blk-throttle.c | 94 ++++++++++++++++++++++++++++++++++----------
>   1 file changed, 73 insertions(+), 21 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 4e4609dce85d..cfb9c47d1af7 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -571,6 +571,56 @@ static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
>   	return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
>   }
>   
> +static long long throtl_trim_bps(struct throtl_grp *tg, bool rw,
> +				 unsigned long time_elapsed)
> +{
> +	u64 bps_limit = tg_bps_limit(tg, rw);
> +	long long bytes_trim;
> +
> +	if (bps_limit == U64_MAX)
> +		return 0;
> +
> +	/* Need to consider the case of bytes_allowed overflow. */
> +	bytes_trim = calculate_bytes_allowed(bps_limit, time_elapsed);
> +	if (bytes_trim <= 0) {
> +		bytes_trim = tg->bytes_disp[rw];
> +		tg->bytes_disp[rw] = 0;
> +		goto out;
> +	}
> +
> +	if (tg->bytes_disp[rw] >= bytes_trim)
> +		tg->bytes_disp[rw] -= bytes_trim;
> +	else
> +		tg->bytes_disp[rw] = 0;

Perhaps

if (bytes_trim <=0 || tg->bytes_disp[rw] < bytes_trim) {
	bytes_trim = tg->bytes_disp[rw];
	tg->bytes_disp[rw] = 0;
} else {
	tg->bytes_disp[rw] -= bytes_trim;
}

And you don't need the out tag.
> +out:
> +	return bytes_trim;
> +}
> +
> +static int throtl_trim_iops(struct throtl_grp *tg, bool rw,
> +			    unsigned long time_elapsed)
> +{
> +	u32 iops_limit = tg_iops_limit(tg, rw);
> +	int io_trim;
> +
> +	if (iops_limit == UINT_MAX)
> +		return 0;
> +
> +	/* Need to consider the case of io_allowed overflow. */
> +	io_trim = calculate_io_allowed(iops_limit, time_elapsed);
> +	if (io_trim <= 0) {
> +		io_trim = tg->io_disp[rw];
> +		tg->io_disp[rw] = 0;
> +		goto out;
> +	}
> +
> +	if (tg->io_disp[rw] >= io_trim)
> +		tg->io_disp[rw] -= io_trim;
> +	else
> +		tg->io_disp[rw] = 0;
> +out:
> +	return io_trim;

Same as above.

Thanks,
Kuai

> +}
> +
>   /* Trim the used slices and adjust slice start accordingly */
>   static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>   {
> @@ -612,22 +662,11 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>   	 * one extra slice is preserved for deviation.
>   	 */
>   	time_elapsed -= tg->td->throtl_slice;
> -	bytes_trim = calculate_bytes_allowed(tg_bps_limit(tg, rw),
> -					     time_elapsed);
> -	io_trim = calculate_io_allowed(tg_iops_limit(tg, rw), time_elapsed);
> -	if (bytes_trim <= 0 && io_trim <= 0)
> +	bytes_trim = throtl_trim_bps(tg, rw, time_elapsed);
> +	io_trim = throtl_trim_iops(tg, rw, time_elapsed);
> +	if (!bytes_trim && !io_trim)
>   		return;
>   
> -	if ((long long)tg->bytes_disp[rw] >= bytes_trim)
> -		tg->bytes_disp[rw] -= bytes_trim;
> -	else
> -		tg->bytes_disp[rw] = 0;
> -
> -	if ((int)tg->io_disp[rw] >= io_trim)
> -		tg->io_disp[rw] -= io_trim;
> -	else
> -		tg->io_disp[rw] = 0;
> -
>   	tg->slice_start[rw] += time_elapsed;
>   
>   	throtl_log(&tg->service_queue,
> @@ -643,6 +682,8 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
>   	unsigned long jiffy_elapsed = jiffies - tg->slice_start[rw];
>   	u64 bps_limit = tg_bps_limit(tg, rw);
>   	u32 iops_limit = tg_iops_limit(tg, rw);
> +	long long bytes_allowed;
> +	int io_allowed;
>   
>   	/*
>   	 * If the queue is empty, carryover handling is not needed. In such cases,
> @@ -661,19 +702,28 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
>   	 * accumulate how many bytes/ios are waited across changes. And use the
>   	 * calculated carryover (@bytes/@ios) to update [bytes/io]_disp, which
>   	 * will be used to calculate new wait time under new configuration.
> +	 * And we need to consider the case of bytes/io_allowed overflow.
>   	 */
>   	if (bps_limit != U64_MAX) {
> -		*bytes = calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
> -			tg->bytes_disp[rw];
> -		tg->bytes_disp[rw] = -*bytes;
> +		bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed);
> +		if (bytes_allowed < 0) {
> +			tg->bytes_disp[rw] = 0;
> +		} else {
> +			*bytes = bytes_allowed - tg->bytes_disp[rw];
> +			tg->bytes_disp[rw] = -*bytes;
> +		}
>   	} else {
>   		tg->bytes_disp[rw] = 0;
>   	}
>   
>   	if (iops_limit != UINT_MAX) {
> -		*ios = calculate_io_allowed(iops_limit, jiffy_elapsed) -
> -			tg->io_disp[rw];
> -		tg->io_disp[rw] = -*ios;
> +		io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed);
> +		if (io_allowed < 0) {
> +			tg->io_disp[rw] = 0;
> +		} else {
> +			*ios = io_allowed - tg->io_disp[rw];
> +			tg->io_disp[rw] = -*ios;
> +		}
>   	} else {
>   		tg->io_disp[rw] = 0;
>   	}
> @@ -741,7 +791,9 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
>   
>   	jiffy_elapsed_rnd = roundup(jiffy_elapsed_rnd, tg->td->throtl_slice);
>   	bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed_rnd);
> -	if (bytes_allowed > 0 && tg->bytes_disp[rw] + bio_size <= bytes_allowed)
> +	/* Need to consider the case of bytes_allowed overflow. */
> +	if ((bytes_allowed > 0 && tg->bytes_disp[rw] + bio_size <= bytes_allowed)
> +	    || bytes_allowed < 0)
>   		return 0;
>   
>   	/* Calc approx time to dispatch */
> 

