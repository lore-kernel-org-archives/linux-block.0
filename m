Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572131AAB4
	for <linux-block@vger.kernel.org>; Mon, 15 Dec 2025 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765782777; cv=none; b=DE80OvYopcRBT8WE66THX5eogKEOfnWm5lnhtmVaxgiao+aqDBY/eogihlP5YLvBznVPvsXdUIhh/tUPr7Z4THI72Js4bIBproJFQS/GGmSQHc5exLvvLSk0afeAL5vltEuQkYJmO+o9nzf4GLX4ibITy5d/eZ8ZFCAfCHfovlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765782777; c=relaxed/simple;
	bh=cjBKEJDYkBRaiCLsumSCYZAbl6JELoob6e/nBmidDME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWygREpzuMjB7BJkE3UWkPhwysW3yTgSapZflZQOvjoALuEI+yaH9BpEVwNzbtXXbq9ZMxN+JDFzvWWqIGF6HflQwNGsvPXDdSQBUoxZ2mmzpT5xXz9uJpFZPo8Z/xUw5jadI3pUdPe8UGqE1/wiVzZYGXTUnMzgtVn+KdylB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK7BOfu3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK7BOfu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E27C4CEF5;
	Mon, 15 Dec 2025 07:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765782776;
	bh=cjBKEJDYkBRaiCLsumSCYZAbl6JELoob6e/nBmidDME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XK7BOfu3HghP63lsTD6fS2LpQyrboCuEat/4ilaR6dw273l0mRgKwozA4l7UEX2SQ
	 MrCrKVI5jAacKnsIeJxd+U8LLOgZZzRzpcaS2bzD15bRTH5CPVD/dYVdxQRunyCw2Z
	 Dhoix1ftYM7R1/OYzheiimHjoXri2I8LaVpSLi/P50y0dscszkblIeNOim7xzMLdBj
	 /CcowQTbPjj+DH9gtW/cU9KSWMDoXNjHRpnRG+EiprLH1oBmJ9jhVjVssXr5c83a/9
	 xF3KsNC5N6ZG3z+NM6IaGkRqHB6EKST2bqE3X7hiRMejbQRYlw9QhDWBBMSdYb0onN
	 XSRjuAfPMAjPg==
Message-ID: <66ae3b25-7d82-445c-b125-bc017d299c85@kernel.org>
Date: Mon, 15 Dec 2025 16:12:54 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] loop: convert lo_state to atomic_t type to ensure
 atomic state checks in queue_rq path
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <yangyongpeng.storage@outlook.com>
References: <20251215065458.1452317-2-yangyongpeng.storage@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20251215065458.1452317-2-yangyongpeng.storage@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/25 15:54, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> lo_state is currently defined as an int, which does not guarantee
> atomicity for state checks. In the queue_rq path, ensuring correct state
> checks requires holding lo->lo_mutex, which may increase I/O submission
> latency. This patch converts lo_state to atomic_t type. The main changes
> are:
> 1. Updates to lo_state still require holding lo->lo_mutex, since the
> state must be validated before modification, and the lock ensures that
> no concurrent operation can change the state.
> 2. Read-only accesses to lo_state no longer require holding lo->lo_mutex.
> 
> This allows atomic state checks in the queue_rq fast path while avoiding
> unnecessary locking overhead.

Code like:

if (loop_device_get_state(lo) != Lo_bound)

is absolutely *not* atomic, since the state can change in between the atomic
read and the comparison instruction. So this is not about atomicity, it is about
not reading garbage from the state field if there is a load and a store
concurrently executed on different CPUs (that happening depends on the CPU
architecture though).

As Christoph suggested, using "data_race()" may be enough to silence code
checkers. Or use READ_ONCE() WRITE_ONCE() for the state.

> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> ---
>  drivers/block/loop.c | 67 ++++++++++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 272bc608e528..bc661ecb449a 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -59,7 +59,7 @@ struct loop_device {
>  	gfp_t		old_gfp_mask;
>  
>  	spinlock_t		lo_lock;
> -	int			lo_state;
> +	atomic_t		lo_state;
>  	spinlock_t              lo_work_lock;
>  	struct workqueue_struct *workqueue;
>  	struct work_struct      rootcg_work;
> @@ -94,6 +94,16 @@ static DEFINE_IDR(loop_index_idr);
>  static DEFINE_MUTEX(loop_ctl_mutex);
>  static DEFINE_MUTEX(loop_validate_mutex);
>  
> +static inline int loop_device_get_state(struct loop_device *lo)
> +{
> +	return atomic_read(&lo->lo_state);
> +}
> +
> +static inline void loop_device_set_state(struct loop_device *lo, int state)
> +{
> +	atomic_set(&lo->lo_state, state);
> +}
> +
>  /**
>   * loop_global_lock_killable() - take locks for safe loop_validate_file() test
>   *
> @@ -200,7 +210,7 @@ static bool lo_can_use_dio(struct loop_device *lo)
>  static inline void loop_update_dio(struct loop_device *lo)
>  {
>  	lockdep_assert_held(&lo->lo_mutex);
> -	WARN_ON_ONCE(lo->lo_state == Lo_bound &&
> +	WARN_ON_ONCE(loop_device_get_state(lo) == Lo_bound &&
>  		     lo->lo_queue->mq_freeze_depth == 0);
>  
>  	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && !lo_can_use_dio(lo))
> @@ -495,7 +505,7 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
>  			return -EBADF;
>  
>  		l = I_BDEV(f->f_mapping->host)->bd_disk->private_data;
> -		if (l->lo_state != Lo_bound)
> +		if (loop_device_get_state(l) != Lo_bound)
>  			return -EINVAL;
>  		/* Order wrt setting lo->lo_backing_file in loop_configure(). */
>  		rmb();
> @@ -563,7 +573,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
>  	if (error)
>  		goto out_putf;
>  	error = -ENXIO;
> -	if (lo->lo_state != Lo_bound)
> +	if (loop_device_get_state(lo) != Lo_bound)
>  		goto out_err;
>  
>  	/* the loop device has to be read-only */
> @@ -1019,7 +1029,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>  		goto out_bdev;
>  
>  	error = -EBUSY;
> -	if (lo->lo_state != Lo_unbound)
> +	if (loop_device_get_state(lo) != Lo_unbound)
>  		goto out_unlock;
>  
>  	error = loop_validate_file(file, bdev);
> @@ -1082,7 +1092,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
>  	/* Order wrt reading lo_state in loop_validate_file(). */
>  	wmb();
>  
> -	lo->lo_state = Lo_bound;
> +	loop_device_set_state(lo, Lo_bound);
>  	if (part_shift)
>  		lo->lo_flags |= LO_FLAGS_PARTSCAN;
>  	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
> @@ -1179,7 +1189,7 @@ static void __loop_clr_fd(struct loop_device *lo)
>  	if (!part_shift)
>  		set_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
>  	mutex_lock(&lo->lo_mutex);
> -	lo->lo_state = Lo_unbound;
> +	loop_device_set_state(lo, Lo_unbound);
>  	mutex_unlock(&lo->lo_mutex);
>  
>  	/*
> @@ -1206,7 +1216,7 @@ static int loop_clr_fd(struct loop_device *lo)
>  	err = loop_global_lock_killable(lo, true);
>  	if (err)
>  		return err;
> -	if (lo->lo_state != Lo_bound) {
> +	if (loop_device_get_state(lo) != Lo_bound) {
>  		loop_global_unlock(lo, true);
>  		return -ENXIO;
>  	}
> @@ -1218,7 +1228,7 @@ static int loop_clr_fd(struct loop_device *lo)
>  
>  	lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
>  	if (disk_openers(lo->lo_disk) == 1)
> -		lo->lo_state = Lo_rundown;
> +		loop_device_set_state(lo, Lo_rundown);
>  	loop_global_unlock(lo, true);
>  
>  	return 0;
> @@ -1235,7 +1245,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
>  	err = mutex_lock_killable(&lo->lo_mutex);
>  	if (err)
>  		return err;
> -	if (lo->lo_state != Lo_bound) {
> +	if (loop_device_get_state(lo) != Lo_bound) {
>  		err = -ENXIO;
>  		goto out_unlock;
>  	}
> @@ -1289,7 +1299,7 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
>  	ret = mutex_lock_killable(&lo->lo_mutex);
>  	if (ret)
>  		return ret;
> -	if (lo->lo_state != Lo_bound) {
> +	if (loop_device_get_state(lo) != Lo_bound) {
>  		mutex_unlock(&lo->lo_mutex);
>  		return -ENXIO;
>  	}
> @@ -1408,7 +1418,7 @@ static int loop_set_capacity(struct loop_device *lo)
>  {
>  	loff_t size;
>  
> -	if (unlikely(lo->lo_state != Lo_bound))
> +	if (unlikely(loop_device_get_state(lo) != Lo_bound))
>  		return -ENXIO;
>  
>  	size = lo_calculate_size(lo, lo->lo_backing_file);
> @@ -1422,7 +1432,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
>  	bool use_dio = !!arg;
>  	unsigned int memflags;
>  
> -	if (lo->lo_state != Lo_bound)
> +	if (loop_device_get_state(lo) != Lo_bound)
>  		return -ENXIO;
>  	if (use_dio == !!(lo->lo_flags & LO_FLAGS_DIRECT_IO))
>  		return 0;
> @@ -1464,7 +1474,7 @@ static int loop_set_block_size(struct loop_device *lo, blk_mode_t mode,
>  	if (err)
>  		goto abort_claim;
>  
> -	if (lo->lo_state != Lo_bound) {
> +	if (loop_device_get_state(lo) != Lo_bound) {
>  		err = -ENXIO;
>  		goto unlock;
>  	}
> @@ -1716,16 +1726,11 @@ static int lo_compat_ioctl(struct block_device *bdev, blk_mode_t mode,
>  static int lo_open(struct gendisk *disk, blk_mode_t mode)
>  {
>  	struct loop_device *lo = disk->private_data;
> -	int err;
> -
> -	err = mutex_lock_killable(&lo->lo_mutex);
> -	if (err)
> -		return err;
> +	int state = loop_device_get_state(lo);
>  
> -	if (lo->lo_state == Lo_deleting || lo->lo_state == Lo_rundown)
> -		err = -ENXIO;
> -	mutex_unlock(&lo->lo_mutex);
> -	return err;
> +	if (state == Lo_deleting || state == Lo_rundown)
> +		return -ENXIO;
> +	return 0;
>  }
>  
>  static void lo_release(struct gendisk *disk)
> @@ -1742,10 +1747,10 @@ static void lo_release(struct gendisk *disk)
>  	 */
>  
>  	mutex_lock(&lo->lo_mutex);
> -	if (lo->lo_state == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR))
> -		lo->lo_state = Lo_rundown;
> +	if (loop_device_get_state(lo) == Lo_bound && (lo->lo_flags & LO_FLAGS_AUTOCLEAR))
> +		loop_device_set_state(lo, Lo_rundown);
>  
> -	need_clear = (lo->lo_state == Lo_rundown);
> +	need_clear = (loop_device_get_state(lo) == Lo_rundown);
>  	mutex_unlock(&lo->lo_mutex);
>  
>  	if (need_clear)
> @@ -1858,7 +1863,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  
>  	blk_mq_start_request(rq);
>  
> -	if (lo->lo_state != Lo_bound)
> +	if (loop_device_get_state(lo) != Lo_bound)
>  		return BLK_STS_IOERR;
>  
>  	switch (req_op(rq)) {
> @@ -2016,7 +2021,7 @@ static int loop_add(int i)
>  	lo->worker_tree = RB_ROOT;
>  	INIT_LIST_HEAD(&lo->idle_worker_list);
>  	timer_setup(&lo->timer, loop_free_idle_workers_timer, TIMER_DEFERRABLE);
> -	lo->lo_state = Lo_unbound;
> +	loop_device_set_state(lo, Lo_unbound);
>  
>  	err = mutex_lock_killable(&loop_ctl_mutex);
>  	if (err)
> @@ -2168,13 +2173,13 @@ static int loop_control_remove(int idx)
>  	ret = mutex_lock_killable(&lo->lo_mutex);
>  	if (ret)
>  		goto mark_visible;
> -	if (lo->lo_state != Lo_unbound || disk_openers(lo->lo_disk) > 0) {
> +	if (loop_device_get_state(lo) != Lo_unbound || disk_openers(lo->lo_disk) > 0) {
>  		mutex_unlock(&lo->lo_mutex);
>  		ret = -EBUSY;
>  		goto mark_visible;
>  	}
>  	/* Mark this loop device as no more bound, but not quite unbound yet */
> -	lo->lo_state = Lo_deleting;
> +	loop_device_set_state(lo, Lo_deleting);
>  	mutex_unlock(&lo->lo_mutex);
>  
>  	loop_remove(lo);
> @@ -2198,7 +2203,7 @@ static int loop_control_get_free(int idx)
>  		return ret;
>  	idr_for_each_entry(&loop_index_idr, lo, id) {
>  		/* Hitting a race results in creating a new loop device which is harmless. */
> -		if (lo->idr_visible && data_race(lo->lo_state) == Lo_unbound)
> +		if (lo->idr_visible && loop_device_get_state(lo) == Lo_unbound)
>  			goto found;
>  	}
>  	mutex_unlock(&loop_ctl_mutex);


-- 
Damien Le Moal
Western Digital Research
