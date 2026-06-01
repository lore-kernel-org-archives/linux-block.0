Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E2386453
	for <linux-block@vger.kernel.org>; Mon,  1 Jun 2026 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299221; cv=none; b=CQKN8NdzsQi6AEOjUAifdMzUw2e7n/QTR2FK2F8mORpwEYV8RkkUCqAJS70mRihiwoSJr5mLPbgFi5h/d2xvr31s3pH35fioJUeWOOSWMkWY6WalVfGeN2S68wJOsoj7dUqoa/Qq8yzsTZofRzHk6kN6z2pcLD213Zs+raFL3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299221; c=relaxed/simple;
	bh=Jo6xyLUpZexThRp9ZB4QKt1PDaaCuc/bxfZD8AMOCvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhKsI1ARvTTVenCpW5CrLkZ1eifDe+KStLd9hkSqiFzxqlLS0l5o2hoQnj6ItYZVPh1HTLS0uQM0uoH4BAzvlNZQoq2jtaUxkbGVLorfgiuCeTkX1Kx3hZdvKV7Ne6vn2Fb5r5q/nj5bzGeWsW/Zv/S+ZKTxtNnKxNWzE3sYDGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9A3D568B05; Mon,  1 Jun 2026 09:33:37 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:33:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v5 09/12] block/blk-mq-debugfs: Improve lock context
 annotations
Message-ID: <20260601073337.GE7799@lst.de>
References: <cover.1779997063.git.bvanassche@acm.org> <b49bc91945356894b8ab1dc2de1aabad6db3ce16.1779997063.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b49bc91945356894b8ab1dc2de1aabad6db3ce16.1779997063.git.bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 28, 2026 at 12:45:46PM -0700, Bart Van Assche wrote:
> Make the existing lock context annotations compatible with Clang. Add
> the lock context annotations that are missing.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-mq-debugfs.c | 12 ++++++------
>  block/blk.h            |  4 ++++
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 047ec887456b..5c168e82273e 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -20,7 +20,7 @@ static int queue_poll_stat_show(void *data, struct seq_file *m)
>  }
>  
>  static void *queue_requeue_list_start(struct seq_file *m, loff_t *pos)
> -	__acquires(&q->requeue_lock)
> +	__acquires(&((struct request_queue *)m->private)->requeue_lock)

I try to member where we got stuck on this, but isn't there a way
to at least have a macro for this dereference that can have a comment?

Also I guess most seq_file users will have a mess like this, but I
don't really know a good way around it.

