Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B8718BC34;
	Fri, 25 Oct 2024 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842634; cv=none; b=kPUfC+PzN+LFmm2+WhzzsoaPBB1uZtzIUVTMSn5e1RDJtXGTCNfecSN6evAQti8yArRzWHNIgEHOpRE6w0ZYoxX4YLlyznBOGQAyydCVFnVLIBejXLGcgFfyO2ThN0WpX7gDf7Vxg+c2fPJFhJYOqYZlOeLM+rEX8+eDkoG0/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842634; c=relaxed/simple;
	bh=uVyDIzrMhpMILz655M51Vt7BTLiBxwWcOnZzBwsXeH8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=u5H/QVFzfFjHjVKI7ee27YdXkbhAIWCOeU9p7B5oYIHaLQ911/yhmAPFePQvQn/XaywYnhsXCq0XI5AecFpDA0LAkAQlHFx/Z3Gm0xTPZJ7kTPi0Z4SeOECPQIL27CDSAN6g8B8r9vP8bqPvD8uwwX+qoYvXcc6wz80/ajqTkXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XZZgv6Pddz4f3jMW;
	Fri, 25 Oct 2024 15:50:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 619E71A0196;
	Fri, 25 Oct 2024 15:50:21 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8e7TRtnG0lEFA--.6716S3;
	Fri, 25 Oct 2024 15:50:21 +0800 (CST)
Subject: Re: [PATCH] block: refactor rq_qos_wait()
To: Muchun Song <songmuchun@bytedance.com>, axboe@kernel.dk
Cc: mingo@redhat.com, peterz@infradead.org, chengming.zhou@linux.dev,
 muchun.song@linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, tj@kernel.org, "yukuai (C)"
 <yukuai3@huawei.com>
References: <20241024043525.98663-1-songmuchun@bytedance.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9c6099ba-8d95-f2f6-fe36-7333f706c0fc@huaweicloud.com>
Date: Fri, 25 Oct 2024 15:50:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241024043525.98663-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+8e7TRtnG0lEFA--.6716S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1DtFWDGry3tryUXr1rCrg_yoWxZr43pa
	yrKF15tF48JrZrKw1xJw4fAa4a9w4rGa43GrWxKasrAr4j9r9YqF1kKF1kWa4Yyrs3XF48
	Xw40qr9xCrs8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

+CC Tejun

ÔÚ 2024/10/24 12:35, Muchun Song Ð´µÀ:
> When rq_qos_wait() is first introduced, it is easy to understand. But
> with some bug fixes applied, it is not easy for newcomers to understand
> the whole logic under those fixes. In this patch, rq_qos_wait() is
> refactored and more comments are added for better understanding. There
> are 4 points for the improvement:
> 
>      1) Use waitqueue_active() instead of wq_has_sleeper() to eliminate
>         unnecessary memory barrier in wq_has_sleeper() which is supposed
>         to be used in waker side. In this case, we do need the barrier.
>         So use the cheaper one to locklessly test for waiters on the queue.
> 
>      2) There is already a macro DEFINE_WAIT_FUNC() to declare a
>         wait_queue_entry with a specified waking function. But there is not
>         a counterpart for initializing one wait_queue_entry with a
>         specified waking function. So introducing init_wait_func() for
>         this, which also could be used elsewhere (like filemap.c). It can
>         be used in rq_qos_wait() to use default_wake_function() to wake up
>         waiters, which could remove ->task field from rq_qos_wait_data.

I think it's better to cook point 2 as a seperate patch.

Whether or not, this patch LGTM.
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

>
>      3) Remove acquire_inflight_cb() logic for the first waiter out of the
>         while loop to make the code clear.
> 
>      4) Add more comments to explain how to sync with different waiters and
>         the waker.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   block/blk-rq-qos.c   | 82 +++++++++++++++++++++++++++++---------------
>   include/linux/wait.h |  6 ++--
>   2 files changed, 58 insertions(+), 30 deletions(-)
> 
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index 9b0aa7dd6779f..5d995d389eaf5 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -196,7 +196,6 @@ bool rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle)
>   
>   struct rq_qos_wait_data {
>   	struct wait_queue_entry wq;
> -	struct task_struct *task;
>   	struct rq_wait *rqw;
>   	acquire_inflight_cb_t *cb;
>   	void *private_data;
> @@ -218,7 +217,20 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
>   		return -1;
>   
>   	data->got_token = true;
> -	wake_up_process(data->task);
> +	/*
> +	 * autoremove_wake_function() removes the wait entry only when it
> +	 * actually changed the task state. We want the wait always removed.
> +	 * Remove explicitly and use default_wake_function().
> +	 */
> +	default_wake_function(curr, mode, wake_flags, key);
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
> @@ -244,41 +256,55 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
>   		 cleanup_cb_t *cleanup_cb)
>   {
>   	struct rq_qos_wait_data data = {
> -		.wq = {
> -			.func	= rq_qos_wake_function,
> -			.entry	= LIST_HEAD_INIT(data.wq.entry),
> -		},
> -		.task = current,
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
> -	has_sleeper = !prepare_to_wait_exclusive(&rqw->wait, &data.wq,
> +	init_wait_func(&data.wq, rq_qos_wake_function);
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
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index 8aa3372f21a08..b008ca42b5903 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -1206,14 +1206,16 @@ int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, i
>   
>   #define DEFINE_WAIT(name) DEFINE_WAIT_FUNC(name, autoremove_wake_function)
>   
> -#define init_wait(wait)								\
> +#define init_wait_func(wait, function)						\
>   	do {									\
>   		(wait)->private = current;					\
> -		(wait)->func = autoremove_wake_function;			\
> +		(wait)->func = function;					\
>   		INIT_LIST_HEAD(&(wait)->entry);					\
>   		(wait)->flags = 0;						\
>   	} while (0)
>   
> +#define init_wait(wait)	init_wait_func(wait, autoremove_wake_function)
> +
>   typedef int (*task_call_f)(struct task_struct *p, void *arg);
>   extern int task_call_func(struct task_struct *p, task_call_f func, void *arg);
>   
> 

