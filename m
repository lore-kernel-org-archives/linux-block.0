Received: from mta0.migadu.com (out-31.mta0.migadu.com [91.218.175.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBB42DF138
	for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245941; cv=none; b=Yjjc8F527tuG5TAaUBssvnHbHi5pPqHk0Km1UbFmKkQcrKhDoW4SSon0p724DZ8K0VNGdPiY4sbR3cBmRsrPD191iDfvAtcH4JbYhTMfvoqRCWn6nYrIH54jaxASFu0IwqUvS1K/3OI6NANvgCxVJTk3ZYGTp5ulSNbkrvaYSLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245941; c=relaxed/simple;
	bh=ObZcquRpx4x09nCPiDX6i/CHCCMMhKjGvOEeNB6yuZc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F5qxZBBRgNL3L/MfH5EFKo+ZMSjjmZNjnfAX1HP1MLUfmHQsCNAHWsY35CRKwNjQ1Quw6+cI6WpBTqJSQykNoypANDdCiz1yH6WWMDNyQVNNix7r+givLGlLoPIy7GLylPehE/veH6dxe0o3xZ451af4bOkTUVNf6BOT/nNyErQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cDe9sJdZ; arc=none smtp.client-ip=91.218.175.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cDe9sJdZ"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ObZcquRpx4x09nCPiDX6i/CHCCMMhKjGvOEeNB6yuZc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790245937; v=1; x=1790850737;
 b=cDe9sJdZXTpjyok5ljrQkbmMQodvtDWC6IVx7X10yHq6efYtvN5QQ3BNjKBGlYKyVGsGgly0
 0ujoUrA0HCwu/D33bVV2rjxhohTlVTD0WS27G1b5jrBNqI236Ua52PPj/aPojptPMx3H+djgvZa
 A5a5QPIypGqS+ahyvx7CuC8g=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e39e4bbfa92ee16f;
	Thu, 24 Sep 2026 10:32:16 +0000
X-Mizu-Trace-ID: e39e4bbfa92ee16f
X-Migadu-Flow: FLOW_OUT
Message-ID: <446b50ad-f41d-4e08-ad33-45da37193560@linux.dev>
Date: Thu, 24 Sep 2026 18:32:13 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, cuitao@kylinos.cn, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loop: defer the queue limits clear to a workqueue
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20260924102027.2307044-1-cui.tao@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260924102027.2307044-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/24 18:20, Tao Cui 写道:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> loop_clear_limits() calls queue_limits_commit_update() directly from
> the loop workqueue that processes the request.  That does a
> non-atomic struct assignment to q->limits without freezing the queue,
> which races with lockless readers of q->limits on other CPUs - bio
> splitting reads max_hw_sectors, the discard path reads
> max_hw_discard_sectors - and can let them observe torn values.  The
> trigger is a discard or write-zeroes request on a loop device whose
> backing file does not support the corresponding fallocate operation.
> 

Oops, I messed up the subject, that was supposed to be [PATCH v5].
The patch in it is the final version: rebased as a single commit,
plus one fix over v4, clear_limits_lock now covers the limits
commit too, since the queue freeze is counted and doesn't exclude
a concurrent loop_change_fd(). Please ignore the subject and treat
it as v5.

Sorry for the noise,
Tao.

> The code already has an XXX comment saying this should move to a
> workqueue.  Do that: schedule a work item on the system workqueue, where
> it is safe to freeze the queue around the limits update.  The pending
> modes and the rebind generation live under a new mutex,
> lo->clear_limits_lock.  The work item takes the mutex with the queue
> frozen and holds it over the limits commit, so a rebind cannot slip
> in between the generation check and the commit.  Rebinding the
> device drops the accumulated modes and invalidates an already
> scheduled work item, so a stale clear cannot hit the new backing
> file.  The work item is cancelled before the device is freed.
> 
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> 
> ---
> Changes since v4:
> 
> - Rebase onto the current block tree as a single commit.
> 
> - Hold clear_limits_lock over the limits commit in the work item.
>   The queue freeze is counted, not mutually exclusive, so
>   loop_change_fd() could rebind between the generation check and
>   the commit, and a stale clear could disable discard and write
>   zeroes on the new backing file.
> 
> Changes since v3:
> 
> - Replace the three atomic variables (clear_limits_mode, rebind_gen,
>   clear_limits_gen) with plain variables protected by a new
>   clear_limits_lock mutex, as suggested by Bart.  The mutex is taken
>   after the queue freeze in the work item, which keeps the same
>   freeze -> mutex ordering as loop_change_fd(), the only rebinding
>   path that freezes the queue.
> 
> Changes since v2:
> 
> - Skip the clear when the device was rebound since the work item
>   was scheduled: the modes used to be captured before the freeze,
>   so a LOOP_CHANGE_FD completing in between could apply the old
>   modes to the new backing file.  The rebind generation is now
>   checked with the queue frozen, which excludes loop_change_fd()
>   because it assigns the new backing file under the same freeze,
>   so a rebind cannot slip in between the check and the commit.
>   Cancelling from loop_assign_backing_file() would instead
>   deadlock on the freeze held by loop_change_fd().
> 
> - Also bump the rebind generation from __loop_clr_fd(): unbinding
>   does not go through loop_assign_backing_file(), so a work item
>   scheduled before the last close could otherwise commit a stale
>   clear to the queue limits of the unbound device.
> 
> Changes since v1:
> 
> - Reset clear_limits_mode when assigning a new backing file, so
>   stale modes do not clear limits of the new file.
> 
> - Cancel the work item from loop_remove() before del_gendisk():
>   the queue can already be in RCU-delayed freeing when
>   lo_free_disk() cancels it.
> 
> Tested on x86-64 (qemu, vfat-backed loop device): a 30s discard and
> reconfigure loop exercises the clear path 288 times, no torn sysfs
> reads, no difference against the unpatched kernel.
> 
> Link: https://lore.kernel.org/r/20260828072004.273519-1-cui.tao@linux.dev/
> ---
>  drivers/block/loop.c | 83 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 69 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 758c20678bf6c..0b89036c982ad 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -67,6 +67,11 @@ struct loop_device {
>  	struct list_head        rootcg_cmd_list;
>  	struct list_head        idle_worker_list;
>  	struct rb_root          worker_tree;
> +	struct work_struct      clear_limits_work;
> +	struct mutex		clear_limits_lock;
> +	unsigned int		clear_limits_mode;
> +	unsigned int		rebind_gen;
> +	unsigned int		clear_limits_gen;
>  	struct timer_list       timer;
>  	bool			sysfs_inited;
>  
> @@ -222,26 +227,53 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
>  		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
>  }
>  
> -static void loop_clear_limits(struct loop_device *lo, int mode)
> +static void loop_clear_limits_workfn(struct work_struct *work)
>  {
> +	struct loop_device *lo =
> +		container_of(work, struct loop_device, clear_limits_work);
>  	struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
> -
> -	if (mode & FALLOC_FL_ZERO_RANGE)
> -		lim.max_write_zeroes_sectors = 0;
> -
> -	if (mode & FALLOC_FL_PUNCH_HOLE) {
> -		lim.max_hw_discard_sectors = 0;
> -		lim.discard_granularity = 0;
> -	}
> +	unsigned int memflags;
> +	int mode = 0;
>  
>  	/*
> -	 * XXX: this updates the queue limits without freezing the queue, which
> -	 * is against the locking protocol and dangerous.  But we can't just
> -	 * freeze the queue as we're inside the ->queue_rq method here.  So this
> -	 * should move out into a workqueue unless we get the file operations to
> -	 * advertise if they support specific fallocate operations.
> +	 * Commit the unmodified limits if the device was rebound since
> +	 * the work item was scheduled.  The freeze does not exclude a
> +	 * rebind through loop_change_fd(), which freezes the queue
> +	 * itself, so hold clear_limits_lock over the generation check
> +	 * and the commit: loop_assign_backing_file() bumps rebind_gen
> +	 * under the same mutex, so a rebind either precedes the check
> +	 * or follows the commit, and a stale clear cannot hit the new
> +	 * backing file.  The other rebinding paths, loop_configure()
> +	 * and __loop_clr_fd(), bump rebind_gen under the same mutex
> +	 * without freezing the queue; the generation check detects
> +	 * them as well.
>  	 */
> +	memflags = blk_mq_freeze_queue(lo->lo_queue);
> +	mutex_lock(&lo->clear_limits_lock);
> +	if (lo->clear_limits_gen == lo->rebind_gen) {
> +		mode = lo->clear_limits_mode;
> +		lo->clear_limits_mode = 0;
> +
> +		if (mode & FALLOC_FL_ZERO_RANGE)
> +			lim.max_write_zeroes_sectors = 0;
> +
> +		if (mode & FALLOC_FL_PUNCH_HOLE) {
> +			lim.max_hw_discard_sectors = 0;
> +			lim.discard_granularity = 0;
> +		}
> +	}
>  	queue_limits_commit_update(lo->lo_queue, &lim);
> +	mutex_unlock(&lo->clear_limits_lock);
> +	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
> +}
> +
> +static void loop_clear_limits(struct loop_device *lo, int mode)
> +{
> +	mutex_lock(&lo->clear_limits_lock);
> +	lo->clear_limits_gen = lo->rebind_gen;
> +	lo->clear_limits_mode |= mode;
> +	mutex_unlock(&lo->clear_limits_lock);
> +	schedule_work(&lo->clear_limits_work);
>  }
>  
>  static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
> @@ -518,6 +550,10 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
>  static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
>  {
>  	lo->lo_backing_file = file;
> +	mutex_lock(&lo->clear_limits_lock);
> +	lo->rebind_gen++;
> +	lo->clear_limits_mode = 0;
> +	mutex_unlock(&lo->clear_limits_lock);
>  	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
>  	mapping_set_gfp_mask(file->f_mapping,
>  			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
> @@ -1148,6 +1184,15 @@ static void __loop_clr_fd(struct loop_device *lo)
>  	lo->lo_backing_file = NULL;
>  	spin_unlock_irq(&lo->lo_lock);
>  
> +	/*
> +	 * Invalidate any pending clear that was scheduled against the old
> +	 * backing file, like loop_assign_backing_file() does on rebind.
> +	 */
> +	mutex_lock(&lo->clear_limits_lock);
> +	lo->rebind_gen++;
> +	lo->clear_limits_mode = 0;
> +	mutex_unlock(&lo->clear_limits_lock);
> +
>  	lo->lo_device = NULL;
>  	lo->lo_offset = 0;
>  	lo->lo_sizelimit = 0;
> @@ -1783,7 +1828,9 @@ static void lo_free_disk(struct gendisk *disk)
>  		destroy_workqueue(lo->workqueue);
>  	loop_free_idle_workers(lo, true);
>  	timer_shutdown_sync(&lo->timer);
> +	cancel_work_sync(&lo->clear_limits_work);
>  	mutex_destroy(&lo->lo_mutex);
> +	mutex_destroy(&lo->clear_limits_lock);
>  	kfree(lo);
>  }
>  
> @@ -2102,6 +2149,8 @@ static int loop_add(int i)
>  	spin_lock_init(&lo->lo_lock);
>  	spin_lock_init(&lo->lo_work_lock);
>  	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
> +	INIT_WORK(&lo->clear_limits_work, loop_clear_limits_workfn);
> +	mutex_init(&lo->clear_limits_lock);
>  	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
>  	disk->major		= LOOP_MAJOR;
>  	disk->first_minor	= i << part_shift;
> @@ -2140,6 +2189,12 @@ static int loop_add(int i)
>  
>  static void loop_remove(struct loop_device *lo)
>  {
> +	/*
> +	 * Cancel early: the queue may already be in RCU-delayed freeing
> +	 * by the time lo_free_disk() cancels the work item.
> +	 */
> +	cancel_work_sync(&lo->clear_limits_work);
> +
>  	/* Make this loop device unreachable from pathname. */
>  	del_gendisk(lo->lo_disk);
>  	blk_mq_free_tag_set(&lo->tag_set);

