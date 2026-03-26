Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F189D3FA5C3
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534778; cv=none; b=R/hz1EOO9wdoX/3OGrDFQul7UBGHobp1bkrCZxFepaQauBmpQKukgCN1rv75bWzOPUypzkSh8NI848ILsQtm3fiK3QWVfu/RNNx4B1/OWrIEiurmnnHYLq2YXxfi1Bzflviefv4af94a+ZdDw+ssat3RdGGrOq3GcKO1V3WeJAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534778; c=relaxed/simple;
	bh=X/bPbk6QGZd+gmbjZHb+UZSTb1xLlDYSinwvn8SHzMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShXV0DqqzhkXTb2Farg3OVq8xeDWMkwU9j1ecizKVoZLN2Mnm17cEsnWYhJo603aHk8lctehwUPOYANsY1Yxv3fTj6dYXUDLeYzFAIn9swp7telFkaV3roeNfGa9GFJX8f4jjdIXKyppyuOh8FLcbprDWMhF9Pk5ftMAAW4PhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4B56D68AFE; Thu, 26 Mar 2026 15:19:30 +0100 (CET)
Date: Thu, 26 Mar 2026 15:19:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Kees Cook <kees@kernel.org>,
	Genjian Zhang <zhanggenjian@kylinos.cn>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH v2 20/26] null_blk: Enable lock context analysis
Message-ID: <20260326141930.GG16166@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-21-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-21-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 25, 2026 at 02:45:01PM -0700, Bart Van Assche wrote:
> Convert __releases() __acquires() into __must_hold(). Add __must_hold()
> annotations where these are missing. Annotate two functions that use
> conditional locking with __no_context_analysis. Enable lock context
> analysis in the Makefile.

Not a very good explanation why this is needed and there's not better
way to avoid the big hammer.

