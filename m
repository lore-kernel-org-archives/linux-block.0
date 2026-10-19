Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424863;
	b=oxjmkpBeu5IQw05X8/8ehB960AjJV/klH519tVIhAllWlkKT+s2w0nvFYdrVVZKV5Ree
	 RqSVsN8qPHpGDmHrKqsr+X7a9gSkvayxbNQL1V0jqbT23cPHBtolAhJI9Pz9NauB6aj0z
	 QH42CxwSC2R7FLgUT+4FoySMNW6yrIEwCJPlgzdF+EnySeR+LOii3b4n3t8jVtfSoPnBc
	 1bdPxUWclY0VkHW24y448EH9Z8ntg/vVqIt0gs46vaH4P22L08+YlESg8neS+4HRlAqST
	 CqnRnVRVTKMLu4YWChIsSSp/7uEe6xpiEgZaSBk1/UvOMxDOlaBfDfKEOxWmOU93WkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424863;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=U/VyF77YKfNghnKfGG9u9PtwhnFl9zFcySQnmm3Q0V8=;
	b=ZLGmk1jaxO0GOwGTWmLo0ojkKEijz0gDSWB8G3n68BpjT3GcWm3rFX0jAZdRuUbKKZqk
	 x9IyW3bntIxeGUW5PK4B7nHSH/QXc1rHK7VvyAlBH5RZGJ6KnPQ4jI+aTN1dAt1OWeBFv
	 pEp+yJkzB3dlp2HXlW6lfrCqtd7ka5ZP/U6OMTz2Tel4812yrxxQzV9GsIi50r67DAK7p
	 okA/D8sWnCf/5GwDt0lUmjQWtBOqdTU5p1S/u9uq/E7HVglFejT+EKI9tWKKHs6nIMwbk
	 OO8G5hSYjiNT7GRspFZypziZjtj3FZZLtI7mASX3TUNpbx4VaQn3c+3nc/QixW8yuUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2KyOiO5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56C2606C90D;
	Mon, 19 Oct 2026 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2KyOiO5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AA81F0180B;
	Mon, 19 Oct 2026 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792424862;
	bh=U/VyF77YKfNghnKfGG9u9PtwhnFl9zFcySQnmm3Q0V8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=W2KyOiO5M8UTjkf6BgUasTgM0p64q6VTFva46JuBS1ymVvvmv/M/Pgby0wi5f1Ejk
	 w/O/4E4CCAFG8vmRSix1tuhMzRLLJnHohCobu4TZK7Rj/+KifdcTXZ+maSd6wFbY+x
	 VdACYN96J750/G1HLGKpGM/3/t231dVNH+z6tIwvCOAekoFzN3qZaHYT8Xw0UFjq33
	 wWBLTrVFNt4jKu+KwYo73Y6+HsUYxG/jEtmfyRSjUN9fPfu1sNJWD6DaG9EFF1ggbJ
	 bhU1yijPWsUwM/kbq6VLBlICsQEL6pxcX357xrsYeRx42EYXYre1PpEMwj2+jC4wrg
	 qtrS2oJgXR4/Q==
Message-ID: <3cd6c8b6-3c8e-412e-87f0-79a521ebc2df@kernel.org>
Date: Mon, 19 Oct 2026 17:47:38 +0200
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: annotate lockless task ioprio accesses
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+feeb9b5352b9ff89618a@syzkaller.appspotmail.com
References: <20261018071636.79198-1-ngocthang2710.1999@gmail.com>
 <20261019125811.21666-1-ngocthang2710.1999@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261019125811.21666-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/19 14:58, Nguyen Ngoc Thang wrote:
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
> The io_context itself needs no extra protection: only the owning task
> drops it, in exit_io_context(), so it cannot be freed under a lockless
> reader running as current.
> 
> Publish the pointer with smp_store_release(), read it with READ_ONCE()
> (address dependency orders the ioprio load), and mark the ioprio
> accesses.
> 
> Reported-by: syzbot+feeb9b5352b9ff89618a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=feeb9b5352b9ff89618a
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> v2:
> - Document why no RCU is needed: only the owning task drops its io_context
>   (Damien).  Comment in __get_task_ioprio() and a paragraph in the commit
>   message.  No code change.
> - v1: https://lore.kernel.org/r/20261018071636.79198-1-ngocthang2710.1999@gmail.com
> 
> Tested with a KCSAN kernel in QEMU: 26 data-race reports per run before, 0
> in two runs after (v1 code, v2 differs only in comments).
>  block/blk-ioc.c        | 5 +++--
>  include/linux/ioprio.h | 9 +++++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
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
> index 5210e8371238..d148548691c7 100644
> --- a/include/linux/ioprio.h
> +++ b/include/linux/ioprio.h
> @@ -56,7 +56,12 @@ static inline int task_nice_ioclass(struct task_struct *task)
>   */
>  static inline int __get_task_ioprio(struct task_struct *p)
>  {
> -	struct io_context *ioc = p->io_context;
> +	/*
> +	 * Only the task itself drops its io_context (exit_io_context()), so
> +	 * for p == current a non-NULL ioc stays valid.  Another task can
> +	 * still install it or change ->ioprio, hence the annotations.
> +	 */
> +	struct io_context *ioc = READ_ONCE(p->io_context);

Personally, I do not find comment blocks in the middle of declarations pretty.
Can you maybe rewrite this like:

	struct io_context *ioc;
	int prio;

	/*
	 * Only the task itself drops its io_context (exit_io_context()), so
	 * for p == current a non-NULL ioc stays valid.  Another task can
	 * still install it or change ->ioprio, hence the annotations.
	 */
	ioc = READ_ONCE(p->io_context);
	if (!ioc)
		...

Also, the comment mentions "annotation" which I am not sure is the right naming
for READ_ONCE(). It is also a little confusing as that hints at something like
lockdep annotations, which is not what is doe here.

So maybe the comment should be something like:

	/*
	 * Only the current task itself drops its io_context on
	 * exit_io_context()), so a non-NULL ioc is always valid.
	 * However, another task may change ->io_context or ioc->ioprio,
	 * so make sure to get the latest value with READ_ONCE().
	 */
	ioc = READ_ONCE(p->io_context);
	if (!ioc)
		...>  	
>  
>  	if (!ioc)
> @@ -66,7 +71,7 @@ static inline int __get_task_ioprio(struct task_struct *p)
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
