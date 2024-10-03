Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00CB1E871
	for <linux-block@vger.kernel.org>; Thu,  3 Oct 2024 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727960462; cv=none; b=sQgXuanRzBIQVyMzcqbTTxsvlTG+z3NmJjzAZlfUKMIMM1EwZnmwEW72VV1nUtmNeZNmQaEolFyrfKWjRWBSC/llrOv3OAqjhRWinHrvNUzvK6lbcvVCdK3OF8NID/XEUvlnsWIVBjE2lZD30l+JKcPFTkKVElcg0gVpvM049uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727960462; c=relaxed/simple;
	bh=MYPrw1HfQmRdBN/Pm0tt4Z+sahqR0WRNOi94CW8Ecqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCJctjebtCDjNg+vySiPhm1jGAoFyn4xx5tC6Be0QP/LYUYjxWFn0Irf7u8hvGUDxYDPjoYc14s1haiBHobUrOsN1nq60IEr4vzPaaP0dNAhmzWrPEmJ+U/4i7Wflww/Sik7o3ZzE4fy2/e6yVQuzMOX0rhUY3vlFe0ISnDTfkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E5C9227A88; Thu,  3 Oct 2024 15:00:55 +0200 (CEST)
Date: Thu, 3 Oct 2024 15:00:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block: enable passthrough command statistics
Message-ID: <20241003130053.GE17031@lst.de>
References: <20241002210744.72321-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002210744.72321-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 02, 2024 at 02:07:44PM -0700, Keith Busch wrote:
> +		accounting of the disk. Set to 0 to disable all stats. Set to 1
> +		to enable block IO stats. Set to 2 to enable passthrough stats
> +		in addition to block IO.

Jens' reply suggest he likes this interface, but I have to say I
already hated it with a passion for the merges - overloading a
previously boolean file with a numberic value is not exactly an
intuitive interface.  Is a new sysfs file for this really a problem?

> +	if (!bio)
> +		return false;
> +	if (!bio->bi_bdev)
> +		return false;
> +	if (blk_rq_bytes(req) & (bdev_logical_block_size(bio->bi_bdev) - 1))
> +		return false;

I understand why all these conditions are there, because basically
they'd break the current code to collect stats.  But I think this needs
a comment explaining why they are there, and why the statistics are
still useful without the requests matching them.

> +	lim = queue_limits_start_update(disk->queue);
> +	if (!ios)
> +		lim.features &= ~(BLK_FEAT_IO_STAT | BLK_FEAT_PASSTHROUGH_STAT);
> +	else if (ios == 2)
> +		lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_PASSTHROUGH_STAT;
> +	else if (ios == 1) {
> +		lim.features |= BLK_FEAT_IO_STAT;
> +		lim.features &= ~BLK_FEAT_PASSTHROUGH_STAT;

BLK_FEAT_IO_STAT is in ->features because drivers need to opt into it,
but BLK_FEAT_PASSTHROUGH_STAT is purely a flag triggered by sysfs and
should go into ->flags.

