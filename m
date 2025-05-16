Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114423AD;
	Fri, 16 May 2025 02:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747361320; cv=none; b=lhejPIJZunqfY6iTvFENa4nZ6W14FPi0Ddn2xzlaw9c0Gpmeq052AZ3YR4/Jl9yZ28A0Qe4rU5+9GMgLdDSMXVWl4h3/8m6LJOa9KRrqfnzt9XSA5bsyU9466NTH3i912XWTv6HTQoezjdbRYZQabpxTUXs+h312bEXRo3qEXeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747361320; c=relaxed/simple;
	bh=irBezzit9VaurM2oY6CR9RnmhuZ2ej9ZOUEf0wkyeis=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LDYYgBwSDCxeN7V8gEPalVI5adVioJ5IlmnqCJ05bKj0J1L2S3Z/0f7UTsF4oQ9fw0HlUkPmmNI7x3KS/+xzVy30+mROxp3x1Gc3ANa2jMPPC6lcp/opODwaic+c5/OSNGAe3k5t+gdwvxaLahcFaErVrZiFKSuCxaam+3iU1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma+NaXL+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma+NaXL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D046FC4CEE7;
	Fri, 16 May 2025 02:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747361320;
	bh=irBezzit9VaurM2oY6CR9RnmhuZ2ej9ZOUEf0wkyeis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ma+NaXL+4Mtot2QdyJisGok4fSar6B6ZHbnuRUQgLIStXRoYxycb93Pc16grhxEMN
	 gBlNSoNCS0OXXuA8kzkf5ZZyWw8L8F18kCx6eKes1jLL08BYgsgPFD7PNZLC/pn5Yw
	 weYCHYAl9MRC34fOSQR19GxowfdGHPjjL524nHVV9zZUxNPFoVIg4dRKP/sUYdv1Pu
	 hr8f4DvLXbhd63/CNusfWOvI84n/o6/NKkda13/ceMDqcCOv+e3WkJ1JwgZnsTiwLW
	 Vs19poIhuKyeMpkex3no/IG0+3lCZL2eNX0kejIIXjXddXFwcJcE2YLAWWVR9WKR7k
	 F1sA9qaw78JRg==
Date: Fri, 16 May 2025 11:08:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v2 2/4] relayfs: introduce dump of relayfs statistics
 function
Message-Id: <20250516110837.355d963224cf74ea2b020d9d@kernel.org>
In-Reply-To: <20250515061643.31472-3-kerneljasonxing@gmail.com>
References: <20250515061643.31472-1-kerneljasonxing@gmail.com>
	<20250515061643.31472-3-kerneljasonxing@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 14:16:41 +0800
Jason Xing <kerneljasonxing@gmail.com> wrote:

> From: Jason Xing <kernelxing@tencent.com>
> 
> In this version, only support dumping the counter for buffer full and
> implement the framework of how it works.
> 
> Users can pass certain flag to fetch what field/statistics they expect
> to know. Each time it only returns one result. So do not pass multiple
> flags.
> 
> Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v2
> 1. refactor relay_dump() and make it only return a pure size_t result
> of the value that users specifies.
> 2. revise the commit log.
> ---
>  include/linux/relay.h |  7 +++++++
>  kernel/relay.c        | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/include/linux/relay.h b/include/linux/relay.h
> index ce7a1b396872..3fb285716e34 100644
> --- a/include/linux/relay.h
> +++ b/include/linux/relay.h
> @@ -31,6 +31,12 @@
>  /*
>   * Relay buffer statistics dump
>   */
> +enum {
> +	RELAY_DUMP_BUF_FULL = (1 << 0),
> +
> +	RELAY_DUMP_LAST = RELAY_DUMP_BUF_FULL,
> +};
> +
>  struct rchan_buf_stats
>  {
>  	unsigned int full_count;	/* counter for buffer full */
> @@ -167,6 +173,7 @@ struct rchan *relay_open(const char *base_filename,
>  			 void *private_data);
>  extern void relay_close(struct rchan *chan);
>  extern void relay_flush(struct rchan *chan);
> +extern size_t relay_dump(struct rchan *chan, int flags);
>  extern void relay_subbufs_consumed(struct rchan *chan,
>  				   unsigned int cpu,
>  				   size_t consumed);
> diff --git a/kernel/relay.c b/kernel/relay.c
> index eb3f630f3896..f47fc750e559 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -701,6 +701,37 @@ void relay_flush(struct rchan *chan)
>  }
>  EXPORT_SYMBOL_GPL(relay_flush);
>  
> +/**
> + *	relay_dump - dump channel buffer statistics

nit: relay_dump() can mislead to dump relay channel contents.
Can you rename it to relay_stats() or relay_get_stats()?

Thanks,

> + *	@chan: the channel
> + *	@flags: select particular information to dump
> + *
> + *	Returns the count of certain field that caller specifies.
> + */
> +size_t relay_dump(struct rchan *chan, int flags)
> +{
> +	unsigned int i, count = 0;
> +	struct rchan_buf *rbuf;
> +
> +	if (!chan || flags > RELAY_DUMP_LAST)
> +		return 0;
> +
> +	if (chan->is_global) {
> +		rbuf = *per_cpu_ptr(chan->buf, 0);
> +		if (flags & RELAY_DUMP_BUF_FULL)
> +			count = rbuf->stats.full_count;
> +	} else {
> +		for_each_online_cpu(i) {
> +			if ((rbuf = *per_cpu_ptr(chan->buf, i)))
> +				if (flags & RELAY_DUMP_BUF_FULL)
> +					count += rbuf->stats.full_count;
> +		}
> +	}
> +
> +	return count;
> +}
> +EXPORT_SYMBOL_GPL(relay_dump);
> +
>  /**
>   *	relay_file_open - open file op for relay files
>   *	@inode: the inode
> -- 
> 2.43.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
