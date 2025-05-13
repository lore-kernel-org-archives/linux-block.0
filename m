Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F50D35963;
	Tue, 13 May 2025 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747097509; cv=none; b=OUG6baajAyiooVWd7WbERNk0Yeb6RKd/lMKSzQEeGccKvU7ak4VXG5yPu8LhWfVaqxMWAsIRHVrTC17HQGqJWIJEZ/uqVTddg5Bk4V3KYlmnNwxNOdqhJM9rUwClRtjkQanhsGj8LcUdz0iZvra5iQlJ/pX+FbBwwtnr1JNCl3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747097509; c=relaxed/simple;
	bh=dykArHGaxyt4Kxg8tkLURPYvkMUtVE3+EydPHwxxRFA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iSwTY2tZu7NnEk3yIg9+UZbi6ypBdcyPghqagKynnfQCNuffjpJlp4p90SQbFfaMuhUUtOyMXMCIjMJtszUbmPzxCNJyUP/HF1gqd1MFgPX9h9t0n9/U4sZu1Cnc5NMJJFGnqYGfLhFliU96Ynvrh4FbEM4I0Gz+IBI9gID0Xus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cyf0HtwH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cyf0HtwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7548CC4CEE7;
	Tue, 13 May 2025 00:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747097508;
	bh=dykArHGaxyt4Kxg8tkLURPYvkMUtVE3+EydPHwxxRFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cyf0HtwHystq8hcaqSIMC2f5usGGtKTyF7Vch/ZSM6x+fIcxyZ8OzdoHpZVxLGkZo
	 tr0P5ywCN2vHhW6V3BUt0H3JJtKOCA3udcBJ6Z3ffrur4mgJiGOE/NPr6mr1gRUdao
	 iSEN3YxngfNxkJ7vomun2M9tocuYpdoBRz3TcUsA=
Date: Mon, 12 May 2025 17:51:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v1 1/5] relayfs: support a counter tracking if per-cpu
 buffers is full
Message-Id: <20250512175147.925bcdcd5f6cfa71def08bb0@linux-foundation.org>
In-Reply-To: <20250512024935.64704-2-kerneljasonxing@gmail.com>
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
	<20250512024935.64704-2-kerneljasonxing@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 10:49:31 +0800 Jason Xing <kerneljasonxing@gmail.com> wrote:

> From: Jason Xing <kernelxing@tencent.com>
> 
> Add 'full' field in per-cpu buffer structure to detect if the buffer is
> full, which means: 1) relayfs doesn't intend to accept new data in
> non-overwrite mode that is also by default, or 2) relayfs is going to
> start over again and overwrite old unread data when kernel module has
> its own subbuf_start callback to support overwrite mode. This counter
> works for both overwrite and non-overwrite modes.
> 
> This counter doesn't have any explicit lock to protect from being
> modified by different threads at the same time for the better
> performance consideration. In terms of the atomic operation, it's not
> introduced for incrementing the counter like blktrace because side
> effect may arise when multiple threads access the counter simultaneously
> on the machine equipped with many cpus, say, more than 200. As we can
> see in relay_write() and __relay_write(), the writer at the beginning
> should consider how to use the lock for the whole write process, thus
> it's not necessary to add another lock to make sure the counter is
> accurate.
> 
> Using 'pahole --hex -C rchan_buf vmlinux' so you can see this field just
> fits into one 4-byte hole in the cacheline 2.

Does this alter blktrace output?  If so is that backward-compatible
(and do we care).  Is there any blktrace documentation which should be
updated?

Also, please check Documentation/filesystems/relay.rst and see if any
updates should be made to reflect the changes in this patchset.

I'm not really clear on the use cases of this counter - perhaps you can
be more verbose about this in the changelog.

> diff --git a/include/linux/relay.h b/include/linux/relay.h
> index f80b0eb1e905..022cf11e5a92 100644
> --- a/include/linux/relay.h
> +++ b/include/linux/relay.h
> @@ -28,6 +28,14 @@
>   */
>  #define RELAYFS_CHANNEL_VERSION		7
>  
> +/*
> + * Relay buffer error statistics dump
> + */
> +struct rchan_buf_error_stats
> +{
> +	unsigned int full;		/* counter for buffer full */
> +};

Why a struct?

>  /*
>   * Per-cpu relay channel buffer
>   */
> @@ -43,6 +51,7 @@ struct rchan_buf
>  	struct irq_work wakeup_work;	/* reader wakeup */
>  	struct dentry *dentry;		/* channel file dentry */
>  	struct kref kref;		/* channel buffer refcount */
> +	struct rchan_buf_error_stats stats; /* error stats */

Could simply use

	unsigned int full;

here?

Also, the name "full" implies to me "it is full".  Perhaps "full_count"
would be better.

>  	struct page **page_array;	/* array of current buffer pages */
>  	unsigned int page_count;	/* number of current buffer pages */
>  	unsigned int finalized;		/* buffer has been finalized */
> diff --git a/kernel/relay.c b/kernel/relay.c
> index 5aeb9226e238..b5db4aa60da1 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -252,8 +252,13 @@ EXPORT_SYMBOL_GPL(relay_buf_full);
>  static int relay_subbuf_start(struct rchan_buf *buf, void *subbuf,
>  			      void *prev_subbuf)
>  {
> +	int buf_full = relay_buf_full(buf);
> +
> +	if (buf_full)
> +		buf->stats.full++;

I don't understand the changelog's description of this, sorry.

Is it saying "this operation is protected by a lock"?  If so, please
specifically state which lock this is.

Or is it saying "we don't care if this races because the counter will
be close enough".  If so then maybe so, but things like KCSAN will
probably detect and warn and then people will want to address this.


