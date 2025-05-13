Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8DA35963;
	Tue, 13 May 2025 00:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747097518; cv=none; b=Nu37JrBLWhmNX6rD3fbQXFoPm77sLNaWANQFsAXvb03huqMpxblQgh7hTtYF60jxFzvbYG8YkwnuwXxgqFoGKPyUs8Hf0KQGIGP8FDGBydvH4BwOGEPQbnhOiOcU/InCEan7MMcYtn/SyQOpk+vcxs6wHD5Kz/y0kTYLpZWJLGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747097518; c=relaxed/simple;
	bh=rfJCN3r9RGU/4beIquN6/Ebr6OHx6dDmJrAUfCNm8Lc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nxVQn3BhTs1QD3wAn9vY7U9dXrm6eSgBQm3U+bOd+utp4N5Bf2ICSo7XdtuHsKX1fWrOtCRYc89mram5mwx/WJj90fa9ZlOydUmuKgLuRk7Hq+Vg5HVOnB1X61A2/wdO7aT14xjYipJF2C1ybujOssIg+WwULEYMYc+FW22aVko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KfHjFBd8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KfHjFBd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CCCC4CEEE;
	Tue, 13 May 2025 00:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747097517;
	bh=rfJCN3r9RGU/4beIquN6/Ebr6OHx6dDmJrAUfCNm8Lc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KfHjFBd8k4juzPALdtOd3py3ZkANvRO49njEUO/LHEdar7nG04btyMjZa2VNbws5V
	 FzO8y2yQijfAMvvrUGe20P1iK3O6GIjawHAUptBq49hZ2gk9YUNsnvUWfso0vL/dpw
	 Y386NynjyodQWdwjMUhX6lkuVd7SBD2Xplluxarg=
Date: Mon, 12 May 2025 17:51:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v1 2/5] relayfs: introduce dump of relayfs statistics
 function
Message-Id: <20250512175156.7d3d4db53d40c7a34c1f68d6@linux-foundation.org>
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

On Mon, 12 May 2025 10:49:32 +0800 Jason Xing <kerneljasonxing@gmail.com> wrote:

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
> ...
>  
> +/**
> + *	relay_dump - dump statistics of the specified channel buffer
> + *	@chan: the channel
> + *	@buf: buf to store statistics
> + *	@len: len of buf to check
> + *	@flags: select particular information to dump
> + */
> +void relay_dump(struct rchan *chan, char *buf, int len, int flags)

`size_t' is probably a more appropriate type for `len'.

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

So we left the memory at *buf uninitialized but failed to tell the
caller this.  The caller will then proceed to use uninitialized memory.

It's a programming error, so simply going BUG seems OK.

> +	if (chan->is_global) {
> +		rbuf = *per_cpu_ptr(chan->buf, 0);
> +		full_counter = rbuf->stats.full;
> +	} else {
> +		for_each_possible_cpu(i) {

I'm thinking that at this stage in the patch series, this should be
for_each_online_cpu(), then adjust that in patch [5/5].

> +			if ((rbuf = *per_cpu_ptr(chan->buf, i)))
> +				full_counter += rbuf->stats.full;
> +	}
> +
> +	if (flags & RELAY_DUMP_BUF_FULL)
> +		offset += snprintf(buf, sizeof(unsigned int), "%u", full_counter);

This seems strange.  sizeof(unsigned int) has nothing to do with the
number of characters which are consumed by expansion of "%u"?

> +
> +	snprintf(buf + offset, 1, "\n");
> +}
> +EXPORT_SYMBOL_GPL(relay_dump);
> +
>  /**
>   *	relay_file_open - open file op for relay files
>   *	@inode: the inode

