Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2B1F61C;
	Wed, 18 Dec 2024 01:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734484692; cv=none; b=CKvFzWSzLlLutUe7zdQ8H5YNhYviR34eOCFiAFGpLcsDAn9EbHgg3UFzrb+6OJjICSo4xiQpRBb3dPneLI0PbnTJl5DH1lOxwpB03sseZA7HY91VmrLrBM1+sub0JAdnBQ0+UQK8WG33chWJN66wR0cRTLPRxNmTRUbqewDVoO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734484692; c=relaxed/simple;
	bh=McfR0613Zf6/X45COIYtJP57OSX3/SO2sYfzLYb9v5o=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZCsrvplu0NKwcED14FERh8VAMN/8iU+Mjx4SLIsFfR7xO4QetGuZK4jAdu2rCQGhFPzBGTRhcxSa08O6yhszKtyrC3pA6t2A8U0lflD1IPFuWrLcPSpUjx8/iVFZfXoyks5pEehWJ0haLIDJnADBChFQunmg70R3y3JU23hUBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCbQQ4w1Lz4f3jt6;
	Wed, 18 Dec 2024 09:17:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2178D1A0196;
	Wed, 18 Dec 2024 09:18:05 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgDH7oLMImJngmqiEw--.60737S3;
	Wed, 18 Dec 2024 09:18:04 +0800 (CST)
Subject: Re: [PATCH v2 RFC 2/4] lib/sbitmap: fix shallow_depth tag allocation
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, akpm@linux-foundation.org, ming.lei@redhat.com,
 yang.yang@vivo.com, osandov@fb.com, paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241217024047.1091893-1-yukuai1@huaweicloud.com>
 <20241217024047.1091893-3-yukuai1@huaweicloud.com>
 <698a01e6-cb03-43a2-a0f1-5c8555dea8c1@acm.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1b99962f-80e2-7047-acd2-c6e90c26ba81@huaweicloud.com>
Date: Wed, 18 Dec 2024 09:18:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <698a01e6-cb03-43a2-a0f1-5c8555dea8c1@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH7oLMImJngmqiEw--.60737S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr45GrW8JFyDZw1DAFyrWFg_yoW5AFW7pF
	48tFy8Gry5KF10kr1DtayDXF98Aw1DJ3ZrGF1rXFyUCrWDJFnYqrn5WF9IgwnrAr48JF4j
	yF1rXry7uw1UXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoWlkDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/12/18 5:47, Bart Van Assche 写道:
> On 12/16/24 6:40 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Currently, shallow_depth is used by bfq, kyber and mq-deadline, they both
> 
> both -> all
> 
>> pass in the value for the whole sbitmap, while sbitmap treats the value
> 
> treats for -> applies to
> 
>> for just one word. Which means, shallow_depth never work as expected,
> 
> work -> works
> 
>> and there really is no such functional tests to covert it.
> 
> is ... tests -> is ... test or are ... tests
> 
> covert -> cover
> 
>> Consider that callers doesn't know which word will be used, and it's
> 
> Consider -> Considering
> doesn't -> don't
> 
>> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
>> index 189140bf11fc..92e77bc13cf6 100644
>> --- a/include/linux/sbitmap.h
>> +++ b/include/linux/sbitmap.h
>> @@ -213,12 +213,12 @@ int sbitmap_get(struct sbitmap *sb);
>>    * sbitmap_get_shallow() - Try to allocate a free bit from a &struct 
>> sbitmap,
>>    * limiting the depth used from each word.
>>    * @sb: Bitmap to allocate from.
>> - * @shallow_depth: The maximum number of bits to allocate from a 
>> single word.
>> + * @shallow_depth: The maximum number of bits to allocate from the 
>> bitmap.
>>    *
>>    * This rather specific operation allows for having multiple users with
>>    * different allocation limits. E.g., there can be a high-priority 
>> class that
>>    * uses sbitmap_get() and a low-priority class that uses 
>> sbitmap_get_shallow()
>> - * with a @shallow_depth of (1 << (@sb->shift - 1)). Then, the 
>> low-priority
>> + * with a @shallow_depth of (sb->depth << 1). Then, the low-priority
> 
> (sb->depth << 1) -> (sb->depth >> 1)
> 
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index d3412984170c..6b8b909614a5 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -208,8 +208,27 @@ static int sbitmap_find_bit_in_word(struct 
>> sbitmap_word *map,
>>       return nr;
>>   }
>> +static unsigned int __map_depth_with_shallow(const struct sbitmap *sb,
>> +                         int index,
>> +                         unsigned int shallow_depth)
>> +{
>> +    unsigned int pre_word_bits = 0;
>> +
>> +    if (shallow_depth >= sb->depth)
>> +        return __map_depth(sb, index);
>> +
>> +    if (index > 0)
>> +        pre_word_bits += (index - 1) << sb->shift;
> 
> Why "index - 1" instead of "index"?

We're finding bit in the 'index' word, and pre_word_bits are the number
of bits in previous workds.

> 
>> +
>> +    if (shallow_depth <= pre_word_bits)
>> +        return 0;
>> +
>> +    return min_t(unsigned int, __map_depth(sb, index),
>> +                   shallow_depth - pre_word_bits);
>> +}
> 
> How about renaming pre_word_bits into lower_bound?

Yes.
> 
> Otherwise this patch looks good to me.
> 

Thanks,
Kuai

> Thanks,
> 
> Bart.
> .
> 

