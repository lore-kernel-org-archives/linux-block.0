Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112FD420877;
	Tue,  7 Jul 2026 06:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405708; cv=none; b=SeItSN8v5uhDfbRwR5u81OZXArF1Lap1+Ubs0tKY4KNOBI0ca/ho0t1/0u4BCOaK9IEVYdQq0nWXGkVdWw174FtIkhCorBfILi30Ga3U0KkE/spq0pEY+hx6xJ3ZaJeBj/TFO48dIxpT06nPIbnOaJ+M2Rcsl/PJ72mFFrJs3UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405708; c=relaxed/simple;
	bh=dWhhX+xvfpdp+rIP93Yk/88hzSxKVrYbPDIe+zUQS1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NUyscvqsuCAzyEpfO78EvbS3LdKWIuPApSnFB8FwASj+7cQTwU9p+pjuoofdPHn6Sxv3AYthsOwJWfK8jfN6UDIzVZAD3fMeiVeWx1NE0ZrNpHxY6FUoK5gtZv6LXWPBvzsgQfqjqCRv0wHJJhyNGPeao4k8LmFVgyL5soDNl0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOWLwQAw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOWLwQAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F46F1F000E9;
	Tue,  7 Jul 2026 06:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783405706;
	bh=zQ4i4zuSFwc7H5qbsT2kdaD1GVyg2DXvKtY9NVpSmGk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AOWLwQAwMI0cs/msdA6oVjWwbCndDeKDTPymBPn4lKO5AxpoPcu/F+6nr9KA+y5nG
	 nieZWIhvjHtujSMURYinbtBoaBNwbdq9juZOi3LfpWT8VBrlmZpQxlsFpVEveuGrr2
	 hE0JhyD2KM9axWECW+tUFl9EPawwzakNZuSzuvN1eBX1ambDqgNSyoxTvhC8i4NGwu
	 LtWHZFc+r0k0voceMgml79BaF1yV80Iosgd2OWJUjo5eNVNMeAd9uY3EqsE4djotPF
	 HWR4kRfMpG0T6pKEweYW5iv6rV7TqdJdIgkndD+FH89qFFxIgSYQ9rf3PeqvKqkD/j
	 ZHu04qCYO26jQ==
Message-ID: <017a3a24-2b9a-4567-b2d6-a496a86da0fe@kernel.org>
Date: Tue, 7 Jul 2026 15:28:23 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/6] null_blk: give the file-scope mutex a descriptive
 name
To: Zizhi Wo <wozizhi@huaweicloud.com>, axboe@kernel.dk, nilay@linux.ibm.com,
 linux-block@vger.kernel.org, kch@nvidia.com, johannes.thumshirn@wdc.com,
 kbusch@kernel.org, bvanassche@acm.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20260707025542.1299859-1-wozizhi@huaweicloud.com>
 <20260707025542.1299859-3-wozizhi@huaweicloud.com>
 <0ab391b1-20e2-4ae9-a606-7111014e489c@kernel.org>
 <5dd82788-aa48-4f11-907f-6f21b57a27fa@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <5dd82788-aa48-4f11-907f-6f21b57a27fa@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/7/26 15:24, Zizhi Wo wrote:
> 
> 
> 在 2026/7/7 12:16, Damien Le Moal 写道:
>> On 7/7/26 11:55, Zizhi Wo wrote:
>>> From: Zizhi Wo <wozizhi@huawei.com>
>>>
>>> The file-scope lock mutex serializes access to global null_blk state,
>>> including the nullb_list and device creation/removal. Rename it to
>>> "nullb_global_lock" to make its purpose clear. No functional change.
>>>
>>> Suggested-by: Bart Van Assche <bvanassche@acm.org>
>>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>>> ---
>>>   drivers/block/null_blk/main.c | 32 ++++++++++++++++----------------
>>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>> index eba204b27785..98f6935bb502 100644
>>> --- a/drivers/block/null_blk/main.c
>>> +++ b/drivers/block/null_blk/main.c
>>> @@ -66,7 +66,7 @@ struct nullb_page {
>>>   #define NULLB_PAGE_FREE (MAP_SZ - 2)
>>>   
>>>   static LIST_HEAD(nullb_list);
>>> -static DEFINE_MUTEX(lock);
>>> +static DEFINE_MUTEX(nullb_global_lock);
>>
>> Since this seem to protect only the device list, why not simply call this
>> nullb_list_lock ?
>>
>>>   static int null_major;
>>>   static DEFINE_IDA(nullb_indexes);
>>>   static struct blk_mq_tag_set tag_set;
>>> @@ -423,9 +423,9 @@ static int nullb_apply_submit_queues(struct nullb_device *dev,
>>>   {
>>>   	int ret;
>>>   
>>> -	mutex_lock(&lock);
>>> +	mutex_lock(&nullb_global_lock);
>>>   	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
>>> -	mutex_unlock(&lock);
>>> +	mutex_unlock(&nullb_global_lock);
>>
>> Nothing in nullb_update_nr_hw_queues() touches the device list. So it is very
>> odd that nullb_global_lock is used for serialization here instead of a
>> nullb_device mutex. If you change this, why not a prep patch to introduce such a
>> mutex ?
>>
> 
> Thanks for pointing this out. The rename really belongs together with
> the locking rework, so I'll drop this patch from v3 and fold the rename
> into a separate series that splits the locking (introducing a per-
> nullb_device mutex for the updates).

Please carefully check if the use of the global lock in these function is not to
serialize with power on/off. The code is a little (uselessly) complicated in
that area and I may not be seeing something. But it seems that on/off control
could also use a device lock, with proper ordering: device lock first, then list
lock.


-- 
Damien Le Moal
Western Digital Research
