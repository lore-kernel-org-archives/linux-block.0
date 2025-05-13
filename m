Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399C02F85B;
	Tue, 13 May 2025 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130294; cv=none; b=lAmjC0u+Sm8/q6VYfmm7+OZxNib3CC73vX6iuEDsPsI+6luVTz3zJFRjV9SsJFUS574P+EOYinoTDt5tWyV/f2KNwDmu2+mT53WS8UQPqptzPosJD5TTpMjJsE+9aIo2sletX5KudjKumeQlHtWewz+HbS3EQ+ZfBJEtPdcgDM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130294; c=relaxed/simple;
	bh=CIStumLbA7h8G3wMXshXEHGNUXbJZDxIRH0X9c6sHTU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=keruMmktWKp8KoeOaxfgys/e8ooS7LailMVQwg+gavmyOPMA8CeAObhvjUvFsd3vldgVhYsaUAu3tV8t9h3Xea7spz33Ki/K+3FlPYwSlpBi66ThEGUTXUVEG7PmkF62QbW/52YiPBTf0w4gY6QSr9Qn0mxOTzfI/3K9yLl7Mss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lACNBNeA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lACNBNeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1F3C4CEE4;
	Tue, 13 May 2025 09:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747130293;
	bh=CIStumLbA7h8G3wMXshXEHGNUXbJZDxIRH0X9c6sHTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lACNBNeAFNJHMSbGN8Y0rEVZExrT2X3GN3yGaxx5LbGfACukoHjGdnWQ8MM3F2FJk
	 3ulaYt0WnYZgFyRQH1Xru3j31iXdFhwvJh+L6/ym4Jou98Skp2Wd23AnqnYrFVpGwm
	 dRWUN26sqgM6aTBRv/J3PC6xdiFFnQqSs4IdgqZetVS9EKO/S0JV6blwQ4kE1ONJeN
	 BsCbPxgp0h4aylet1HJ8bC0+xu+rwNwikN2VcUtuccxOAqp5UkBQKkt3qhhMLDXYbP
	 XZcutSYDosNt2D3e1yIyqqdFKQRSlJT+HD6AEMkB45TvWurcgPok+0cYP3EfcuAprr
	 Wgf6mgQHOI1iQ==
Date: Tue, 13 May 2025 18:58:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v1 2/5] relayfs: introduce dump of relayfs statistics
 function
Message-Id: <20250513185810.3d57dfe2a0c05784ddf8f0a9@kernel.org>
In-Reply-To: <20250512024935.64704-3-kerneljasonxing@gmail.com>
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
	<20250512024935.64704-3-kerneljasonxing@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jason,

On Mon, 12 May 2025 10:49:32 +0800
Jason Xing <kerneljasonxing@gmail.com> wrote:

> From: Jason Xing <kernelxing@tencent.com>
> 
> In this version, only support dumping the counter for buffer full and
> implement the framework of how it works. Users MUST pass a valid @buf
> with a valid @len that is required to be larger than RELAY_DUMP_BUF_MAX_LEN
> to acquire which information indicated by @flags to dump.
> 
> RELAY_DUMP_BUF_MAX_LEN shows the maximum len of the buffer if users
> choose to dump all the values.
> 
> Users can use this buffer to do whatever they expect in their own kernel
> module, say, print to console/dmesg or write them into the relay buffer.
> 
> Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/linux/relay.h | 10 ++++++++++
>  kernel/relay.c        | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/include/linux/relay.h b/include/linux/relay.h
> index 022cf11e5a92..7a442c4cbead 100644
> --- a/include/linux/relay.h
> +++ b/include/linux/relay.h
> @@ -31,6 +31,15 @@
>  /*
>   * Relay buffer error statistics dump
>   */
> +enum {
> +	RELAY_DUMP_BUF_FULL = (1 << 0),
> +
> +	RELAY_DUMP_LAST = RELAY_DUMP_BUF_FULL,
> +	RELAY_DUMP_MASK = (RELAY_DUMP_LAST - 1) | RELAY_DUMP_LAST
> +};
> +
> +#define RELAY_DUMP_BUF_MAX_LEN 32
> +
>  struct rchan_buf_error_stats
>  {
>  	unsigned int full;		/* counter for buffer full */
> @@ -170,6 +179,7 @@ extern int relay_late_setup_files(struct rchan *chan,
>  				  struct dentry *parent);
>  extern void relay_close(struct rchan *chan);
>  extern void relay_flush(struct rchan *chan);
> +extern void relay_dump(struct rchan *chan, char *buf, int len, int flags);
>  extern void relay_subbufs_consumed(struct rchan *chan,
>  				   unsigned int cpu,
>  				   size_t consumed);
> diff --git a/kernel/relay.c b/kernel/relay.c
> index b5db4aa60da1..0e675a77285c 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -810,6 +810,41 @@ void relay_flush(struct rchan *chan)
>  }
>  EXPORT_SYMBOL_GPL(relay_flush);
>  
> +/**
> + *	relay_dump - dump statistics of the specified channel buffer
> + *	@chan: the channel
> + *	@buf: buf to store statistics
> + *	@len: len of buf to check
> + *	@flags: select particular information to dump
> + */
> +void relay_dump(struct rchan *chan, char *buf, int len, int flags)
> +{
> +	unsigned int i, full_counter = 0;
> +	struct rchan_buf *rbuf;
> +	int offset = 0;
> +
> +	if (!chan || !buf || flags & ~RELAY_DUMP_MASK)
> +		return;
> +
> +	if (len < RELAY_DUMP_BUF_MAX_LEN)
> +		return;
> +
> +	if (chan->is_global) {
> +		rbuf = *per_cpu_ptr(chan->buf, 0);
> +		full_counter = rbuf->stats.full;
> +	} else {
> +		for_each_possible_cpu(i) {
> +			if ((rbuf = *per_cpu_ptr(chan->buf, i)))
> +				full_counter += rbuf->stats.full;
> +	}
> +
> +	if (flags & RELAY_DUMP_BUF_FULL)
> +		offset += snprintf(buf, sizeof(unsigned int), "%u", full_counter);
> +
> +	snprintf(buf + offset, 1, "\n");

Is there any reason to return the value as string?
If it returns a digit value and the caller makes it a string,
it could be more flexible for other use cases.

Thank you,

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
