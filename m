Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA518036;
	Thu, 30 May 2024 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717033768; cv=none; b=paW6rtYwUR7EgUA+ssJ9fCRl8wCEiB/mKZZKKjdC367xYEUVSE69vOUcvDHpW1Ki36MKjFjiynbm0/r9/rTZ59iLY2vzlisCnimfkbNT8JmGM1wmN6IeeZpmHB2Ra26k+HCFZnJPpTPQ6Z5PuoksOIaP7dOSxAAnZadj+ISCbTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717033768; c=relaxed/simple;
	bh=mY/foS7cc/9Dxh6P5MjKPvofzIufEuNdePlyuqwblYg=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=k7cYtxz1lqPXoADJeN7KehsXg9EpKtchWB0purjGRoCYj5nxQueLJpFGE3k2GU/S89g95Bu/8iPe3aNZUTF79eXUzlQKzdZF6B7pwIzQhYhVplbt8ed0LG2AezVbtS+4Wlj7rH+PTewUiYS6O1QhFJ3OxD/yOmeKfnprji0Ibqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VqTgj3rbWz4f3jMd;
	Thu, 30 May 2024 09:49:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DBC851A0189;
	Thu, 30 May 2024 09:49:14 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBEZ21dmGhI4OA--.43211S3;
	Thu, 30 May 2024 09:49:14 +0800 (CST)
Subject: Re: [RFC PATCH] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
To: Yang Yang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240527042654.2404-1-yang.yang@vivo.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <bd176002-90e8-030d-f8d8-9388d3b40241@huaweicloud.com>
Date: Thu, 30 May 2024 09:49:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240527042654.2404-1-yang.yang@vivo.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBEZ21dmGhI4OA--.43211S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWDCw4DJryDAw45tr1UJrb_yoWrGF4rpF
	WUKFyxKFWYqr17ursxJ3y8A3WSvws7t39rJr1xK343C3W7Kr9xJF4rKFW3twn3AFWktF4U
	XF4rJrWkCw1q9FJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/05/27 12:26, Yang Yang Ð´µÀ:
> Configuration for sbq:
>    depth=64, wake_batch=6, shift=6, map_nr=1
> 
> 1. There are 64 requests in progress:
>    map->word = 0xFFFFFFFFFFFFFFFF
> 2. After all the 64 requests complete, and no more requests come:
>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
> 3. Now two tasks try to allocate requests:
>    T1:                                       T2:
>    __blk_mq_get_tag                          .
>    __sbitmap_queue_get                       .
>    sbitmap_get                               .
>    sbitmap_find_bit                          .
>    sbitmap_find_bit_in_word                  .
>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>    sbitmap_deferred_clear                    __sbitmap_queue_get
>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>        return false;                         __sbitmap_get_word -> nr=-1
>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>      atomic_long_andnot()                    /* map->cleared=0 */
>                                                if (!(map->cleared))
>                                                  return false;
>                                       /*
>                                        * map->cleared is cleared by T1
>                                        * T2 fail to acquire the tag
>                                        */

This looks correct.

> 
> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
> up due to the wake_batch being set at 6. If no more requests come, T1
> will wait here indefinitely.
> 
> Fix this issue by adding a new flag swap_inprogress to indicate whether
> the swap is ongoing.
> 
> Fixes: 661d4f55a794 ("sbitmap: remove swap_lock")
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
> ---
>   include/linux/sbitmap.h |  5 +++++
>   lib/sbitmap.c           | 22 ++++++++++++++++++++--
>   2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index d662cf136021..b88a9e4997ab 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -36,6 +36,11 @@ struct sbitmap_word {
>   	 * @cleared: word holding cleared bits
>   	 */
>   	unsigned long cleared ____cacheline_aligned_in_smp;
> +
> +	/**
> +	 * @swap_inprogress: set to 1 when swapping word <-> cleared
> +	 */
> +	atomic_t swap_inprogress;
>   } ____cacheline_aligned_in_smp;
>   
>   /**
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 1e453f825c05..d4bb258fe8b0 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -62,10 +62,19 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
>    */
>   static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>   {
> -	unsigned long mask;
> +	unsigned long mask, flags;
> +	int zero = 0;
>   
> -	if (!READ_ONCE(map->cleared))
> +	if (!READ_ONCE(map->cleared)) {
> +		if (atomic_read(&map->swap_inprogress))
> +			goto out_wait;
>   		return false;
> +	}
> +
> +	if (!atomic_try_cmpxchg(&map->swap_inprogress, &zero, 1))
> +		goto out_wait;
> +
> +	local_irq_save(flags);
>   
>   	/*
>   	 * First get a stable cleared mask, setting the old mask to 0.
> @@ -77,6 +86,15 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>   	 */
>   	atomic_long_andnot(mask, (atomic_long_t *)&map->word);
>   	BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
> +
> +	atomic_set(&map->swap_inprogress, 0);
> +	smp_mb__after_atomic();
> +	local_irq_restore(flags);
> +	return true;
> +
> +out_wait:
> +	while (atomic_read(&map->swap_inprogress))
> +		;

However, I really don't like this change.

How about following patch? I think it can fix the prblem as well.

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 1e453f825c05..d1b9bd61d296 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -175,12 +175,14 @@ static int sbitmap_find_bit_in_word(struct 
sbitmap_word *map,
         int nr;

         do {
+               bool clear = READ_ONCE(map->cleared) != 0;
+
                 nr = __sbitmap_get_word(&map->word, depth,
                                         alloc_hint, wrap);
-               if (nr != -1)
-                       break;
-               if (!sbitmap_deferred_clear(map))
+               if (nr != -1 || !clear)
                         break;
+
+               sbitmap_deferred_clear(map);
         } while (1);

         return nr;

Thanks,
Kuai
>   	return true;
>   }
>   
> 

