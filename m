Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA71964D
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 06:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744611702; cv=none; b=ovNe/dRQEsZj1bdNJoJG4u0KLuXJ8Uu6LWSoOulKsQlRoqcMJAHe9VNvVOpJUKID+DNBE6JuKzRPb0gqYti1emdkiPCkDUQ6EY78tHVT/7hSrZpXUzusLrnoUpv1vYMM79jQzxcLK+4ztp61QovRyAjPqYRCmwSwL+ZgEGoXYX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744611702; c=relaxed/simple;
	bh=CgSCsUEPkjWr9rpSvIRdNfmlUVv3qFoLvsoSKqvdyHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce3d1F+qaorymUoFycuEZbk/SZHiIY9h1wNrlMcrFXdA0sdJXgsk67ViF1BACepyrQVyYuxXtKVYDoaPegUZHhY0OV9KFcHpWrEwdNcIDJLNvAK1mrA08movY6xl3uSFRjO3TBrFF8xeXXGrohSQ/29rciySdgqcPOkwv4CXwMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D13C67373; Mon, 14 Apr 2025 08:21:35 +0200 (CEST)
Date: Mon, 14 Apr 2025 08:21:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/15] block: add `struct elev_change_ctx` for unifying
 elevator change
Message-ID: <20250414062135.GB6673@lst.de>
References: <20250410133029.2487054-1-ming.lei@redhat.com> <20250410133029.2487054-9-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410133029.2487054-9-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Apr 10, 2025 at 09:30:20PM +0800, Ming Lei wrote:
> +		struct elev_change_ctx ctx = {
> +			.name	= "none",
> +			.force	= 1,
> +			.uevent	= 1,
> +		};
>  
>  		mutex_lock(&q->elevator_lock);
>  		if (q->elevator && !blk_queue_dying(q))
> +			ctx.name = q->elevator->type->elevator_name;
> +		__elevator_change(q, &ctx);
>  		mutex_unlock(&q->elevator_lock);

Can we have this whole code section in a helper in elevator.c and
keep the low-level __elevator_change function private there?

> +/* Holding data for changing elevator */
> +struct elev_change_ctx {
> +	const char *name;
> +	unsigned int force:1;
> +	unsigned int uevent:1;

Using an integer type for flags is odd.  This should a boolean, or even
better aflags field with flag names.

And I think with the flag names we can just pass the name and the flags
and do away with the separate structure entirely.
