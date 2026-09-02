Received: from mta0.migadu.com (out-22.mta0.migadu.com [91.218.175.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799638CFE7
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330979; cv=none; b=THO6xb/4R//D5SYDKZMT8p7JpC4tWkFdTTY7YSoPd5GmWUgHmVW535pNSUHswGjgcX6Db0HndY4i+VvkhlsYZAiHwwK6Ubh3lcLniOwDfc3SYRbaMlf67gDHbGR+unDtv9tGyCCQIes1nhqZwnwiFK6qPEYpwNH19XnJehTz7Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330979; c=relaxed/simple;
	bh=O5KS5q5kowuwRNhVBilCCDdZNkUSPi5it2ZSZRGWyl8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dxt/JsOpNTJz/2Squ5Fx+ppPByUoFmmNbSy133nDRUFKfIXaNtDs82n5eSk8AyQM+Vn9DCKu8sYjmlUPEItPAL+2I6YBlDqgGGF9UfJHf+EC31DWD57g3TJd2YQHjXrkN/29HGUMF02c5N0SbBNgNtARo2NpIGgv5VTj04OSUHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gBoRVk1T; arc=none smtp.client-ip=91.218.175.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gBoRVk1T"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O5KS5q5kowuwRNhVBilCCDdZNkUSPi5it2ZSZRGWyl8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788330974; v=1; x=1788935774;
 b=gBoRVk1T19a7vBkifysRN2wXZ4/WH+RiqftqNhW0j7tV2AbGDrRwwYV6bGBJ/xHhfVVCdH4t
 xUx9IOGu042abdokDF4kdtqIrJ1KwKFj18DYbHrOR4DGesAIkh7icmsHOL77uo7blLkKSceFRyY
 0A+RnwJaZ9KmVUo23nWeb8P4=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id db4f6236f35008cd;
	Wed, 02 Sep 2026 06:36:14 +0000
X-Mizu-Trace-ID: db4f6236f35008cd
X-Migadu-Flow: FLOW_OUT
Message-ID: <73b3b4d6-888a-4621-8a7c-7914fa2c5fc6@linux.dev>
Date: Wed, 2 Sep 2026 14:36:08 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2] loop: defer the queue limits clear to a workqueue
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20260902063420.882203-1-cui.tao@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260902063420.882203-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi. Bart, 

在 2026/9/2 14:34, Tao Cui 写道:
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
> The code already has an XXX comment saying this should move to a
> workqueue.  Do that: schedule a work item on the system workqueue,
> where it is safe to freeze the queue and update the limits using
> queue_limits_commit_update_frozen().  Accumulate pending modes in
> lo->clear_limits_mode so that failures between scheduling and
> execution of the work item are not lost, reset the accumulated
> modes when a new backing file is assigned, and cancel the work
> item before the device is freed.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> 
> ---
> Changes since v1:
> 
> - Make clear_limits_mode atomic_t: loop workers can hit the |=
>   concurrently.
> 
> - Reset clear_limits_mode when assigning a new backing file, so
>   stale modes do not clear limits of the new file.
> 
> - Cancel the work item from loop_remove() before del_gendisk():
>   the queue can already be in RCU-delayed freeing when
>   lo_free_disk() cancels it.
> 
> Tested on x86-64 (qemu, vfat-backed loop device): 30s discard and
> reconfigure loop exercises the clear 577 times, no torn sysfs reads,
> no difference against the unpatched kernel.
> 

thanks for the Reviewed-by on v1.

v2 makes clear_limits_mode atomic, resets it on rebind, and
cancels the work item from loop_remove().  The code changed, so
could you take another look when you have time?

Thanks,
Tao

> Link: https://lore.kernel.org/r/20260828072004.273519-1-cui.tao@linux.dev/
> ---
>  drivers/block/loop.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 6f12976035b0..368ea857895c 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -67,6 +67,8 @@ struct loop_device {
>  	struct list_head        rootcg_cmd_list;
>  	struct list_head        idle_worker_list;
>  	struct rb_root          worker_tree;
> +	struct work_struct      clear_limits_work;
> +	atomic_t		clear_limits_mode;
>  	struct timer_list       timer;
>  	bool			sysfs_inited;
>  
> @@ -222,9 +224,12 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
>  		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
>  }
>  
> -static void loop_clear_limits(struct loop_device *lo, int mode)
> +static void loop_clear_limits_workfn(struct work_struct *work)
>  {
> +	struct loop_device *lo =
> +		container_of(work, struct loop_device, clear_limits_work);
>  	struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
> +	int mode = atomic_xchg(&lo->clear_limits_mode, 0);
>  
>  	if (mode & FALLOC_FL_ZERO_RANGE)
>  		lim.max_write_zeroes_sectors = 0;
> @@ -234,14 +239,13 @@ static void loop_clear_limits(struct loop_device *lo, int mode)
>  		lim.discard_granularity = 0;
>  	}
>  
> -	/*
> -	 * XXX: this updates the queue limits without freezing the queue, which
> -	 * is against the locking protocol and dangerous.  But we can't just
> -	 * freeze the queue as we're inside the ->queue_rq method here.  So this
> -	 * should move out into a workqueue unless we get the file operations to
> -	 * advertise if they support specific fallocate operations.
> -	 */
> -	queue_limits_commit_update(lo->lo_queue, &lim);
> +	queue_limits_commit_update_frozen(lo->lo_queue, &lim);
> +}
> +
> +static void loop_clear_limits(struct loop_device *lo, int mode)
> +{
> +	atomic_or(mode, &lo->clear_limits_mode);
> +	schedule_work(&lo->clear_limits_work);
>  }
>  
>  static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
> @@ -516,6 +520,7 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
>  static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
>  {
>  	lo->lo_backing_file = file;
> +	atomic_set(&lo->clear_limits_mode, 0);
>  	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
>  	mapping_set_gfp_mask(file->f_mapping,
>  			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
> @@ -1781,6 +1786,7 @@ static void lo_free_disk(struct gendisk *disk)
>  		destroy_workqueue(lo->workqueue);
>  	loop_free_idle_workers(lo, true);
>  	timer_shutdown_sync(&lo->timer);
> +	cancel_work_sync(&lo->clear_limits_work);
>  	mutex_destroy(&lo->lo_mutex);
>  	kfree(lo);
>  }
> @@ -2100,6 +2106,7 @@ static int loop_add(int i)
>  	spin_lock_init(&lo->lo_lock);
>  	spin_lock_init(&lo->lo_work_lock);
>  	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
> +	INIT_WORK(&lo->clear_limits_work, loop_clear_limits_workfn);
>  	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
>  	disk->major		= LOOP_MAJOR;
>  	disk->first_minor	= i << part_shift;
> @@ -2138,6 +2145,10 @@ static int loop_add(int i)
>  
>  static void loop_remove(struct loop_device *lo)
>  {
> +	/* Cancel early: the queue may be in RCU-delayed freeing
> +	 * by the time lo_free_disk() runs. */
> +	cancel_work_sync(&lo->clear_limits_work);
> +
>  	/* Make this loop device unreachable from pathname. */
>  	del_gendisk(lo->lo_disk);
>  	blk_mq_free_tag_set(&lo->tag_set);

