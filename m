Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD1B7DA82
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730194536; cv=none; b=swsYe3faVSxmCJJOkWb1K7WmNS5idFflwxWjmJORSoVteMForo4M5aa2Wthl+2okZEwVVeOcRdZ++iXvsS5dbrF0fZIGqqal7iMR/+wSlniArn5aRYfknaKR42HXuiqjSp7ZfGsjLVfakNhyqJ7R+8lV5QSdTE3hIRWk/UOLmTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730194536; c=relaxed/simple;
	bh=YJrh7hUGQiUNMQcjnWqaa6JmnL6AChiyOk0uwMAr2T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSs8T/ylM9dBVTDx6rA8K1CV+qiZHJHMQ3YhWHm2YnNRe+5nJXyyNptZs0LWyoS7QM2ywQA9cfxcaBdHxb3oG+jlHt0VKzdxkL/c712Z14UFQclyVPhCnQYjUnlaImGOpj//IMQhuaGLduloqnEUc8uUUzzoMZVSNvK8ti+ZZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NwqthI3F; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NwqthI3F"
Message-ID: <b134e3e5-91fd-43fe-b0a5-1a63b59302af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730194530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OcZCmIP2+C2Bbha8O8u8jVsFI4EZuvwasHnrHMnF8Y=;
	b=NwqthI3FiGVTNZj3aEZbZQM0AvXkQKKP2gmj5vRtxQghgRbiRo6HqxulqN9ZhP3mJ9h1Ko
	jY2KmPE1of1f1JlN9Kq4S4KL06rXP8NE/1Oq6ehWO0OL3LafYVZH5qvpKR1qoEqmoCgePv
	zzo1VUMN+UH+0EF4QdhtUu/4VJS0nx8=
Date: Tue, 29 Oct 2024 17:35:07 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] block: refactor rq_qos_wait()
To: Muchun Song <songmuchun@bytedance.com>, axboe@kernel.dk, tj@kernel.org,
 yukuai1@huaweicloud.com
Cc: muchun.song@linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>
References: <20241029085559.98390-1-songmuchun@bytedance.com>
 <20241029085559.98390-2-songmuchun@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20241029085559.98390-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/10/29 16:55, Muchun Song wrote:
> When rq_qos_wait() is first introduced, it is easy to understand. But
> with some bug fixes applied, it is not easy for newcomers to understand
> the whole logic under those fixes. In this patch, rq_qos_wait() is
> refactored and more comments are added for better understanding. There
> are 3 points for the improvement:
> 
> 1) Use waitqueue_active() instead of wq_has_sleeper() to eliminate
>     unnecessary memory barrier in wq_has_sleeper() which is supposed
>     to be used in waker side. In this case, we do need the barrier.
>     So use the cheaper one to locklessly test for waiters on the queue.
> 
> 2) Remove acquire_inflight_cb() logic for the first waiter out of the
>     while loop to make the code clear.
> 
> 3) Add more comments to explain how to sync with different waiters and
>     the waker.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
> v2:
>   - Introduce init_wait_func() in a seprate patch (Yu Kuai).
> 
>   block/blk-rq-qos.c | 68 ++++++++++++++++++++++++++++++++--------------
>   1 file changed, 47 insertions(+), 21 deletions(-)
> 
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index 858ce69c04ece..5d995d389eaf5 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -223,6 +223,14 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
>   	 * Remove explicitly and use default_wake_function().
>   	 */
>   	default_wake_function(curr, mode, wake_flags, key);
> +	/*
> +	 * Note that the order of operations is important as finish_wait()
> +	 * tests whether @curr is removed without grabbing the lock. This
> +	 * should be the last thing to do to make sure we will not have a
> +	 * UAF access to @data. And the semantics of memory barrier in it
> +	 * also make sure the waiter will see the latest @data->got_token
> +	 * once list_empty_careful() in finish_wait() returns true.
> +	 */
>   	list_del_init_careful(&curr->entry);
>   	return 1;
>   }
> @@ -248,37 +256,55 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
>   		 cleanup_cb_t *cleanup_cb)
>   {
>   	struct rq_qos_wait_data data = {
> -		.rqw = rqw,
> -		.cb = acquire_inflight_cb,
> -		.private_data = private_data,
> +		.rqw		= rqw,
> +		.cb		= acquire_inflight_cb,
> +		.private_data	= private_data,
> +		.got_token	= false,
>   	};
> -	bool has_sleeper;
> +	bool first_waiter;
>   
> -	has_sleeper = wq_has_sleeper(&rqw->wait);
> -	if (!has_sleeper && acquire_inflight_cb(rqw, private_data))
> +	/*
> +	 * If there are no waiters in the waiting queue, try to increase the
> +	 * inflight counter if we can. Otherwise, prepare for adding ourselves
> +	 * to the waiting queue.
> +	 */
> +	if (!waitqueue_active(&rqw->wait) && acquire_inflight_cb(rqw, private_data))
>   		return;
>   
>   	init_wait_func(&data.wq, rq_qos_wake_function);
> -	has_sleeper = !prepare_to_wait_exclusive(&rqw->wait, &data.wq,
> +	first_waiter = prepare_to_wait_exclusive(&rqw->wait, &data.wq,
>   						 TASK_UNINTERRUPTIBLE);
> +	/*
> +	 * Make sure there is at least one inflight process; otherwise, waiters
> +	 * will never be woken up. Since there may be no inflight process before
> +	 * adding ourselves to the waiting queue above, we need to try to
> +	 * increase the inflight counter for ourselves. And it is sufficient to
> +	 * guarantee that at least the first waiter to enter the waiting queue
> +	 * will re-check the waiting condition before going to sleep, thus
> +	 * ensuring forward progress.
> +	 */
> +	if (!data.got_token && first_waiter && acquire_inflight_cb(rqw, private_data)) {
> +		finish_wait(&rqw->wait, &data.wq);
> +		/*
> +		 * We raced with rq_qos_wake_function() getting a token,
> +		 * which means we now have two. Put our local token
> +		 * and wake anyone else potentially waiting for one.
> +		 *
> +		 * Enough memory barrier in list_empty_careful() in
> +		 * finish_wait() is paired with list_del_init_careful()
> +		 * in rq_qos_wake_function() to make sure we will see
> +		 * the latest @data->got_token.
> +		 */
> +		if (data.got_token)
> +			cleanup_cb(rqw, private_data);
> +		return;
> +	}
> +
> +	/* we are now relying on the waker to increase our inflight counter. */
>   	do {
> -		/* The memory barrier in set_task_state saves us here. */
>   		if (data.got_token)
>   			break;
> -		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
> -			finish_wait(&rqw->wait, &data.wq);
> -
> -			/*
> -			 * We raced with rq_qos_wake_function() getting a token,
> -			 * which means we now have two. Put our local token
> -			 * and wake anyone else potentially waiting for one.
> -			 */
> -			if (data.got_token)
> -				cleanup_cb(rqw, private_data);
> -			return;
> -		}
>   		io_schedule();
> -		has_sleeper = true;
>   		set_current_state(TASK_UNINTERRUPTIBLE);
>   	} while (1);
>   	finish_wait(&rqw->wait, &data.wq);
