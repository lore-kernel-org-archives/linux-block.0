Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F618F9CB;
	Wed, 17 Jul 2024 03:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188416; cv=none; b=T2gdZQNWU+PDwIufUqnNFz5qn+Xp2MQ+Vs8Cf2CXaaP7xIMFStHhTh/lAT33G0PrR5B1PAkFh8oyPGxA2wpBWnzpL9+D4iyt/Mqb65jopDJSqm4w/xJnhL+Rf8/e5/Dv+wqPjm0EgKCJUB0osCg/b88yF9CBQ7tRi5ZVK+w769I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188416; c=relaxed/simple;
	bh=XfD8QRMp3TPwXDBaX/GMUh+AYPJjPthOOQeDIqGqNvM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lJzb0MUNgDaRUFGP+iHpb26E8cve6PS6Q1JV6fV0xCvtpltGPL4cxFR128bSoHq37PfFxr88gbOqASJQDmrfaf7xw6jT9zF47QLhI/CnnJp4ev6x8DkqCIyMFqlf2P/PZdX8f1Qg2VqviRvVMFHwzJse+b+l+RukB5j/Y7Auqeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WP28w6TRzz4f3jHm;
	Wed, 17 Jul 2024 11:53:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DC4671A016E;
	Wed, 17 Jul 2024 11:53:28 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgC3mjg3QJdmD1drAQ--.43036S3;
	Wed, 17 Jul 2024 11:53:28 +0800 (CST)
Subject: Re: [PATCH] block: fix deadlock between sd_remove & sd_release
To: YangYang <yang.yang@vivo.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240716083801.809763-1-yang.yang@vivo.com>
 <1859a975-8c53-140c-f5b5-898ad5e7f653@huaweicloud.com>
 <451c8746-5260-4be6-b78d-54305c94ef73@vivo.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a81cdd5b-d6ad-2a4f-0f6d-40e9db6233cd@huaweicloud.com>
Date: Wed, 17 Jul 2024 11:53:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <451c8746-5260-4be6-b78d-54305c94ef73@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3mjg3QJdmD1drAQ--.43036S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WF43Zr1UGFWrtrWUAFW8Zwb_yoWxJF1xpF
	s5tFyUJrWUArn3trWjqF1UJrW0k3WUJ3WkXr97Ja4jvFsrAr1qqayUWF1Yg3WUX3y8A3Wq
	qFn09ayfZw1qvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/07/16 17:30, YangYang 写道:
> On 2024/7/16 17:15, Yu Kuai wrote:
>> Hi,
>>
>> 在 2024/07/16 16:38, Yang Yang 写道:
>>> Our test report the following hung task:
>>>
>>> [ 2538.459400] INFO: task "kworker/0:0":7 blocked for more than 188 
>>> seconds.
>>> [ 2538.459427] Call trace:
>>> [ 2538.459430]  __switch_to+0x174/0x338
>>> [ 2538.459436]  __schedule+0x628/0x9c4
>>> [ 2538.459442]  schedule+0x7c/0xe8
>>> [ 2538.459447]  schedule_preempt_disabled+0x24/0x40
>>> [ 2538.459453]  __mutex_lock+0x3ec/0xf04
>>> [ 2538.459456]  __mutex_lock_slowpath+0x14/0x24
>>> [ 2538.459459]  mutex_lock+0x30/0xd8
>>> [ 2538.459462]  del_gendisk+0xdc/0x350
>>> [ 2538.459466]  sd_remove+0x30/0x60
>>> [ 2538.459470]  device_release_driver_internal+0x1c4/0x2c4
>>> [ 2538.459474]  device_release_driver+0x18/0x28
>>> [ 2538.459478]  bus_remove_device+0x15c/0x174
>>> [ 2538.459483]  device_del+0x1d0/0x358
>>> [ 2538.459488]  __scsi_remove_device+0xa8/0x198
>>> [ 2538.459493]  scsi_forget_host+0x50/0x70
>>> [ 2538.459497]  scsi_remove_host+0x80/0x180
>>> [ 2538.459502]  usb_stor_disconnect+0x68/0xf4
>>> [ 2538.459506]  usb_unbind_interface+0xd4/0x280
>>> [ 2538.459510]  device_release_driver_internal+0x1c4/0x2c4
>>> [ 2538.459514]  device_release_driver+0x18/0x28
>>> [ 2538.459518]  bus_remove_device+0x15c/0x174
>>> [ 2538.459523]  device_del+0x1d0/0x358
>>> [ 2538.459528]  usb_disable_device+0x84/0x194
>>> [ 2538.459532]  usb_disconnect+0xec/0x300
>>> [ 2538.459537]  hub_event+0xb80/0x1870
>>> [ 2538.459541]  process_scheduled_works+0x248/0x4dc
>>> [ 2538.459545]  worker_thread+0x244/0x334
>>> [ 2538.459549]  kthread+0x114/0x1bc
>>>
>>> [ 2538.461001] INFO: task "fsck.":15415 blocked for more than 188 
>>> seconds.
>>> [ 2538.461014] Call trace:
>>> [ 2538.461016]  __switch_to+0x174/0x338
>>> [ 2538.461021]  __schedule+0x628/0x9c4
>>> [ 2538.461025]  schedule+0x7c/0xe8
>>> [ 2538.461030]  blk_queue_enter+0xc4/0x160
>>> [ 2538.461034]  blk_mq_alloc_request+0x120/0x1d4
>>> [ 2538.461037]  scsi_execute_cmd+0x7c/0x23c
>>> [ 2538.461040]  ioctl_internal_command+0x5c/0x164
>>> [ 2538.461046]  scsi_set_medium_removal+0x5c/0xb0
>>> [ 2538.461051]  sd_release+0x50/0x94
>>> [ 2538.461054]  blkdev_put+0x190/0x28c
>>> [ 2538.461058]  blkdev_release+0x28/0x40
>>> [ 2538.461063]  __fput+0xf8/0x2a8
>>> [ 2538.461066]  __fput_sync+0x28/0x5c
>>> [ 2538.461070]  __arm64_sys_close+0x84/0xe8
>>> [ 2538.461073]  invoke_syscall+0x58/0x114
>>> [ 2538.461078]  el0_svc_common+0xac/0xe0
>>> [ 2538.461082]  do_el0_svc+0x1c/0x28
>>> [ 2538.461087]  el0_svc+0x38/0x68
>>> [ 2538.461090]  el0t_64_sync_handler+0x68/0xbc
>>> [ 2538.461093]  el0t_64_sync+0x1a8/0x1ac
>>>
>>>    T1:                T2:
>>>    sd_remove
>>>    del_gendisk
>>>    __blk_mark_disk_dead
>>>    blk_freeze_queue_start
>>>    ++q->mq_freeze_depth
>>>                    bdev_release
>>>                   mutex_lock(&disk->open_mutex)
>>>                    sd_release
>>>                   scsi_execute_cmd
>>>                   blk_queue_enter
>>>                   wait_event(!q->mq_freeze_depth)
>>
>> This looks wrong, there is a condition blk_queue_dying() in
>> blk_queue_enter().
> 
>   584 static void __blk_mark_disk_dead(struct gendisk *disk)
>   585 {
>   ......
>   591
>   592     if (test_bit(GD_OWNS_QUEUE, &disk->state))
>   593         blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
> 
> SCSI does not set GD_OWNS_QUEUE, so QUEUE_FLAG_DYING is not set in
> this scenario.

Yes, you're right. Please explain this in commit message as well.
> 
> Thanks.
> 
>>
>> Thanks,
>> Kuai
>>
>>>    mutex_lock(&disk->open_mutex)
>>>
>>> This is a classic ABBA deadlock. To fix the deadlock, make sure we don't
>>> try to acquire disk->open_mutex after freezing the queue.
>>>
>>> Signed-off-by: Yang Yang <yang.yang@vivo.com>
>>> ---
>>>   block/genhd.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/block/genhd.c b/block/genhd.c
>>> index 8f1f3c6b4d67..c5fca3e893a0 100644
>>> --- a/block/genhd.c
>>> +++ b/block/genhd.c
>>> @@ -663,12 +663,12 @@ void del_gendisk(struct gendisk *disk)
>>>        */
>>>       if (!test_bit(GD_DEAD, &disk->state))
>>>           blk_report_disk_dead(disk, false);
>>> -    __blk_mark_disk_dead(disk);
>>>       /*
>>>        * Drop all partitions now that the disk is marked dead.
>>>        */
>>>       mutex_lock(&disk->open_mutex);
>>> +    __blk_mark_disk_dead(disk);
>>>       xa_for_each_start(&disk->part_tbl, idx, part, 1)
>>>           drop_partition(part);
>>>       mutex_unlock(&disk->open_mutex);

Take a look at del_gendisk(), between freeze and unfreeze queue, I
notice that there is also device_del() here, which means it will wait
for all sysfs readers/writers to be done, so related sysfs api can't
issue IO to trigger blk_queue_enter(). And this behaviour does't look
reasonable, we never forbit this.

Then take a look at scsi sysfs api, I notice that scsi_rescan_device()
can be called and issue IO. Hence other than the 'open_mutex', same
deadlock still exist:

t1:			t2
store_state_field
  scsi_rescan_device
   scsi_attach_vpd
    scsi_get_vpd_buf
     scsi_vpd_inquiry
      scsi_execute_cmd
			del_gendisk
			 bdev_unhash
			 blk_freeze_queue_start
       blk_queue_enter
			 device_del
			  kobject_del
			   sysfs_remove_dir

I didn't test this, just by code review, and I could be wrong. And
I don't check all the procedures between freeze and unfreeze yet.

Thanks,
Kuai
>>>
>>
> 
> .
> 

