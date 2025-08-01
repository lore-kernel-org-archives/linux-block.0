Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA3128395;
	Fri,  1 Aug 2025 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754034272; cv=none; b=eM1emWydoCfXYIo+Qu+grFCG5wsSBsZJCkQH5chsaMxN2BLJmvoPS/NfE2gXS7pB34Fb6h4I0C3mCaDaQteYrRgr6Yd7/Zrm4mb2jhIHOHbDRfGHR3ZjR8sbMnmlHMM0liMuqApFRQV9R2+2wrpj0aVpzpWXI1B29WXJ/DA8UFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754034272; c=relaxed/simple;
	bh=IOKknmoN058i5Nyyh+W8nKeoL8+dbqcPOd4rpSG3JLE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YNHQJRB5tYH09qv0xrDTz22230iU3Qh6/S+c1Hon3lNU64QFgDiXh9yKEjH21qatE+is45ovhwlmmfXWCIUutDSZD87+FQ7wu839B7KYFXzMYjLSgJckmN5Px0i6lEpX2zDHr4WxZgF2G9uRuMYqU1Y1x2GAdPr1NYKUwuYa9sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4btdJD2qGKzYQvFK;
	Fri,  1 Aug 2025 15:44:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 157111A144D;
	Fri,  1 Aug 2025 15:44:27 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBn4hJYcIxoJKzCCA--.19811S3;
	Fri, 01 Aug 2025 15:44:26 +0800 (CST)
Subject: Re: [PATCH v2 1/2] lib/sbitmap: convert shallow_depth from one word
 to the whole sbitmap
To: Yu Kuai <yukuai1@huaweicloud.com>, Jan Kara <jack@suse.cz>
Cc: yukuai@kernel.org, axboe@kernel.dk, akpm@linux-foundation.org,
 yang.yang@vivo.com, dlemoal@kernel.org, ming.lei@redhat.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 Omar Sandoval <osandov@fb.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250729031906.3615228-1-yukuai1@huaweicloud.com>
 <20250729031906.3615228-2-yukuai1@huaweicloud.com>
 <ozjsdoiqa2uem65qqj4fjbrwm6toxlj5bzv7f5dg5xfiljv3zi@wcaamboo2r6h>
 <8edcdef6-8749-aa45-e7d2-ada677645d76@huaweicloud.com>
 <jr54uomodnzqyw4bu4hcdpllgafkhueyygiiempuudwjy3vir5@d7lv3jsxxqx2>
 <223acbc1-60d4-4687-8eea-5306aa44ae24@kernel.org>
 <c748a3ee-bf33-e13e-d507-984277acbb32@huaweicloud.com>
 <imit4dkxy55c6a6tfqzaa6hf67nrawedotc3rzltlmmgmf3b3t@nde6h6cy3agw>
 <12d82243-237c-d890-a975-392b151d55a9@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <12f8070a-5358-af01-8535-e94405bea931@huaweicloud.com>
Date: Fri, 1 Aug 2025 15:44:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <12d82243-237c-d890-a975-392b151d55a9@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBn4hJYcIxoJKzCCA--.19811S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyfCFWxGFW5Cw4xtw13Jwb_yoW5Xry3pr
	1rt3W7GryUJr1vkr1Utw1DXry5tr1UJ3W3XF15XF18Jr4qy3WYqr1YqFyj9ry7ArW8Xr4j
	yr4rJry7Zw1Utw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/01 8:24, Yu Kuai 写道:
> Hi,
> 
> 在 2025/08/01 0:27, Jan Kara 写道:
>> On Thu 31-07-25 10:38:58, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2025/07/31 2:24, Yu Kuai 写道:
>>>> hi, Jan!
>>>>
>>>> 在 2025/7/30 21:03, Jan Kara 写道:
>>>>> I think having two APIs will be even more confusing than the current
>>>>> state.
>>>>> But as I wrote I think you can have API to specify shallow depth in 
>>>>> total
>>>>> size and in sbitmap_queue_get_shallow() do:
>>>>>
>>>>> shallow_per_word = (shallow_depth << sb->shift) / sb->depth;
>>> In order to consider the last word, I think we should use __map_depth()
>>> here.
>>
>> Right.
>>
>>>>> rounding_index = shallow_depth - shallow_per_word * sb->depth;
>>> And then it's not possible to calculate this rounding index easily. How
>>> about following, although the reminder handling is not perfect.
>>>
>>>   static unsigned int __map_depth_with_shallow(const struct sbitmap *sb,
>>>                                               int index,
>>>                                               unsigned int 
>>> shallow_depth)
>>>   {
>>>          unsigned int word_depth = __map_depth(sb, index);
>>>          unsigned int shallow_word_depth = word_depth * shallow_depth;
>>>          unsigned reminder = do_div(shallow_word_depth, sb->depth);
>>>
>>>          if (reminder && !(index & 0x1))
>>
>> Well, why not:
>>     if (remainder > index)
> Do you mean reminder > index * shallow_depth? This looks correct, and
> with the consideration for the last word:
> 
> if (index == sb->map_nr - 1)
>      shallow_word_depth = max(shallow_word_depth, 1);
> else if (reminder > index * shallow_depth)

Sorry there is a mistake, should use the word_depth here, following is
an example for 4 word sbitmap(64+64+64+32), I do the math manually, and
the results look perfect :)

| shallow_depth | word0  | word1  | word2  | word3 | total |
| ------------- | ------ | ------ | ------ | ----- | ----- |
| 224           | 64     | 64     | 64     | 32    | 224   |
| 112           | 32     | 32     | 32     | 16    | 112   |
| 113           | 32 + 1 | 32     | 32     | 16    | 113   |
| 114           | 32 + 1 | 32 + 1 | 32     | 16    | 114   |
| 115           | 32 + 1 | 32 + 1 | 32 + 1 | 16    | 115   |
| 116           | 33     | 33     | 33     | 16+1  | 116   |
>      shallow_word_depth++;
> 
> Thanks,
> Kuai
> 
>> ?
>>
>> That should accurately distribute the remainder across the remaining 
>> words,
>> shouldn't it?
>>
>>>                  shallow_word_depth++;
>>>
>>>          return shallow_word_depth;
>>>   }
>>
>>                                 Honza
>>
> 
> .
> 

