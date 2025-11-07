Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9502F6189
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515486; cv=none; b=kl9k886pVzCLuaJpOwx8Q0qDA23bfXaS6Z6o4K5CtCq1mdy6qn2xeDFflAI2kaVrGZldjB5FWa2JDbf6RmFbjx+QP0oQ/9pIJhAxQnueWM6t3w+I4ls2VMMZ6LVQoOsc33EKiSLIW+enl3BUag9FJPAyTEEEUramJiRCPYZr5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515486; c=relaxed/simple;
	bh=kxtSxUARO58PZfxKRmRQnXgnzGrhAi9RrG2CiIh7SOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5l1OJsAhpQFW4rygiBGjYjok4laZs35NkvKVhPg+lI+ssDw7G/PQdrVyJiNAdQBijP1y/uWhAWXNpJRLHkyX5/Djse8lr83PGpovvB+jEi3KcBlZa0L1vn1f9v2EK9dULHVdI4AuKeynZSxIqlC1GRmnpKsrUW8+haRMmQQrys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8258A227AAE; Fri,  7 Nov 2025 12:37:58 +0100 (CET)
Date: Fri, 7 Nov 2025 12:37:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/2] block: don't return 1 for the fallback case in
 blkdev_get_zone_info
Message-ID: <20251107113758.GA29154@lst.de>
References: <20251106145332.GA15681@lst.de> <6f85828c-a6a6-4bef-8b31-b48dfa173f91@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f85828c-a6a6-4bef-8b31-b48dfa173f91@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 07, 2025 at 03:14:20PM +0900, Damien Le Moal wrote:
> Note: Is this patch alone or part of a series ?
> (the subject has the odd 3/2...)

Yeah, this was supposed to be a follow up to the report zones caching
fixes, but I edited out the in-reply-to header accidentally.

