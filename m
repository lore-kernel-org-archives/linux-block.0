Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0C1547EE;
	Tue, 30 Sep 2025 01:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759194716; cv=none; b=mL/2sUg+rQJYZhPQg9ItiGYmSAyupfLKf3TzXjmAewCi8fllVievsx7po16Oai43tXjmY9WoNkUoNM/sFcxQgk6q8ihyyiKPdMGtqHhT4xfJLHBbMaMB4txp2pFFrQn3tCT/QmszvSqL1FIcQwXarmz3qUNl8TvGqdxFwBYzerI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759194716; c=relaxed/simple;
	bh=smQWXVrEipLiSnyezzEM2x3kB70lA++LqA2mlbqAh+I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lNrpPREFhxcLPNHcz6fCa6m30JUJqtXIAweI0r8DbIL2+a/kQLKo6+qx9RvYul/COB+Zp5w/LkC8JM9pcl0cOcjjTfp6G78W7KRqlMhNN9Avszcwjz6e+dxjl/CI1Kze4jf5Uk9dNgwsLGhy4voaqu9LoBF61P8pJWQ+CrHKB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cbKl92cClzYQtxC;
	Tue, 30 Sep 2025 09:11:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2D55B1A16CB;
	Tue, 30 Sep 2025 09:11:50 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgA3+mFULttoaZEbBQ--.38707S3;
	Tue, 30 Sep 2025 09:11:50 +0800 (CST)
Subject: Re: [PATCH v3] block: plug attempts to batch allocate tags multiple
 times
To: Xue He <xue01.he@samsung.com>, axboe@kernel.dk,
 akpm@linux-foundation.org, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CGME20250929091034epcas5p2810fc25ca2fec7a640d4121ec61478f4@epcas5p2.samsung.com>
 <20250929090602.6102-1-xue01.he@samsung.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <35b513ba-5bd5-3411-0362-06e5b29857ab@huaweicloud.com>
Date: Tue, 30 Sep 2025 09:11:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250929090602.6102-1-xue01.he@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3+mFULttoaZEbBQ--.38707S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKw47JF13tw47tw1rZr1fJFb_yoW7WrWUpr
	ZxJa13GrWrXry29Fs3J3yDXr1rtws7GF1xGr4ftr1Fy3s7Cr1Sqr48JF4SvFyxArWDAF48
	Wrs8JFy3ur4qqrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/29 17:06, Xue He 写道:
> In the existing plug mechanism, tags are allocated in batches based on
> the number of requests. However, testing has shown that the plug only
> attempts batch allocation of tags once at the beginning of a batch of
> I/O operations. Since the tag_mask does not always have enough available
> tags to satisfy the requested number, a full batch allocation is not
> guaranteed to succeed each time. The remaining tags are then allocated
> individually (occurs frequently), leading to multiple single-tag
> allocation overheads.
> 
> This patch aims to retry batch allocation of tags when the initial batch
> allocation fails to reach the requested number, thereby reducing the
> overhead of individual allocation attempts.
> 
> --------------------------------------------------------------------
> perf:
> base code: __blk_mq_alloc_requests() 1.35%
> patch:__blk_mq_alloc_requests() 0.73%
> -------------------------------------------------------------------
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
> Signed-off-by: hexue <xue01.he@samsung.com>
> ---
>   block/blk-mq.c | 44 +++++++++++++++++++++++++-------------------
>   lib/sbitmap.c  | 44 ++++++++++++++++++++++++++------------------
>   2 files changed, 51 insertions(+), 37 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ba3a4b77f578..bf9d288e3411 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -456,28 +456,34 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
>   	struct blk_mq_tags *tags;
>   	struct request *rq;
>   	unsigned long tag_mask;
> -	int i, nr = 0;
> +	int nr_tags = data->nr_tags;
>   
> -	tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
> -	if (unlikely(!tag_mask))
> -		return NULL;
> +	do {
> +		int i, nr = 0;
> +
> +		tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
> +		if (unlikely(!tag_mask))
> +			return NULL;

You should break and handle allocated tags from previous loop. This leak
looks really possible if you run some tests.

> +
> +		tags = blk_mq_tags_from_data(data);
> +		for (i = 0; tag_mask; i++) {
> +			if (!(tag_mask & (1UL << i)))
> +				continue;
> +			tag = tag_offset + i;
> +			prefetch(tags->static_rqs[tag]);
> +			tag_mask &= ~(1UL << i);
> +			rq = blk_mq_rq_ctx_init(data, tags, tag);
> +			rq_list_add_head(data->cached_rqs, rq);
> +			nr++;
> +		}
> +		if (!(data->rq_flags & RQF_SCHED_TAGS))
> +			blk_mq_add_active_requests(data->hctx, nr);
> +
> +		data->nr_tags -= nr;
> +	} while (data->nr_tags);

And perhaps you shoud update the local variable nr_tags to the real
allocated tags.

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
> -	percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
> -	data->nr_tags -= nr;
> +	percpu_ref_get_many(&data->q->q_usage_counter, nr_tags - 1);
>   
>   	return rq_list_pop(data->cached_rqs);
>   }
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 4d188d05db15..457d18650950 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -534,26 +534,34 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
>   		unsigned int map_depth = __map_depth(sb, index);
>   		unsigned long val;
>   
> -		sbitmap_deferred_clear(map, 0, 0, 0);
>   		val = READ_ONCE(map->word);
> -		if (val == (1UL << (map_depth - 1)) - 1)
> -			goto next;
> -
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
> +		while (1) {
> +			if (val == (1UL << (map_depth - 1)) - 1) {
> +				if (!sbitmap_deferred_clear(map, 0, 0, 0))
> +					goto next;
> +				val = READ_ONCE(map->word);
>   			}
> +			nr = find_first_zero_bit(&val, map_depth);
> +			if (nr + nr_tags <= map_depth)
> +				break;
> +
> +			if (!sbitmap_deferred_clear(map, 0, 0, 0))
> +				goto next;
> +
> +			val = READ_ONCE(map->word);
> +		}

Can you also add a helper like sbitmap_find_bits_in_word() ?

Thanks,
Kuai

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
>   		}
>   next:
>   		/* Jump to next index. */
> 

