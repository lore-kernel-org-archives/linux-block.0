Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8351E494
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337217; cv=none; b=jqSUg7sjjS5YwsAoCezTBbKU9846SnYRDBwd2ZPUHuuxTaVke3hY1f7+OcKmk+nk0n0czf3YUiD/+3pBAL8Gq0da5FWQNzgzXzQwc8/X4LwDOVvtBq8GtFLvPyjUwSuhxRLX3sv0MEsN9v6IPtWj67I95hmoMLM+zUhAf9eVOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337217; c=relaxed/simple;
	bh=/c1i91tfehnhcGwwlOCvCRhSnov7dufo1WIlHa/kSqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOfhr83k6v8iIV8D7Ae77vD/sqOaVXOeO6pQA6EfjKHH63H0mPiFWgp0YJA2cYX1V73tkqheut9KW6ifQK7wUfdm3dCorNz5llqtBsiM5vHSCryIcHY8YgYru77/mthGKLlVHYJSR3lwt+P9mwejtukZu0j+rM86EVGHg/XmpJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB4F168D07; Fri,  5 Apr 2024 19:13:30 +0200 (CEST)
Date: Fri, 5 Apr 2024 19:13:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: work around sparse in queue_limits_commit_update
Message-ID: <20240405171330.GA16914@lst.de>
References: <20240405085018.243260-1-hch@lst.de> <65a7c6b1-ad4e-4b27-b8b1-44d94a66bf7a@oracle.com> <20240405143856.GA6008@lst.de> <343cc769-b318-4c2d-b08a-0bc752f41f78@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <343cc769-b318-4c2d-b08a-0bc752f41f78@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 05, 2024 at 05:43:24PM +0100, John Garry wrote:
> This actually looks like a kernel issue - that being that the mutex API is 
> not annotated for lock checking.

Oh.  Yeah, that would explain the weird behavior.

> I would need to investigate further for any progress in adding that lock 
> checking to the mutex API, but it did not look promising from that 
> patchset. For now I suppose you can either:
> a. remove current annotation.

I can send a patch for that.

> b. change to a spinlock - I don't think that anything requiring scheduling 
> is happening when updating the limits, but would need to audit to be sure.

With SCSI we'll hold it over the new ->device_configure, which must
be able to sleep.
