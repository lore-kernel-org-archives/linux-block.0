Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ACD1D90A5
	for <linux-block@vger.kernel.org>; Mon,  6 Jan 2025 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736152222; cv=none; b=c3+ILzady+D6VAwLahNJNZJcyKQdfNFnbn11nv2X8P34CEd+HchwgRlx+rIgZVUTXly59/LGKl2p11hcb+/hiCFgRcwabNzFjATQE24FrJ1I6CahERj2Wn7hFNwkUAjSTDEzN9Gu+QgpJ2gnQJxREB++l5o59RdRcr0BBS4yO3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736152222; c=relaxed/simple;
	bh=YjzUEfeQfN9APDogMiuB4MDYeaMSCCrn26HGfSjDBUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmPyN4yXnT6yuC4lJc4EpsbBga7f+hr+CoEoknugHWf6oY1Rm4JQ/aQMPF2WP0vvC+gdUlw9rmnKOCwH6AR7TJYzm8XT3S6iIFLP1g7FlpwHJBk2cqFllFcqO74QHhRn2sTCPumbGdgya8TfsCpMw/ZSY0Vs1el51R8aP8RFFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A9E3E68C7B; Mon,  6 Jan 2025 09:30:15 +0100 (CET)
Date: Mon, 6 Jan 2025 09:30:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 2/3] block: Fix __blk_mq_update_nr_hw_queues() queue
 freeze and limits lock order
Message-ID: <20250106083014.GD18408@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250104132522.247376-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jan 04, 2025 at 10:25:21PM +0900, Damien Le Moal wrote:
> __blk_mq_update_nr_hw_queues() freezes a device queues during operation,
> which also includes updating the BLK_FEAT_POLL feature flag for the
> device queues using queue_limits_start_update() and
> queue_limits_commit_update(). This call order thus creates an invalid
> ordering of a queue freeze and queue limit locking which can lead to a
> deadlock when the device driver must issue commands to probe the device
> when revalidating its limits.
> 
> Avoid this issue by moving the update of the BLK_FEAT_POLL feature flag
> out of the main queue remapping loop to the end of
> __blk_mq_update_nr_hw_queues(), after the device queues have been
> unfrozen.

What happens if I/O is queued after the unfreeze, but before clearing
the poll flag?

