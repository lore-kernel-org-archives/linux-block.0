Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDF13A3F2;
	Tue, 13 May 2025 00:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747097526; cv=none; b=ayxbMABrsNBKoWFW+Z+ayP/hjJopUiTQapPREw+BMbIWUJ1d49MApLufmqJj+lugW2BK1b+U1JKLE1jN7vfDgtbqy9a7L8Oc5v6wG7nBMslk6ndhLlNgthMdUGskP9qoDemk3Rytu6POlxwKVyPWXnuGGq7jrmpMvComV3Q4W8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747097526; c=relaxed/simple;
	bh=O9o8/bvVIX+Q/y1eX04IGbKASaY13MNl+otnvwElV/I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rcMY80QM7nJmKA+FGxAQRaJ6okNZvz+V9Xj9UpYKtpfQ9MN9RzJfU46EALFJQCeAKanZr1cEG2a4IfVvbbU8aXexs1qFBkzZcD/ptxOKaU6xkzLipSKZo9MNCdt8ZTltSkahly+qeMo1BGG+eeEfcYcRuV+yVO4eauQCl7JQqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bXEy6+qZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bXEy6+qZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C678C4CEEE;
	Tue, 13 May 2025 00:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747097525;
	bh=O9o8/bvVIX+Q/y1eX04IGbKASaY13MNl+otnvwElV/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bXEy6+qZV7ia91hQjBEzsuWpR32xJLOOnOJ9lOHHiJZclgegci7Bnz4voyHeJFtQT
	 NZY1o5s/8AG/4qGFWCz4cmj7pnZ7KvZXgdwdZwqXcyHjZsyS45dsi/UxiulFuqYQLf
	 uiV2nYG+dnJu7zLmkMKN6I98KWC7ddjncFVrS3NA=
Date: Mon, 12 May 2025 17:52:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Jason Xing
 <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v1 5/5] relayfs: uniformally use possible cpu iteration
Message-Id: <20250512175204.8faa5fd646da7247137db14b@linux-foundation.org>
In-Reply-To: <20250512024935.64704-6-kerneljasonxing@gmail.com>
References: <20250512024935.64704-1-kerneljasonxing@gmail.com>
	<20250512024935.64704-6-kerneljasonxing@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 May 2025 10:49:35 +0800 Jason Xing <kerneljasonxing@gmail.com> wrote:

> From: Jason Xing <kernelxing@tencent.com>
> 
> Use for_each_possible_cpu to create per-cpu relayfs file to avoid later
> hotplug cpu which doesn't have its own file.

I don't understand this.  Exactly what problem are we trying to solve?

> Reviewed-by: Yushan Zhou <katrinzhou@tencent.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  kernel/relay.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/relay.c b/kernel/relay.c
> index 27f7e701724f..dcb099859e83 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -519,7 +519,7 @@ struct rchan *relay_open(const char *base_filename,
>  	kref_init(&chan->kref);
>  
>  	mutex_lock(&relay_channels_mutex);
> -	for_each_online_cpu(i) {
> +	for_each_possible_cpu(i) {

num_possible_cpus() can sometimes greatly exceed num_online_cpus(), so
this is an unfortunate change.  It would be better to implement the
hotplug notifier?

>  		buf = relay_open_buf(chan, i);
>  		if (!buf)
>  			goto free_bufs;
> @@ -615,7 +615,7 @@ int relay_late_setup_files(struct rchan *chan,
>  	 * no files associated. So it's safe to call relay_setup_buf_file()
>  	 * on all currently online CPUs.
>  	 */
> -	for_each_online_cpu(i) {
> +	for_each_possible_cpu(i) {
>  		buf = *per_cpu_ptr(chan->buf, i);
>  		if (unlikely(!buf)) {
>  			WARN_ONCE(1, KERN_ERR "CPU has no buffer!\n");
> -- 
> 2.43.5
