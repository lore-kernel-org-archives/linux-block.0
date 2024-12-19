Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9988E148FE8
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 06:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734589040; cv=none; b=HWGpKZN01lSQE09sNVteNH/uTERNbq+WrOx5bcMgtcAgiMF7Vo8TGAaAnEc+gY/uMbhX9r1FPSNBs6zv8hV/Y5uuUhL+6BHvYg74Z1h97wAYiDKJgf40KyCGOJKrBq4jNO1McdS7oiQ4YpBadGAQZHVYj9wtPNThN3q7yUOWbE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734589040; c=relaxed/simple;
	bh=mwMIxPogSq9MWscre/DDzLjRXLXwexxn7/O5R7LyeQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzoVhvG7hoadjZeHXBnuvIoePBz/c5dCAXqgPcrgP3Y2Vh+TJ46m02Q4OTCIfJUPD8TMB811ONF8j7v/x9cs7nT52EG3mleRousLLshnOjFg3L+PgSgYZz/QozcKUi62Aqx3dc4EP7GdsWi5+3JzPSskvcZvaCVQDt7iLeYMCAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4B1B868AFE; Thu, 19 Dec 2024 07:17:14 +0100 (CET)
Date: Thu, 19 Dec 2024 07:17:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Ming Lei <ming.lei@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: avoid to hold q->limits_lock across APIs
 for atomic update queue limits
Message-ID: <20241219061713.GB19575@lst.de>
References: <Z2DZc1cVzonHfMIe@fedora> <20241217044056.GA15764@lst.de> <Z2EizLh58zjrGUOw@fedora> <20241217071928.GA19884@lst.de> <Z2Eog2mRqhDKjyC6@fedora> <a032a3a0-0784-4260-92fd-90feffe1fe20@kernel.org> <Z2Iu1CAAC-nE-5Av@fedora> <f34f179a-4eaf-4f73-93ff-efb1ff9fe482@linux.ibm.com> <Z2LQ0PYmt3DYBCi0@fedora> <0fdf7af6-9401-4853-8536-4295a614e6d2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fdf7af6-9401-4853-8536-4295a614e6d2@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 18, 2024 at 07:35:36PM +0530, Nilay Shroff wrote:
> One simple way I could think of would be updating queue_limit_xxx() APIs and
> then use it,
> 
> queue_limits_start_update(struct request_queue *q, bool freeze) 
> {
>     ...
>     mutex_lock(&q->limits_lock);
>     if(freeze)
>         blk_mq_freeze_queue(q);
>     ...

Conditional locking (and the freeze sort of is a lock) is always a bad
idea.  But we can do a lower level no-free API or this use case.

