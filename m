Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D54A06;
	Fri,  8 Aug 2025 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642062; cv=none; b=bXgsvzgztJdFDBnEZg0vqxwNiD5xvSSTPvMZYGG70QYYWw1F4WSKtVjEQ05gavACWLUKH8wo2TMMq7hIR5mvJPm9vq4fVYjBYy5xnsk91AP8DSsTiSdQCawdgGRZsVe0UXFuFk9gH3N8oSjoG3Of8RNOkpWFPrd/znTT6LU0zJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642062; c=relaxed/simple;
	bh=OPa/uqrQHFXPqWrfLiMQ3T+NAqXePZR2EtviC8j1kFU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AAND78Un5/Tol3xhGO6Vaa39Oq7FJo6RWWJ0x5LDkkr2HqdTCLGeTGKuUnJZantFcR8/NSO63VHWjk5LNNMBtoGa0lQNWfrfBaE7X3Hsn6usRyVwoDLoTIu9wTBLbw4dVleKHcgwUb5ttD4YEeS/dwMKLnOH3jBpGwac5zSiBec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4byy4R0HmdzYQttm;
	Fri,  8 Aug 2025 16:34:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A93A71A13D4;
	Fri,  8 Aug 2025 16:34:13 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgBXIBF_tpVoO8_lCw--.63551S3;
	Fri, 08 Aug 2025 16:34:09 +0800 (CST)
Subject: Re: [PATCH] block: fix kobject double initialization in add_disk
To: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 Zheng Qixing <zhengqixing@huaweicloud.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, houtao1@huawei.com,
 zhengqixing@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250807072056.2627592-1-zhengqixing@huaweicloud.com>
 <470ab442-e5eb-4fa8-bde7-d6d2d1115a5a@linux.ibm.com>
 <1aa629f8-88d3-4e1b-9e96-003959809fa1@huaweicloud.com>
 <c5036a51-ffd5-4eab-f1a5-369adff3a291@huaweicloud.com>
 <bc3b132d-f017-4bcd-a3f4-3ea344d67a04@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <712dba37-31a6-f53d-741d-a98f69f2d756@huaweicloud.com>
Date: Fri, 8 Aug 2025 16:34:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bc3b132d-f017-4bcd-a3f4-3ea344d67a04@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXIBF_tpVoO8_lCw--.63551S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWUJr4xtF1rGF4DtF4UCFg_yoWxWFW8pr
	Zaq3W7t3y8Kr4xXw4qq3WDJFy8tr4kJw1DZrn3trySvrZrtrnIgF4UXFyq9F48Ars3GF4j
	qF4UK39xur1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/08 16:09, Nilay Shroff 写道:
> 
> 
> On 8/8/25 6:18 AM, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/08/07 21:44, Zheng Qixing 写道:
>>> Hi,
>>>
>>>
>>> 在 2025/8/7 19:47, Nilay Shroff 写道:
>>>>
>>>> On 8/7/25 12:50 PM, Zheng Qixing wrote:
>>>>> From: Zheng Qixing <zhengqixing@huawei.com>
>>>>>
>>>>> Device-mapper can call add_disk() multiple times for the same gendisk
>>>>> due to its two-phase creation process (dm create + dm load). This leads
>>>>> to kobject double initialization errors when the underlying iSCSI devices
>>>>> become temporarily unavailable and then reappear.
>>>>>
>>>>> However, if the first add_disk() call fails and is retried, the queue_kobj
>>>>> gets initialized twice, causing:
>>>>>
>>>>> kobject: kobject (ffff88810c27bb90): tried to init an initialized object,
>>>>> something is seriously wrong.
>>>>>    Call Trace:
>>>>>     <TASK>
>>>>>     dump_stack_lvl+0x5b/0x80
>>>>>     kobject_init.cold+0x43/0x51
>>>>>     blk_register_queue+0x46/0x280
>>>>>     add_disk_fwnode+0xb5/0x280
>>>>>     dm_setup_md_queue+0x194/0x1c0
>>>>>     table_load+0x297/0x2d0
>>>>>     ctl_ioctl+0x2a2/0x480
>>>>>     dm_ctl_ioctl+0xe/0x20
>>>>>     __x64_sys_ioctl+0xc7/0x110
>>>>>     do_syscall_64+0x72/0x390
>>>>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>>
>>>>> Fix this by separating kobject initialization from sysfs registration:
>>>>>    - Initialize queue_kobj early during gendisk allocation
>>>>>    - add_disk() only adds the already-initialized kobject to sysfs
>>>>>    - del_gendisk() removes from sysfs but doesn't destroy the kobject
>>>>>    - Final cleanup happens when the disk is released
>>>>>
>>>>> Fixes: 2bd85221a625 ("block: untangle request_queue refcounting from sysfs")
>>>>> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
>>>>> Closes: https://lore.kernel.org/all/83591d0b-2467-433c-bce0-5581298eb161@huawei.com/
>>>>> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
>>>>> ---
>>>>>    block/blk-sysfs.c | 4 +---
>>>>>    block/blk.h       | 1 +
>>>>>    block/genhd.c     | 2 ++
>>>>>    3 files changed, 4 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>>>>> index 396cded255ea..37d8654faff9 100644
>>>>> --- a/block/blk-sysfs.c
>>>>> +++ b/block/blk-sysfs.c
>>>>> @@ -847,7 +847,7 @@ static void blk_queue_release(struct kobject *kobj)
>>>>>        /* nothing to do here, all data is associated with the parent gendisk */
>>>>>    }
>>>>> -static const struct kobj_type blk_queue_ktype = {
>>>>> +const struct kobj_type blk_queue_ktype = {
>>>>>        .default_groups = blk_queue_attr_groups,
>>>>>        .sysfs_ops    = &queue_sysfs_ops,
>>>>>        .release    = blk_queue_release,
>>>>> @@ -875,7 +875,6 @@ int blk_register_queue(struct gendisk *disk)
>>>>>        struct request_queue *q = disk->queue;
>>>>>        int ret;
>>>>> -    kobject_init(&disk->queue_kobj, &blk_queue_ktype);
>>>>>        ret = kobject_add(&disk->queue_kobj, &disk_to_dev(disk)->kobj, "queue");
>>>>>        if (ret < 0)
>>>>>            goto out_put_queue_kobj;
>>>> If the kobject_add() fails here, then we jump to the label out_put_queue_kobj,
>>>> where we release/put disk->queue_kobj. That would decrement the kref of
>>>> disk->queue_kobj and possibly bring it to zero.
>>>
>>>
>>> Since we remove the kobject_init() into alloc disk, when the kobject_add() fails here,
>>>
>>> it should return without kobject_del/put().
>>
>> Yes, sorry I didn't noticed.
>>>
>>>
>>> If kobject_add() succeeds but later steps fail, we should call kobject_del() to rollback.
>>>
>>>
>>> The current error handling with kobject_put() in blk_register_queue() is indeed problematic.
>>>
>>>
>>>> Next time, when we call add_disk() again without invoking kobject_init()
>>>> (because the initialization is now moved outside add_disk()), the refcount
>>>> of disk->queue_kobj — which was previously released — would now go for a
>>>> toss. Wouldn't that lead to use-after-free or inconsistent state?
>>>>
>>>>> @@ -986,5 +985,4 @@ void blk_unregister_queue(struct gendisk *disk)
>>>>>            elevator_set_none(q);
>>>>>        blk_debugfs_remove(disk);
>>>>> -    kobject_put(&disk->queue_kobj);
>>>>>    }
>>>> I'm thinking a case where add_disk() fails after the queue is registered.
>>>> In that case, we call blk_unregister_queue() — which would ideally put()
>>>> the disk->queue_kobj.
>>>> But if we skip that put() in blk_unregister_queue() (and that's what we do
>>>> above), and then later retry add_disk(), wouldn’t kobject_add() from
>>>> blk_register_queue() complain loudly — since we’re trying to add a kobject
>>>> that was already added previously?
>>
>> This is exactly the problem reported orginally, now is the same
>> procedures before 2bd85221a625:
>>
>> 1) allocate memory: kobject_init
>> 2) register queue: kobject_add
>> 3) unregister queue: kobject_del
>> 4) free memory: kobject_put
>>
>> Noted that kobject_add is corresponding to kobject_del, and they don't
>> grab/release kobject reference. 2) and 3) can be executed multiple
>> times, the only thing that I noticed is the following uevent:
>>
>> kobject_uevent(&disk->queue_kobj, KOBJ_ADD);
>>
>> Looks like the uevent is only valid for the first one, if first add_disk
>> failed and then queue is registered again, there won't be uevent again,
>> see state_add_uevent_sent.
>>
> Why do you think so? We always send the "add" uevent when we register
> queue and then send "remove" uevent when the queue is unregistered. This
> behavior should remain intact with this change. The kobj->state_add_uevent_sent
> is only used for sending "remove" event during automatic cleanup of kobject.
> It shouldn't have any side effect while we re-register queue or retry
> add_disk(). Or am I missing something here?

Yes, turns out I misread the code after I tested and found that user
didn't get the queue uevent. Just dig deeper and realize this is due
to dev_uevent_filter() from the top devices_kset stop the queue kobj
uevent.

So, if I don't misread the code now, looks like the kobject_uevent()
call to queue_kobj is useless.

Thanks,
Kuai

> 
> Thanks,
> --Nilay
> .
> 

