Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1926403150;
	Tue, 26 May 2026 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815155; cv=none; b=XD4fLOYlEi8+wxyuHHL7T17oQrbOaYXzzvP0+G5o1/RTyqL0dksmwtLFX9r8G/sDMpIsFTDin0F53lvfzUfBH+BFPQpqtvHimOfz0iz9e/2DeEAU7kBGK6VZ1uTBFDjZSAe7tAU1V/iaU+rgiR8y7PINqqIWDEjDpMcLBDRdoII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815155; c=relaxed/simple;
	bh=YwiBdqTTI+MzFu0gmZVucmSu2x+c0H/dGMa8DRydGXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMNwg0h6+AwBwF10tYvz+fWaVQUDl0R/hFSQ1AkDxWDn0gpaiIS0i3NsGnXIaxrx2surv68vyKtBVsmFZJtrPtZYgr8DHlqNoKqb/IgLlu5BP6OOJkGqzS+/FCp2VUIG5vECUw1VjrY3Jo+yUW+JPr9mKigUIzojLUtFhY3g4i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8BhK+Ht; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8BhK+Ht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455EB1F000E9;
	Tue, 26 May 2026 17:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815152;
	bh=PmNGpYbXcCi/H+1rET6iqOrDKpMsTwG8PxKGlVYNFG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f8BhK+HtBrlwMU9T2Ih4G5WiNw1G/e1Ur/p4GjnStMrar3I/SJsQKG4ZIlxfkfpXr
	 c/40a6mmBSo3//JlTwOarnQJDIH0ZUB62sx0gRG+pZR7PXbcY1KdqLSwbnAQbPxUDU
	 oukZwOFq6EW/IuAoHMTpm4mXiy9tSqTlCWecV3vIF5XA6zuH9+N53KCaZHrVUFbiV3
	 dXE5XVQuH1zRPMvVw0M3JF0L1q9DeEXiAycGSaAPbVnsKToVxROPdOUnXiKUuw4/QX
	 sUmr4qfrh693Em0H8WtjJnGVHghAbYYKdpFh7GFezS57PBbIqhoCsdfrZIHEaKc+O4
	 YyVD7rKyLGK8g==
Date: Tue, 26 May 2026 11:05:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] block: blk-mq: fix ws_active refcount leak in
 blk_mq_mark_tag_wait()
Message-ID: <ahXS7gkpU3LbcJJ0@kbusch-mbp>
References: <20260526103722.2287587-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526103722.2287587-1-vulab@iscas.ac.cn>

On Tue, May 26, 2026 at 10:37:22AM +0000, Wentao Liang wrote:
> blk_mq_mark_tag_wait() calls sbitmap_queue_get() which increments
> sbq->ws_active. On the error path where the waitqueue_active() check
> fails and the function returns early, sbq->ws_active is not decremented,
> leaking the reference.

I must be confused as I'm not making sense of this. Not only does
blk_mq_mark_tag_wait not call sbitmap_queue_get, sbitmap_queue_get does
not increment sbq->ws_active either. Could you clarify the actual
sequence?
 
> Fix this by calling sbitmap_queue_clear() to properly release the
> ws_active reference before returning on the error path.

And same here, I don't see sbitmap_queue_clear() called anywhere in this
path, nor does sbitmap_queue_clear() release ws_active anyway. What is
the actual sequence that gets there? 

> Fixes: c27d53fb445f ("blk-mq: Reduce the number of if-statements in blk_mq_mark_tag_wait()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  block/blk-mq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d0c37daf568f..e1c2ac416693 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1952,6 +1952,8 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
>  	spin_lock_irq(&wq->lock);
>  	spin_lock(&hctx->dispatch_wait_lock);
>  	if (!list_empty(&wait->entry)) {
> +		list_del_init(&wait->entry);
> +		atomic_dec(&sbq->ws_active);

As far as I can tell, sbq->ws_active is incremented from three places:

  - blk_mq_mark_tag_wait() itself, but just below this line. So your
    change decrements before the local increment happened, no?
  - sbitmap_prepare_to_wait() / sbitmap_add_wait_queue() in
    lib/sbitmap.c, which are unrelated helpers not used here

What am I missing?
