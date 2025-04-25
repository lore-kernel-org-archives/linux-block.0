Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455118870C
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745605850; cv=none; b=aFqPZbD8329708SmJAUmZUCGGQyZPwMqZ4FB9S1paUPDFTGSoxphU4Mp9irtyQjSJUyfh69anLLYVzYAOI1he/6T5zM6XhCGj82otVJZUm2Xl9YmSRhC+76pgHTmw5QZ4ZCqWK7hnI6yiTDn/03yKIvAdIGNKkyxcD9CypFYnXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745605850; c=relaxed/simple;
	bh=KbkM7NX0opR18TVUe3vRyhfBADZr8lTKxHjiN7+Kgtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VId9z+AzBgyt4j7pKrKz5RbLoXXDjTjWWfQXGZeoYB9pOzVCZWW/myAccjeVaAjrt/7QQ7oInbeFWDSF12/PhWK++iboZW+XlHoxXhBarxf1nKLXhgVaZK/738zRJhgBnQfg1FPMuY50xnrcieQH+0Hl+QjNw476V1mvBZr6ueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C27D468BEB; Fri, 25 Apr 2025 20:30:43 +0200 (CEST)
Date: Fri, 25 Apr 2025 20:30:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 13/20] block: unifying elevator change
Message-ID: <20250425183043.GB26154@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com> <20250424152148.1066220-14-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424152148.1066220-14-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 24, 2025 at 11:21:36PM +0800, Ming Lei wrote:
> elevator change is one well-define behavior:

Start the sentence captitalized.

> +static bool use_default_elevator(struct request_queue *q)
>  {
>  	if (q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
> +		return false;
>  
>  	if (q->nr_hw_queues != 1 &&
>  	    !blk_mq_is_shared_tags(q->tag_set->flags))
> +		return false;
>  
> +	return true;

looking at the only caller I think this is better open coded there.

> @@ -694,7 +651,7 @@ static int __elevator_change(struct request_queue *q,
>  	lockdep_assert_held(&q->tag_set->update_nr_hwq_sema);
>  
>  	/* Make sure queue is not in the middle of being removed */
> -	if (!blk_queue_registered(q))
> +	if (!ctx->init && !blk_queue_registered(q))

This init flag is confusingly also set by the teardown, so it is quite
misnamed.  But given that none of the locks held here protected the
queue registered flag, why not just move the check out to
elv_iosched_store and remove the entire need for the flag?

> +/*
> + * Use the default elevator settings. If the chosen elevator initialization
> + * fails, fall back to the "none" elevator (no elevator).
> + */
> +void elevator_set_default(struct request_queue *q)
> +{
> +	struct elv_change_ctx ctx = {
> +		.init = true,
> +	};
> +	int err;
> +
> +	if (!queue_is_mq(q))
> +		return;

Please keep this in the caller.  Same for the set_none side.

> +
> +	ctx.name = use_default_elevator(q) ? "mq-deadline" : "none";
> +	if (!q->elevator && !strcmp(ctx.name, "none"))
> +		return;
> +	err = elevator_change(q, &ctx);

q->elevator can't be set here.  And the extra none strcmp is weird
because we have the boolean information avaiable.

Just make this:

	struct elv_change_ctx ctx = {
		.name = "mq-deadline",
	};

	...

 	if (!(q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT) &&
	    (q->nr_hw_queues == 1 ||
	     blk_mq_is_shared_tags(q->tag_set->flags))) {
		err = elevator_change(q, &ctx);

> +	if (err < 0)
> +		pr_warn("\"%s\" set elevator failed %d, "
> +			"falling back to \"none\"\n", ctx.name, err);

Please keep the more useful message from the current code.

