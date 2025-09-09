Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D732BEFE0;
	Tue,  9 Sep 2025 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757410583; cv=none; b=lh4yAQmJvOdJmWuQyiQG+WOQ9xV/UX6tjtA8xaBVq+wFe3k4jurYgJEqg7kL9zybDd/LPYEbpXqlGgs09AntbYCrj2zJPGQkX5vUk7Hu99GN1wpI8iguRb+ZyxySJVSLTgYb8PRhzHyyYDLWQ70jnErplhUGyLkKa79KvRy1iLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757410583; c=relaxed/simple;
	bh=P9O2Fk+lvzyaJHVRCl8W2a66c9AQA/ityzFxTEeAzvk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hJ2EJWXj1+lDWZ+QIjPTj0XV1xFD5BF3kMaCEb5OyGjseIFr4JN0vzBVvf/tSFLXQ8EHaqjn12IxTAXIoalMMch9flyYyEe8GwfHNunIbxVjvC6OohZ7TnCYYYck/fZIdY7G1lFHEMDbSVSQGM/OYjR7sLRGMdIEzLGSNEDajZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cLdxG0lWvzYQv8m;
	Tue,  9 Sep 2025 17:36:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 96FBB1A19DF;
	Tue,  9 Sep 2025 17:36:16 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnMY4O9b9oHH6lBw--.26435S3;
	Tue, 09 Sep 2025 17:36:16 +0800 (CST)
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
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7544e26c-502a-75fc-7147-721a98bb0e80@huaweicloud.com>
Date: Tue, 9 Sep 2025 17:36:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d15faae0-40bb-41f0-bef1-f2ad48543110@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnMY4O9b9oHH6lBw--.26435S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKrWkGw1rWF15CF47Cr48WFg_yoW7Xr47pF
	Z5Ja9Fk3y0qw18Zw1jvw17W34Utw1Igw17Wr48tF17Jrnrtwnaqr18Xr1jgrW8Ars7Jr1j
	q3W5tFW7ZryDZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU52NtDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/09 17:26, Nilay Shroff 写道:
> 
> 
> On 9/9/25 12:46 PM, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/09/09 14:52, Nilay Shroff 写道:
>>>
>>>
>>> On 9/9/25 12:08 PM, Yu Kuai wrote:
>>>> Hi,
>>>>
>>>> 在 2025/09/09 14:29, Nilay Shroff 写道:
>>>>>
>>>>>
>>>>> On 9/8/25 11:45 AM, Yu Kuai wrote:
>>>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>>>
>>>>>> request_queue->nr_requests can be changed by:
>>>>>>
>>>>>> a) switching elevator by update nr_hw_queues
>>>>>> b) switching elevator by elevator sysfs attribute
>>>>>> c) configue queue sysfs attribute nr_requests
>>>>>>
>>>>>> Current lock order is:
>>>>>>
>>>>>> 1) update_nr_hwq_lock, case a,b
>>>>>> 2) freeze_queue
>>>>>> 3) elevator_lock, cas a,b,c
>>>>>>
>>>>>> And update nr_requests is seriablized by elevator_lock() already,
>>>>>> however, in the case c), we'll have to allocate new sched_tags if
>>>>>> nr_requests grow, and do this with elevator_lock held and queue
>>>>>> freezed has the risk of deadlock.
>>>>>>
>>>>>> Hence use update_nr_hwq_lock instead, make it possible to allocate
>>>>>> memory if tags grow, meanwhile also prevent nr_requests to be changed
>>>>>> concurrently.
>>>>>>
>>>>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>>>>> ---
>>>>>>     block/blk-sysfs.c | 12 +++++++++---
>>>>>>     1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>>>>>> index f99519f7a820..7ea15bf68b4b 100644
>>>>>> --- a/block/blk-sysfs.c
>>>>>> +++ b/block/blk-sysfs.c
>>>>>> @@ -68,13 +68,14 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
>>>>>>         int ret, err;
>>>>>>         unsigned int memflags;
>>>>>>         struct request_queue *q = disk->queue;
>>>>>> +    struct blk_mq_tag_set *set = q->tag_set;
>>>>>>           ret = queue_var_store(&nr, page, count);
>>>>>>         if (ret < 0)
>>>>>>             return ret;
>>>>>>     -    memflags = blk_mq_freeze_queue(q);
>>>>>> -    mutex_lock(&q->elevator_lock);
>>>>>> +    /* serialize updating nr_requests with switching elevator */
>>>>>> +    down_write(&set->update_nr_hwq_lock);
>>>>>>     
>>>>> For serializing update of nr_requests with switching elevator,
>>>>> we should use disable_elv_switch(). So with this change we
>>>>> don't need to acquire ->update_nr_hwq_lock in writer context
>>>>> while running blk_mq_update_nr_requests but instead it can run
>>>>> acquiring ->update_nr_hwq_lock in the reader context.
>>>>>
>>>>> So the code flow should be,
>>>>>
>>>>> disable_elv_switch  => this would set QUEUE_FLAG_NO_ELV_SWITCH
>>>>> ...
>>>>> down_read ->update_nr_hwq_lock
>>>>> acquire ->freeze_lock
>>>>> acquire ->elevator_lock;
>>>>> ...
>>>>> ...
>>>>> release ->elevator_lock;
>>>>> release ->freeze_lock
>>>>>
>>>>> clear QUEUE_FLAG_NO_ELV_SWITCH
>>>>> up_read ->update_nr_hwq_lock
>>>>>
>>>>
>>>> Yes, this make sense, however, there is also an implied condition that
>>>> we should serialize queue_requests_store() with itself, what if a
>>>> concurrent caller succeed the disable_elv_switch() before the
>>>> down_read() in this way?
>>>>
>>>> t1:
>>>> disable_elv_switch
>>>>           t2:
>>>>           disable_elv_switch
>>>>
>>>> down_read    down_read
>>>>
>>> I believe this is already protected with the kernfs internal
>>> mutex locks. So you shouldn't be able to run two sysfs store
>>> operations concurrently on the same attribute file.
>>>
>>
>> There really is no such internal lock, the call stack is:
>>
>> kernfs_fop_write_iter
>>   sysfs_kf_write
>>    queue_attr_store
>>
>> There is only a file level mutex kernfs_open_file->lock from the top
>> function kernfs_fop_write_iter(), however, this lock is not the same
>> if we open the same attribute file from different context.
>>
> Oh yes this lock only protects if the same fd is being written
> concurrently. However if we open the same sysfs file from different process
> contexts then fd would be different and so this lock wouldn't protect
> the simultaneous update of sysfs attribute. Having said that,
> looking through the code again it seems that q->nr_requests update
> is protected with ->elevator_lock (including both the elevator switch
> code and your proposed changes in this patchset). So my question is
> do we really need to synchronize nr_requests update code with elevator
> swiupdate_nr_hwq_locktch code? So in another words what if we don't at
> all use ->update_nr_hwq_lock in queue_requests_store?

1) lock update_nr_hwq_lock, then no one can change nr_queuests
2) checking input nr_reqeusts
3) if grow, allocate memory

Main idea here is we can checking if nr_requests grow and then allocate
mermory, without concern that nr_requests can be changed after memory
allocation.

BTW, I think this sysfs attr is really a slow path, and it's fine to
grab the write lock.

Thanks,
Kuai
> 
> Thanks
> --Nilay
> .
> 

