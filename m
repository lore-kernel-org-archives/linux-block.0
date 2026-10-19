Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A963644C1;
	Mon, 19 Oct 2026 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411144; cv=none; b=etCo/T/ZI6D/gGgwC53ZggfOTdhOQi+OoX0llz+4jWhfcsodBBPji69IY51U6nCeAj/gXOlxrU1X6CmOyFsdKiZXI+WfUwQvafkQcsf+kDYeEkiR1oReK/Rj5etzqkAdMXqpy9Yb3XYEWdctZd8RmGvoIMmmOvAcCDH81HTvCwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411144; c=relaxed/simple;
	bh=1P2yaxxJpP7qzNDDrXWV9ssvFit25736jZ5DTAdp9sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ifrl/rGtGQxcel6jXopx04zrD9OJcqYCSuNbdjXD7P9rImi0fo+o9Fb8VTlDerTaSeo+yzmt1ASL5Nz58m1SYSuWxJIbkrgxow8bgpgKlYzekvbdhSTN7gumfX9g7BLDCNV/0Dhcb1S5SwFoFe5ZR9jX6SEAo+hYzFrpmt4PZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsRb9jq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsRb9jq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9407C1F000C4;
	Mon, 19 Oct 2026 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792411143;
	bh=Zt72IrKC2ghWoNgvmBFIkIB7w0ruT8503Thne6gkNQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WsRb9jq3OMzaMO/pcQGtFHkN0mVIeMmATtTOrkPk7C+SEFS5dtRlT1cHeVwroIB1a
	 qGp12nTfeWbWBId1YLP5Mn/KrYbtXLHqbFFrieXWRXp+ZZ8rAj8aa2Otb3RkCBi/xD
	 CWymOKqgFSKpSNKH+G6Nzl6joUx1zb/YgN3bcbEg6Yey0iVAywj3tG5y+gGy2XniVM
	 c9CRx5D8HiF6XskcKIF8qT2Um2+KvnSKDJgsadYrvaQmsTOcZ761VvfK+uiJHzC+qc
	 bdain2mpQOO3sIrvWL3GJw14Ywt9xuaRQnwe1hgm8mgy6urB65tX7mQ5UWQPbEnTrU
	 O3JPpo1/vbhgg==
Message-ID: <d8eeb6b8-70c0-4629-b140-34e283678c37@kernel.org>
Date: Mon, 19 Oct 2026 13:59:00 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: annotate lockless task ioprio accesses
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+feeb9b5352b9ff89618a@syzkaller.appspotmail.com
References: <20261018071636.79198-1-ngocthang2710.1999@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261018071636.79198-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/18 9:16, Nguyen Ngoc Thang wrote:
> __get_task_ioprio() reads task->io_context and ioc->ioprio without
> task_lock() when called on current, e.g. from init_sync_kiocb() on every
> write.  set_task_ioprio() can update both for another task at any time,
> including the first publication of a new io_context.  KCSAN reports it:
> 
>   BUG: KCSAN: data-race in __kernel_write_iter / set_task_ioprio
>   value changed: 0x0000000000000000 -> 0xffff888109813730
> 
> A stale or torn value is harmless, a task simply gets the old or new
> priority, but the compiler may tear or refetch the accesses and the
> io_context fields must be visible before the pointer is.
> 
> Publish the pointer with smp_store_release(), read it with READ_ONCE()
> (address dependency orders the ioprio load), and mark the ioprio
> accesses.
> 
> Reported-by: syzbot+feeb9b5352b9ff89618a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=feeb9b5352b9ff89618a
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> Tested with a KCSAN kernel in QEMU. syzbot's coredump repro is too slow to hit
> the window, so a thread loops pwrite() on a tmpfs file while the main thread
> does the first ioprio_set() on its tid (~35k iterations per run). Same pair,
> same "0 -> pointer" value change: 26 reports per run before, 0 in two runs
> after. No Fixes: tag, the history I have is grafted.
>  block/blk-ioc.c        | 5 +++--
>  include/linux/ioprio.h | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index d15918d7fabb..12ddc672f41d 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -277,9 +277,10 @@ int set_task_ioprio(struct task_struct *task, int ioprio)
>  		if (task->io_context)
>  			kmem_cache_free(iocontext_cachep, ioc);
>  		else
> -			task->io_context = ioc;
> +			/* Pairs with READ_ONCE() in __get_task_ioprio() */
> +			smp_store_release(&task->io_context, ioc);
>  	}
> -	task->io_context->ioprio = ioprio;
> +	WRITE_ONCE(task->io_context->ioprio, ioprio);
>  out:
>  	task_unlock(task);
>  	return 0;
> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
> index 5210e8371238..56371e9ea306 100644
> --- a/include/linux/ioprio.h
> +++ b/include/linux/ioprio.h
> @@ -56,7 +56,8 @@ static inline int task_nice_ioclass(struct task_struct *task)
>   */
>  static inline int __get_task_ioprio(struct task_struct *p)
>  {
> -	struct io_context *ioc = p->io_context;
> +	/* Paired with smp_store_release() in set_task_ioprio() */
> +	struct io_context *ioc = READ_ONCE(p->io_context);

How does this help with the ioc dereference below? By the time we access
ioc->ioprio without task_lock() held, ioc could have been freed already, no?
So it feels like this should be using rcu.

>  	int prio;
>  
>  	if (!ioc)
> @@ -66,7 +67,7 @@ static inline int __get_task_ioprio(struct task_struct *p)
>  	if (p != current)
>  		lockdep_assert_held(&p->alloc_lock);
>  
> -	prio = ioc->ioprio;
> +	prio = READ_ONCE(ioc->ioprio);
>  	if (IOPRIO_PRIO_CLASS(prio) == IOPRIO_CLASS_NONE)
>  		prio = IOPRIO_PRIO_VALUE(task_nice_ioclass(p),
>  					 task_nice_ioprio(p));


-- 
Damien Le Moal
Western Digital Research
