Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C894F288A2
	for <linux-block@vger.kernel.org>; Thu, 20 Feb 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058701; cv=none; b=EyEKyRVfsyBhbxB7UAIHgt6EWi2XFdITeK1nHSdHnnvfYW2jXd0wU4EVAA73SClWLM0OTALU+026PcfkbTD8sDvjeGOuo4WRiAdI9uUuiH070PRc5ExBxpPWpvAxu7EI4Bm+ht4axZT0k/L94V4q+9Ygnrt6hk+ENwrWQ+RROAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058701; c=relaxed/simple;
	bh=Ds+QLC6y6l++he1Lz97WkIy1KKDf4ynp5CeByiKDz3c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SORWMqwR3bIJ/zt39EyP+DgEKZYgfKvUeR5PIotHOtgrLX+/U3iyMylkcWRjfithB0R4EPgcP5PyIdBUZ0dD9ulfLAXWhSyo1MsTKZzACsS11aAfC1yS3KZOQ67Kkvch4b2HT+gTddQPuu0Fj3vm8m318rChyns1N2M4gGWl96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YzDps4sypz4f3jt3
	for <linux-block@vger.kernel.org>; Thu, 20 Feb 2025 21:37:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 06DE51A058E
	for <linux-block@vger.kernel.org>; Thu, 20 Feb 2025 21:38:14 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB3219EMLdnXU2TEQ--.61967S3;
	Thu, 20 Feb 2025 21:38:13 +0800 (CST)
Subject: Re: [PATCH] block: throttle: don't add one extra jiffy mistakenly for
 bps limit
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250220111735.1187999-1-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a8f10a51-c9c8-0d1a-296d-f1f542bf8523@huaweicloud.com>
Date: Thu, 20 Feb 2025 21:38:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250220111735.1187999-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3219EMLdnXU2TEQ--.61967S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1DGF48ZF17KFy8tF4rAFb_yoW5Gr4kpr
	W7GF409F4UWFnrK3WfAan5ZFy5XrZYyFZrG3y3ur1IyFn5CFn7KF1YvrWFyw48Zrs2vw4I
	9w10qF9rCF1qvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jjVb
	kUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/02/20 19:17, Ming Lei Ð´µÀ:
> When the current bio needs to be throttled because of bps limit, the wait
> time for the extra bytes may be less than 1 jiffy, tg_within_bps_limit()
> adds one extra 1 jiffy.
> 
> However, when taking roundup time into account, the extra 1 jiffy
> may become not necessary, then bps limit becomes not accurate. This way
> causes blktests throtl/001 failure in case of CONFIG_HZ_100=y.
> 
> Fix it by not adding the 1 jiffy in case that the roundup time can
> cover it.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-throttle.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 8d149aff9fd0..8348972c517b 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -729,14 +729,14 @@ static unsigned long tg_within_bps_limit(struct throtl_grp *tg, struct bio *bio,
>   	extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
>   	jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
>   
> -	if (!jiffy_wait)
> -		jiffy_wait = 1;
> -
>   	/*
>   	 * This wait time is without taking into consideration the rounding
>   	 * up we did. Add that time also.
>   	 */
>   	jiffy_wait = jiffy_wait + (jiffy_elapsed_rnd - jiffy_elapsed);
> +	if (!jiffy_wait)
> +		jiffy_wait = 1;

Just wonder, will wait (0, 1) less jiffies is better than wait (0, 1)
more jiffies.

How about following changes?

Thanks,
Kuai

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8d149aff9fd0..f8430baf3544 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -703,6 +703,7 @@ static unsigned long tg_within_bps_limit(struct 
throtl_grp *tg, struct bio *bio,
                                 u64 bps_limit)
  {
         bool rw = bio_data_dir(bio);
+       long long carryover_bytes;
         long long bytes_allowed;
         u64 extra_bytes;
         unsigned long jiffy_elapsed, jiffy_wait, jiffy_elapsed_rnd;
@@ -727,10 +728,11 @@ static unsigned long tg_within_bps_limit(struct 
throtl_grp *tg, struct bio *bio,

         /* Calc approx time to dispatch */
         extra_bytes = tg->bytes_disp[rw] + bio_size - bytes_allowed;
-       jiffy_wait = div64_u64(extra_bytes * HZ, bps_limit);
+       jiffy_wait = div64_u64_rem(extra_bytes * HZ, bps_limit, 
carryover_bytes);

+       /* carryover_bytes is dispatched without waiting */
         if (!jiffy_wait)
-               jiffy_wait = 1;
+               tg->carryover_bytes[rw] -= carryover_bytes;

         /*
          * This wait time is without taking into consideration the rounding

> +
>   	return jiffy_wait;
>   }
>   
> 

