Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096483B0583
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954441; cv=none; b=FIcwwsNdH1BHCMlXtFc0VnhBbezqKuAhHhGFnt5P9e1M6Ws4dFR4vNc8BFr1lpc2IkydMyEVC0FKn5BCEgkhqNunNrBNZhxh16v48jkq+86hBELK6XzH9HjrbunnaQdG//iS6rOzPvZmwQ4aB9T2VGpfznJN6rMMUu/Rl757yOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954441; c=relaxed/simple;
	bh=73z/J5sGC1pKzm5zmL9Si+on8FxxY6Je3Xpzbs9duvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6i7Nyqfred9ArNmeVc6+nOtSOPoxAH0vohSUzYi1U1lcR3NZRh1KW6GaqVfWGAwK76RatoXHa1L12Qj3eSVrTwaSxWEGWuLyhMY6XIq3ALj52NvSpkhI7xPxUb7lp6a1+CmLxBWXHwK1o5EEk0UAvJX1EaCIpwFubXVgmwCiHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3FCF868CFE; Mon, 17 Aug 2026 10:13:55 +0200 (CEST)
Date: Mon, 17 Aug 2026 10:13:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 4/4] block, nvme: use lower-level limit helpers for
 namespace heads
Message-ID: <20260817081355.GD21461@lst.de>
References: <20260806024658.4193386-1-sangyao@kylinos.cn> <20260806024658.4193386-5-sangyao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806024658.4193386-5-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 06, 2026 at 10:46:58AM +0800, Yao Sang wrote:
> An NVMe namespace head and each path refer to the same namespace.
> queue_limits_stack_bdev() treats the path as a bottom-device range and
> applies all of blk_stack_limits(), including topology rules and start-based
> atomic write checks. These mapped-device rules should not be used when
> updating the namespace head.
> 
> Make blk_stack_path_limits() and the existing
> blk_stack_atomic_writes_limits() public when adding their first caller
> outside the block layer. Keep the existing names and parameter types.

I'd move the making public including the kerneldoc and export into
the patches adding them.  Much better than hiding that in nvme patches.

> +static void nvme_apply_ns_head_identify_limits(struct queue_limits *lim,
> +		const struct queue_limits *ns_lim)

Nothing in here feels nvme specific.  I wonder how much of this
should be in common code, and if that would be useful to John's
scsi multipath work?

