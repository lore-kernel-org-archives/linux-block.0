Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9C0213E83
	for <linux-block@vger.kernel.org>; Mon, 31 Mar 2025 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743430266; cv=none; b=tLrIlZDEPfeP2EMw48QzMOdu8Dab8t4HaGKgsLaCEShrRhoQyBHcUfJbVuI2WQU0nlv7Jh49hqnGSJQNTDhvTX9Q9RxmC6RGAnCOVqVB6S6+5FegSa0DjuWW68PLYiIwQdASiz9+hTFV0G6/EoPNzw9bW4JWPGMMSUeJuEw5NfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743430266; c=relaxed/simple;
	bh=o6YiP+hfdJ1vSNRtwyyAk/naULoqj66JwmyD1tDu4q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzZQZ9bZt2LuHF4eBB2BDtrUO9ALKjZPiA1BDSLnjBhPT9ZjezRFFxJWxoLbtrJHWz10yncuK+Ng8uEw16T1NsOnO6mrNeESrIom/iSPFESogOhTcVnBQ4t3s58nGeddmC2HQpp5JLK01EcDF58RitY7TnInC80Njrp9FKE24s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kycF3tPT; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kycF3tPT"
Message-ID: <d9a00203-a744-4d9e-b86a-51703e1a135a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743430252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WY9rTWqlWYUdXrsjV4+jqRxNBOZeu76XLfJnw4sSWRc=;
	b=kycF3tPT9QrKetZdCxdw8Hlpcrq3xkS3oFLWKWa4AZVtrJ4rQAVk9v3GoOnPUA9EF74lrD
	BhLnfNE+2PVHO3zW4vlovcYDPzHBaQ2nv6v3APhj0iOtCRlB2CyIVHNZ8scBr3+FPTw2nZ
	jlGDcxcw5Wva4Q9iOHNHjHpWiR+6XOs=
Date: Mon, 31 Mar 2025 16:10:47 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V4 for-6.10/block] loop: Fix a race between loop detach
 and loop open
To: Gulam Mohamed <gulam.mohamed@oracle.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com, hch@lst.de, axboe@kernel.dk
References: <20240607190607.17705-1-gulam.mohamed@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240607190607.17705-1-gulam.mohamed@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 07.06.24 21:06, Gulam Mohamed wrote:
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
> Fix:
> Defer the detach of loop device to release function, which is called
> when the last close happens, by setting the lo_flags to LO_FLAGS_AUTOCLEAR
> at the time of detach i.e in loop_clr_fd() function.
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

This is for v6.10 stable, should add "Cc: stable@vger.kernel.org"?
So the engineers who work the stable branch can find this commit and 
apply it?

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
> v4<-v3:
> 1. Defer the loop detach to last close of loop device
> 2. Removed the use of lo_open due to following reasons:
> 
> Setting the lo_state to Lo_rundown in loop_clr_fd() may not help in
> stopping the incoming open(), when the loop is being detached, as the
> open() could invoke the lo_open() before the lo_state is set to Lo_rundown
> and increment the disk_openers refcnt later.
> As the actual cleanup is deferred to last close, in release, there is no
> chance for the open() to kick in to take the reference. Because both open()
> and release() are protected by open_mutex and hence they cannot run in
> parallel.
> So, lo_open() and setting lo_state to Lo_rundown is not needed. Removing
> the loop state Lo_rundown as its not used anymore.
> 
>   drivers/block/loop.c | 44 ++++++++------------------------------------
>   1 file changed, 8 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 28a95fd366fe..4936cadc1a63 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -41,7 +41,6 @@
>   enum {
>   	Lo_unbound,
>   	Lo_bound,
> -	Lo_rundown,
>   	Lo_deleting,
>   };
>   
> @@ -1131,7 +1130,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>   	return error;
>   }
>   
> -static void __loop_clr_fd(struct loop_device *lo, bool release)
> +static void __loop_clr_fd(struct loop_device *lo)
>   {
>   	struct file *filp;
>   	gfp_t gfp = lo->old_gfp_mask;
> @@ -1139,14 +1138,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
>   	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
>   		blk_queue_write_cache(lo->lo_queue, false, false);
>   
> -	/*
> -	 * Freeze the request queue when unbinding on a live file descriptor and
> -	 * thus an open device.  When called from ->release we are guaranteed
> -	 * that there is no I/O in progress already.
> -	 */
> -	if (!release)
> -		blk_mq_freeze_queue(lo->lo_queue);
> -
>   	spin_lock_irq(&lo->lo_lock);
>   	filp = lo->lo_backing_file;
>   	lo->lo_backing_file = NULL;
> @@ -1164,8 +1155,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
>   	mapping_set_gfp_mask(filp->f_mapping, gfp);
>   	/* This is safe: open() is still holding a reference. */
>   	module_put(THIS_MODULE);
> -	if (!release)
> -		blk_mq_unfreeze_queue(lo->lo_queue);
>   
>   	disk_force_media_change(lo->lo_disk);
>   
> @@ -1180,11 +1169,7 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
>   		 * must be at least one and it can only become zero when the
>   		 * current holder is released.
>   		 */
> -		if (!release)
> -			mutex_lock(&lo->lo_disk->open_mutex);
>   		err = bdev_disk_changed(lo->lo_disk, false);
> -		if (!release)
> -			mutex_unlock(&lo->lo_disk->open_mutex);
>   		if (err)
>   			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
>   				__func__, lo->lo_number, err);
> @@ -1232,25 +1217,8 @@ static int loop_clr_fd(struct loop_device *lo)
>   		loop_global_unlock(lo, true);
>   		return -ENXIO;
>   	}
> -	/*
> -	 * If we've explicitly asked to tear down the loop device,
> -	 * and it has an elevated reference count, set it for auto-teardown when
> -	 * the last reference goes away. This stops $!~#$@ udev from
> -	 * preventing teardown because it decided that it needs to run blkid on
> -	 * the loopback device whenever they appear. xfstests is notorious for
> -	 * failing tests because blkid via udev races with a losetup
> -	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
> -	 * command to fail with EBUSY.
> -	 */
> -	if (disk_openers(lo->lo_disk) > 1) {
> -		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
> -		loop_global_unlock(lo, true);
> -		return 0;
> -	}
> -	lo->lo_state = Lo_rundown;
> +	lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
>   	loop_global_unlock(lo, true);
> -
> -	__loop_clr_fd(lo, false);
>   	return 0;
>   }
>   
> @@ -1724,15 +1692,19 @@ static void lo_release(struct gendisk *disk)
>   	if (disk_openers(disk) > 0)
>   		return;
>   
> +	/*
> +	 * Clear the backing device information if this is the last close of
> +	 * a device that's been marked for auto clear, or on which LOOP_CLR_FD
> +	 * has been called.
> +	 */
>   	mutex_lock(&lo->lo_mutex);
>   	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR)) {
> -		lo->lo_state = Lo_rundown;
>   		mutex_unlock(&lo->lo_mutex);
>   		/*
>   		 * In autoclear mode, stop the loop thread
>   		 * and remove configuration after last close.
>   		 */
> -		__loop_clr_fd(lo, true);
> +		__loop_clr_fd(lo);
>   		return;
>   	}
>   	mutex_unlock(&lo->lo_mutex);

