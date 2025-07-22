Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2DF2DC35C
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176290; cv=none; b=qk0+EZbPrOrueVpTVRyHJzLT8VRtAbAp4200RN/Idwf8Bf9x+Sn5w/NwOo/gq5YpWCfmnYSUSokLwtfD9XyVKefGK7YBBHj1frzJAuuvhnhKJug75aTIaGZA1tHMKiZs01CZb7SAlG9nmuv1R1qrfZLZ87myb9Mf7vl3U/RJwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176290; c=relaxed/simple;
	bh=yT+hYd44nbhSEulY/jmV7gTQBfh0xPNcFq0j+FBwtfk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=l2FnYWOQMKZAtRt5pCyYjBPO3CdRHbn+YQseXDvD8psNBYFMMZ30z2D9O1i9qR5pR7ffiDkOPNNplDhX5Ap6nIxiXMOk5w4yjnNB6gAZn0FTLSHkBfSYtgJwkrOS359R4X07M84bKubckckwW1WOsjbn5ZCpUoYG1vK5n3G5FRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bmX0V591CzKHMYy
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 17:24:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6CFE71A0AEF
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 17:24:41 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP1 (Coremail) with SMTP id cCh0CgDnpLDYWH9ojYdSBA--.47556S3;
	Tue, 22 Jul 2025 17:24:41 +0800 (CST)
Subject: Re: [PATCHv2 2/2] null_blk: fix set->driver_data while setting up
 tagset
To: Damien Le Moal <dlemoal@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, axboe@kernel.dk,
 johannes.thumshirn@wdc.com, gjoyce@ibm.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250721140450.1030511-1-nilay@linux.ibm.com>
 <20250721140450.1030511-3-nilay@linux.ibm.com>
 <1cadba31-8e73-4693-9ea5-b5fce8b69ba9@kernel.org>
 <3c33c551-b707-4fd2-bd52-418ff3bc547c@linux.ibm.com>
 <ffa76a0b-3067-129c-ead4-f1e5f0a65357@huaweicloud.com>
 <0687504a-ea0e-497c-b36e-a942520f7177@kernel.org>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8bb4fb9e-e79b-cc92-264f-ae2914093a64@huaweicloud.com>
Date: Tue, 22 Jul 2025 17:24:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0687504a-ea0e-497c-b36e-a942520f7177@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDnpLDYWH9ojYdSBA--.47556S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry3tr1UGFy7uFyxZr1DKFg_yoW7WFykpF
	W8ta1YkrW8JF4kJ3y2kw1UXFy3t3WUA348WF10ya4Fvr4qvr929rnrXF90gF1UKw4kArWS
	qF1UZFW3ZFyDJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/07/22 17:18, Damien Le Moal 写道:
> On 7/22/25 6:17 PM, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/07/22 16:30, Nilay Shroff 写道:
>>>
>>>
>>> On 7/22/25 6:37 AM, Damien Le Moal wrote:
>>>> On 7/21/25 11:04 PM, Nilay Shroff wrote:
>>>>> When setting up a null block device, we initialize a tagset that
>>>>> includes a driver_data field—typically used by block drivers to
>>>>> store a pointer to driver-specific data. In the case of null_blk,
>>>>> this should point to the struct nullb instance.
>>>>>
>>>>> However, due to recent tagset refactoring in the null_blk driver, we
>>>>> missed initializing driver_data when creating a shared tagset. As a
>>>>> result, software queues (ctx) fail to map correctly to new hardware
>>>>> queues (hctx). For example, increasing the number of submit queues
>>>>> triggers an nr_hw_queues update, which invokes null_map_queues() to
>>>>> remap queues. Since set->driver_data is unset, null_map_queues()
>>>>> fails to map any ctx to the new hctxs, leading to hctx->nr_ctx == 0,
>>>>> effectively making the hardware queues unusable for I/O.
>>>>>
>>>>> This patch fixes the issue by ensuring that set->driver_data is properly
>>>>> initialized to point to the struct nullb during tagset setup.
>>>>>
>>>>> Fixes: 72ca28765fc4 ("null_blk: refactor tag_set setup")
>>>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>>> ---
>>>>>    drivers/block/null_blk/main.c | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>>>> index aa163ae9b2aa..fbae0427263d 100644
>>>>> --- a/drivers/block/null_blk/main.c
>>>>> +++ b/drivers/block/null_blk/main.c
>>>>> @@ -1856,6 +1856,7 @@ static int null_setup_tagset(struct nullb *nullb)
>>>>>    {
>>>>>        if (nullb->dev->shared_tags) {
>>>>>            nullb->tag_set = &tag_set;
>>>>> +        nullb->tag_set->driver_data = nullb;
>>>>
>>>> This looks better, but in the end, why is this even needed ? Since this is a
>>>> shared tagset, multiple nullb devices can use that same tagset, so setting the
>>>> driver_data pointer to this device only seems incorrect.
>>>>
>>>> Checking the code, the only function that makes use of this pointer is
>>>> null_map_queues(), which correctly test for private_data being NULL.
>>>>
>>>> So why do we need this ? Isn't your patch 1/2 enough to fix the crash you got ?
>>>>
>>> I think you were right — the first patch alone is sufficient to prevent the
>>> crash.
>>> Initially, I thought the second patch might also be necessary, especially for
>>> the
>>> scenario where the user increases the number of submit_queues for a null_blk
>>> device.
>>> While the block layer does create a new hardware queue (hctx) in response to
>>> such
>>> an update, null_blk (null_map_queues()) does not map any software queue (ctx)
>>> to it.
>>> As a result, the newly added hctx remains unused for I/O.
>>>
>>> Given this behavior, I believe we should not allow users to update submit_queues
>>> on a null_blk device if it is using a shared tagset. Currently, the code allows
>>> this update, but it’s misleading since the change has no actual effect.
>>>
>>> Would it make sense to explicitly prevent updating submit_queues in this case?
>>> That would align the interface with the actual behavior and avoid potential
>>> confusion and also saves us allocating memory for hctx which remains unused.
>>> Maybe we should have this check, in nullb_update_nr_hw_queues():
>>>
>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>> index fbae0427263d..aed2a6904db1 100644
>>> --- a/drivers/block/null_blk/main.c
>>> +++ b/drivers/block/null_blk/main.c
>>> @@ -388,6 +388,12 @@ static int nullb_update_nr_hw_queues(struct nullb_device
>>> *dev,
>>>           if (!submit_queues)
>>>                   return -EINVAL;
>>>    +       /*
>>> +        * Cannot update queues with shared tagset.
>>> +        */
>>> +       if (dev->shared_tags)
>>> +               return -EINVAL;
>>> +
>>>           /*
>>>            * Make sure that null_init_hctx() does not access nullb->queues[] past
>>>            * the end of that array.
>>>
>>> If the above change looks good, maybe I can update second patch with
>>> the above change.
>>
>> I'm good with this change, howerver, with a quick look it seems lots of
>> configfs api are broken for shared_tags. For example:
>>
>> If we switch shared_tags from 0 to 1, and then read submit_queues,
>> looks like it's the old dev->submit_queues instead of g_submit_queues;
> 
> g_submit_queues is used as the initial value for dev->submit_queues. See
> nullb_alloc_dev(). So if we prevent changing dev->submit_queues with configfs,
> we'll get whatever g_submit_queues was set on modprobe for the shared tagset.

I know that, I mean in the case shared_tags is 0 and set submit_queues
different from g_submit_queues, and then *switch shared_tags from 0 to
1*, user will read wrong submit_queues :)

Thanks,
Kuai

> 
> 
> 

