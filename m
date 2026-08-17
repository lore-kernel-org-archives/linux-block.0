Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B183B7753
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954226; cv=none; b=VG9Y65e20+qnB12iVorBThGq6YKt980qnHWjKAkgSXEuIgjHuvGGWqd0EKcmY0gjQdF+UseUPUkI9DX2NGrY+7wgcSZRdIwxTaV5imq7ioUYaJ08yizAAsG3tWuH/t2b3fqZkDO8Oschf1i1MHOs9NtWJxQhBGQp0paYRxRTaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954226; c=relaxed/simple;
	bh=85kU5xKXObhNhCG5rbepL+Bv1P3p+br1POaokRE29So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgXbmkwztUwZHpSVfq8A9MJoeIZYLu3pA0tdr0V5n0IKknlRXC+gtSCClJ49FLnFs7TckulPSMoZFgQzPs5fgJPGBUcMtyk6HlvNjL8AAxL71YFX1eep74jMQX4RaCzCd2I29+eEcFaNP133I20gwLgHhQhu+QengbkpiYENAsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4728568D07; Mon, 17 Aug 2026 10:10:18 +0200 (CEST)
Date: Mon, 17 Aug 2026 10:10:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/4] block: factor out path limit stacking
Message-ID: <20260817081017.GC21461@lst.de>
References: <20260806024658.4193386-1-sangyao@kylinos.cn> <20260806024658.4193386-4-sangyao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806024658.4193386-4-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 06, 2026 at 10:46:57AM +0800, Yao Sang wrote:
> +static void blk_stack_path_limits(struct queue_limits *t,
> +		const struct queue_limits *b)

I find the path limits name a bit confusing, but I don't really
have a much better suggestion.

> +	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);

overly long line here.

I wonder if we sould have a helper macro that encapsulates the

	t = min_not_zero(t, b)

pattern to make all these lines a bit easier to read while we're
at it?

>  	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
>  	t->max_user_sectors = min_not_zero(t->max_user_sectors,
>  			b->max_user_sectors);
> -	t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
> -	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
>  	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
>  					b->max_write_zeroes_sectors);
>  	t->max_user_wzeroes_unmap_sectors =

I'm also not sure why some limits are included in the path limits
and other not.  E.g. wy not max_write_zeroes_sectors?

