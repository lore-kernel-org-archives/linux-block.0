Received: from mta1.migadu.com (out-121.mta1.migadu.com [95.215.58.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6812391E74
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341227; cv=none; b=DVYd3o8pS6sM+TTq9W1qG1xf1vtA5Y0qPf46gsEi6/BGD4IR1U5pfJJnoA0edggmFuL/NqX2WAOyndngRP5CVt6MXfSP2jPVWXJAmCagkPp/T3ee0Om/QQhB/cN7geiDNWm5icOyj3bAfi8oj5JmwAuM5aNzepCHzYKE4FJ5Pxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341227; c=relaxed/simple;
	bh=FrnRx/lksd+m1WnHb7nL4LYhqD1uQNCEMSy08kbSkPA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rw9npRZmYmKu/MeBxdUEjVCGAiJJU9JAFecsl1j3+rwspC8zGIrcsQ6hPkNoG1MhtNIO6C3x9gXblKIze8Us1SQgQ3bnzKMaCzQYHRnPVQMj17qDRBh+gA5rVkSujJ+/ZAvQP2j/bZ5XlsSrS3GcigUQt7PVjUkX97YItMpSf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sCu6k1HR; arc=none smtp.client-ip=95.215.58.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sCu6k1HR"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FrnRx/lksd+m1WnHb7nL4LYhqD1uQNCEMSy08kbSkPA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788341219; v=1; x=1788946019;
 b=sCu6k1HRbGdoUdFOJK3/wL7wWhLztFO97qZnGX17iL5R8LA4uN/+Oq+jrReCbb8gqL8PqyZY
 AWGkaGVJeqDedxDmFcY+jzYEaVSGluBVX5zlJFZTEBxZwHBEYSpHDa1s5vMmFSg+CSLJNueLCf4
 sTZVR0PJ3VugE6YDlhgwwc9M=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1d33ce7253b1fe9e;
	Wed, 02 Sep 2026 09:26:59 +0000
X-Mizu-Trace-ID: 1d33ce7253b1fe9e
X-Migadu-Flow: FLOW_OUT
Message-ID: <46f7e025-1ca5-41cd-846f-8554cd7fb313@linux.dev>
Date: Wed, 2 Sep 2026 17:26:52 +0800
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
 <73b3b4d6-888a-4621-8a7c-7914fa2c5fc6@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <73b3b4d6-888a-4621-8a7c-7914fa2c5fc6@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/2 14:36, Tao Cui 写道:
> Hi. Bart, 
> 
> 在 2026/9/2 14:34, Tao Cui 写道:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> loop_clear_limits() calls queue_limits_commit_update() directly from
>> the loop workqueue that processes the request.  That does a
>> non-atomic struct assignment to q->limits without freezing the queue,
>> which races with lockless readers of q->limits on other CPUs - bio
>> splitting reads max_hw_sectors, the discard path reads
>> max_hw_discard_sectors - and can let them observe torn values.  The
>> trigger is a discard or write-zeroes request on a loop device whose
>> backing file does not support the corresponding fallocate operation.
>>
>> The code already has an XXX comment saying this should move to a
>> workqueue.  Do that: schedule a work item on the system workqueue,
>> where it is safe to freeze the queue and update the limits using
>> queue_limits_commit_update_frozen().  Accumulate pending modes in
>> lo->clear_limits_mode so that failures between scheduling and
>> execution of the work item are not lost, reset the accumulated
>> modes when a new backing file is assigned, and cancel the work
>> item before the device is freed.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>>
>> ---
>> Changes since v1:
>>
>> - Make clear_limits_mode atomic_t: loop workers can hit the |=
>>   concurrently.
>>
>> - Reset clear_limits_mode when assigning a new backing file, so
>>   stale modes do not clear limits of the new file.
>>
>> - Cancel the work item from loop_remove() before del_gendisk():
>>   the queue can already be in RCU-delayed freeing when
>>   lo_free_disk() cancels it.
>>
>> Tested on x86-64 (qemu, vfat-backed loop device): 30s discard and
>> reconfigure loop exercises the clear 577 times, no torn sysfs reads,
>> no difference against the unpatched kernel.
>>
> 
> thanks for the Reviewed-by on v1.
> 
> v2 makes clear_limits_mode atomic, resets it on rebind, and
> cancels the work item from loop_remove().  The code changed, so
> could you take another look when you have time?
> 

I went through the latest sashiko report on v2; its four inline
comments are two issues.

The cancellation issue (marked on loop_remove() and
lo_free_disk()) is not reachable: loop_control_remove() only
accepts a device that is Lo_unbound with zero openers (loop.c,
-EBUSY otherwise), and a bound device also holds a module
reference from loop_configure(), so loop_remove() never sees
in-flight I/O that could reschedule the work item during
del_gendisk().  The cancel in lo_free_disk() therefore never
waits on a running instance.

The mode-capture issue (marked on the atomic_xchg() and the
reset) is real.  It is the window the v1 commit message already
described: the work item takes the modes with atomic_xchg()
before it enters the freeze inside
queue_limits_commit_update_frozen(), so a LOOP_CHANGE_FD that
completes in between gets the old modes applied to the new
backing file, and discard stays off until the next reconfigure.
v2 only fixed the persistent half of it.  Cancelling from
loop_assign_backing_file() is not an option, as the work item may
be blocked on the very freeze that loop_change_fd() holds, and
cancel_work_sync() would deadlock.

The fix is a rebind generation counter: capture it when
scheduling, skip the clear in the work item when it changed.  I'll
send a v3 with that.

---
Tao

> Thanks,
> Tao
> 
>> Link: https://lore.kernel.org/r/20260828072004.273519-1-cui.tao@linux.dev/
>> ---
>>  drivers/block/loop.c | 29 ++++++++++++++++++++---------
>>  1 file changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 6f12976035b0..368ea857895c 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -67,6 +67,8 @@ struct loop_device {
>>  	struct list_head        rootcg_cmd_list;
>>  	struct list_head        idle_worker_list;
>>  	struct rb_root          worker_tree;
>> +	struct work_struct      clear_limits_work;
>> +	atomic_t		clear_limits_mode;
>>  	struct timer_list       timer;
>>  	bool			sysfs_inited;
>>  
>> @@ -222,9 +224,12 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
>>  		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
>>  }
>>  
>> -static void loop_clear_limits(struct loop_device *lo, int mode)
>> +static void loop_clear_limits_workfn(struct work_struct *work)
>>  {
>> +	struct loop_device *lo =
>> +		container_of(work, struct loop_device, clear_limits_work);
>>  	struct queue_limits lim = queue_limits_start_update(lo->lo_queue);
>> +	int mode = atomic_xchg(&lo->clear_limits_mode, 0);
>>  
>>  	if (mode & FALLOC_FL_ZERO_RANGE)
>>  		lim.max_write_zeroes_sectors = 0;
>> @@ -234,14 +239,13 @@ static void loop_clear_limits(struct loop_device *lo, int mode)
>>  		lim.discard_granularity = 0;
>>  	}
>>  
>> -	/*
>> -	 * XXX: this updates the queue limits without freezing the queue, which
>> -	 * is against the locking protocol and dangerous.  But we can't just
>> -	 * freeze the queue as we're inside the ->queue_rq method here.  So this
>> -	 * should move out into a workqueue unless we get the file operations to
>> -	 * advertise if they support specific fallocate operations.
>> -	 */
>> -	queue_limits_commit_update(lo->lo_queue, &lim);
>> +	queue_limits_commit_update_frozen(lo->lo_queue, &lim);
>> +}
>> +
>> +static void loop_clear_limits(struct loop_device *lo, int mode)
>> +{
>> +	atomic_or(mode, &lo->clear_limits_mode);
>> +	schedule_work(&lo->clear_limits_work);
>>  }
>>  
>>  static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
>> @@ -516,6 +520,7 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
>>  static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
>>  {
>>  	lo->lo_backing_file = file;
>> +	atomic_set(&lo->clear_limits_mode, 0);
>>  	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
>>  	mapping_set_gfp_mask(file->f_mapping,
>>  			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
>> @@ -1781,6 +1786,7 @@ static void lo_free_disk(struct gendisk *disk)
>>  		destroy_workqueue(lo->workqueue);
>>  	loop_free_idle_workers(lo, true);
>>  	timer_shutdown_sync(&lo->timer);
>> +	cancel_work_sync(&lo->clear_limits_work);
>>  	mutex_destroy(&lo->lo_mutex);
>>  	kfree(lo);
>>  }
>> @@ -2100,6 +2106,7 @@ static int loop_add(int i)
>>  	spin_lock_init(&lo->lo_lock);
>>  	spin_lock_init(&lo->lo_work_lock);
>>  	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
>> +	INIT_WORK(&lo->clear_limits_work, loop_clear_limits_workfn);
>>  	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
>>  	disk->major		= LOOP_MAJOR;
>>  	disk->first_minor	= i << part_shift;
>> @@ -2138,6 +2145,10 @@ static int loop_add(int i)
>>  
>>  static void loop_remove(struct loop_device *lo)
>>  {
>> +	/* Cancel early: the queue may be in RCU-delayed freeing
>> +	 * by the time lo_free_disk() runs. */
>> +	cancel_work_sync(&lo->clear_limits_work);
>> +
>>  	/* Make this loop device unreachable from pathname. */
>>  	del_gendisk(lo->lo_disk);
>>  	blk_mq_free_tag_set(&lo->tag_set);
> 

