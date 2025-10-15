Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058D42A99;
	Wed, 15 Oct 2025 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494867; cv=none; b=lFyqLSdZOYTEwXUJElpz6/s15fqFOwZTiNwZAiaZ1PB3Kmf+nFV0ZA8IZLlmFcaqo6G8RBSa+xyYHPStJXPX5ieVrZ5RBMB51OgyvTV+Br7Iu360EKkWPDVvu5cO8PikVtjd+UnCcSkxuGc8Z2tJxoUPX0LdvWdll88QEhrAepY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494867; c=relaxed/simple;
	bh=Qenfj8cWKn4pv67a9ph2JMJOy/Y28TdM45xSu9YKR2U=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sPvkZST/OstXlJ2/cs+yA+WNbQw/4j2nBdA5IgjrxvnSxjWeEjsmIZyv74w4QIoYIa/fLDWZcpnN7mk9wlgtFItj6QczrGFzirh6QBynJkWIfAiygChZbowOp5EYQfYX/KaJEX82M53v0xfrz1r73bXXCnBz83WS0QOC9AmVZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cmZYX0Dy6zYQtf2;
	Wed, 15 Oct 2025 10:20:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 04A001A1992;
	Wed, 15 Oct 2025 10:20:58 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP2 (Coremail) with SMTP id Syh0CgBXrUUIBe9o4SiiAQ--.53168S3;
	Wed, 15 Oct 2025 10:20:57 +0800 (CST)
Subject: Re: [PATCH v4] block: plug attempts to batch allocate tags multiple
 times
To: Xue He <xue01.he@samsung.com>, yukuai1@huaweicloud.com
Cc: akpm@linux-foundation.org, axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <979713cc-b2f6-00fa-7021-17d0e74a6913@huaweicloud.com>
 <CGME20251014083611epcas5p1c198e2ad844eb0ac08f0a9cafdeedb46@epcas5p1.samsung.com>
 <20251014083144.5479-1-xue01.he@samsung.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8f55d5e3-dcdc-476a-3af7-1bb3cdfd8d8e@huaweicloud.com>
Date: Wed, 15 Oct 2025 10:20:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251014083144.5479-1-xue01.he@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXrUUIBe9o4SiiAQ--.53168S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy8ury7CrW8Gr45uw1xKrg_yoWrWF15pF
	WUta4DKF4FqryjkaykZ390vr1SkwnrGFyxJF4Sq34rKa4ktF43WryFkF4a9F1xZFykuF4x
	WFZ3Ja1ru398ta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/10/14 16:31, Xue He 写道:
> Hi Yu Kuai,
> 
> On 2025/10/14 15:28, Yu Kuai wrote:
>> On 2025/10/10 14:35, Xue He wrote:
>>>    static unsigned int __map_depth_with_shallow(const struct sbitmap *sb,
>>>    					     int index,
>>>    					     unsigned int shallow_depth)
>>> @@ -534,26 +560,22 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
>>>    		unsigned int map_depth = __map_depth(sb, index);
>>>    		unsigned long val;
>>>    
>>> -		sbitmap_deferred_clear(map, 0, 0, 0);
>>> -		val = READ_ONCE(map->word);
>>> -		if (val == (1UL << (map_depth - 1)) - 1)
>>> +		nr = sbitmap_find_bits_in_word(map, 0, 0, 0, &val, nr_tags, map_depth);
>>> +		if (nr == -1UL)
>>>    			goto next;
>>>    
>>> -		nr = find_first_zero_bit(&val, map_depth);
>>> -		if (nr + nr_tags <= map_depth) {
>>> -			atomic_long_t *ptr = (atomic_long_t *) &map->word;
>>> -
>>> -			get_mask = ((1UL << nr_tags) - 1) << nr;
>>> -			while (!atomic_long_try_cmpxchg(ptr, &val,
>>> -							  get_mask | val))
>>> -				;
>>> -			get_mask = (get_mask & ~val) >> nr;
>>> -			if (get_mask) {
>>> -				*offset = nr + (index << sb->shift);
>>> -				update_alloc_hint_after_get(sb, depth, hint,
>>> -							*offset + nr_tags - 1);
>>> -				return get_mask;
>>> -			}
>>> +		atomic_long_t *ptr = (atomic_long_t *) &map->word;
>>> +
>>> +		get_mask = ((1UL << nr_tags) - 1) << nr;
>>> +		while (!atomic_long_try_cmpxchg(ptr, &val,
>>> +						  get_mask | val))
>>> +			;
>>> +		get_mask = (get_mask & ~val) >> nr;
>>> +		if (get_mask) {
>>> +			*offset = nr + (index << sb->shift);
>>> +			update_alloc_hint_after_get(sb, depth, hint,
>>> +						*offset + nr_tags - 1);
>>> +			return get_mask;
>>
>> I feel it's better to fold in above into the helper and return get_mask
>> directly.
> Hi Yukuai, sorry I'm not sure that my understanding is correct, does it
> mean modifying it in a way similar to the following? If so, I will repackage
> the patch accordingly.
> 
> static unsigned long sbitmap_find_bits_in_word(unsigned long index,
> 					struct sbitmap *sb, unsigned int *offset,
> 					unsigned int hint, unsigned int depth, int nr_tags)
> {
> 	unsigned long val, nr, get_mask;
> 	struct sbitmap_word *map = &sb->map[index];
> 	unsigned int map_depth = __map_depth(sb, index);
> 
> 	while (1) {
> 		val = READ_ONCE(map->word);
> 		if (val == (1UL << (map_depth - 1)) - 1) {
> 			if (!sbitmap_deferred_clear(map, 0, 0, 0))
> 				return 0;
> 			continue;
> 		}
> 
> 		nr = find_first_zero_bit(&val, map_depth);
> 		if (nr != map_depth)
> 			break;
> 
> 		if (!sbitmap_deferred_clear(map, 0, 0, 0))
> 			return 0;
> 	};
> 
> 	atomic_long_t *ptr = (atomic_long_t *) &map->word;
> 	
> 	get_mask = ((1UL << nr_tags) - 1) << nr;

Be careful, since the checking nr + nr_tags <= map_depth is removed,
nr_tags should be updated to:

max(nr_tags, map_depth - nr)

> 	while (!atomic_long_try_cmpxchg(ptr, &val,
> 					  get_mask | val))
> 		;
> 	get_mask = (get_mask & ~val) >> nr;
> 	if (get_mask){
> 		*offset = nr + (index << sb->shift);
> 		update_alloc_hint_after_get(sb, depth, hint,
> 					*offset + nr_tags - 1);

Look to me you're still pass in depth and hint for this, and I think
it's cleaner to move this to the caller :) Use the old nr_tags from
caller is fine, hint will be set to 0 if passed in nr >= depth -1.

Thanks,
Kuai


> 	}
> 	return get_mask;
> }
> 
> and upper like
> 
> unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
> 						unsigned int *offset)
> {
> 	struct sbitmap *sb = &sbq->sb;
> 	unsigned int hint, depth;
> 	unsigned long get_mask, index;
> 	int i;
> 
> 	if (unlikely(sb->round_robin))
> 		return 0;
> 
> 	depth = READ_ONCE(sb->depth);
> 	hint = update_alloc_hint_before_get(sb, depth);
> 
> 	index = SB_NR_TO_INDEX(sb, hint);
> 
> 	for (i = 0; i < sb->map_nr; i++) {
> 		get_mask = sbitmap_find_bits_in_word(index, sb, offset, hint,
> 							depth, nr_tags);
> 		if (get_mask) {
> 			return get_mask;
> 		}
> 
> 		/* Jump to next index. */
> 		if (++index >= sb->map_nr)
> 			index = 0;
> 	}
> 
> 	return 0;
> }
> 
> Am I missing something?
> 
> Thanks,
> Xue
>>
>> BTW, the sbitmap and blk-mq changes are not quite related, and you can
>> split them into seperate patches.
>>
>> Thanks,
>> Kuai
>>
>>>    		}
>>>    next:
>>>    		/* Jump to next index. */
>>>
> 
> .
> 

