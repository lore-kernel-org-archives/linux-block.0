Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5C13B58A;
	Thu,  7 Aug 2025 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574271; cv=none; b=D4xHT7WLh32/6idsv9BwhtsbIekx/y1Sn/lEae7fRL+I8HmzkyAKTyNgaqpr4wc7zu5Uhd8sXDi+bXvWTw4ebXwZn4Taf0+ybNMjNvDZ8J8h/IM/ijNTlzxEL5JUfCDh8mEFqolJTce7T1F2F4N00SXipr82mTfMw1dI2aR5UAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574271; c=relaxed/simple;
	bh=TeaD2IgUIVzQ5ragLIu88y/T0MM1pyFNVBzbYH6mJZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7Hv+C22oXmzM/IvsmdMldQeXyNJsuazE8R1u9asefCcLP1EtZODTIbYA2kJo01md9iIKoweIqggeY2HmEmEkm8195bHoZcmPgqIF5adMhEZrqGlOv5z6j6+bFNHHH516RIyw7QfWjBXUwAdSVvDkSidh48l1nnrWtOjVd6bQF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4byT0m6qWxzYQtrx;
	Thu,  7 Aug 2025 21:44:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 976C91A1508;
	Thu,  7 Aug 2025 21:44:23 +0800 (CST)
Received: from [10.174.178.72] (unknown [10.174.178.72])
	by APP4 (Coremail) with SMTP id gCh0CgBn4hKzrZRoI_OMCw--.46689S3;
	Thu, 07 Aug 2025 21:44:21 +0800 (CST)
Message-ID: <1aa629f8-88d3-4e1b-9e96-003959809fa1@huaweicloud.com>
Date: Thu, 7 Aug 2025 21:44:19 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix kobject double initialization in add_disk
To: Nilay Shroff <nilay@linux.ibm.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
 houtao1@huawei.com, zhengqixing@huawei.com
References: <20250807072056.2627592-1-zhengqixing@huaweicloud.com>
 <470ab442-e5eb-4fa8-bde7-d6d2d1115a5a@linux.ibm.com>
From: Zheng Qixing <zhengqixing@huaweicloud.com>
In-Reply-To: <470ab442-e5eb-4fa8-bde7-d6d2d1115a5a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBn4hKzrZRoI_OMCw--.46689S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1fArWxJw47AFyxZFykGrg_yoWrCw4rpr
	WfWw47G3yktr4xZwsrC3WDAr18Krs5Grn3Ars3Kr9IvrZxXrnIgF4UGFW7ZF48Ars3CF4S
	qF40ywsxKr1kCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: x2kh0wptl0x03j6k3tpzhluzxrxghudrp/

Hi,


在 2025/8/7 19:47, Nilay Shroff 写道:
>
> On 8/7/25 12:50 PM, Zheng Qixing wrote:
>> From: Zheng Qixing <zhengqixing@huawei.com>
>>
>> Device-mapper can call add_disk() multiple times for the same gendisk
>> due to its two-phase creation process (dm create + dm load). This leads
>> to kobject double initialization errors when the underlying iSCSI devices
>> become temporarily unavailable and then reappear.
>>
>> However, if the first add_disk() call fails and is retried, the queue_kobj
>> gets initialized twice, causing:
>>
>> kobject: kobject (ffff88810c27bb90): tried to init an initialized object,
>> something is seriously wrong.
>>   Call Trace:
>>    <TASK>
>>    dump_stack_lvl+0x5b/0x80
>>    kobject_init.cold+0x43/0x51
>>    blk_register_queue+0x46/0x280
>>    add_disk_fwnode+0xb5/0x280
>>    dm_setup_md_queue+0x194/0x1c0
>>    table_load+0x297/0x2d0
>>    ctl_ioctl+0x2a2/0x480
>>    dm_ctl_ioctl+0xe/0x20
>>    __x64_sys_ioctl+0xc7/0x110
>>    do_syscall_64+0x72/0x390
>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Fix this by separating kobject initialization from sysfs registration:
>>   - Initialize queue_kobj early during gendisk allocation
>>   - add_disk() only adds the already-initialized kobject to sysfs
>>   - del_gendisk() removes from sysfs but doesn't destroy the kobject
>>   - Final cleanup happens when the disk is released
>>
>> Fixes: 2bd85221a625 ("block: untangle request_queue refcounting from sysfs")
>> Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
>> Closes: https://lore.kernel.org/all/83591d0b-2467-433c-bce0-5581298eb161@huawei.com/
>> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
>> ---
>>   block/blk-sysfs.c | 4 +---
>>   block/blk.h       | 1 +
>>   block/genhd.c     | 2 ++
>>   3 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 396cded255ea..37d8654faff9 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -847,7 +847,7 @@ static void blk_queue_release(struct kobject *kobj)
>>   	/* nothing to do here, all data is associated with the parent gendisk */
>>   }
>>   
>> -static const struct kobj_type blk_queue_ktype = {
>> +const struct kobj_type blk_queue_ktype = {
>>   	.default_groups = blk_queue_attr_groups,
>>   	.sysfs_ops	= &queue_sysfs_ops,
>>   	.release	= blk_queue_release,
>> @@ -875,7 +875,6 @@ int blk_register_queue(struct gendisk *disk)
>>   	struct request_queue *q = disk->queue;
>>   	int ret;
>>   
>> -	kobject_init(&disk->queue_kobj, &blk_queue_ktype);
>>   	ret = kobject_add(&disk->queue_kobj, &disk_to_dev(disk)->kobj, "queue");
>>   	if (ret < 0)
>>   		goto out_put_queue_kobj;
> If the kobject_add() fails here, then we jump to the label out_put_queue_kobj,
> where we release/put disk->queue_kobj. That would decrement the kref of
> disk->queue_kobj and possibly bring it to zero.


Since we remove the kobject_init() into alloc disk, when the 
kobject_add() fails here,

it should return without kobject_del/put().


If kobject_add() succeeds but later steps fail, we should call 
kobject_del() to rollback.


The current error handling with kobject_put() in blk_register_queue() is 
indeed problematic.


> Next time, when we call add_disk() again without invoking kobject_init()
> (because the initialization is now moved outside add_disk()), the refcount
> of disk->queue_kobj — which was previously released — would now go for a
> toss. Wouldn't that lead to use-after-free or inconsistent state?
>
>> @@ -986,5 +985,4 @@ void blk_unregister_queue(struct gendisk *disk)
>>   		elevator_set_none(q);
>>   
>>   	blk_debugfs_remove(disk);
>> -	kobject_put(&disk->queue_kobj);
>>   }
> I'm thinking a case where add_disk() fails after the queue is registered.
> In that case, we call blk_unregister_queue() — which would ideally put()
> the disk->queue_kobj.
> But if we skip that put() in blk_unregister_queue() (and that's what we do
> above), and then later retry add_disk(), wouldn’t kobject_add() from
> blk_register_queue() complain loudly — since we’re trying to add a kobject
> that was already added previously?


blk_unregister_queue() calls kobject_del(), then the sysfs state is 
properly cleaned up

and retry should work fine.


>
> Thanks,
> --Nilay


Thanks,

Qixing

