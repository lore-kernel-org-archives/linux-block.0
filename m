Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107F41EA73
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 02:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081451; cv=none; b=RkOzlVNRL/KBT5ZcnkoHJ8lFAuFyZvn5FsF8Z2MxVzUkjFTsVuWtHf4UVFDtKEQkFAT4noFPEHsb3aOepjmfLpCmmicVUPDhhcmEiO8DYhthbheYIFzV6QAFMT7813HmCSVKO0H41jJWd/r/Zbrr2HDbjYp1o5C74AKzyvMyX1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081451; c=relaxed/simple;
	bh=Rb2WaBHzRO/NZ+VyH6n+CwrdI0GOxX9ATA7169Z1LB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QIeStOEW7vs+ZDRuj0Da0TjPZBh+PcMsjsDPXo0wT3WIHIfLAwGfVBzCMnNWa91Pb6YanFbnVWYxgAyn95GxYE9HxgmYiKhA5BaphE/H4/LPsWglNoibhUKYY+e3fiwaZDDM9PaU4M4EB5qI1E8S/xBhE3FRsG5ihCV8CIj5buE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XcH0W2SHQz4f3lVg
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 10:10:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BCF9C1A08FC
	for <linux-block@vger.kernel.org>; Mon, 28 Oct 2024 10:10:37 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4eb8h5nvqeWAA--.172S3;
	Mon, 28 Oct 2024 10:10:37 +0800 (CST)
Message-ID: <717f69f3-fe7c-ced7-6947-5a974c663af1@huaweicloud.com>
Date: Mon, 28 Oct 2024 10:10:35 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] brd: fix null pointer when modprobe brd
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
 ulf.hansson@linaro.org, hch@lst.de, houtao1@huawei.com,
 penguin-kernel@i-love.sakura.ne.jp
Cc: linux-block@vger.kernel.org, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20241025070511.932879-1-yangerkun@huaweicloud.com>
 <a15f07a9-d95d-3282-659d-ccd32ac19311@huaweicloud.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <a15f07a9-d95d-3282-659d-ccd32ac19311@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4eb8h5nvqeWAA--.172S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWxurW5Kw48tr13Ww17ZFb_yoW3Ww1UpF
	4kGrW8trW5Crn3Gr4UXr1UXFyrJr40qa1kXr18XF10yr47Ar1vqr1UXryjgr1UArW8JF18
	Ar15Jrn7ZF1rJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/10/25 15:59, Yu Kuai 写道:
> Hi,
> 
> 在 2024/10/25 15:05, Yang Erkun 写道:
>> From: Yang Erkun <yangerkun@huawei.com>
>>
>> My colleague Wupeng found the following problems during fault injection:
>>
>> BUG: unable to handle page fault for address: fffffbfff809d073
>> PGD 6e648067 P4D 123ec8067 PUD 123ec4067 PMD 100e38067 PTE 0
>> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
>> CPU: 5 UID: 0 PID: 755 Comm: modprobe Not tainted 6.12.0-rc3+ #17
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> 1.16.1-2.fc37 04/01/2014
>> RIP: 0010:__asan_load8+0x4c/0xa0
>> ...
>> Call Trace:
>>   <TASK>
>>   blkdev_put_whole+0x41/0x70
>>   bdev_release+0x1a3/0x250
>>   blkdev_release+0x11/0x20
>>   __fput+0x1d7/0x4a0
>>   task_work_run+0xfc/0x180
>>   syscall_exit_to_user_mode+0x1de/0x1f0
>>   do_syscall_64+0x6b/0x170
>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> The error path of modprobe will ignores the refcnt for the module, and
>> directly releases everything about this all associated resources. For
>> the brd module, it can be brd_fops. The brd_init function attempts to
>> create 16 ramdisks; each time add_disk is called, a file for the block
>> device is created to help do partition scanning and remains alive util
>> we return to userspace(Also we can open it with another user thread).
>> Let's say brd_init has successfully create the first ramdisk, but fail
>> to create the second, the error handling path will release code segment.
>> Consequently, bdev_release for file of first ramdisk will trigger null
>> pointer since brd_fops has been removed.
>>
>> To resolve issue, implement a solution similar to loop_init, and
>> reintroduce brd_devices_mutex to help serialize modifications to
>> brd_list.
>>
> 
> This patch looks good to me, just some nits below:
> 
>> Fixes: 7f9b348cb5e9 ("brd: convert to blk_alloc_disk/blk_cleanup_disk")
>> Reported-by: Wupeng Ma <mawupeng1@huawei.com>
>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>> ---
>>   drivers/block/brd.c | 70 ++++++++++++++++++++-------------------------
>>   1 file changed, 31 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
>> index 2fd1ed101748..f86dd0795d3c 100644
>> --- a/drivers/block/brd.c
>> +++ b/drivers/block/brd.c
>> @@ -316,6 +316,7 @@ __setup("ramdisk_size=", ramdisk_size);
>>    * (should share code eventually).
>>    */
>>   static LIST_HEAD(brd_devices);
>> +static DEFINE_MUTEX(brd_devices_mutex);
>>   static struct dentry *brd_debugfs_dir;
>>   static int brd_alloc(int i)
>> @@ -340,14 +341,21 @@ static int brd_alloc(int i)
>>                         BLK_FEAT_NOWAIT,
>>       };
>> -    list_for_each_entry(brd, &brd_devices, brd_list)
>> -        if (brd->brd_number == i)
>> +    mutex_lock(&brd_devices_mutex);
>> +    list_for_each_entry(brd, &brd_devices, brd_list) {
>> +        if (brd->brd_number == i) {
>> +            mutex_unlock(&brd_devices_mutex);
>>               return -EEXIST;
>> +        }
>> +    }
>>       brd = kzalloc(sizeof(*brd), GFP_KERNEL);
>> -    if (!brd)
>> +    if (!brd) {
>> +        mutex_unlock(&brd_devices_mutex);
>>           return -ENOMEM;
>> +    }
>>       brd->brd_number        = i;
>>       list_add_tail(&brd->brd_list, &brd_devices);
>> +    mutex_unlock(&brd_devices_mutex);
>>       xa_init(&brd->brd_pages);
> 
> The global mutex is used to protect brd_alloc() from module init and
> brd_alloc() from creating on open? If so, I think just use the lock in
> the caller is cleaner.

Yes, it appears cleaner. However, is it a little too long to hold the
mutex lock, considering that brd_alloc in brd_init can occur
concurrently with brd_prbe? See f7bf35862477 ("brd: reduce the
brd_devices_mutex scope")

> 
>> @@ -378,7 +386,9 @@ static int brd_alloc(int i)
>>   out_cleanup_disk:
>>       put_disk(disk);
>>   out_free_dev:
>> +    mutex_lock(&brd_devices_mutex);
>>       list_del(&brd->brd_list);
>> +    mutex_unlock(&brd_devices_mutex);
>>       kfree(brd);
>>       return err;
>>   }
>> @@ -388,21 +398,6 @@ static void brd_probe(dev_t dev)
>>       brd_alloc(MINOR(dev) / max_part);
>>   }
>> -static void brd_cleanup(void)
>> -{
>> -    struct brd_device *brd, *next;
>> -
>> -    debugfs_remove_recursive(brd_debugfs_dir);
>> -
>> -    list_for_each_entry_safe(brd, next, &brd_devices, brd_list) {
>> -        del_gendisk(brd->brd_disk);
>> -        put_disk(brd->brd_disk);
>> -        brd_free_pages(brd);
>> -        list_del(&brd->brd_list);
>> -        kfree(brd);
>> -    }
>> -}
>> -
>>   static inline void brd_check_and_reset_par(void)
>>   {
>>       if (unlikely(!max_part))
>> @@ -424,17 +419,7 @@ static inline void brd_check_and_reset_par(void)
>>   static int __init brd_init(void)
>>   {
>> -    int err, i;
>> -
>> -    brd_check_and_reset_par();
>> -
>> -    brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
>> -
>> -    for (i = 0; i < rd_nr; i++) {
>> -        err = brd_alloc(i);
>> -        if (err)
>> -            goto out_free;
>> -    }
>> +    int i;
>>       /*
>>        * brd module now has a feature to instantiate underlying device
>> @@ -450,28 +435,35 @@ static int __init brd_init(void)
>>        *    If (X / max_part) was not already created it will be created
>>        *    dynamically.
>>        */
>> +    brd_check_and_reset_par();
>> +    brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
>>       if (__register_blkdev(RAMDISK_MAJOR, "ramdisk", brd_probe)) {
>> -        err = -EIO;
>> -        goto out_free;
>> +        pr_info("brd: module NOT loaded !!!\n");
>> +        debugfs_remove_recursive(brd_debugfs_dir);
>> +        return -EIO;
>>       }
>> +    for (i = 0; i < rd_nr; i++)
>> +        brd_alloc(i);
> 
> Now that brd_alloc() can fail while loding the module will succed,
> please also add err log if brd_alloc() failed.

OK

>> +
>>       pr_info("brd: module loaded\n");
>>       return 0;
>> -
>> -out_free:
>> -    brd_cleanup();
>> -
>> -    pr_info("brd: module NOT loaded !!!\n");
>> -    return err;
>>   }
>>   static void __exit brd_exit(void)
>>   {
>> +    struct brd_device *brd, *next;
>>       unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
>> -    brd_cleanup();
>> -
>> +    debugfs_remove_recursive(brd_debugfs_dir);
>> +    list_for_each_entry_safe(brd, next, &brd_devices, brd_list) {
>> +        del_gendisk(brd->brd_disk);
>> +        put_disk(brd->brd_disk);
>> +        brd_free_pages(brd);
>> +        list_del(&brd->brd_list);
>> +        kfree(brd);
>> +    }
> 
> Why the global mutex is not used here? It took a while for me to figure
> out that this is safe, because unregister_blkdev() make sure no new
> brd_alloc() can be called from open path, and in progress open will be
> synchronized with del_gendisk().
Yes

> 
> However, please add some comments or just hold the global mutex.

OK

> 
> Thanks,
> Kuai
> 
>>       pr_info("brd: module unloaded\n");
>>   }
>>

