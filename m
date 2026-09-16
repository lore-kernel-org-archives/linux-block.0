Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56353D9556
	for <linux-block@vger.kernel.org>; Wed, 16 Sep 2026 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789598900; cv=none; b=e76vqUKyr1lNz88H0lCJEPZumBsZl3H4rVCzAciY3FvRWTxIKGxF6Mo3FzLFD3ChpJVnhBado6OYHm+vnT7JfJ8nGJv2m0bY4aCGAVKysREehQMHaQWb6/Y6bVtRAkFvBdeyvMxez4YyTZ72lV6+KFRd2NahpqXUEUFemu5SHe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789598900; c=relaxed/simple;
	bh=4+2JBpGMQEs3P2SiD4EYWbuWFdlcM6kXscUUA88i+fo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gdd6wqf9+MHlCxJgwavMhXH4BEQ9p7gEDGrKU/mrR2dv7ltVUyxe458z3SrCfCs3pD3VT9wgzXE8vkTwnj4z6P9/K6tSaPf+Veljpc2CNETkpJqOTi/GoXZHBMgba6b/ppFGgVKxPBrkuiRoD8JguXMvxaZutB0x0WPZQfdwmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 68GMlUGI068960;
	Thu, 17 Sep 2026 07:47:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 68GMlTUW068956
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 17 Sep 2026 07:47:29 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <aae44539-837a-4f75-9af5-694ecfd10784@I-love.SAKURA.ne.jp>
Date: Thu, 17 Sep 2026 07:47:26 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH 2/2] loop: Perform __loop_clr_fd() after disk->open_mutex
 is dropped
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nilay Shroff <nilay@linux.ibm.com>
References: <cover.1789587960.git.bvanassche@acm.org>
 <cb1383e61e1b4d63906deb9a947f781416282939.1789587960.git.bvanassche@acm.org>
Content-Language: en-US
In-Reply-To: <cb1383e61e1b4d63906deb9a947f781416282939.1789587960.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav111.rs.sakura.ne.jp

On 2026/09/17 4:51, Bart Van Assche wrote:
> In order to prevent NULL pointer dereferences in lo_rw_aio() when tearing
> down a loop device, outstanding I/O must be flushed before clearing the
> backing file and device state. However, calling blk_mq_wait_quiesce_done(),
> drain_workqueue(), or blk_mq_freeze_queue() with disk->open_mutex held
> causes lockdep warnings and potential deadlocks.
> 
> Use the .post_release() block device operation to execute __loop_clr_fd()
> synchronously after disk->open_mutex has been released by the block layer.
> Inside __loop_clr_fd(), outstanding I/O is flushed and the request queue
> is frozen before acquiring disk->open_mutex to perform the remaining
> device teardown and partition rescans.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Nacked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Please stop stealing my series and stop proposing broken series.
Instead of spreading lies claiming that my patch series hasn't been working,
please answer my questions.

Your proposed patch introduces a critical concurrency regression that results in
kernel crash (NULL-filp dereference).

Since .post_release is called entirely outside of disk->open_mutex, multiple
non-final close() threads can concurrently invoke lo_post_release() and race
inside __loop_clr_fd() without any serialization. Specifically, Thread 1 can
nullify lo->lo_backing_file under lo->lo_lock. A concurrent Thread 2 will then
fetch lo_backing_file as NULL, yet immediately attempt to dereference it inside
mapping_set_gfp_mask(filp->f_mapping, ...). This triggers an instantaneous NULL
pointer dereference (Oops) and panics the kernel.

The "post_release() operation is intended for performing only idempotent actions
such as flush_work()" in my series is a requirement. Note that concurrently calling
flush_work() from lo_post_release() is safe.

> ---
>  drivers/block/loop.c | 51 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 758c20678bf6..d3e686bebcd3 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1138,11 +1138,33 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>  
>  static void __loop_clr_fd(struct loop_device *lo)
>  {
> +	struct gendisk *disk = lo->lo_disk;
>  	struct queue_limits lim;
>  	struct file *filp;
>  	gfp_t gfp = lo->old_gfp_mask;
> +	unsigned int memflags;
>  	int err;
>  
> +	WARN_ON_ONCE(READ_ONCE(lo->lo_state) != Lo_rundown);
> +
> +	/*
> +	 * Wait for ongoing loop_queue_rq() calls. Subsequent loop_queue_rq()
> +	 * calls which are made after this call returned will see lo->lo_state
> +	 * != Lo_bound and return with BLK_STS_IOERR.
> +	 */
> +	blk_mq_wait_quiesce_done(&lo->tag_set);
> +
> +	/* loop_queue_rq() queues work on lo->workqueue, hence drain it. */
> +	drain_workqueue(lo->workqueue);
> +
> +	lim = queue_limits_start_update(lo->lo_queue);
> +
> +	/*
> +	 * Freeze the request queue while updating parameters used while
> +	 * processing requests.
> +	 */
> +	memflags = blk_mq_freeze_queue(lo->lo_queue);
> +
>  	spin_lock_irq(&lo->lo_lock);
>  	filp = lo->lo_backing_file;
>  	lo->lo_backing_file = NULL;
> @@ -1153,18 +1175,17 @@ static void __loop_clr_fd(struct loop_device *lo)
>  	lo->lo_sizelimit = 0;
>  	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
>  
> -	/*
> -	 * Reset the block size to the default.
> -	 *
> -	 * No queue freezing needed because this is called from the final
> -	 * ->release call only, so there can't be any outstanding I/O.
> -	 */
> -	lim = queue_limits_start_update(lo->lo_queue);
> +	/* Reset the block size to the default. */
>  	lim.logical_block_size = SECTOR_SIZE;
>  	lim.physical_block_size = SECTOR_SIZE;
>  	lim.io_min = SECTOR_SIZE;
>  	queue_limits_commit_update(lo->lo_queue, &lim);
>  
> +	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
> +
> +	/* Serialize against concurrent bdev_open() calls. */
> +	mutex_lock(&disk->open_mutex);
> +
>  	invalidate_disk(lo->lo_disk);
>  	loop_sysfs_exit(lo);
>  	/* let user-space know about this change */
> @@ -1178,9 +1199,6 @@ static void __loop_clr_fd(struct loop_device *lo)
>  	/*
>  	 * Remove all partitions, including partitions added manually with
>  	 * BLKPG, which may exist even if LO_FLAGS_PARTSCAN is not set.
> -	 *
> -	 * open_mutex has been held already in release path, so don't acquire
> -	 * it here.
>  	 */
>  	err = bdev_disk_changed(lo->lo_disk, false);
>  	if (err)
> @@ -1197,6 +1215,8 @@ static void __loop_clr_fd(struct loop_device *lo)
>  	lo->lo_flags = 0;
>  	if (!part_shift)
>  		set_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
> +	mutex_unlock(&disk->open_mutex);
> +
>  	mutex_lock(&lo->lo_mutex);
>  	WRITE_ONCE(lo->lo_state, Lo_unbound);
>  	mutex_unlock(&lo->lo_mutex);
> @@ -1754,7 +1774,6 @@ static int lo_open(struct gendisk *disk, blk_mode_t mode)
>  static void lo_release(struct gendisk *disk)
>  {
>  	struct loop_device *lo = disk->private_data;
> -	bool need_clear = false;
>  
>  	if (disk_openers(disk) > 0)
>  		return;
> @@ -1767,11 +1786,14 @@ static void lo_release(struct gendisk *disk)
>  	mutex_lock(&lo->lo_mutex);
>  	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR))
>  		WRITE_ONCE(lo->lo_state, Lo_rundown);
> -
> -	need_clear = (lo->lo_state == Lo_rundown);
>  	mutex_unlock(&lo->lo_mutex);
> +}
> +
> +static void lo_post_release(struct gendisk *disk)
> +{
> +	struct loop_device *lo = disk->private_data;
>  
> -	if (need_clear)
> +	if (READ_ONCE(lo->lo_state) == Lo_rundown)
>  		__loop_clr_fd(lo);
>  }
>  
> @@ -1791,6 +1813,7 @@ static const struct block_device_operations lo_fops = {
>  	.owner =	THIS_MODULE,
>  	.open =         lo_open,
>  	.release =	lo_release,
> +	.post_release = lo_post_release,
>  	.ioctl =	lo_ioctl,
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl =	lo_compat_ioctl,

