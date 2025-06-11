Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E122A4CC;
	Wed, 11 Jun 2025 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629030; cv=none; b=BI9fW7JDhM2N5NGQpekC4olRsnlBQnbH+c+kbAYR1+awU7dtvPucS+G6kyujOgUQCCq5UvhSyjxFKWDqFqF47LQ5C+DD2/pZDdh9DDvtJv/33v3kup3oIuYnpEC/zjVzYPNDUG//YfGIQPwVzPxFEjGPty6mcdLt26LJmBo4yqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629030; c=relaxed/simple;
	bh=FF/lHwVmvuS/PuJN9WCo9t19979ouT1jzg36Num1n2M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P5LSgIKA79pNFarB4G2+mp3KZcCwDJiD82g3uEnx9F1uulUCQl8cnMIJ1vpli2t8QRieHoNqrcXf92MWefQNESXwvVVqKoTT4iEEVeYIEk32XNXt1fwq/KwvZX0OCDdL3fVbqDt1Tfrc5XwhZ18qXGzLp06FKhg7Wg+27DOC1zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cso6HS8+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cso6HS8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F79DC4CEEE;
	Wed, 11 Jun 2025 08:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749629029;
	bh=FF/lHwVmvuS/PuJN9WCo9t19979ouT1jzg36Num1n2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cso6HS8+Kj0pZHq2A+5pz9++Z1mH/FyxlcippYbqh/sZqbS+1kGDK8RF+WB1sWj49
	 VsMkb4+ymBClrOPiAJaDlohazXJAgZiPS8bpqcfkd29rcF/S3yXCc4ISbPNQ4/Cw4w
	 Yr+qv5IOx3D9iYJW4HTmcioSLsUV8uM3CFGle7tOo0zJRQRgm9ilvE70hF2Qd8P7LJ
	 Xeh7pW4k+96KyAQXJttgc0mqx2fqVzC3XjSCrqD+BJOi3ShINLAabRdEEnf83nTbAc
	 /p+/3oeGHI6JYS+byl+BJRwxhDKCD7rmIb8wZ8B77wC/Kq8Zi4sfG0myZVgXHBd3MN
	 5+YnylS1VTG4A==
Date: Wed, 11 Jun 2025 17:03:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v4 1/5] relayfs: abolish prev_padding
Message-Id: <20250611170346.cc5b885bca560417602540c4@kernel.org>
In-Reply-To: <20250610004844.66688-2-kerneljasonxing@gmail.com>
References: <20250610004844.66688-1-kerneljasonxing@gmail.com>
	<20250610004844.66688-2-kerneljasonxing@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 08:48:40 +0800
Jason Xing <kerneljasonxing@gmail.com> wrote:

> From: Jason Xing <kernelxing@tencent.com>
> 
> prev_padding represents the unused space of certain subbuffer. If the
> content of a call of relay_write() exceeds the limit of the remainder of
> this subbuffer, it will skip storing in the rest space and record the
> start point as buf->prev_padding in relay_switch_subbuf(). Since the buf
> is a per-cpu big buffer, the point of prev_padding as a global value for
> the whole buffer instead of a single subbuffer (whose padding info is
> stored in buf->padding[]) seems meaningless from the real use cases, so
> we don't bother to record it any more.

Sounds reasonable.

> 
> Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  drivers/gpu/drm/i915/gt/uc/intel_guc_log.c |  3 +--
>  drivers/net/wwan/iosm/iosm_ipc_trace.c     |  3 +--
>  drivers/net/wwan/t7xx/t7xx_port_trace.c    |  2 +-
>  include/linux/relay.h                      |  5 +----
>  kernel/relay.c                             | 14 ++++++++------
>  kernel/trace/blktrace.c                    |  2 +-
>  6 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
> index e8a04e476c57..09a64f224c49 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
> @@ -220,8 +220,7 @@ static int guc_action_control_log(struct intel_guc *guc, bool enable,
>   */
>  static int subbuf_start_callback(struct rchan_buf *buf,
>  				 void *subbuf,
> -				 void *prev_subbuf,
> -				 size_t prev_padding)
> +				 void *prev_subbuf)
>  {
>  	/*
>  	 * Use no-overwrite mode by default, where relay will stop accepting
> diff --git a/drivers/net/wwan/iosm/iosm_ipc_trace.c b/drivers/net/wwan/iosm/iosm_ipc_trace.c
> index eeecfa3d10c5..9656254c1c6c 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_trace.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_trace.c
> @@ -51,8 +51,7 @@ static int ipc_trace_remove_buf_file_handler(struct dentry *dentry)
>  }
>  
>  static int ipc_trace_subbuf_start_handler(struct rchan_buf *buf, void *subbuf,
> -					  void *prev_subbuf,
> -					  size_t prev_padding)
> +					  void *prev_subbuf)
>  {
>  	if (relay_buf_full(buf)) {
>  		pr_err_ratelimited("Relay_buf full dropping traces");
> diff --git a/drivers/net/wwan/t7xx/t7xx_port_trace.c b/drivers/net/wwan/t7xx/t7xx_port_trace.c
> index 4ed8b4e29bf1..f16d3b01302c 100644
> --- a/drivers/net/wwan/t7xx/t7xx_port_trace.c
> +++ b/drivers/net/wwan/t7xx/t7xx_port_trace.c
> @@ -33,7 +33,7 @@ static int t7xx_trace_remove_buf_file_handler(struct dentry *dentry)
>  }
>  
>  static int t7xx_trace_subbuf_start_handler(struct rchan_buf *buf, void *subbuf,
> -					   void *prev_subbuf, size_t prev_padding)
> +					   void *prev_subbuf)
>  {
>  	if (relay_buf_full(buf)) {
>  		pr_err_ratelimited("Relay_buf full dropping traces");
> diff --git a/include/linux/relay.h b/include/linux/relay.h
> index b3224111d074..e10a0fdf4325 100644
> --- a/include/linux/relay.h
> +++ b/include/linux/relay.h
> @@ -47,7 +47,6 @@ struct rchan_buf
>  	unsigned int page_count;	/* number of current buffer pages */
>  	unsigned int finalized;		/* buffer has been finalized */
>  	size_t *padding;		/* padding counts per sub-buffer */
> -	size_t prev_padding;		/* temporary variable */
>  	size_t bytes_consumed;		/* bytes consumed in cur read subbuf */
>  	size_t early_bytes;		/* bytes consumed before VFS inited */
>  	unsigned int cpu;		/* this buf's cpu */
> @@ -84,7 +83,6 @@ struct rchan_callbacks
>  	 * @buf: the channel buffer containing the new sub-buffer
>  	 * @subbuf: the start of the new sub-buffer
>  	 * @prev_subbuf: the start of the previous sub-buffer
> -	 * @prev_padding: unused space at the end of previous sub-buffer
>  	 *
>  	 * The client should return 1 to continue logging, 0 to stop
>  	 * logging.
> @@ -100,8 +98,7 @@ struct rchan_callbacks
>  	 */
>  	int (*subbuf_start) (struct rchan_buf *buf,
>  			     void *subbuf,
> -			     void *prev_subbuf,
> -			     size_t prev_padding);
> +			     void *prev_subbuf);
>  
>  	/*
>  	 * create_buf_file - create file to represent a relay channel buffer
> diff --git a/kernel/relay.c b/kernel/relay.c
> index c0c93a04d4ce..94f79f52d826 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -250,13 +250,13 @@ EXPORT_SYMBOL_GPL(relay_buf_full);
>   */
>  
>  static int relay_subbuf_start(struct rchan_buf *buf, void *subbuf,
> -			      void *prev_subbuf, size_t prev_padding)
> +			      void *prev_subbuf)
>  {
>  	if (!buf->chan->cb->subbuf_start)
>  		return !relay_buf_full(buf);
>  
>  	return buf->chan->cb->subbuf_start(buf, subbuf,
> -					   prev_subbuf, prev_padding);
> +					   prev_subbuf);
>  }
>  
>  /**
> @@ -302,7 +302,7 @@ static void __relay_reset(struct rchan_buf *buf, unsigned int init)
>  	for (i = 0; i < buf->chan->n_subbufs; i++)
>  		buf->padding[i] = 0;
>  
> -	relay_subbuf_start(buf, buf->data, NULL, 0);
> +	relay_subbuf_start(buf, buf->data, NULL);
>  }
>  
>  /**
> @@ -555,9 +555,11 @@ size_t relay_switch_subbuf(struct rchan_buf *buf, size_t length)
>  		goto toobig;
>  
>  	if (buf->offset != buf->chan->subbuf_size + 1) {
> -		buf->prev_padding = buf->chan->subbuf_size - buf->offset;
> +		size_t prev_padding;
> +
> +		prev_padding = buf->chan->subbuf_size - buf->offset;
>  		old_subbuf = buf->subbufs_produced % buf->chan->n_subbufs;
> -		buf->padding[old_subbuf] = buf->prev_padding;
> +		buf->padding[old_subbuf] = prev_padding;
>  		buf->subbufs_produced++;
>  		if (buf->dentry)
>  			d_inode(buf->dentry)->i_size +=
> @@ -582,7 +584,7 @@ size_t relay_switch_subbuf(struct rchan_buf *buf, size_t length)
>  	new_subbuf = buf->subbufs_produced % buf->chan->n_subbufs;
>  	new = buf->start + new_subbuf * buf->chan->subbuf_size;
>  	buf->offset = 0;
> -	if (!relay_subbuf_start(buf, new, old, buf->prev_padding)) {
> +	if (!relay_subbuf_start(buf, new, old)) {
>  		buf->offset = buf->chan->subbuf_size + 1;
>  		return 0;
>  	}
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 3f6a7bdc6edf..d3083c88474e 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -461,7 +461,7 @@ static const struct file_operations blk_msg_fops = {
>   * the user space app in telling how many lost events there were.
>   */
>  static int blk_subbuf_start_callback(struct rchan_buf *buf, void *subbuf,
> -				     void *prev_subbuf, size_t prev_padding)
> +				     void *prev_subbuf)
>  {
>  	struct blk_trace *bt;
>  
> -- 
> 2.43.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
