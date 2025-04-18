Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2B119C54B
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 01:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744939720; cv=none; b=gaIrNCkTrIs620Ml5zNVn0UWOv4880cTGL/PSliaw/mJMmxcwE9ztJjNznPdfmWbsgjXBYHswxfBtgeyDy2Xh6rqyIfKKHx3UblVLHA4FXOXxTqZ+6CfTwToEv1/hdMqaTITvPzN1GD634b6AB6I2mo/TocfmV2VQ2XFyOu6nsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744939720; c=relaxed/simple;
	bh=B7oFndvNYesHAglwskwduyKl7T5NhaOf5Set7ZjoNmQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fLUA3q68jVsAklDWI36SlrCSi3PVt6l8pwhiW9QRkppBsKxz4nMYSWMHwORK6ntN6NeHl0KkSjncpA5bQReObA0VlQcskDbX/EIFy6u0ci9yJZHa0PdZ38d2OgUXuHwHsg6Vo3kOulQhwUpQb702Wh2p8tE68e+1rROgRIvSVJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZdxwV2dr2z4f3kF4
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 09:28:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 226F41A1538
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 09:28:34 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl_BqgFotGk3Jw--.13675S3;
	Fri, 18 Apr 2025 09:28:33 +0800 (CST)
Subject: Re: [PATCH V2 3/3] blk-throttle: Add an additional overflow check to
 the call calculate_bytes/io_allowed
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: yangerkun@huawei.com, ming.lei@redhat.com, tj@kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250417132054.2866409-1-wozizhi@huaweicloud.com>
 <20250417132054.2866409-4-wozizhi@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <0a0a1bf8-6245-4a17-d3c0-8bb1b5a84e36@huaweicloud.com>
Date: Fri, 18 Apr 2025 09:28:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250417132054.2866409-4-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl_BqgFotGk3Jw--.13675S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFyDGr4UAr18ZrykCFWDXFb_yoW7uryDpr
	4xGF17Ga1DXF1xtF1fX3ZayFyrJr48AryUJ3y3W395Ar90kryvgrn8urZ8tayIyrn7Aayf
	Aw12v3srCr4qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUotCzDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/04/17 21:20, Zizhi Wo Ð´µÀ:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
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
>   block/blk-throttle.c | 83 +++++++++++++++++++++++++++++++++-----------
>   1 file changed, 62 insertions(+), 21 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 66a9044a5207..a0c2b2813ee7 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -571,6 +571,48 @@ static u64 calculate_bytes_allowed(u64 bps_limit, unsigned long jiffy_elapsed)
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
> +	if (bytes_trim <= 0 || tg->bytes_disp[rw] < bytes_trim) {
> +		bytes_trim = tg->bytes_disp[rw];
> +		tg->bytes_disp[rw] = 0;
> +	} else {
> +		tg->bytes_disp[rw] -= bytes_trim;
> +	}
> +
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
> +	if (io_trim <= 0 || tg->io_disp[rw] < io_trim) {
> +		io_trim = tg->io_disp[rw];
> +		tg->io_disp[rw] = 0;
> +	} else {
> +		tg->io_disp[rw] -= io_trim;
> +	}
> +
> +	return io_trim;
> +}
> +
>   /* Trim the used slices and adjust slice start accordingly */
>   static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>   {
> @@ -612,22 +654,11 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
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
> @@ -643,6 +674,8 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
>   	unsigned long jiffy_elapsed = jiffies - tg->slice_start[rw];
>   	u64 bps_limit = tg_bps_limit(tg, rw);
>   	u32 iops_limit = tg_iops_limit(tg, rw);
> +	long long bytes_allowed;
> +	int io_allowed;
>   
>   	/*
>   	 * If the queue is empty, carryover handling is not needed. In such cases,
> @@ -661,13 +694,19 @@ static void __tg_update_carryover(struct throtl_grp *tg, bool rw,
>   	 * accumulate how many bytes/ios are waited across changes. And use the
>   	 * calculated carryover (@bytes/@ios) to update [bytes/io]_disp, which
>   	 * will be used to calculate new wait time under new configuration.
> +	 * And we need to consider the case of bytes/io_allowed overflow.
>   	 */
> -	if (bps_limit != U64_MAX)
> -		*bytes = calculate_bytes_allowed(bps_limit, jiffy_elapsed) -
> -			tg->bytes_disp[rw];
> -	if (iops_limit != UINT_MAX)
> -		*ios = calculate_io_allowed(iops_limit, jiffy_elapsed) -
> -			tg->io_disp[rw];
> +	if (bps_limit != U64_MAX) {
> +		bytes_allowed = calculate_bytes_allowed(bps_limit, jiffy_elapsed);
> +		if (bytes_allowed > 0)
> +			*bytes = bytes_allowed - tg->bytes_disp[rw];

So, I don't think this is possible in real life, because BIO has to be
throttled here, means allowed is less than dispatched. However, changes
make sense, feel free to add:

Reviewed-by: Yu Kuai <yukuai3@huawei.com>

> +	}
> +	if (iops_limit != UINT_MAX) {
> +		io_allowed = calculate_io_allowed(iops_limit, jiffy_elapsed);
> +		if (io_allowed > 0)
> +			*ios = io_allowed - tg->io_disp[rw];
> +	}
> +
>   	tg->bytes_disp[rw] = -*bytes;
>   	tg->io_disp[rw] = -*ios;
>   }
> @@ -734,7 +773,9 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
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

