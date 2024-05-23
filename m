Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68CE3B29D;
	Thu, 23 May 2024 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449953; cv=none; b=djWcaasql6qeF++EM/vqElg93Pkoo3KbeX2am9PthL32HnoZtTS709B0uGrHFdHk1fcIzFrhLXYrVR8QmKHFUw17hXTNVKH4G9esBNq+YSVV5w8LTxrXb0Z4ooA18PrzCyIzp8SFOCKTa1y/SOE9W+XbpxKbaIc6NJ8r4KHkrQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449953; c=relaxed/simple;
	bh=XINoD2jDM7KnhgAunmyNnPEZhhA7jX+YzC5sUZ14+fg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=npVWS43xfE4jLyRrokpcwXTjV33HR3uBPWTeyf9KHPDgLDHuRlS4+yQ7TQOMOKmGcR5wizbCAjYUtHRYrRdpMNA6h1AdxCoiLNjOC2biAOtPDslneNm23TBup7jy70PEVulgmchoJdBEAB1kb7jERG7HUh/7yVwPt4pmBilRk7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VlKmZ0TTTz4f3jZD;
	Thu, 23 May 2024 15:38:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DD2381A017F;
	Thu, 23 May 2024 15:38:59 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g6Q8k5mIvzCNQ--.53707S3;
	Thu, 23 May 2024 15:38:58 +0800 (CST)
Subject: Re: [PATCH RESEND] null_blk: fix null-ptr-dereference while
 configuring 'power' and 'submit_queues'
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Yu Kuai <yukuai1@huaweicloud.com>,
 axboe@kernel.dk, yi.zhang@redhat.com, dlemoal@kernel.org, hare@suse.de,
 johannes.thumshirn@wdc.com, kch@nvidia.com, zhouchengming@bytedance.com,
 bvanassche@acm.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240523144536.1376904-1-yukuai1@huaweicloud.com>
 <c30465e7-ced2-4732-993f-9d9eba2f8403@linux.dev>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <e725aae5-bd31-b5f3-53e5-48cd585abf1d@huaweicloud.com>
Date: Thu, 23 May 2024 15:38:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c30465e7-ced2-4732-993f-9d9eba2f8403@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g6Q8k5mIvzCNQ--.53707S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar1DJr18XF4rGry3AFW3trb_yoW3JF1UpF
	4kGFWUGryjgF1kJw1Utr1UGFy5Jr1UZ3WDGr1xJFyUJr4UZr1jqr1UXryYgr1UJ3y8Gr4U
	XF1UXrsrZF1UXrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/05/23 15:34, Zhu Yanjun 写道:
> 
> On 23.05.24 16:45, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Writing 'power' and 'submit_queues' concurrently will trigger kernel
>> panic:
>>
>> Test script:
>>
>> modprobe null_blk nr_devices=0
>> mkdir -p /sys/kernel/config/nullb/nullb0
>> while true; do echo 1 > submit_queues; echo 4 > submit_queues; done &
>> while true; do echo 1 > power; echo 0 > power; done
>>
>> Test result:
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000148
>> Oops: 0000 [#1] PREEMPT SMP
>> RIP: 0010:__lock_acquire+0x41d/0x28f0
>> Call Trace:
>>   <TASK>
>>   lock_acquire+0x121/0x450
>>   down_write+0x5f/0x1d0
>>   simple_recursive_removal+0x12f/0x5c0
>>   blk_mq_debugfs_unregister_hctxs+0x7c/0x100
>>   blk_mq_update_nr_hw_queues+0x4a3/0x720
>>   nullb_update_nr_hw_queues+0x71/0xf0 [null_blk]
>>   nullb_device_submit_queues_store+0x79/0xf0 [null_blk]
>>   configfs_write_iter+0x119/0x1e0
>>   vfs_write+0x326/0x730
>>   ksys_write+0x74/0x150
>>
>> This is because del_gendisk() can concurrent with
>> blk_mq_update_nr_hw_queues():
>>
>> nullb_device_power_store    nullb_apply_submit_queues
>>   null_del_dev
>>   del_gendisk
>>                  nullb_update_nr_hw_queues
>>                   if (!dev->nullb)
>>                   // still set while gendisk is deleted
>>                    return 0
>>                   blk_mq_update_nr_hw_queues
>>   dev->nullb = NULL
>>
>> Fix this problem by resuing the global mutex to protect
>> nullb_device_power_store() and nullb_update_nr_hw_queues() from configs.
>>
>> Fixes: 45919fbfe1c4 ("null_blk: Enable modifying 'submit_queues' after 
>> an instance has been configured")
>> Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
>> Closes: 
>> https://lore.kernel.org/all/CAHj4cs9LgsHLnjg8z06LQ3Pr5cax-+Ps+xT7AP7TPnEjStuwZA@mail.gmail.com/ 
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   drivers/block/loop.c          |  2 +-
>>   drivers/block/null_blk/main.c | 40 +++++++++++++++++++++++------------
>>   2 files changed, 27 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 28a95fd366fe..3e1c4f5ef714 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -2140,7 +2140,7 @@ static int loop_control_remove(int idx)
>>           pr_warn_once("deleting an unspecified loop device is not 
>> supported.\n");
>>           return -EINVAL;
>>       }
>> -
>> +
> 
> This snippet changes nothing. Can we remove it?

Of course this should be removed... it's tail space here, however,
it's not related to this patch, and I somehow merged into this patch...

Will send a v2.

Thanks,
Kuai

> 
> Zhu Yanjun
> 
>>       /* Hide this loop device for serialization. */
>>       ret = mutex_lock_killable(&loop_ctl_mutex);
>>       if (ret)
>> diff --git a/drivers/block/null_blk/main.c 
>> b/drivers/block/null_blk/main.c
>> index 5d56ad4ce01a..eb023d267369 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -413,13 +413,25 @@ static int nullb_update_nr_hw_queues(struct 
>> nullb_device *dev,
>>   static int nullb_apply_submit_queues(struct nullb_device *dev,
>>                        unsigned int submit_queues)
>>   {
>> -    return nullb_update_nr_hw_queues(dev, submit_queues, 
>> dev->poll_queues);
>> +    int ret;
>> +
>> +    mutex_lock(&lock);
>> +    ret = nullb_update_nr_hw_queues(dev, submit_queues, 
>> dev->poll_queues);
>> +    mutex_unlock(&lock);
>> +
>> +    return ret;
>>   }
>>   static int nullb_apply_poll_queues(struct nullb_device *dev,
>>                      unsigned int poll_queues)
>>   {
>> -    return nullb_update_nr_hw_queues(dev, dev->submit_queues, 
>> poll_queues);
>> +    int ret;
>> +
>> +    mutex_lock(&lock);
>> +    ret = nullb_update_nr_hw_queues(dev, dev->submit_queues, 
>> poll_queues);
>> +    mutex_unlock(&lock);
>> +
>> +    return ret;
>>   }
>>   NULLB_DEVICE_ATTR(size, ulong, NULL);
>> @@ -468,28 +480,31 @@ static ssize_t nullb_device_power_store(struct 
>> config_item *item,
>>       if (ret < 0)
>>           return ret;
>> +    ret = count;
>> +    mutex_lock(&lock);
>>       if (!dev->power && newp) {
>>           if (test_and_set_bit(NULLB_DEV_FL_UP, &dev->flags))
>> -            return count;
>> +            goto out;
>> +
>>           ret = null_add_dev(dev);
>>           if (ret) {
>>               clear_bit(NULLB_DEV_FL_UP, &dev->flags);
>> -            return ret;
>> +            goto out;
>>           }
>>           set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
>>           dev->power = newp;
>>       } else if (dev->power && !newp) {
>>           if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
>> -            mutex_lock(&lock);
>>               dev->power = newp;
>>               null_del_dev(dev->nullb);
>> -            mutex_unlock(&lock);
>>           }
>>           clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
>>       }
>> -    return count;
>> +out:
>> +    mutex_unlock(&lock);
>> +    return ret;
>>   }
>>   CONFIGFS_ATTR(nullb_device_, power);
>> @@ -1932,15 +1947,12 @@ static int null_add_dev(struct nullb_device *dev)
>>       nullb->q->queuedata = nullb;
>>       blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
>> -    mutex_lock(&lock);
>>       rv = ida_alloc(&nullb_indexes, GFP_KERNEL);
>> -    if (rv < 0) {
>> -        mutex_unlock(&lock);
>> +    if (rv < 0)
>>           goto out_cleanup_disk;
>> -    }
>> +
>>       nullb->index = rv;
>>       dev->index = rv;
>> -    mutex_unlock(&lock);
>>       if (config_item_name(&dev->group.cg_item)) {
>>           /* Use configfs dir name as the device name */
>> @@ -1969,9 +1981,7 @@ static int null_add_dev(struct nullb_device *dev)
>>       if (rv)
>>           goto out_ida_free;
>> -    mutex_lock(&lock);
>>       list_add_tail(&nullb->list, &nullb_list);
>> -    mutex_unlock(&lock);
>>       pr_info("disk %s created\n", nullb->disk_name);
>> @@ -2020,7 +2030,9 @@ static int null_create_dev(void)
>>       if (!dev)
>>           return -ENOMEM;
>> +    mutex_lock(&lock);
>>       ret = null_add_dev(dev);
>> +    mutex_unlock(&lock);
>>       if (ret) {
>>           null_free_dev(dev);
>>           return ret;
> 

