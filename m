Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1946728DB3;
	Tue,  9 Sep 2025 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757414561; cv=pass; b=oTGbTLtL20nJa7CunJmAmTuMliBXIowCf5l7227l4fZ1sZHQrnOhP7cTPSJRF5wunbWiOqWkEOS3zH4RPvF+lXtyfxeM//WCeeNaSFvcb4w7MJEvDwB/Wb3PVVRBsY9inkM2LEAy2GXXl2GQ6WgeUW+5KTNReYYhIo3pASNSiMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757414561; c=relaxed/simple;
	bh=FC7bW83OEVRCIUjlMXx2dOA12vDeV+6yDp6CGr0Dtfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fEZ94VMap8ZEcRLFqsfReMXYkKzRBNmP+RI+j6Oh5tYrisALqnsC1ctugwSLElZ4E0uwkYhPcOW0eiFa4XD+lelc0flc5IA3uQZ6mLgot2+u1eH8kltgYrgIZJqxmT1lfu9Q165Ws1OVSW57hMW6rDI/pNQnaO8wVo/1qMh9Ruk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=ceHDnpKi; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="ceHDnpKi"
ARC-Seal: i=1; a=rsa-sha256; t=1757414534; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e4KVhUIBwKrZGOBIdxXOJt26FrhCR+d4zMF1+q3RnW0uUoZnVid80gVGEyzzwdrU+HheL7rXMvD4sh/YzVS+Dp0AlvNsd9xU3Jm6WoYqqNPs9eL2NoEnRLQJ0SMK5Uqapz+bbM0VKz2AF0Hl7X3J369VIc3lBCh6U38RYK2ccxU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757414534; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zla5rRyWRpNUcW0IeCuac8C2OfPcUBBMpzB/j62xmDU=; 
	b=Y+cDTA6MUjEGzIgDqJMjgYQ6HWFv9Y1Mc4qd3b++VjUWTQ/0ufidPYUZVy8yxN2/mdg0HlebimhjKmnQkUNvTRdI5s6Jqt1QxFYk20XXtiOBx4V2Txp8xMnkq/JAe7wf6OYAjPpOThcqrBncFwagkdNzU14CQO+igLOTnps4VfM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757414534;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zla5rRyWRpNUcW0IeCuac8C2OfPcUBBMpzB/j62xmDU=;
	b=ceHDnpKiXivtZwdDGuaMgHhrCLfdv1i92XlanB5VB86+hRgWvvutvw5Evl+5F8Ft
	wsrcwVOhRx0y9ujPwspCFiAVObjVKM+vIekjngbLz5/OysQrfCkxkFHmTtZQGRbpco4
	rTWaWAhBtZOz5GxaTYwNrYBwTiiNbfMbpfNZdBVU=
Received: by mx.zohomail.com with SMTPS id 1757414531847661.167349591676;
	Tue, 9 Sep 2025 03:42:11 -0700 (PDT)
Message-ID: <b85a8730-78f0-4933-a415-815e6ceefe5f@yukuai.org.cn>
Date: Tue, 9 Sep 2025 18:42:05 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 04/10] blk-mq: convert to serialize
 updating nr_requests with update_nr_hwq_lock
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-5-yukuai1@huaweicloud.com>
 <9708abeb-7677-4c0e-931b-7ca5fe0a0242@linux.ibm.com>
 <329ca336-21f6-e686-0446-b3ae9a46f4c9@huaweicloud.com>
 <f57ebcf8-9225-4e3d-86d2-cac7f9cacb54@linux.ibm.com>
 <43d25899-6b1a-c0e1-c3f5-8e2a560c93d5@huaweicloud.com>
 <d15faae0-40bb-41f0-bef1-f2ad48543110@linux.ibm.com>
 <7544e26c-502a-75fc-7147-721a98bb0e80@huaweicloud.com>
 <7fe7bfd3-d6c0-4485-aaa1-2c1629cb1784@linux.ibm.com>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <7fe7bfd3-d6c0-4485-aaa1-2c1629cb1784@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/9/9 18:11, Nilay Shroff 写道:
>
> On 9/9/25 3:06 PM, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/09/09 17:26, Nilay Shroff 写道:
>>>
>>> On 9/9/25 12:46 PM, Yu Kuai wrote:
>>>> Hi,
>>>>
>>>> 在 2025/09/09 14:52, Nilay Shroff 写道:
>>>>>
>>>>> On 9/9/25 12:08 PM, Yu Kuai wrote:
>>>>>> Hi,
>>>>>>
>>>>>> 在 2025/09/09 14:29, Nilay Shroff 写道:
>>>>>>>
>>>>>>> On 9/8/25 11:45 AM, Yu Kuai wrote:
>>>>>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>>>>>
>>>>>>>> request_queue->nr_requests can be changed by:
>>>>>>>>
>>>>>>>> a) switching elevator by update nr_hw_queues
>>>>>>>> b) switching elevator by elevator sysfs attribute
>>>>>>>> c) configue queue sysfs attribute nr_requests
>>>>>>>>
>>>>>>>> Current lock order is:
>>>>>>>>
>>>>>>>> 1) update_nr_hwq_lock, case a,b
>>>>>>>> 2) freeze_queue
>>>>>>>> 3) elevator_lock, cas a,b,c
>>>>>>>>
>>>>>>>> And update nr_requests is seriablized by elevator_lock() already,
>>>>>>>> however, in the case c), we'll have to allocate new sched_tags if
>>>>>>>> nr_requests grow, and do this with elevator_lock held and queue
>>>>>>>> freezed has the risk of deadlock.
>>>>>>>>
>>>>>>>> Hence use update_nr_hwq_lock instead, make it possible to allocate
>>>>>>>> memory if tags grow, meanwhile also prevent nr_requests to be changed
>>>>>>>> concurrently.
>>>>>>>>
>>>>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>>>>>> ---
>>>>>>>>      block/blk-sysfs.c | 12 +++++++++---
>>>>>>>>      1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>>>>>>>> index f99519f7a820..7ea15bf68b4b 100644
>>>>>>>> --- a/block/blk-sysfs.c
>>>>>>>> +++ b/block/blk-sysfs.c
>>>>>>>> @@ -68,13 +68,14 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
>>>>>>>>          int ret, err;
>>>>>>>>          unsigned int memflags;
>>>>>>>>          struct request_queue *q = disk->queue;
>>>>>>>> +    struct blk_mq_tag_set *set = q->tag_set;
>>>>>>>>            ret = queue_var_store(&nr, page, count);
>>>>>>>>          if (ret < 0)
>>>>>>>>              return ret;
>>>>>>>>      -    memflags = blk_mq_freeze_queue(q);
>>>>>>>> -    mutex_lock(&q->elevator_lock);
>>>>>>>> +    /* serialize updating nr_requests with switching elevator */
>>>>>>>> +    down_write(&set->update_nr_hwq_lock);
>>>>>>>>      
>>>>>>> For serializing update of nr_requests with switching elevator,
>>>>>>> we should use disable_elv_switch(). So with this change we
>>>>>>> don't need to acquire ->update_nr_hwq_lock in writer context
>>>>>>> while running blk_mq_update_nr_requests but instead it can run
>>>>>>> acquiring ->update_nr_hwq_lock in the reader context.
>>>>>>>
>>>>>>> So the code flow should be,
>>>>>>>
>>>>>>> disable_elv_switch  => this would set QUEUE_FLAG_NO_ELV_SWITCH
>>>>>>> ...
>>>>>>> down_read ->update_nr_hwq_lock
>>>>>>> acquire ->freeze_lock
>>>>>>> acquire ->elevator_lock;
>>>>>>> ...
>>>>>>> ...
>>>>>>> release ->elevator_lock;
>>>>>>> release ->freeze_lock
>>>>>>>
>>>>>>> clear QUEUE_FLAG_NO_ELV_SWITCH
>>>>>>> up_read ->update_nr_hwq_lock
>>>>>>>
>>>>>> Yes, this make sense, however, there is also an implied condition that
>>>>>> we should serialize queue_requests_store() with itself, what if a
>>>>>> concurrent caller succeed the disable_elv_switch() before the
>>>>>> down_read() in this way?
>>>>>>
>>>>>> t1:
>>>>>> disable_elv_switch
>>>>>>            t2:
>>>>>>            disable_elv_switch
>>>>>>
>>>>>> down_read    down_read
>>>>>>
>>>>> I believe this is already protected with the kernfs internal
>>>>> mutex locks. So you shouldn't be able to run two sysfs store
>>>>> operations concurrently on the same attribute file.
>>>>>
>>>> There really is no such internal lock, the call stack is:
>>>>
>>>> kernfs_fop_write_iter
>>>>    sysfs_kf_write
>>>>     queue_attr_store
>>>>
>>>> There is only a file level mutex kernfs_open_file->lock from the top
>>>> function kernfs_fop_write_iter(), however, this lock is not the same
>>>> if we open the same attribute file from different context.
>>>>
>>> Oh yes this lock only protects if the same fd is being written
>>> concurrently. However if we open the same sysfs file from different process
>>> contexts then fd would be different and so this lock wouldn't protect
>>> the simultaneous update of sysfs attribute. Having said that,
>>> looking through the code again it seems that q->nr_requests update
>>> is protected with ->elevator_lock (including both the elevator switch
>>> code and your proposed changes in this patchset). So my question is
>>> do we really need to synchronize nr_requests update code with elevator
>>> swiupdate_nr_hwq_locktch code? So in another words what if we don't at
>>> all use ->update_nr_hwq_lock in queue_requests_store?
>> 1) lock update_nr_hwq_lock, then no one can change nr_queuests
>> 2) checking input nr_reqeusts
>> 3) if grow, allocate memory
>>
>> Main idea here is we can checking if nr_requests grow and then allocate
>> mermory, without concern that nr_requests can be changed after memory
>> allocation.
>>
> If nr_requests changes after memory allocation we're still good because
> eventually we'd only have one consistent value of nr_requests. For
> instance, if process A is updating nr_requests to 128 and sched switch
> is updating nr_requests to 256 simultaneously then we'd either see
> nr_requests set to 128 or 256 in the end depending on who runs last.
> We wouldn't get into a situation where we find some inconsistent update
> to nr_requests, isn't it?

Then we'll have to allocate memory for every input nr_requests now, we don't
know for sure if tag will grow in advance this way. And even with this, we
still have to hold read lock before allocating memory, to prevent nr hctxs
to change.

>> BTW, I think this sysfs attr is really a slow path, and it's fine to
>> grab the write lock.
>>
> Yep you're right. But I think we should avoid locks if possible.

Yes, we should avoid locks, but we should also keep code as simple
as possible, I think.

Thanks,
Kuai

>
> Thanks,
> --Nilay
>
>
