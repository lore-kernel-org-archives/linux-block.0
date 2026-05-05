Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D91248C8A6;
	Tue,  5 May 2026 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999080; cv=none; b=Y7hko3Z7Q6ZxmbXFxckofwAWQqrEbUHb3W8uRlRUURP1r2o1LOV28Y/Dofc59q+v1r0uOc1Z+xaLb6wr64bfbVh7CYzhc09Nia7PZ2+AamCagDyHVLbXXHQFZVmdP+hs20g/vMpN9O/Q4yPS4YfrJp2BhxF18BEB+wactSKqPt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999080; c=relaxed/simple;
	bh=OR+cXX3O3Pn5AnhBdDXDFvoMA55eZX7aqCQYJmBcSwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwL8SQdQewAkSQJ8w9uIezLkr88c+9H/yAOsk01p6IjkFvxpd8NKBfheKGn3p6m2i8hjTOOrbNG9vd07+cT/zttf9gvOamxGiGsylPiaUcWS/J1zecbj4BdC7lZ3/02Yf5AjA7G0sQKMmrNyKgwZFVkvSzXd8CW6RGwZsCYEacY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PT5kkN6R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PT5kkN6R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33B5C2BCB4;
	Tue,  5 May 2026 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777999080;
	bh=OR+cXX3O3Pn5AnhBdDXDFvoMA55eZX7aqCQYJmBcSwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PT5kkN6Rg7Zr+umAFS68riH9fPZUlYimaVd9+UCV993sVtUPjG+zgOMNOoYZYxPZ8
	 XKU3by1C9G1rulwOyQGw4c8h4sVfkr26Nzkx9wHCFLiQULmbqOqNVEL9nZMnHE9iQE
	 0Skc4Rss8oYhJUIiPKqbXtdcKYEf8XJjHmM3t8bFtgKkkGawOTHA1SeY+Nml47OeNb
	 pBPnJHtDzmrnPbvfCUO/Z4/c7dK5+syJJN959XwjlGLAK0Uft2aowz6oEh390QzQkC
	 5dhxZJTU1qRsxSb0wE6fW+wrztq85AXi5R3hT+YAoi+VC3sC7fJlmCoomP0y8JnFcS
	 iVtuXeABi/OMA==
Date: Tue, 5 May 2026 09:37:58 -0700
From: Minchan Kim <minchan@kernel.org>
To: Richard Chang <richardycc@google.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>, bgeffon@google.com,
	liumartin@google.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] zram: fix use-after-free in zram_writeback_endio
Message-ID: <afoc5qLvK2PDQKb-@google.com>
References: <20260504123230.3833765-1-richardycc@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504123230.3833765-1-richardycc@google.com>

On Mon, May 04, 2026 at 12:32:30PM +0000, Richard Chang wrote:
> A crash was observed in zram_writeback_endio due to a NULL pointer
> dereference in wake_up. The root cause is a race condition between the
> bio completion handler (zram_writeback_endio) and the writeback task.
> 
> In zram_writeback_endio, wake_up() is called on &wb_ctl->done_wait after
> releasing wb_ctl->done_lock. This creates a race window where the
> writeback task can see num_inflight become 0, return, and free wb_ctl
> before zram_writeback_endio calls wake_up().
> 
> CPU 0 (zram_writeback_endio)       CPU 1 (zram_complete_done_reqs)
> ============================       ============================
> spin_lock(&wb_ctl->done_lock);
> list_add(&req->entry, &wb_ctl->done_reqs);
> spin_unlock(&wb_ctl->done_lock);
>                                    while (&wb_ctl->num_inflight) > 0)
>                                    spin_lock(&wb_ctl->done_lock);
>                                    list_del(&req->entry);
>                                    spin_unlock(&wb_ctl->done_lock);
> 				   // num_inflight becomes 0
>                                    atomic_dec(&wb_ctl->num_inflight);
>                                    returns to writeback_store();
> 				   // frees wb_ctl
>                                    release_wb_ctl(wb_ctl);
> 
> // UAF crash!
> wake_up(&wb_ctl->done_wait);
> 
> Fix this by moving wake_up() inside the done_lock critical section.
> This ensures that zram_complete_done_reqs cannot consume the request
> and decrement num_inflight until zram_writeback_endio has finished
> calling wake_up() and released the lock.
> 
> Fixes: f405066a1f0d ("zram: introduce writeback bio batching")
> Signed-off-by: Richard Chang <richardycc@google.com>
> ---
>  drivers/block/zram/zram_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index aebc710f0d6a..a457fdf564f8 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -966,9 +966,8 @@ static void zram_writeback_endio(struct bio *bio)
>  
>  	spin_lock_irqsave(&wb_ctl->done_lock, flags);
>  	list_add(&req->entry, &wb_ctl->done_reqs);
> -	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
> -
>  	wake_up(&wb_ctl->done_wait);
> +	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
>  }
>  

I agree this will fix the issue, but using a lock to extend the lifetime of
an object to avoid a UAF is not a good pattern. Object lifetime shared between
process and interrupt contexts should be managed explicitly using refcount.

Furthermore, keeping wake_up() outside the critical section minimizes
interrupt-disabled latency and avoids nesting spinlocks
(done_lock -> done_wait.lock), reducing the risk of future lockdep
issues, just in case.

It definitely will add more overhead for the submission/completion paths to deal
with the refcount, but I think we should go that way at the cost of runtime.
