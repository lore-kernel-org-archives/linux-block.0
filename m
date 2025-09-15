Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892F7464;
	Mon, 15 Sep 2025 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757899376; cv=none; b=tzWRktyR4q4+YdCJvHsLBNTPkLiIX324mym2x0G0ZyIS9QrrKy9xVvm7XXc+PF596Ig3mK7XbD6nEfIL5pPlyo1istikkZFeuasggQO3aChVtNB5i5WeQpC5Y1fFxPtr8AIijhpSaii12yDIA3kJ4bENhajyc43T60ro+ddY6dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757899376; c=relaxed/simple;
	bh=l0juZ/ynTtBV7EGkcGAm9rP8owpzoA9PWtcats2I68A=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=G/gNOXkqzPVV41r3RKSrg1JNkeOl6YV8nMPz1/UOQSBYoKD2ke9dgYCsHPclMV3Rk9r/veLhsXMzqEuszcDjmM6WBafvnYsz/IBkAnmhOGuH4XM6ueY5RJtjFv6+eB8B5FfcicBxZ32vn/JUpMIb9i3EodwEqyutaC8Z75FurWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cQ6j22FQ3zYQv0K;
	Mon, 15 Sep 2025 09:22:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DC7BC1A0930;
	Mon, 15 Sep 2025 09:22:44 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3QY5jasdozTAqCg--.54847S3;
	Mon, 15 Sep 2025 09:22:44 +0800 (CST)
Subject: Re: [PATCH] block: plug attempts to batch allocate tags multiple
 times
To: Xue He <xue01.he@samsung.com>, yukuai1@huaweicloud.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <bfc12406-e608-b3fa-45e7-2105d9cc15bf@huaweicloud.com>
 <CGME20250912031032epcas5p3f38da43ad6cf93b849bb44f14e49c8f9@epcas5p3.samsung.com>
 <20250912030601.236426-1-xue01.he@samsung.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <51ad6831-31c9-945b-dc7a-136013f79c14@huaweicloud.com>
Date: Mon, 15 Sep 2025 09:22:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250912030601.236426-1-xue01.he@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3QY5jasdozTAqCg--.54847S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW5JF4kZw4kJw13WF4kJFb_yoW5KF1fpF
	WfJa1akrZ5AFyq9r4qq3yxCryFywnrWF48Jw15Kr1rur9F9r1fXw4xJ3WSva4SkrWkAF40
	qr45Jr9xWFZ0gFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2025/09/12 11:06, Xue He 写道:
> On 2025/09/03 18:35 PM, Yu Kuai wrote:
>> On 2025/09/03 16:41 PM, Xue He wrote:
>>> On 2025/09/02 08:47 AM, Yu Kuai wrote:
>>>> On 2025/09/01 16:22, Xue He wrote:
>>> ......
>>
>>
>> Yes, so this function will likely to obtain less tags than nr_tags,the
>> mask is always start from first zero bit with nr_tags bit, and
>> sbitmap_deferred_clear() is called uncondionally, it's likely there are
>> non-zero bits within this range.
>>
>> Just wonder, do you consider fixing this directly in
>> __blk_mq_alloc_requests_batch()?
>>
>>   - call sbitmap_deferred_clear() and retry on allocation failure, so
>> that the whole word can be used even if previous allocated request are
>> done, especially for nvme with huge tag depths;
>>   - retry blk_mq_get_tags() until data->nr_tags is zero;
> 
> Hi, Yu Kuai, I'm not entirely sure if I understand correctly, but during
> each tag allocation, sbitmap_deferred_clear() is typically called first,
> as seen in the __sbitmap_queue_get_batch() function.
> 
>          for (i = 0; i < sb->map_nr; i++) {
>                  struct sbitmap_word *map = &sb->map[index];
>                  unsigned long get_mask;
>                  unsigned int map_depth = __map_depth(sb, index);
>                  unsigned long val;
> 
>                  sbitmap_deferred_clear(map, 0, 0, 0);

Yes, this is called first each time, and I don't feel this is good for
performance anyway. I think it can be dealyed after a try first, like
sbitmap_find_bit_in_word().

> ------------------------------------------------------------------------
> so I try to recall blk_mq_get_tags() until data->nr_tags is zero, like:
> 
> -       int i, nr = 0;
> 
> -       tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
> -       if (unlikely(!tag_mask))
> -               return NULL;
> -
> -       tags = blk_mq_tags_from_data(data);
> -       for (i = 0; tag_mask; i++) {
> -               if (!(tag_mask & (1UL << i)))
> -                       continue;
> -               tag = tag_offset + i;
> -               prefetch(tags->static_rqs[tag]);
> -               tag_mask &= ~(1UL << i);
> -               rq = blk_mq_rq_ctx_init(data, tags, tag);
> -               rq_list_add_head(data->cached_rqs, rq);
> -               nr++;
> -       }
> -       if (!(data->rq_flags & RQF_SCHED_TAGS))
> -               blk_mq_add_active_requests(data->hctx, nr);
> -       /* caller already holds a reference, add for remainder */
> -       percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
> -       data->nr_tags -= nr;
> +       do {
> +               int i, nr = 0;
> +               tag_mask = blk_mq_get_tags(data, data->nr_tags, &tag_offset);
> +               if (unlikely(!tag_mask))
> +                       return NULL;
> +               tags = blk_mq_tags_from_data(data);
> +               for (i = 0; tag_mask; i++) {
> +                       if (!(tag_mask & (1UL << i)))
> +                               continue;
> +                       tag = tag_offset + i;
> +                       prefetch(tags->static_rqs[tag]);
> +                       tag_mask &= ~(1UL << i);
> +                       rq = blk_mq_rq_ctx_init(data, tags, tag);
> +                       rq_list_add_head(data->cached_rqs, rq);
> +                       nr++;
> +               }
> +               if (!(data->rq_flags & RQF_SCHED_TAGS))
> +                       blk_mq_add_active_requests(data->hctx, nr);
> +               /* caller already holds a reference, add for remainder */
> +               percpu_ref_get_many(&data->q->q_usage_counter, nr - 1);
> +               data->nr_tags -= nr;
> +       } while (data->nr_tags);
> 
> I added a loop structure, it also achieve a good results like before,
> but I have a question: although the loop will retry tag allocation
> when the required number of tags is not met, there is a risk of an
> infinite loop, right? However, I couldn't think of a safer condition
> to terminate the loop. Do you have any suggestions?

Yes, this is what I have in mind. Why do you think there can be infinite
loop? We should allcocate at least one tag by blk_mq_get_tags() in each
loop, or return directly.

Thanks,
Kuai

> 
> Thanks,
> Xue
> 
> .
> 

