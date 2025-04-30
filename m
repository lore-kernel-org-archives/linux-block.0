Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75D0145A03
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022540; cv=none; b=A2prT/N52VuStwFgQ61DmvF0xI7CogKYipr79DuGgzcfEFhGBAJ7Qu2h8p6G9vbR3J7Gqs26/cmjwW0nNWOy+MQqNgMBxAZW2vhLuM/02utIjrzzATx5tye/nmQ/II3yWrXTPf0GqafQywdza1DXRR2bHezuZ2RmO4kw1fk+Qhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022540; c=relaxed/simple;
	bh=hdKN39FXl1voi+derZCqwrY9phwdQCd4TnlWH5dTc24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/s0HHS7LwC/EyssvrA+vbvXvF/Ny/5nThB0TNLsQ5x3mCk4aqzqdoXPI8W/c8XYYdtleku5xQMuxRpFTZCXfzGdxd7eUVnY6Rwdo5FlxMF5dPQ4mS6sxqgHXlzzYb/bCM5SsX1JbYpGm1NWUgcz/jRmDSY8boLXe3mGecr+F1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D19E467373; Wed, 30 Apr 2025 16:15:33 +0200 (CEST)
Date: Wed, 30 Apr 2025 16:15:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V4 14/24] block: add `struct elv_change_ctx` for
 unifying elevator change
Message-ID: <20250430141533.GD6702@lst.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com> <20250430043529.1950194-15-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430043529.1950194-15-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

>  void elv_update_nr_hw_queues(struct request_queue *q)
>  {
> -	const char *name = "none";
> +	struct elv_change_ctx ctx = {
> +		.name	= "none",
> +	};
>  
>  	WARN_ON_ONCE(q->mq_freeze_depth == 0);
>  
>  	mutex_lock(&q->elevator_lock);
>  	if (q->elevator && !blk_queue_dying(q) && !blk_queue_registered(q))
> -		name = q->elevator->type->elevator_name;
> +		ctx.name = q->elevator->type->elevator_name;
>  	/* force to reattach elevator after nr_hw_queue is updated */
> -	elevator_switch(q, name);
> +	elevator_switch(q, &ctx);

I don't think this elevator_switch is needed or even a good idea outside
the above if clause.  Moving it in there would also restore the behavior
in the earlier version of this series.

With that ctx.name also doesn't need to be initialized to none at
declaration time.

