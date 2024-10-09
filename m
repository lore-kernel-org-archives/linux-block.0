Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D8C191F90
	for <linux-block@vger.kernel.org>; Wed,  9 Oct 2024 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477706; cv=none; b=HcX34SXrl8itBD+DfsUCDcLo0YldkEKv2oG6Ili3d71Bl/5MggzGWMZWUFK7OT3S3oK628N4Wvqi3o9oSMX5yfwcNrgGO04ZSH2s4GJ5m3ycjO56G3KS3tDSc62vQ2QPIKRr0BDYbXfpZxaoLg/lj1uS6NU4m1pcB97yI8MlFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477706; c=relaxed/simple;
	bh=VvZPLC8EOlsmsCAFrCGTI89JQjBvEzIWCVgqHQujppo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+HQB972uNOuWu+CO3uTZ1LBqXAwaz/XPkNzo6wXHIT1J87BKLsOpaKSWzuweaC2jG3SdulUWG3tk3Wnbc9xNpQ8upYJ7wLB0bjgjFVAMvcGhPbG097/Lozpq6BAhZeuOvaiqwpcilkE24F5oZ9cURbweChUeN8zVO+1KlsUq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5AF0F227AAA; Wed,  9 Oct 2024 14:41:38 +0200 (CEST)
Date: Wed, 9 Oct 2024 14:41:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <20241009124137.GA21408@lst.de>
References: <20241009113831.557606-1-hch@lst.de> <20241009113831.557606-2-hch@lst.de> <20241009123123.GD565009@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009123123.GD565009@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 09, 2024 at 09:31:23PM +0900, Sergey Senozhatsky wrote:
> >  	if (!test_bit(GD_OWNS_QUEUE, &disk->state)) {
> > +		if (test_bit(QUEUE_FLAG_RESURRECT, &q->queue_flags)) {
> > +			clear_bit(QUEUE_FLAG_DYING, &q->queue_flags);
> > +			clear_bit(QUEUE_FLAG_RESURRECT, &q->queue_flags);
> > +		}
> 
> Christoph, shouldn't QUEUE_FLAG_RESURRECT handling be outside of
> GD_OWNS_QUEUE if-block? Because __blk_mark_disk_dead() sets
> QUEUE_FLAG_DYING/QUEUE_FLAG_RESURRECT regardless of GD_OWNS_QUEUE.

For !GD_OWNS_QUEUE the queue is freed right below, so there isn't much
of a point.

> // A silly nit: it seems the code uses blk_queue_flag_set() and
> // blk_queue_flag_clear() helpers, but there is no queue_flag_test(),
> // I don't know what if the preference here - stick to queue_flag
> // helpers, or is it ok to mix them.

Yeah.  I looked into a test_and_set wrapper, but then saw how pointless
the existing wrappers are.  So for now this just open codes it, and
once we're done with the fixes I plan to just send a patch to remove
the wrappers entirely.

