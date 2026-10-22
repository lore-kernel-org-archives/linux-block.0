Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792654444;
	b=pgIAd6vnP8PvV1hXc3a2yUoMLdkMKO3wjjFqp8G3tb2LhOZ8HclwOd7+2E91vjScVp2W
	 3ngRbXvI480FZhNTnt1Aa+pM/APfK8j+F/TV4spWl2zqU6BM69r8Vih8mckICPOriNDaN
	 q4ypmOIM9Tf+6oCOvo/HsE4+QdCAAbfFm95NxXKQ9B1DjL2S76AuYIc3s8mvf2NW7iUpY
	 OnjclzDQ0qr7PgN0QIYpOw6O/ayfptc4L197UYQrAw2m3pOm5xBY87vnXNnx6m7JtsluG
	 ILYvZuX3z98XByvfXRk76K5JM3+l4vLurUkH+zRW82gssJfzW+UQ4GMXrF0Whff3NJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792654444;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=EXmo14MNykGN07bA6sS/UaZhsjisvLhN9+lktwXS9t4=;
	b=dh6rkh5woRWXkUYHSJFtlvN36YA3dId9KLk6L/N7qi/VwdhZOmqv9S5zopldFjY621UG
	 G9zsKPvgeAuz1Y4S/JqF0Sxu5eThOPjoew/tXw5J/j+nwLpiG7YMDes5l1l6jto1j9N4o
	 I++pmKTC/ml1N6n0zvbg/Mp1Y8hNl82KN6ZPFb8trgydDxYkjUWVO/UJ5BO+HJAe7XRWc
	 i1mSEO7Q0Aj3uOHvYEHhFiKki6p5wHZxccZpaF5iFCrm154EMvH0lKDxOSt4SdEvwDh90
	 j/ApIbzqn4p+PPtSKMNGQ0mdLaIFl6lZ4QMuhUEsJUF36f0Cmk1cs4LZ8e9f2FHU8ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ih+gmNB1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F8606A31D;
	Thu, 22 Oct 2026 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ih+gmNB1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B171F000C1;
	Thu, 22 Oct 2026 07:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792654443;
	bh=EXmo14MNykGN07bA6sS/UaZhsjisvLhN9+lktwXS9t4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ih+gmNB1PknqfRTD3S0H7jnj02GqqPSb69Y9zURlWSixrqKzMkiELJfykibd9LZHS
	 66TeG6jXBNUeU1y3tIKZ8GzCKn8Cq5MATLdQ8wFEnSd0GuFViFkqYUqOuzwnmksFWD
	 4zASIIWYe4te1IEHNIail4FKp3nHlY7iUCw3FPq+zJXBZ4xdGKyGiDOzMQu6wVowhQ
	 i/TeZltDSqo2zCjUUhPf5KGhUO5iuRfC19l3cLIVuoeY4Ba+SwD+cMGCw0X0tplY4v
	 AmVkSgiFvKZ2EHn0oxxGTIyHZHnHB57cjMga27o6xmFFcaz0db+a7TSGOZqVi+r8qc
	 fs4sr0cNIKI/Q==
Message-ID: <10bb721f-43bb-4a22-a9c5-6ebacda9b6b4@kernel.org>
Date: Thu, 22 Oct 2026 09:34:01 +0200
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
Subject: Re: [PATCH v3] block: annotate lockless task ioprio accesses
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+feeb9b5352b9ff89618a@syzkaller.appspotmail.com
References: <20261019125811.21666-1-ngocthang2710.1999@gmail.com>
 <20261020125233.9820-1-ngocthang2710.1999@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20261020125233.9820-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/20 14:52, Nguyen Ngoc Thang wrote:
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

The patch title still mentions "annotate", which is really vague. Please change
the title to be more descriptive. E.g. "use READ_ONCE() to access a task ioprio
context".

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

This is normally paired with smp_load_acquire(). The generic implementation of
that is simply a READ_ONCE() followed by an __smp_mb(), but some architectures
may have their own implementation. So why is it always correct to pair with
READ_ONCE()? Why not use WRITE_ONCE() here?

>  	}
> -	task->io_context->ioprio = ioprio;
> +	WRITE_ONCE(task->io_context->ioprio, ioprio);
>  out:
>  	task_unlock(task);
>  	return 0;
> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h


-- 
Damien Le Moal
Western Digital Research
