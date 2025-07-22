Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EAF28A726
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176059; cv=none; b=HBOjOb9l+VtQ/ll16OF8IyGJAClGfvJR8vLQShmslllzexXJL27ofv5c3uGmofMjmgck51m30JwIXeLvEJoqfbtIcQG4pPwpgdF9XV40UHG0bUtQImZ7P5/dAIdmga4mbh5Xk/HMVEYKJN7jinuL9TayT7Rw6Ja/MFT35QWjUTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176059; c=relaxed/simple;
	bh=cwKUk91NvHUxn/27Eb+527G5FjZShQXJt4TrtXI+I6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOnsDpG/DW+W1evYFZCwUeTCwMJXGnJz9Ei/MJt8AVPtP4DlS6HiUSGYLiWftFho2QwUMWlbyANdZEN3R+TIAF9jHKBIMAC3Nh62QHezrHAurIFIPuRqMoCn/4XwkvdZHr2aJHhCzNoXi0OsZhfi2+xAHJr8O3ne3EtIRFnVNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClV4aWP8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClV4aWP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B680C4CEEB;
	Tue, 22 Jul 2025 09:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753176058;
	bh=cwKUk91NvHUxn/27Eb+527G5FjZShQXJt4TrtXI+I6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ClV4aWP8umXfqHdOhcyfH2GNLAL0EMJqKeAJLysWGxmN13dPjJkT88C3nx4n5V7nK
	 NRX3Qez4R7YvxXV2yq1opJ6AnFon7qqqykMXHJnFrcfQllVyXCBZX6uE3H3xW1skPI
	 3xTuEIxjki+WYgu5IPKu6u9sGdSnmmjhcO9dZzeXUO1MsCygEKHIUp3c6pkVyjp0XS
	 4T1ZI7blz6QRj669YqEAGZqo4qlP1AwjSSycYsqTeqU9q7X6dtf43uvnZIsEOHR7WY
	 ok8a3ZBICBrJ9qEle9roDyd52x1UY1IDT7mrZFQ1O4278tXhWN1f29wzhuC0bhDbka
	 Gq8v1W0mqYw5A==
Message-ID: <0687504a-ea0e-497c-b36e-a942520f7177@kernel.org>
Date: Tue, 22 Jul 2025 18:18:31 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] null_blk: fix set->driver_data while setting up
 tagset
To: Yu Kuai <yukuai1@huaweicloud.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, axboe@kernel.dk,
 johannes.thumshirn@wdc.com, gjoyce@ibm.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250721140450.1030511-1-nilay@linux.ibm.com>
 <20250721140450.1030511-3-nilay@linux.ibm.com>
 <1cadba31-8e73-4693-9ea5-b5fce8b69ba9@kernel.org>
 <3c33c551-b707-4fd2-bd52-418ff3bc547c@linux.ibm.com>
 <ffa76a0b-3067-129c-ead4-f1e5f0a65357@huaweicloud.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ffa76a0b-3067-129c-ead4-f1e5f0a65357@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/22/25 6:17 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/07/22 16:30, Nilay Shroff 写道:
>>
>>
>> On 7/22/25 6:37 AM, Damien Le Moal wrote:
>>> On 7/21/25 11:04 PM, Nilay Shroff wrote:
>>>> When setting up a null block device, we initialize a tagset that
>>>> includes a driver_data field—typically used by block drivers to
>>>> store a pointer to driver-specific data. In the case of null_blk,
>>>> this should point to the struct nullb instance.
>>>>
>>>> However, due to recent tagset refactoring in the null_blk driver, we
>>>> missed initializing driver_data when creating a shared tagset. As a
>>>> result, software queues (ctx) fail to map correctly to new hardware
>>>> queues (hctx). For example, increasing the number of submit queues
>>>> triggers an nr_hw_queues update, which invokes null_map_queues() to
>>>> remap queues. Since set->driver_data is unset, null_map_queues()
>>>> fails to map any ctx to the new hctxs, leading to hctx->nr_ctx == 0,
>>>> effectively making the hardware queues unusable for I/O.
>>>>
>>>> This patch fixes the issue by ensuring that set->driver_data is properly
>>>> initialized to point to the struct nullb during tagset setup.
>>>>
>>>> Fixes: 72ca28765fc4 ("null_blk: refactor tag_set setup")
>>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>> ---
>>>>   drivers/block/null_blk/main.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>>> index aa163ae9b2aa..fbae0427263d 100644
>>>> --- a/drivers/block/null_blk/main.c
>>>> +++ b/drivers/block/null_blk/main.c
>>>> @@ -1856,6 +1856,7 @@ static int null_setup_tagset(struct nullb *nullb)
>>>>   {
>>>>       if (nullb->dev->shared_tags) {
>>>>           nullb->tag_set = &tag_set;
>>>> +        nullb->tag_set->driver_data = nullb;
>>>
>>> This looks better, but in the end, why is this even needed ? Since this is a
>>> shared tagset, multiple nullb devices can use that same tagset, so setting the
>>> driver_data pointer to this device only seems incorrect.
>>>
>>> Checking the code, the only function that makes use of this pointer is
>>> null_map_queues(), which correctly test for private_data being NULL.
>>>
>>> So why do we need this ? Isn't your patch 1/2 enough to fix the crash you got ?
>>>
>> I think you were right — the first patch alone is sufficient to prevent the
>> crash.
>> Initially, I thought the second patch might also be necessary, especially for
>> the
>> scenario where the user increases the number of submit_queues for a null_blk
>> device.
>> While the block layer does create a new hardware queue (hctx) in response to
>> such
>> an update, null_blk (null_map_queues()) does not map any software queue (ctx)
>> to it.
>> As a result, the newly added hctx remains unused for I/O.
>>
>> Given this behavior, I believe we should not allow users to update submit_queues
>> on a null_blk device if it is using a shared tagset. Currently, the code allows
>> this update, but it’s misleading since the change has no actual effect.
>>
>> Would it make sense to explicitly prevent updating submit_queues in this case?
>> That would align the interface with the actual behavior and avoid potential
>> confusion and also saves us allocating memory for hctx which remains unused.
>> Maybe we should have this check, in nullb_update_nr_hw_queues():
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index fbae0427263d..aed2a6904db1 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -388,6 +388,12 @@ static int nullb_update_nr_hw_queues(struct nullb_device
>> *dev,
>>          if (!submit_queues)
>>                  return -EINVAL;
>>   +       /*
>> +        * Cannot update queues with shared tagset.
>> +        */
>> +       if (dev->shared_tags)
>> +               return -EINVAL;
>> +
>>          /*
>>           * Make sure that null_init_hctx() does not access nullb->queues[] past
>>           * the end of that array.
>>
>> If the above change looks good, maybe I can update second patch with
>> the above change.
> 
> I'm good with this change, howerver, with a quick look it seems lots of
> configfs api are broken for shared_tags. For example:
> 
> If we switch shared_tags from 0 to 1, and then read submit_queues,
> looks like it's the old dev->submit_queues instead of g_submit_queues;

g_submit_queues is used as the initial value for dev->submit_queues. See
nullb_alloc_dev(). So if we prevent changing dev->submit_queues with configfs,
we'll get whatever g_submit_queues was set on modprobe for the shared tagset.



-- 
Damien Le Moal
Western Digital Research
