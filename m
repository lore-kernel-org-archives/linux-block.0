Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DEF635
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 06:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747807443; cv=none; b=kjQ36y+Ez6yQ+HOnaCAm85HwXOIMlGGVW8QFqe0hZ6oKB2xVqq8fT95muN+FoYfZXwrwt0nE9tXie92OFedMaYMyy/gDOYkBkCHwYFqpyhMxPHWwp9jOMZ70hXZe6zb4YDiYAVZVS4Wj0MSUMHHeFVobRuRIL3+HKZ56kn50/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747807443; c=relaxed/simple;
	bh=t9Uz4cO33PK9UfNYkKSLJgJyqiFatjc+LnYR1zekIMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSLD52XmLr4FNx4Bt6vNr+k66IKN+mCE2+7CVeoyJN+55ey3sSydvwlplbxGakeCTV20aifYwK8xXQK3dRBIkv9+sN0+sZ1iX5PEGsHEx0cMzVf5SGC1slEvbkZzH7VgpXsSyjLy4AjO7Yxk5SGKroz4elRGt0gIZjhKmuNecUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1DBDD68D1C; Wed, 21 May 2025 08:03:58 +0200 (CEST)
Date: Wed, 21 May 2025 08:03:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	hch@lst.de, axboe@kernel.dk, sth@linux.ibm.com, gjoyce@ibm.com
Subject: Re: [PATCH] block: fix lock dependency between percpu alloc lock
 and elevator lock
Message-ID: <20250521060357.GA3404@lst.de>
References: <20250520103425.1259712-1-nilay@linux.ibm.com> <aC1Ropdb5x05WCIc@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC1Ropdb5x05WCIc@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 21, 2025 at 12:08:02PM +0800, Ming Lei wrote:
> Not dig into this implementation, will look into later.
> 
> I guess it should work by extending elv_change_ctx.
> 
> However we have other elevator_queue lifetime issue, that is why
> ->elevator_lock is used almost everywhere.
> 
> Another solution is to move all `sched_data` into 'struct elevator_queue':

With "sched_data" you primarily mean the sched tags here, right?

Anyway, getting scheduler owned items out of the request_queue and into
the elevator data seems like the right thing to do, but it might indeed
be very invasive.

