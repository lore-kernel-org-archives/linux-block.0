Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB4317BEC5
	for <linux-block@vger.kernel.org>; Wed,  9 Oct 2024 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459257; cv=none; b=QGtj2qrinmRHPCSvvnFTtZRkblZNQlptVxWo5EgtG7ZJClj2/YYC2rf3sXUEKoEPzZlrYZbHtYZJ8ZuT6HKgy8/7JZzDKlm610YJWlETFDXXbTnZJCHeJ1VVkvlsq4AsRnz3kpwxH8s9Yzv3wVPPS+4cTmsfHlzMKqQxOMLQfRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459257; c=relaxed/simple;
	bh=YzvMDE1y2Pz+AUD/o7TQMLucgSZcBeHzl+zrFo0GQN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ese/AHK0hArzt0OO6J/Hj1O4RjesGcV0eQpUPHXrkWayhKPoPtqiUQyw2+SKz3PoBfJ6UywSiv+TKH8+Vd6qXdeUgE+6a3+9JzhcPwwRrfQs3bmvZjnj6DbhxTA0R0/bu2aQD0kUrEYwj1NXCkCRPbhOUZSMKr3xeZ7u71omX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9861B227A8E; Wed,  9 Oct 2024 09:34:06 +0200 (CEST)
Date: Wed, 9 Oct 2024 09:34:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	YangYang <yang.yang@vivo.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also mark disk-owned queues as dying in
 __blk_mark_disk_dead
Message-ID: <20241009073406.GA15983@lst.de>
References: <20241008115756.355936-1-hch@lst.de> <20241008115756.355936-2-hch@lst.de> <20241009050602.GC565009@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009050602.GC565009@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 09, 2024 at 02:06:02PM +0900, Sergey Senozhatsky wrote:
> >  	if (!test_bit(GD_OWNS_QUEUE, &disk->state)) {
> > +		if (test_bit(QUEUE_FLAG_RESURRECT, &q->queue_flags))
> > +			clear_bit(QUEUE_FLAG_DYING, &q->queue_flags);
> 
> Don't know if we also want to clear QUEUE_FLAG_RESURRECT here, just in
> case.

Yes, we really should do that.

