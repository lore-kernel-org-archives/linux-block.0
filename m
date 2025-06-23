Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B769E347DD
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685814; cv=none; b=fybBDOfoEgps33CrVeBp8eLbEMsa76Nqa/UKyM7AXQfH2CRY8DTTZRUGbWe4QogPOOHAoWPM/QE7nd+YB3L6/aOlbYohMalz6AtFhw9crpJrtTbZ9Myo8IXnpGPaJs5wcnmmTiULwL+Ow05hZ6BT3eLnYE+Lp+WQWrXdZequiNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685814; c=relaxed/simple;
	bh=shDSWe0/zknBL3jGY6VkJ5guKjrnEL41QRwC5ZzYO14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPUV0m0ze2+0N3cH2nDoaZ4eMyO19Xnazh3RZjU1BK3QirXD3AWSGNG1UsdEpGAwc8m4qFnSJEj1uuBtskqvlPem48NyH2ccIUrolSLJmOhCxQjGmzNWAkvhKZgJONPAH5JiKvyfgxqMwTIb6ChzWjZBFsZHn/Wez9Xss58KqYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D8F5268B05; Mon, 23 Jun 2025 15:36:48 +0200 (CEST)
Date: Mon, 23 Jun 2025 15:36:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	ming.lei@redhat.com, axboe@kernel.dk, sth@linux.ibm.com,
	gjoyce@ibm.com
Subject: Re: [PATCHv3 2/2] block: fix lock dependency between percpu alloc
 lock and elevator lock
Message-ID: <20250623133648.GB27271@lst.de>
References: <20250616173233.3803824-1-nilay@linux.ibm.com> <20250616173233.3803824-3-nilay@linux.ibm.com> <20250623061015.GA30266@lst.de> <f306f309-7cc2-4426-98bf-fb6684db5b7c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f306f309-7cc2-4426-98bf-fb6684db5b7c@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 23, 2025 at 03:03:27PM +0530, Nilay Shroff wrote:
> > 
> > This is a check for not having an elevator so far, right?  Wouldn't
> > !q->elevator be the more obvious check for that?  Or am I missing
> > something why that's not safe here?
> > 
> This code runs in the context of an elevator switch, not as part of an
> nr_hw_queues update. Hence, at this point, q->elevator has not yet been
> updated to the new elevator we’re switching to, so accessing q->elevator
> here would be incorrect. Since we've already stored the name of the target
> elevator in ctx->name, we use that instead of referencing q->elevator here.

Make sense, thanks. 
