Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8213E1219
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756294; cv=none; b=hcQAcyPU9CGXIZSRDY3BvWEJEvQs3zxnGjkdCCqb/I6WzhEdA1sx5lqpMI0AiP6khEOo47OnxOPDejqO/RDVLDRWzn4ZjbmmQr69gvgqyMR6LcDEgIndiM2l0P7FvexR3TJmRUvtKjc0Yzm+7NP6MBl3jy1G8N3Xr9ui7N9SohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756294; c=relaxed/simple;
	bh=PFJqwj7w4jlk+h+2Hd+Q4SxEbwFH3dEExMAA9yLgFE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJOYoVRIBhbXYfb64uqypWhveKMy4JIfogNHwM95WRmniPjpPB0YF+I/0gWaJe2CRITAw9K1C3sC34IU4TgQGXb125VoEDMkuSTkO16G0Pz0m0cJlCirRcPa1sV4P5zbLZGrQepdN/PJnYrL4OIdWqteQ3bzrVSXwnxS33sa8JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EBFDE68BEB; Tue, 17 Mar 2026 15:04:48 +0100 (CET)
Date: Tue, 17 Mar 2026 15:04:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v2 02/12] block: Make the lock context annotations
 compatible with Clang
Message-ID: <20260317140448.GB2670@lst.de>
References: <20260316200901.4111651-1-bvanassche@acm.org> <20260316200901.4111651-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316200901.4111651-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 16, 2026 at 01:08:39PM -0700, Bart Van Assche wrote:
> Clang is more strict than sparse with regard to lock context annotation
> checking. Hence this patch that makes the lock context annotations
> compatible with Clang.

Does it break sparse in the way?  If so we'll need to find out a way
to disable the sparse lock annotations conditionally as there are
other warnings we only get from spare.  Most importantly the __bitwise
warnings for endianess and the address spaces for user/mmio pointers.
All these are arguably more important than the lock annotations.
(If only the compilers could pick these up natively...)

> __release() annotations have been added below
> invocations of indirect calls that unlock a mutex because Clang does not
> support annotating function pointers with __releases().

Please split this up into a patch per area and document what you're
doing in each area in the commit log.

>  	if (bdev->bd_holder_ops && bdev->bd_holder_ops->freeze) {
>  		error = bdev->bd_holder_ops->freeze(bdev);
>  		lockdep_assert_not_held(&bdev->bd_holder_lock);
> +		__release(&bdev->bd_holder_lock); /* blk_holder_ops::freeze() */

I have no idea what this comment is supposed to mean.

>  	} else {
>  		mutex_unlock(&bdev->bd_holder_lock);
>  		error = sync_blockdev(bdev);
> @@ -356,6 +357,7 @@ int bdev_thaw(struct block_device *bdev)
>  	if (bdev->bd_holder_ops && bdev->bd_holder_ops->thaw) {
>  		error = bdev->bd_holder_ops->thaw(bdev);
>  		lockdep_assert_not_held(&bdev->bd_holder_lock);
> +		__release(&bdev->bd_holder_lock); /* blk_holder_ops::freeze() */

Same.

> -	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
> +	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead) {
>  		bdev->bd_holder_ops->mark_dead(bdev, surprise);
> -	else {
> +		/* blk_holder_ops::mark_dead() */

Same.

>  int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
> +	__no_context_analysis /* conditional locking */

Please always try to refactor code to avoid the conditional locking
first, and only if that doesn't work it go for this, explaining why
you had to do that in the commit message.

>  static void *kyber_##name##_rqs_start(struct seq_file *m, loff_t *pos)	\
> -	__acquires(&khd->lock)						\
> +	__acquires(((struct kyber_hctx_data *)((struct blk_mq_hw_ctx *)m->private)->sched_data)->lock) \
>  {									\

Urrg.  Is there some way to make this less ugly?  A macro?

Same for all the other crazy cast+dereference instances.

> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

This isn't block layer code at all.

