Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0101E3DED;
	Tue, 14 Oct 2025 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424334; cv=none; b=ZN9/D6Kpia/8jshWZh03psZocTqLdLwRqVsmkbk0PU446QPpV6oxwcz1nFqCEjyQTBo1whdh+KSn3IcNU7c6atNcZ0rdcrqHUkkLIfGsjiJcb0vv7m/rn283AILzJ/H3SiN7JvDLOwC5SGq3MAz/MJOrZ3YbDppXLA+tVkQD1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424334; c=relaxed/simple;
	bh=W8vlS2pNcU8IVeInIL6N8F8MawlVLSU4YNXnTOXhY5Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nHevP7ntfwo24jaz/3YYoXmTp+ssqcNS9QaGQUoE7Y3BiVKBy7kK/wf2rwz4wmEXaHSe3+Adf3t6LoUhdTswATxvSuB06jIvRoF46OiLpHWou7jcmmYvgEnLQlGYgIw3zfQvn5qItUWmOv0X400S4t3q4pAKKSn86LDxNq+IQUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cm4685c90zYQtrJ;
	Tue, 14 Oct 2025 14:28:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 603E81A17F2;
	Tue, 14 Oct 2025 14:28:57 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP2 (Coremail) with SMTP id Syh0CgBnvUWn7e1ojqZDAQ--.26196S3;
	Tue, 14 Oct 2025 14:28:57 +0800 (CST)
Subject: Re: [PATCH v4] block: plug attempts to batch allocate tags multiple
 times
To: Xue He <xue01.he@samsung.com>, axboe@kernel.dk,
 akpm@linux-foundation.org, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CGME20251010064008epcas5p3c507d64678fadfb71574050b01357341@epcas5p3.samsung.com>
 <20251010063538.3597-1-xue01.he@samsung.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <979713cc-b2f6-00fa-7021-17d0e74a6913@huaweicloud.com>
Date: Tue, 14 Oct 2025 14:28:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251010063538.3597-1-xue01.he@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnvUWn7e1ojqZDAQ--.26196S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XF15GF1kur1fXr4DJrWfuFg_yoW7Crykpr
	W3Ja13Gr4FqF129FsxXayDZr1Fywn7GF1xJa1ftw1rurykCFnxWr4rJF4Sqa4xAFWkJF48
	Xrs8Jry5uw4qqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/10/10 14:35, Xue He 写道:
> This patch aims to enable batch allocation of sufficient tags after
> batch IO submission with plug mechanism, thereby avoiding the need for
> frequent individual requests when the initial allocation is
> insufficient.
> 
> ------------------------------------------------------------
> Perf:
> base code: __blk_mq_alloc_requests() 1.31%
> patch: __blk_mq_alloc_requests() 0.71%
> ------------------------------------------------------------
> 
> ---
> changes since v1:
> - Modify multiple batch registrations into a single loop to achieve
>    the batch quantity
> 
> changes since v2:
> - Modify the call location of remainder handling
> - Refactoring sbitmap cleanup time
> 
> changes since v3:
> - Add handle operation in loop
> - Add helper sbitmap_find_bits_in_word
> 
> Signed-off-by: hexue <xue01.he@samsung.com>
> ---
>   block/blk-mq.c | 39 ++++++++++++++++++---------------
>   lib/sbitmap.c  | 58 ++++++++++++++++++++++++++++++++++----------------
>   2 files changed, 62 insertions(+), 35 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ba3a4b77f578..695ccc72e69f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -458,26 +458,31 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
>   	unsigned long tag_mask;
>   	int i, nr = 0;
>   
> -	tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
> -	if (unlikely(!tag_mask))
> -		return NULL;
> +	do {
> +		tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
> +		if (unlikely(!tag_mask)) {
> +			if (nr == 0)
> +				return NULL;
> +			break;
> +		}
> +		tags = blk_mq_tags_from_data(data);
> +		for (i = 0; tag_mask; i++) {
> +			if (!(tag_mask & (1UL << i)))
> +				continue;
> +			tag = tag_offset + i;
> +			prefetch(tags->static_rqs[tag]);
> +			tag_mask &= ~(1UL << i);
> +			rq = blk_mq_rq_ctx_init(data, tags, tag);
> +			rq_list_add_head(data->cached_rqs, rq);
> +			data->nr_tags--;
> +			nr++;
> +		}
> +		if (!(data->rq_flags & RQF_SCHED_TAGS))
> +			blk_mq_add_active_requests(data->hctx, nr);
> +	} while (data->nr_tags);
>   
> -	tags = blk_mq_tags_from_data(data);
> -	for (i = 0; tag_mask; i++) {
> -		if (!(tag_mask & (1UL << i)))
> -			continue;
> -		tag = tag_offset + i;
> -		prefetch(tags->static_rqs[tag]);
> -		tag_mask &= ~(1UL << i);
> -		rq = blk_mq_rq_ctx_init(data, tags, tag);
> -		rq_list_add_head(data->cached_rqs, rq);
> -		nr++;
> -	}
> -	if (!(data->rq_flags & RQF_SCHED_TAGS))
> -		blk_mq_add_active_requests(data->hctx, nr);
>   	/* caller already holds a reference, add for remainder */
>   	percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
> -	data->nr_tags -= nr;
>   
>   	return rq_list_pop(data->cached_rqs);
>   }
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 4d188d05db15..c0a8da1beec9 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -208,6 +208,32 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
>   	return nr;
>   }
>   
> +static unsigned long sbitmap_find_bits_in_word(struct sbitmap_word *map,
> +				    unsigned int depth, unsigned int alloc_hint, bool wrap,
> +				    unsigned long *val, int nr_tags, unsigned int map_depth)

The parameters depth, alloc_hint, wrap are not necessary, the only
caller always pass in 0.

> +{
> +	unsigned long local_val, nr;
> +
> +	while (1) {
> +		local_val = READ_ONCE(map->word);
> +		if (local_val == (1UL << (map_depth - 1)) - 1) {
> +			if (!sbitmap_deferred_clear(map, depth, alloc_hint, wrap))
> +				return -1UL;
> +			continue;
> +		}
> +
> +		nr = find_first_zero_bit(&local_val, map_depth);
> +		if (nr + nr_tags <= map_depth)
> +			break;

With the respect we can allocate multiple times, and it's not necessary
to allocate nr_tags at once, perhaps it'll make  sense to skip this
checking.

> +
> +		if (!sbitmap_deferred_clear(map, depth, alloc_hint, wrap))
> +			return -1UL;
> +	};
> +
> +	*val = local_val;
> +	return nr;
> +}
> +
>   static unsigned int __map_depth_with_shallow(const struct sbitmap *sb,
>   					     int index,
>   					     unsigned int shallow_depth)
> @@ -534,26 +560,22 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
>   		unsigned int map_depth = __map_depth(sb, index);
>   		unsigned long val;
>   
> -		sbitmap_deferred_clear(map, 0, 0, 0);
> -		val = READ_ONCE(map->word);
> -		if (val == (1UL << (map_depth - 1)) - 1)
> +		nr = sbitmap_find_bits_in_word(map, 0, 0, 0, &val, nr_tags, map_depth);
> +		if (nr == -1UL)
>   			goto next;
>   
> -		nr = find_first_zero_bit(&val, map_depth);
> -		if (nr + nr_tags <= map_depth) {
> -			atomic_long_t *ptr = (atomic_long_t *) &map->word;
> -
> -			get_mask = ((1UL << nr_tags) - 1) << nr;
> -			while (!atomic_long_try_cmpxchg(ptr, &val,
> -							  get_mask | val))
> -				;
> -			get_mask = (get_mask & ~val) >> nr;
> -			if (get_mask) {
> -				*offset = nr + (index << sb->shift);
> -				update_alloc_hint_after_get(sb, depth, hint,
> -							*offset + nr_tags - 1);
> -				return get_mask;
> -			}
> +		atomic_long_t *ptr = (atomic_long_t *) &map->word;
> +
> +		get_mask = ((1UL << nr_tags) - 1) << nr;
> +		while (!atomic_long_try_cmpxchg(ptr, &val,
> +						  get_mask | val))
> +			;
> +		get_mask = (get_mask & ~val) >> nr;
> +		if (get_mask) {
> +			*offset = nr + (index << sb->shift);
> +			update_alloc_hint_after_get(sb, depth, hint,
> +						*offset + nr_tags - 1);
> +			return get_mask;

I feel it's better to fold in above into the helper and return get_mask
directly.

BTW, the sbitmap and blk-mq changes are not quite related, and you can
split them into seperate patches.

Thanks,
Kuai

>   		}
>   next:
>   		/* Jump to next index. */
> 

