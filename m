Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CDC1632E7
	for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 02:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786759638; cv=none; b=iRlmstB32Lr5nPI31QfmWPnBV6C/tcNBZRTqTWA+Q4tlqK6l6wQV1xm58bWo2yghUV6rhHzlW+ZMJv9IqdLdsP1AVGaCyTt7gIRjyAi66IYOQcUuMCAhuNAZn5IF/yRU1aHv26GdKJbmm0vG9Ck3uzJIKg0U7t0S3gxgRx0JbxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786759638; c=relaxed/simple;
	bh=Q2a5ZcCPbsCZ/5jg31PhFGnD0Fi5Vp/Tk8Gpb3zi8NM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HrL98Sl/lxjoO48c8neKAAoLSBuG6LJkCMQMlVjUFzQg9t1zUj4m6Dv4EaexOMbCWoQS0SLNa4UKU0tiXwh9gvzNSUlQ+b09AxM0NHuwCplGYYMQThyUuS5S1GT+St0pViTvCRzJIOgijnCcs8ydZUtUoEECDDdQ9w926DL3Ht0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hMMsw2JN3zYQtpf
	for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 10:07:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B579D40750
	for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 10:07:09 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP3 (Coremail) with UTF8SMTPSA id _Ch0CgC3pkXMyX9qc_JrCQ--.6508S3;
	Sat, 15 Aug 2026 10:07:09 +0800 (CST)
Message-ID: <4591d9cc-3dcb-46b8-833e-4a98a0bbdc8e@huaweicloud.com>
Date: Sat, 15 Aug 2026 10:07:08 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: serialize configfs attribute updates with
 device setup
To: Niklas Cassel <cassel@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Shaohua Li <shli@fb.com>, Kyungchan Koh <kkc6196@fb.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
 syzbot+643a6dd130546afdf1fb@syzkaller.appspotmail.com,
 linux-block@vger.kernel.org
References: <20260813141456.1625857-2-cassel@kernel.org>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20260813141456.1625857-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgC3pkXMyX9qc_JrCQ--.6508S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww47ZFW3Cry5ur4fur18Grg_yoWxAr4rpF
	W0ga1Ygry8GF17Za4qvw1DuFy5Cw1kZryxGryfA34fC3WDZr9YyryvkF45X3W8G3ykCF4r
	Xa1DuFsxCFWUur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UpyxiUUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

Hi Niklas,

在 2026/8/13 22:14, Niklas Cassel 写道:
> The attribute store methods generated with NULLB_DEVICE_ATTR() refuse to
> change the configuration of a live device by testing
> NULLB_DEV_FL_CONFIGURED, but that flag is only set by
> nullb_device_power_store() after null_add_dev() has returned, and the
> store methods take no lock at all. configfs only serializes writes to
> the same open file (buffer->mutex), so a write to any attribute can run
> concurrently with null_add_dev() and change the device configuration
> while it is being used.
> 
> null_add_dev() reads the configuration several times, e.g. dev->zoned is
> read once to set up the queue limits and once to initialize the zone
> resources:
> 
>    CPU0: echo 1 > nullb0/power         CPU1: echo 1 > nullb0/zoned
>    nullb_device_power_store()
>      mutex_lock(&lock)
>      null_add_dev()
>        if (dev->zoned) -> false
>          /* no BLK_FEAT_ZONED */       nullb_device_zoned_store()
>                                          test_bit(FL_CONFIGURED) -> 0
>                                          dev->zoned = true
>        blk_mq_alloc_disk()
>          /* queue is not zoned */
>        if (nullb->dev->zoned) -> true
>          null_register_zoned_dev()
>            blk_revalidate_disk_zones()
> 
> blk_revalidate_disk_zones() is then called for a queue that does not
> have BLK_FEAT_ZONED set, which triggers its WARN_ON_ONCE() and fails the
> device setup with -EIO:
> 
>    WARNING: CPU: 2 PID: 322 at block/blk-zoned.c:2357 blk_revalidate_disk_zones+0x4c/0x560
> 
> Clearing dev->zoned in the same window is worse: the queue is created
> with BLK_FEAT_ZONED but the zone resources are never initialized, so
> add_disk() succeeds for a zoned disk that has no zones. And a store that
> lands after the last dev->zoned test leaves dev->zoned set while
> dev->zones is still NULL, which null_process_zoned_cmd() dereferences on
> the first write.
> 
> Fix this by taking the global lock, which nullb_device_power_store()
> already holds across null_add_dev() and null_del_dev(), around both the
> NULLB_DEV_FL_CONFIGURED test and the update of the device configuration.
> The submit_queues and poll_queues apply callbacks are now called with
> that lock held, so remove the locking they did themselves.
> 
> Since the store methods can run as soon as configfs_register_subsystem()
> returns, that is, before null_init() gets to mutex_init(&lock), also
> initialize the lock statically with DEFINE_MUTEX().
> 
> Fixes: 3bf2bd20734e ("nullb: add configfs interface")
> Reported-by: syzbot+643a6dd130546afdf1fb@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-block/6a7d0b3f.ac361c09.22ff0a.004c.GAE@google.com/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/block/null_blk/main.c | 39 ++++++++++++++++-------------------
>   1 file changed, 18 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index f8c0fd57e041..2e8f99873956 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -66,7 +66,7 @@ struct nullb_page {
>   #define NULLB_PAGE_FREE (MAP_SZ - 2)
>   
>   static LIST_HEAD(nullb_list);
> -static struct mutex lock;
> +static DEFINE_MUTEX(lock);
>   static int null_major;
>   static DEFINE_IDA(nullb_indexes);
>   static struct blk_mq_tag_set tag_set;
> @@ -340,7 +340,15 @@ static ssize_t nullb_device_bool_attr_store(bool *val, const char *page,
>   	return count;
>   }
>   
> -/* The following macro should only be used with TYPE = {uint, ulong, bool}. */
> +/*
> + * The following macro should only be used with TYPE = {uint, ulong, bool}.
> + *
> + * The device configuration is modified under the global lock to serialize
> + * attribute changes against null_add_dev() and null_del_dev(): without this,
> + * an attribute could be changed while null_add_dev() is running, that is,
> + * before NULLB_DEV_FL_CONFIGURED is set, which would let null_add_dev()
> + * observe inconsistent values for the device configuration.
> + */
>   #define NULLB_DEVICE_ATTR(NAME, TYPE, APPLY)				\
>   static ssize_t								\
>   nullb_device_##NAME##_show(struct config_item *item, char *page)	\
> @@ -360,13 +368,16 @@ nullb_device_##NAME##_store(struct config_item *item, const char *page,	\
>   	ret = nullb_device_##TYPE##_attr_store(&new_value, page, count);\
>   	if (ret < 0)							\
>   		return ret;						\
> +	mutex_lock(&lock);						\
>   	if (apply_fn)							\
>   		ret = apply_fn(dev, new_value);				\
>   	else if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags)) 	\
>   		ret = -EBUSY;						\
> +	if (ret >= 0)							\
> +		dev->NAME = new_value;					\
> +	mutex_unlock(&lock);						\
>   	if (ret < 0)							\
>   		return ret;						\
> -	dev->NAME = new_value;						\
>   	return count;							\
>   }									\
>   CONFIGFS_ATTR(nullb_device_, NAME);
> @@ -379,6 +390,8 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
>   	struct blk_mq_tag_set *set;
>   	int ret, nr_hw_queues;
>   
> +	lockdep_assert_held(&lock);
> +
>   	if (!dev->nullb)
>   		return 0;
>   
> @@ -421,25 +434,13 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
>   static int nullb_apply_submit_queues(struct nullb_device *dev,
>   				     unsigned int submit_queues)
>   {
> -	int ret;
> -
> -	mutex_lock(&lock);
> -	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
> -	mutex_unlock(&lock);
> -
> -	return ret;
> +	return nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
>   }
>   
>   static int nullb_apply_poll_queues(struct nullb_device *dev,
>   				   unsigned int poll_queues)
>   {
> -	int ret;
> -
> -	mutex_lock(&lock);
> -	ret = nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
> -	mutex_unlock(&lock);
> -
> -	return ret;
> +	return nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
>   }
>   
>   NULLB_DEVICE_ATTR(size, ulong, NULL);
> @@ -2166,8 +2167,6 @@ static int __init null_init(void)
>   	if (ret)
>   		return ret;
>   
> -	mutex_init(&lock);
> -
>   	null_major = register_blkdev(0, "nullb");
>   	if (null_major < 0) {
>   		ret = null_major;
> @@ -2211,8 +2210,6 @@ static void __exit null_exit(void)
>   
>   	if (tag_set.ops)
>   		blk_mq_free_tag_set(&tag_set);
> -
> -	mutex_destroy(&lock);
>   }
>   
>   module_init(null_init);

Thanks for the patch. This issue has already been addressed in my 
null_blk series posted back in July:

https://lore.kernel.org/all/20260725022509.714271-1-
wozizhi@huaweicloud.com/

This includes DEFINE_MUTEX and the serialization, but this series hasn't
been merged yet. It has already collected some Reviewed-by tags, and I'm
hoping it can be picked up for mainline soon.

Thanks,
Zizhi Wo





