Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73A54A08;
	Thu, 13 Feb 2025 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739415401; cv=none; b=SNpgaSF6bAPRYHB/3xUOHzuO5tHZq6E7NU/2ljSg02k86Ssl1v6Nw+pL1dWaF/7Utg/1BmJZCuKqLeKUlSa/eM11iXutwJJFQIfs0VbTb6LecBHc9qjkWZWHz9tfmwMC2GJI10YBaRX7LVka0VkyS39afnljBSeswW9M3m2sJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739415401; c=relaxed/simple;
	bh=dvZJGnR3IBV8iCwMPyCo3wGbBEKyPO60n1soK8uhBoo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iEhTyvbetziaHIQP8+W5sQ6Ohd6No+xtj8OylYMmeNfLgtQKdod1JskjMzr7st4btgvG2rroh6hK5SoaICa4I7w04LE7CyZ/kk+5tJDJBEPJd02Ek6QKBtSJPwc+VMDtYTV6YGQ3bRZyfmMS5b2vwfWv4rOb9woyNAwPm1mRxqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YtfvR6qPRz4f3kFm;
	Thu, 13 Feb 2025 10:56:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 529C01A13C2;
	Thu, 13 Feb 2025 10:56:25 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGBXX61n22LHDg--.12367S3;
	Thu, 13 Feb 2025 10:56:25 +0800 (CST)
Subject: Re: [PATCH] blk-wbt: Cleanup some comments
To: Tang Yizhou <yizhou.tang@shopee.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250212030055.407090-1-yizhou.tang@shopee.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e8de697b-e098-97cd-fe3c-800b59b2c7cf@huaweicloud.com>
Date: Thu, 13 Feb 2025 10:56:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250212030055.407090-1-yizhou.tang@shopee.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHrGBXX61n22LHDg--.12367S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AryDKr1fAw4fZrWkuFWfXwb_yoW8Zw1UpF
	sakw13Zr47tF1xu3s7Xay7Gr4fG3Z5Kr18tr1xWwnIqrnIgrnYvF4UKr10vrWrZ34fGr4I
	va1jgF4fGa18u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUzi
	SdDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/02/12 11:00, Tang Yizhou Ð´µÀ:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> wbt_wait() no longer uses a spinlock as a parameter. Update the
> function comments accordingly.
> 
> Additionally, revise other comments to ensure they align with the
> actual implementation.
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> ---
>   block/blk-wbt.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> index 6dfc659d22e2..f1754d07f7e0 100644
> --- a/block/blk-wbt.c
> +++ b/block/blk-wbt.c
> @@ -136,8 +136,9 @@ enum {
>   	RWB_MIN_WRITE_SAMPLES	= 3,
>   
>   	/*
> -	 * If we have this number of consecutive windows with not enough
> -	 * information to scale up or down, scale up.
> +	 * If we have this number of consecutive windows without enough
> +	 * information to scale up or down, slowly return to center state
> +	 * (step == 0).
>   	 */
>   	RWB_UNKNOWN_BUMP	= 5,
>   };
> @@ -446,9 +447,9 @@ static void wb_timer_fn(struct blk_stat_callback *cb)
>   		break;
>   	case LAT_UNKNOWN_WRITES:
>   		/*
> -		 * We started a the center step, but don't have a valid
> -		 * read/write sample, but we do have writes going on.
> -		 * Allow step to go negative, to increase write perf.
> +		 * We don't have a valid read/write sample, but we do have
> +		 * writes going on. Allow step to go negative, to increase
> +		 * write performance.

Other than this clean up, the others are actually fix. Can you remove
this one and change the title to "Fix some comments"?

Thanks,
Kuai

>   		 */
>   		scale_up(rwb);
>   		break;
> @@ -638,11 +639,7 @@ static void wbt_cleanup(struct rq_qos *rqos, struct bio *bio)
>   	__wbt_done(rqos, flags);
>   }
>   
> -/*
> - * May sleep, if we have exceeded the writeback limits. Caller can pass
> - * in an irq held spinlock, if it holds one when calling this function.
> - * If we do sleep, we'll release and re-grab it.
> - */
> +/* May sleep, if we have exceeded the writeback limits. */
>   static void wbt_wait(struct rq_qos *rqos, struct bio *bio)
>   {
>   	struct rq_wb *rwb = RQWB(rqos);
> 

