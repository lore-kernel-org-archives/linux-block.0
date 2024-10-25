Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C1E1BA89C
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843168; cv=none; b=b63+nmN6BApdhelgaYySSCQAmDai4nZtAbh70n2VpeOlyaNULVRcaLHz2VWA1enqFwH7sSe5u5tPQp3zZPE8PwKTnYsOlJjXVfWIJ72XekJrm4VA/X6SWAMAZS6QeMgKlKdF6PyL/4cBBXMA2gWk4i500IFgYXNggeiaJUcpQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843168; c=relaxed/simple;
	bh=fPziT4WjxgqvrhBCtTL/dtt0L6hI0cUt6Y+F2fEKz+Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VPuDsS0CVE9kL9ncgHk/72aXcO3ur2nuEEHlWn46R4cHrMJn9Z2zEjvW//jO1Qy2M/fy1gEuus4KTuDA/IEmr9DsSQRbZ917IaJ9GPflUmGN9QNEAtbs0Rtgff8PxeQvU09Mzpu4rn7npBgvhIcgvFnLq/oxxdcys/wy80h7Vk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XZZtH3wT6z4f3jY9
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 15:59:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 109801A07BA
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 15:59:21 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8fYTxtnkOREFA--.6912S3;
	Fri, 25 Oct 2024 15:59:20 +0800 (CST)
Subject: Re: [PATCH] brd: fix null pointer when modprobe brd
To: Yang Erkun <yangerkun@huaweicloud.com>, axboe@kernel.dk,
 ulf.hansson@linaro.org, hch@lst.de, houtao1@huawei.com,
 penguin-kernel@i-love.sakura.ne.jp
Cc: linux-block@vger.kernel.org, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20241025070511.932879-1-yangerkun@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <a15f07a9-d95d-3282-659d-ccd32ac19311@huaweicloud.com>
Date: Fri, 25 Oct 2024 15:59:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241025070511.932879-1-yangerkun@huaweicloud.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+8fYTxtnkOREFA--.6912S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWruw4DKry5ZF1kZrWUurg_yoWxJrW8pa
	y3GFZ3trWrAr1fKw4UX3WDuFyfJan293y8X3Wxur1I9r48Ar9ava4xtryjqry8CrWkAF48
	ZFy5tr4kuFyFk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/10/25 15:05, Yang Erkun Ð´µÀ:
> From: Yang Erkun <yangerkun@huawei.com>
> 
> My colleague Wupeng found the following problems during fault injection:
> 
> BUG: unable to handle page fault for address: fffffbfff809d073
> PGD 6e648067 P4D 123ec8067 PUD 123ec4067 PMD 100e38067 PTE 0
> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 5 UID: 0 PID: 755 Comm: modprobe Not tainted 6.12.0-rc3+ #17
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.16.1-2.fc37 04/01/2014
> RIP: 0010:__asan_load8+0x4c/0xa0
> ...
> Call Trace:
>   <TASK>
>   blkdev_put_whole+0x41/0x70
>   bdev_release+0x1a3/0x250
>   blkdev_release+0x11/0x20
>   __fput+0x1d7/0x4a0
>   task_work_run+0xfc/0x180
>   syscall_exit_to_user_mode+0x1de/0x1f0
>   do_syscall_64+0x6b/0x170
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The error path of modprobe will ignores the refcnt for the module, and
> directly releases everything about this all associated resources. For
> the brd module, it can be brd_fops. The brd_init function attempts to
> create 16 ramdisks; each time add_disk is called, a file for the block
> device is created to help do partition scanning and remains alive util
> we return to userspace(Also we can open it with another user thread).
> Let's say brd_init has successfully create the first ramdisk, but fail
> to create the second, the error handling path will release code segment.
> Consequently, bdev_release for file of first ramdisk will trigger null
> pointer since brd_fops has been removed.
> 
> To resolve issue, implement a solution similar to loop_init, and
> reintroduce brd_devices_mutex to help serialize modifications to
> brd_list.
> 

This patch looks good to me, just some nits below:

> Fixes: 7f9b348cb5e9 ("brd: convert to blk_alloc_disk/blk_cleanup_disk")
> Reported-by: Wupeng Ma <mawupeng1@huawei.com>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> ---
>   drivers/block/brd.c | 70 ++++++++++++++++++++-------------------------
>   1 file changed, 31 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 2fd1ed101748..f86dd0795d3c 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -316,6 +316,7 @@ __setup("ramdisk_size=", ramdisk_size);
>    * (should share code eventually).
>    */
>   static LIST_HEAD(brd_devices);
> +static DEFINE_MUTEX(brd_devices_mutex);
>   static struct dentry *brd_debugfs_dir;
>   
>   static int brd_alloc(int i)
> @@ -340,14 +341,21 @@ static int brd_alloc(int i)
>   					  BLK_FEAT_NOWAIT,
>   	};
>   
> -	list_for_each_entry(brd, &brd_devices, brd_list)
> -		if (brd->brd_number == i)
> +	mutex_lock(&brd_devices_mutex);
> +	list_for_each_entry(brd, &brd_devices, brd_list) {
> +		if (brd->brd_number == i) {
> +			mutex_unlock(&brd_devices_mutex);
>   			return -EEXIST;
> +		}
> +	}
>   	brd = kzalloc(sizeof(*brd), GFP_KERNEL);
> -	if (!brd)
> +	if (!brd) {
> +		mutex_unlock(&brd_devices_mutex);
>   		return -ENOMEM;
> +	}
>   	brd->brd_number		= i;
>   	list_add_tail(&brd->brd_list, &brd_devices);
> +	mutex_unlock(&brd_devices_mutex);
>   
>   	xa_init(&brd->brd_pages);

The global mutex is used to protect brd_alloc() from module init and
brd_alloc() from creating on open? If so, I think just use the lock in
the caller is cleaner.

>   
> @@ -378,7 +386,9 @@ static int brd_alloc(int i)
>   out_cleanup_disk:
>   	put_disk(disk);
>   out_free_dev:
> +	mutex_lock(&brd_devices_mutex);
>   	list_del(&brd->brd_list);
> +	mutex_unlock(&brd_devices_mutex);
>   	kfree(brd);
>   	return err;
>   }
> @@ -388,21 +398,6 @@ static void brd_probe(dev_t dev)
>   	brd_alloc(MINOR(dev) / max_part);
>   }
>   
> -static void brd_cleanup(void)
> -{
> -	struct brd_device *brd, *next;
> -
> -	debugfs_remove_recursive(brd_debugfs_dir);
> -
> -	list_for_each_entry_safe(brd, next, &brd_devices, brd_list) {
> -		del_gendisk(brd->brd_disk);
> -		put_disk(brd->brd_disk);
> -		brd_free_pages(brd);
> -		list_del(&brd->brd_list);
> -		kfree(brd);
> -	}
> -}
> -
>   static inline void brd_check_and_reset_par(void)
>   {
>   	if (unlikely(!max_part))
> @@ -424,17 +419,7 @@ static inline void brd_check_and_reset_par(void)
>   
>   static int __init brd_init(void)
>   {
> -	int err, i;
> -
> -	brd_check_and_reset_par();
> -
> -	brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
> -
> -	for (i = 0; i < rd_nr; i++) {
> -		err = brd_alloc(i);
> -		if (err)
> -			goto out_free;
> -	}
> +	int i;
>   
>   	/*
>   	 * brd module now has a feature to instantiate underlying device
> @@ -450,28 +435,35 @@ static int __init brd_init(void)
>   	 *	If (X / max_part) was not already created it will be created
>   	 *	dynamically.
>   	 */
> +	brd_check_and_reset_par();
> +	brd_debugfs_dir = debugfs_create_dir("ramdisk_pages", NULL);
>   
>   	if (__register_blkdev(RAMDISK_MAJOR, "ramdisk", brd_probe)) {
> -		err = -EIO;
> -		goto out_free;
> +		pr_info("brd: module NOT loaded !!!\n");
> +		debugfs_remove_recursive(brd_debugfs_dir);
> +		return -EIO;
>   	}
>   
> +	for (i = 0; i < rd_nr; i++)
> +		brd_alloc(i);

Now that brd_alloc() can fail while loding the module will succed,
please also add err log if brd_alloc() failed.
> +
>   	pr_info("brd: module loaded\n");
>   	return 0;
> -
> -out_free:
> -	brd_cleanup();
> -
> -	pr_info("brd: module NOT loaded !!!\n");
> -	return err;
>   }
>   
>   static void __exit brd_exit(void)
>   {
> +	struct brd_device *brd, *next;
>   
>   	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
> -	brd_cleanup();
> -
> +	debugfs_remove_recursive(brd_debugfs_dir);
> +	list_for_each_entry_safe(brd, next, &brd_devices, brd_list) {
> +		del_gendisk(brd->brd_disk);
> +		put_disk(brd->brd_disk);
> +		brd_free_pages(brd);
> +		list_del(&brd->brd_list);
> +		kfree(brd);
> +	}

Why the global mutex is not used here? It took a while for me to figure
out that this is safe, because unregister_blkdev() make sure no new
brd_alloc() can be called from open path, and in progress open will be
synchronized with del_gendisk().

However, please add some comments or just hold the global mutex.

Thanks,
Kuai

>   	pr_info("brd: module unloaded\n");
>   }
>   
> 

