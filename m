Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61B520EB
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 04:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409286; cv=none; b=swfA46JArHMC6dhUIhoNavhCD2QN0mFUSz7kGGw455XILxCSpPv0qDdV898KdAZrHfAwYGNsHEVQGBOoxEd0wL/u1De4m3dv4zGoEGtZMyWRnaxN8zGkBPUc+dCLeTK6F7Fu+0ggO7l4qStuUaFfrbPn4iF7M7owRp1cnggByeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409286; c=relaxed/simple;
	bh=B2s1DjWFHX8EhFfDs02IwRjKeNxCnlWLf7Xkp7QhRR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkZddtQbVzb0WZxhL3qIIIKsa52HobFoyd9Gn7+aaXEL64VsBxfe2Rhb6QzqyuUxh6cNJtEDLHcAJjMLaDL+dMPQfIcraKxZxgnx/G/bxpGfXQLExthP2zF6DzUGolAuey9ve5YNQLaVoi0z2j7W8B2WBoKmAoewXcGfJcSytjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F51668BEB; Tue, 17 Dec 2024 05:21:20 +0100 (CET)
Date: Tue, 17 Dec 2024 05:21:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 2/6] blk-zoned: Document the locking order
Message-ID: <20241217042120.GB15358@lst.de>
References: <20241216210244.2687662-1-bvanassche@acm.org> <20241216210244.2687662-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216210244.2687662-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 16, 2024 at 01:02:40PM -0800, Bart Van Assche wrote:
> Document that zwplug->lock is the outer lock relative to
> disk->zone_wplugs_lock.
> 
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-zoned.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 1575b887fa38..3e42372fa832 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -46,7 +46,8 @@ static const char *const zone_cond_name[] = {
>   *       reference is dropped whenever the zone of the zone write plug is reset,
>   *       finished and when the zone becomes full (last write BIO to the zone
>   *       completes).
> - * @lock: Spinlock to atomically manipulate the plug.
> + * @lock: Spinlock to atomically manipulate the plug. Outer lock relative to
> + *	disk->zone_wplugs_lock.

That's pretty odd wording.  If you think this information is important
we should probably have a comment at the top of the file explaining the
lock order like in many MM or VFS source files.

