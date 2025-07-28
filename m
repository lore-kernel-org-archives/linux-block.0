Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929138FB9;
	Mon, 28 Jul 2025 01:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753665560; cv=none; b=Ne6QkAVngTdpNYT8mgVCl9AfDLPH6NuiATmtopxFPg+RaG50qvqK0wLIiXRoYyPmwq1EtEeH9IvYOjqEQb92L/N7RRHRF3mMyx0isp8ErNQGkMzAhkO2MhuuyY50S+agUyuaM9euaaK0ZQYTkQudK9hglttB+N8QIKjE4cDpaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753665560; c=relaxed/simple;
	bh=FoVKhnR6kNP7vLTkP14OCXpAiwsB4oYZHvj+vqo6EPU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=syr3OqkUL1NL1g9K1058WqDtGHNddnusSfk+WN5g4xCXQrKkEP8ROtN1bH4dR2YmEX9N2WKyboB69t1okiyViIIOYs0BN0ISNKd47Gv/Y6nfhIi1PDAXDcmwXEVYli3NOTJ6a1bgXwp/ds2NRWb0LLa1kseEzty9Uw3fZl0cZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4br0xb4yrdzYQv9s;
	Mon, 28 Jul 2025 09:19:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 62DF51A1121;
	Mon, 28 Jul 2025 09:19:14 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3chMQ0IZovIjiBg--.33407S3;
	Mon, 28 Jul 2025 09:19:13 +0800 (CST)
Subject: Re: [PATCH] blk-wbt: use fast inverse square root to optimize window
 size calculation
To: Meng Shao Liu <sau525@gmail.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250727112142.604373-1-sau525@gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a945646d-279a-ba10-2ee6-94eb09431bd9@huaweicloud.com>
Date: Mon, 28 Jul 2025 09:19:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250727112142.604373-1-sau525@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3chMQ0IZovIjiBg--.33407S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF17ArWxXw4DWFW3KrW7Arb_yoWrWF47pa
	17tr93Ars7Ja4xK3Z3Jan8CFW3Wwn5GFy7GF93Gw4rXryfAFyjga1fKryj9F1kurZ7Gr47
	XrnFvrWUuF1UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7I
	JmUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/07/27 19:21, Meng Shao Liu Ð´µÀ:
> Optimize the computation of cur_win_nsec = win_nsec / sqrt(scale_step + 1)
> in blk-wbt by introducing a fast inverse square root algorithm.
> This approach replaces the original use of int_sqrt and division with a
> more efficient and accurate approximation method.
> 
> Signed-off-by: Meng Shao Liu <sau525@gmail.com>
> ---
> Since this fast inverse square root algorithm now appears in three locations
> (blk-wbt, sch_cake, codel), it might be worth considering refactoring
> the implementation into a shared helper to reduce duplication and ensure consistency.
> However, this patch focuses solely on introducing the optimization in blk-wbt.
> 
>   block/blk-wbt.c | 60 +++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 51 insertions(+), 9 deletions(-)
> 

Do you have numbers how this optimization is helper for wbt? Any
difference for IO perforamce or other overhead?

I don't feel this is much helper in the slow path. Please consider
introducing a shared helper first, then convert wbt to use that new
helper.

Thanks,
Kuai

> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index a50d4cd55..1fd5af3ba 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -80,6 +80,8 @@ struct rq_wb {
>   	u64 win_nsec;				/* default window size */
>   	u64 cur_win_nsec;			/* current window size */
>   
> +	u32 rec_inv_sqrt;   /* reciprocal value of sqrt(scaling step + 1) */
>   	struct blk_stat_callback *cb;
>   
>   	u64 sync_issue;
> @@ -130,6 +132,11 @@ enum {
>   	 */
>   	RWB_WINDOW_NSEC		= 100 * 1000 * 1000ULL,
>   
> +	/*
> +	 * Initial reciprocal value of sqrt(scaling step + 1)
> +	 */
> +	RWB_REC_INV_SQRT    = 0,
> +
>   	/*
>   	 * Disregard stats, if we don't meet this minimum
>   	 */
> @@ -395,20 +402,55 @@ static void scale_down(struct rq_wb *rwb, bool hard_throttle)
>   	rwb_trace_step(rwb, tracepoint_string("scale down"));
>   }
>   
> +#define REC_INV_SQRT_CACHE (16)
> +static const u32 inv_sqrt_cache[REC_INV_SQRT_CACHE] = {
> +		~0,         ~0, 3037000500, 2479700525,
> +	2147483647, 1920767767, 1753413056, 1623345051,
> +	1518500250, 1431655765, 1358187914, 1294981364,
> +	1239850263, 1191209601, 1147878294, 1108955788
> +};
> +
> +/* http://en.wikipedia.org/wiki/Methods_of_computing_square_roots
> + * new_invsqrt = (invsqrt / 2) * (3 - count * invsqrt^2)
> + *
> + * Here, invsqrt is a fixed point number (< 1.0), 32bit mantissa, aka Q0.32
> + */
> +
> +static void rwb_newton_step(struct rq_wb *rwb)
> +{
> +	struct rq_depth *rqd = &rwb->rq_depth;
> +	u32 invsqrt, invsqrt2;
> +	u64 val;
> +
> +	invsqrt = rwb->rec_inv_sqrt;
> +	invsqrt2 = ((u64)invsqrt * invsqrt) >> 32;
> +	val = (3LL << 32) - ((u64)(rqd->scale_step + 1) * invsqrt2);
> +
> +	val >>= 2; /* avoid overflow in following multiply */
> +	val = (val * invsqrt) >> (32 - 2 + 1);
> +
> +	rwb->rec_inv_sqrt = val;
> +}
> +
> +static void rwb_invsqrt(struct rq_wb *rwb)
> +{
> +	struct rq_depth *rqd = &rwb->rq_depth;
> +
> +	if (rqd->scale_step + 1 < REC_INV_SQRT_CACHE)
> +		rwb->rec_inv_sqrt = inv_sqrt_cache[rqd->scale_step + 1];
> +	else
> +		rwb_newton_step(rwb);
> +}
> +
>   static void rwb_arm_timer(struct rq_wb *rwb)
>   {
>   	struct rq_depth *rqd = &rwb->rq_depth;
>   
>   	if (rqd->scale_step > 0) {
> -		/*
> -		 * We should speed this up, using some variant of a fast
> -		 * integer inverse square root calculation. Since we only do
> -		 * this for every window expiration, it's not a huge deal,
> -		 * though.
> -		 */
> -		rwb->cur_win_nsec = div_u64(rwb->win_nsec << 4,
> -					int_sqrt((rqd->scale_step + 1) << 8));
> -	} else {
> +		rwb_invsqrt(rwb);
> +		rwb->cur_win_nsec = reciprocal_scale(rwb->win_nsec,
> +					     rwb->rec_inv_sqrt);
> +	} else {
>   		/*
>   		 * For step < 0, we don't want to increase/decrease the
>   		 * window size.
> @@ -911,6 +953,7 @@ int wbt_init(struct gendisk *disk)
>   
>   	rwb->last_comp = rwb->last_issue = jiffies;
>   	rwb->win_nsec = RWB_WINDOW_NSEC;
> +	rwb->rec_inv_sqrt = RWB_REC_INV_SQRT;
>   	rwb->enable_state = WBT_STATE_ON_DEFAULT;
>   	rwb->rq_depth.default_depth = RWB_DEF_DEPTH;
>   	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
> 

