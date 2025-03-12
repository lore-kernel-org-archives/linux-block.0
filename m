Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D915853B
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776666; cv=none; b=VXkEb6mDGbwzvG1QpYu4Z5XfrEsTHH+dNZ7t29EAx/yy+88CzwAizVQs6dHbv77TOkprAACGXhiA131F3j77uVNfunhHPvbxgXZUlCH6cbuIWdt/9gdiKw8wK+jNH/fDd2qap8mvBSCCljHTlE/aIyjFo5sSI0RpCWUkC5tagZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776666; c=relaxed/simple;
	bh=tt3hoCtxyEhdQEzuXJOMbADD+qZQu0AJO/Jm1sN+wSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HplMr1r2ybUNj1cJ+gJ4aCvAja+rJtnHEGHyVX6We2GgcJ2HsgC5vnF7fVWkL4LXgR0cVu2fUoEmr6hLCSkBX9bh04V/o7rlVdtKhyMeJ5mYJ5Q7avyHUt6c9BLycbnW/+Xiu6bzB7eNkNeNsMBwJIJXNuu1ya0WygNvHaMni4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny5+Pnt/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny5+Pnt/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5810CC4CEE3;
	Wed, 12 Mar 2025 10:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741776666;
	bh=tt3hoCtxyEhdQEzuXJOMbADD+qZQu0AJO/Jm1sN+wSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ny5+Pnt/5B5JkIkl6RRBUIXfahvEoQjAvQD2riGp1oTIE2cFo8jQkmmnXKNwrlsnj
	 uoifBQJBfttANZl+he9iAWMkpnoLFkXUPfEQQPS+QKHaDU15C78jMFE7Rk9BaBhfcS
	 HjvcQASIK0Wj2+FWGODfC0TAdleTTSn+/4ujv3A6CRx9Rt7zPRXOg2meNlocpajCg1
	 j+t2/9fxQJ3KmU6qSjIQJtwKYFM8UeqlSHtCHZVEvGXT6V4Tj+XfpmxNz9QCS2khDT
	 LN8YQExa/RMFSk/1PGEXIhjdHiVEpOlELYRKseIJtE10aIAIx5OLmd3CGTe3A4Cvjl
	 fKGoy+c3iUU7w==
Message-ID: <3e26b52a-0bc7-438d-8ae4-29ac27268cad@kernel.org>
Date: Wed, 12 Mar 2025 19:51:04 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: protect debugfs attributes using q->elevator_lock
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, axboe@kernel.dk,
 gjoyce@ibm.com
References: <20250312102903.3584358-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250312102903.3584358-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 19:28, Nilay Shroff wrote:
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index adf5f0697b6b..d26a6df945bd 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -347,11 +347,16 @@ static int hctx_busy_show(void *data, struct seq_file *m)
>  {
>  	struct blk_mq_hw_ctx *hctx = data;
>  	struct show_busy_params params = { .m = m, .hctx = hctx };
> +	int res;
>  
> +	res = mutex_lock_interruptible(&hctx->queue->elevator_lock);
> +	if (res)
> +		goto out;

There is no need for the goto here. You can "return res;" directly.
Same comment for all the other changes below.

>  	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy_rq,
>  				&params);
> -
> -	return 0;
> +	mutex_unlock(&hctx->queue->elevator_lock);
> +out:
> +	return res;

And you can keep the "return 0;" here.

>  }
>  
>  static const char *const hctx_types[] = {
> @@ -400,12 +405,12 @@ static int hctx_tags_show(void *data, struct seq_file *m)
>  	struct request_queue *q = hctx->queue;
>  	int res;
>  
> -	res = mutex_lock_interruptible(&q->sysfs_lock);
> +	res = mutex_lock_interruptible(&q->elevator_lock);
>  	if (res)
>  		goto out;
>  	if (hctx->tags)
>  		blk_mq_debugfs_tags_show(m, hctx->tags);
> -	mutex_unlock(&q->sysfs_lock);
> +	mutex_unlock(&q->elevator_lock);
>  
>  out:
>  	return res;
> @@ -417,12 +422,12 @@ static int hctx_tags_bitmap_show(void *data, struct seq_file *m)
>  	struct request_queue *q = hctx->queue;
>  	int res;
>  
> -	res = mutex_lock_interruptible(&q->sysfs_lock);
> +	res = mutex_lock_interruptible(&q->elevator_lock);
>  	if (res)
>  		goto out;
>  	if (hctx->tags)
>  		sbitmap_bitmap_show(&hctx->tags->bitmap_tags.sb, m);
> -	mutex_unlock(&q->sysfs_lock);
> +	mutex_unlock(&q->elevator_lock);
>  
>  out:
>  	return res;
> @@ -434,12 +439,12 @@ static int hctx_sched_tags_show(void *data, struct seq_file *m)
>  	struct request_queue *q = hctx->queue;
>  	int res;
>  
> -	res = mutex_lock_interruptible(&q->sysfs_lock);
> +	res = mutex_lock_interruptible(&q->elevator_lock);
>  	if (res)
>  		goto out;
>  	if (hctx->sched_tags)
>  		blk_mq_debugfs_tags_show(m, hctx->sched_tags);
> -	mutex_unlock(&q->sysfs_lock);
> +	mutex_unlock(&q->elevator_lock);
>  
>  out:
>  	return res;
> @@ -451,12 +456,12 @@ static int hctx_sched_tags_bitmap_show(void *data, struct seq_file *m)
>  	struct request_queue *q = hctx->queue;
>  	int res;
>  
> -	res = mutex_lock_interruptible(&q->sysfs_lock);
> +	res = mutex_lock_interruptible(&q->elevator_lock);
>  	if (res)
>  		goto out;
>  	if (hctx->sched_tags)
>  		sbitmap_bitmap_show(&hctx->sched_tags->bitmap_tags.sb, m);
> -	mutex_unlock(&q->sysfs_lock);
> +	mutex_unlock(&q->elevator_lock);
>  
>  out:
>  	return res;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 22600420799c..709a32022c78 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -568,9 +568,9 @@ struct request_queue {
>  	 * nr_requests and wbt latency, this lock also protects the sysfs attrs
>  	 * nr_requests and wbt_lat_usec. Additionally the nr_hw_queues update
>  	 * may modify hctx tags, reserved-tags and cpumask, so this lock also
> -	 * helps protect the hctx attrs. To ensure proper locking order during
> -	 * an elevator or nr_hw_queue update, first freeze the queue, then
> -	 * acquire ->elevator_lock.
> +	 * helps protect the hctx sysfs/debugfs attrs. To ensure proper locking
> +	 * order during an elevator or nr_hw_queue update, first freeze the
> +	 * queue, then acquire ->elevator_lock.
>  	 */
>  	struct mutex		elevator_lock;
>  


-- 
Damien Le Moal
Western Digital Research
