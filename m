Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E475228314A;
	Wed, 24 Sep 2025 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705838; cv=none; b=acWGcE6c1S6Bhebw5pOyd7UPWYHn+4ZayCKMePNYDzvByzi92vcyeBFyEMHm+uUZj3LNQKX41ZcWVMIIMCW9XxwL3irbumIhp9D+/8Agc1PVtkLaHjT8hLpjNs6dMtfloEFlBhglCHlrLJ83GT4EOBCGhgL3ht7SmrH92beDo3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705838; c=relaxed/simple;
	bh=k8ls7HJ0NSab/bPbOZ8rD4KwrDpIQu6nSQmh86M3UxE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=V/D3WdxSmEqdteONW3cYjIUPFcC2gMhHCUmzVYkKcncsHALG4XI2HH0SKpkIIrsbBqhQQ6fw/UOVUjeTcm8F8ytR3bguRiHDDGv2bGyXFLmvSFFckBUrq9Vy5MK36JBSveZN8qpP5gUQhod62p/ZqfVMwb2imGIAg4Q1iNzckUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cWrxg69KVzKHMpM;
	Wed, 24 Sep 2025 17:23:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4D7D71A0CCF;
	Wed, 24 Sep 2025 17:23:42 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAHGWGcuNNoLuybAg--.35059S3;
	Wed, 24 Sep 2025 17:23:42 +0800 (CST)
Subject: Re: [PATCH v2] block: plug attempts to batch allocate tags multiple
 times
To: Xue He <xue01.he@samsung.com>, axboe@kernel.dk, akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CGME20250918075946epcas5p39a6793513e02e446b3e4801ba66b6925@epcas5p3.samsung.com>
 <20250918075511.8197-1-xue01.he@samsung.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7626767b-35c1-4c55-399c-24e21ec81ced@huaweicloud.com>
Date: Wed, 24 Sep 2025 17:23:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250918075511.8197-1-xue01.he@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHGWGcuNNoLuybAg--.35059S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4xZrW8CF15ur4xJrWDurg_yoWrWFykpr
	W3Ja13Kryaqr1q9FsxX3yUWr1rtwnrGF17J3WfKr1FvrnrCr1fXr4kGF4FvryIyrWkAF48
	Xr45JFy3Wr1qqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Hi,

I'm not in the cc list, so it can take sometime before I notice this
patch.

在 2025/09/18 15:55, Xue He 写道:
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
> base code: __blk_mq_alloc_requests() 1.33%
> patch:__blk_mq_alloc_requests() 0.72%
> -------------------------------------------------------------------
> 
> Signed-off-by: hexue <xue01.he@samsung.com>
> ---

Please add change log.

>   block/blk-mq.c | 43 +++++++++++++++++++++++--------------------
>   lib/sbitmap.c  |  7 ++++---
>   2 files changed, 27 insertions(+), 23 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ba3a4b77f578..3ed8da176831 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -456,28 +456,31 @@ __blk_mq_alloc_requests_batch(struct blk_mq_alloc_data *data)
>   	struct blk_mq_tags *tags;
>   	struct request *rq;
>   	unsigned long tag_mask;
> -	int i, nr = 0;
>   
> -	tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
> -	if (unlikely(!tag_mask))
> -		return NULL;
> +	do {
> +		int i, nr = 0;
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
> -	/* caller already holds a reference, add for remainder */
> -	percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
> -	data->nr_tags -= nr;
> +		tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
> +		if (unlikely(!tag_mask))
> +			return NULL;
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
> +		/* caller already holds a reference, add for remainder */
> +		percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);

This should move outside of the loop, the remainder handling is one time
thing.

> +		data->nr_tags -= nr;
> +	} while (data->nr_tags);
>   
>   	return rq_list_pop(data->cached_rqs);
>   }
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 4d188d05db15..4ac303842aec 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -534,10 +534,11 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
>   		unsigned int map_depth = __map_depth(sb, index);
>   		unsigned long val;
>   
> -		sbitmap_deferred_clear(map, 0, 0, 0);
>   		val = READ_ONCE(map->word);
> -		if (val == (1UL << (map_depth - 1)) - 1)
> -			goto next;
> +		if (val == (1UL << (map_depth - 1)) - 1) {
> +			if (!sbitmap_deferred_clear(map, map_depth, 0, 0))
> +				goto next;

This looks wrong, you're still using the old val after
sbitmap_deferred_clear().
> +		}
>   
>   		nr = find_first_zero_bit(&val, map_depth);
>   		if (nr + nr_tags <= map_depth) {
> 

And I think if above checking failed, sbitmap_deferred_clear() should be
called and retry as well.

Thanks,
Kuai

