Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAEE12CDBF
	for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 06:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729578394; cv=none; b=mjpxM92E+8neY7wmFiaO3yd5htX4rN3V325uJFdjRHU46gkqMT9N141/LCVtkbCn7FSRcpNXbUJ6uhuhjEVsM/m4SeqisjOoLoDWkXim36FecSC+nU5BFokSTrkfYlU7mEAzKOqRviWNS4dSMzOc35CcOnaII9E0toPmCQvHA0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729578394; c=relaxed/simple;
	bh=9TogqvMs8NpwphK1AsgYcxYazWWn+OEA1q1oVO4R75Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGk+fFi0v+Cylrw1rN3Oa92T4dhX4b2KTky69oMOThYjH4Mfy2SDVx3yVPeZvXcItsSqAkq/dIp/p7kGmq8zqv8iAuhlG75GaVH1pHx2xN5rHS0ZpvT53DvHnrIaZwK6DsfHzBPbrByuM/jugclBlrlEATXQ4GvGEhe9KP62OHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 02418227AA8; Tue, 22 Oct 2024 08:26:26 +0200 (CEST)
Date: Tue, 22 Oct 2024 08:26:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: model freeze & enter queue as rwsem for
 supporting lockdep
Message-ID: <20241022062626.GB10573@lst.de>
References: <20241018013542.3013963-1-ming.lei@redhat.com> <46493f6f-850e-459e-a4be-116deb5d3ca0@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46493f6f-850e-459e-a4be-116deb5d3ca0@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Oct 18, 2024 at 09:57:12AM -0700, Bart Van Assche wrote:
> Thank you for having reported this issue and for having proposed a
> patch. I think the following is missing from the patch description:
> (a) An analysis of which code causes the inconsistent nested lock order.
> (b) A discussion of potential alternatives.
>
> It seems unavoidable to me that some code freezes request queue(s)
> before the limits are updated. Additionally, there is code that freezes
> queues first (sd_revalidate_disk()), executes commands and next updates
> limits. Hence the inconsistent order of freezing queues and obtaining
> limits_lock.
>
> The alternative (entirely untested) solution below has the following
> advantages:
> * No additional information has to be provided to lockdep about the
>   locking order.
> * No new flags are required (SKIP_FREEZE_LOCKDEP).
> * No exceptions are necessary for blk_queue_exit() nor for the NVMe
>   driver.

As mentioned by Ming fixing the lockdep reports is a bit different
from adding it first.  But I'll chime in for your proposal to fix
the report anyway.

I think requiring the queue to be frozen before we start the queue
limits update is reasonable in general, but a major pain for
sd_revalidate_disk, and unfortunately I don't think your proposed patch
works there as it doesn't protect against concurrent updates from
say sysfs, and also doesn't scale to adding new limits.

One option to deal with this would be to add an update sequence to
the queue_limits.  sd_revalidate_disk would sample it where it
currently starts the update, then drop the lock and query the
device, then takes the limits lock again, checks for the sequence.
If it matches it commits the update, else it retries.

