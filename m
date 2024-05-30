Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386C8208B8;
	Thu, 30 May 2024 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034779; cv=none; b=EvHd8B+5Z4iDXX8eZ839ec6cRRFwPbRsYSrQeBBhoZqh/PyyMcJwo9GQM43c48fbdB6hDb8/1UFZeR6vIuxY3Pv5xuZliBkTArDoQ4jFNNuaiJ8+HQ5jILBqiuPCgKpQbkEoLhEHzBoNx95jS9jXNSSCtBYomFq2+5ZMyQbADxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034779; c=relaxed/simple;
	bh=I4dthDT81/XC750ot5BC7m03ZhUTSupTYMwzaVFeLUI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Mf2wE9m5PMaLPEBWqxuN41yYy0vIvOKfxu7+W7eLhsEmaIWlnQYGEVKOow4HYiaM7qnH88NiQeRgegU6e90racMV6SfuMzuxxLykJSan9N9KTifAHFA/UEnT45e+Z8NYERFlAVRobdln6Y+m8a5QdPm6Ce2r5RZVKQruwbGY6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VqV38662xz4f3lg1;
	Thu, 30 May 2024 10:05:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AC00A1A0568;
	Thu, 30 May 2024 10:06:07 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBEN31dmICw5OA--.43626S3;
	Thu, 30 May 2024 10:06:07 +0800 (CST)
Subject: Re: [PATCH V3 for-6.10/block] loop: Fix a race between loop detach
 and loop open
To: Gulam Mohamed <gulam.mohamed@oracle.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, hch@lst.de, axboe@kernel.dk,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240529200240.133331-1-gulam.mohamed@oracle.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <06c04f8f-5e67-ca57-6764-32d542cb3e90@huaweicloud.com>
Date: Thu, 30 May 2024 10:06:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240529200240.133331-1-gulam.mohamed@oracle.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBEN31dmICw5OA--.43626S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WFyrGrW5WFW5Jr45Cw1fCrg_yoW7Xw17pF
	WrWayjyFZYgFZ8WasFkF1xu345u3Z2y3yrGry3K34a9r9xXr9IvFy0q34Y9ryUWrW8GFWj
	vF4UXrWUuFW7ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
	DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/05/30 4:02, Gulam Mohamed Ð´µÀ:
> 1. Userspace sends the command "losetup -d" which uses the open() call
>     to open the device
> 2. Kernel receives the ioctl command "LOOP_CLR_FD" which calls the
>     function loop_clr_fd()
> 3. If LOOP_CLR_FD is the first command received at the time, then the
>     AUTOCLEAR flag is not set and deletion of the
>     loop device proceeds ahead and scans the partitions (drop/add
>     partitions)
> 
>          if (disk_openers(lo->lo_disk) > 1) {
>                  lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
>                  loop_global_unlock(lo, true);
>                  return 0;
>          }
> 
>   4. Before scanning partitions, it will check to see if any partition of
>      the loop device is currently opened
>   5. If any partition is opened, then it will return EBUSY:
> 
>      if (disk->open_partitions)
>                  return -EBUSY;
>   6. So, after receiving the "LOOP_CLR_FD" command and just before the above
>      check for open_partitions, if any other command
>      (like blkid) opens any partition of the loop device, then the partition
>      scan will not proceed and EBUSY is returned as shown in above code
>   7. But in "__loop_clr_fd()", this EBUSY error is not propagated
>   8. We have noticed that this is causing the partitions of the loop to
>      remain stale even after the loop device is detached resulting in the
>      IO errors on the partitions
> 
> Fix:
> Re-introduce the lo_open() call to restrict any process to open the loop
> device when its being detached
> 
> Test case involves the following two scripts:
> 
> script1.sh:
> 
> while [ 1 ];
> do
>          losetup -P -f /home/opt/looptest/test10.img
>          blkid /dev/loop0p1
> done
> 
> script2.sh:
> 
> while [ 1 ];
> do
>          losetup -d /dev/loop0
> done
> 
> Without fix, the following IO errors have been observed:
> 
> kernel: __loop_clr_fd: partition scan of loop0 failed (rc=-16)
> kernel: I/O error, dev loop0, sector 20971392 op 0x0:(READ) flags 0x80700
>          phys_seg 1 prio class 0
> kernel: I/O error, dev loop0, sector 108868 op 0x0:(READ) flags 0x0
>          phys_seg 1 prio class 0
> kernel: Buffer I/O error on dev loop0p1, logical block 27201, async page
>          read
> 
> Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> ---
> v3<-v2:
> Re-introduced the loop->lo_refcnt to take care of the case where we race
> when the Lo_rundown is set after the lo_open() function releases the
> lo_mutex lock
> 
>   drivers/block/loop.c | 31 ++++++++++++++++++++++++++-----
>   1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 28a95fd366fe..60f61bf8dbd1 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -49,6 +49,7 @@ struct loop_func_table;
>   
>   struct loop_device {
>   	int		lo_number;
> +	atomic_t        lo_refcnt;
>   	loff_t		lo_offset;
>   	loff_t		lo_sizelimit;
>   	int		lo_flags;
> @@ -1242,7 +1243,7 @@ static int loop_clr_fd(struct loop_device *lo)
>   	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
>   	 * command to fail with EBUSY.
>   	 */
> -	if (disk_openers(lo->lo_disk) > 1) {
> +	if (atomic_read(&lo->lo_refcnt) > 1) {
>   		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
>   		loop_global_unlock(lo, true);
>   		return 0;
> @@ -1717,14 +1718,31 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
>   }
>   #endif
>   
> -static void lo_release(struct gendisk *disk)
> +static int lo_open(struct gendisk *disk, blk_mode_t mode)
>   {
>   	struct loop_device *lo = disk->private_data;
> +	int err;
>   
> -	if (disk_openers(disk) > 0)
> -		return;
> +	err = mutex_lock_killable(&lo->lo_mutex);
> +	if (err)
> +		return err;
> +
> +	if (lo->lo_state == Lo_deleting || lo->lo_state == Lo_rundown)
> +		err = -ENXIO;
> +	else
> +		atomic_inc(&lo->lo_refcnt);
> +	mutex_unlock(&lo->lo_mutex);
> +	return err;
> +}
> +
> +static void lo_release(struct gendisk *disk)
> +{
> +	struct loop_device *lo = disk->private_data;
>   
>   	mutex_lock(&lo->lo_mutex);
> +	if (atomic_dec_return(&lo->lo_refcnt))
> +		goto out_unlock;

So, both add, dec and test are inside the lo_mutex, then there is no
need to use atomic value.

Thanks,
Kuai
> +
>   	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR)) {
>   		lo->lo_state = Lo_rundown;
>   		mutex_unlock(&lo->lo_mutex);
> @@ -1735,6 +1753,7 @@ static void lo_release(struct gendisk *disk)
>   		__loop_clr_fd(lo, true);
>   		return;
>   	}
> +out_unlock:
>   	mutex_unlock(&lo->lo_mutex);
>   }
>   
> @@ -1752,6 +1771,7 @@ static void lo_free_disk(struct gendisk *disk)
>   
>   static const struct block_device_operations lo_fops = {
>   	.owner =	THIS_MODULE,
> +	.open =         lo_open,
>   	.release =	lo_release,
>   	.ioctl =	lo_ioctl,
>   #ifdef CONFIG_COMPAT
> @@ -2064,6 +2084,7 @@ static int loop_add(int i)
>   	 */
>   	if (!part_shift)
>   		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> +	atomic_set(&lo->lo_refcnt, 0);
>   	mutex_init(&lo->lo_mutex);
>   	lo->lo_number		= i;
>   	spin_lock_init(&lo->lo_lock);
> @@ -2158,7 +2179,7 @@ static int loop_control_remove(int idx)
>   	ret = mutex_lock_killable(&lo->lo_mutex);
>   	if (ret)
>   		goto mark_visible;
> -	if (lo->lo_state != Lo_unbound || disk_openers(lo->lo_disk) > 0) {
> +	if (lo->lo_state != Lo_unbound || atomic_read(&lo->lo_refcnt) > 0) {
>   		mutex_unlock(&lo->lo_mutex);
>   		ret = -EBUSY;
>   		goto mark_visible;
> 

