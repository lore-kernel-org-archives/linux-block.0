Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAA23D3B3;
	Thu,  9 Jul 2026 04:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783572506; cv=none; b=A/2hwz8AFi9HnWzSZNc/HZO/2m8jOogMb6b3F2bPSPP81t6Vu/YrICP1blbzOJMaJ7kTuchHPtVVlBPP/rLZ7wpuPKuvKlfNn+2ncIee46iz4Lw8wbmgv/guI4ddTtzNP1q/gWgOXMOc7UJ/OUriP1aBFVf9RRJ6/cXpTbEfx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783572506; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRYJlW5UfIE9CvxrRODgkqu8j5z2dd7EmLjQJQ3mFYoNfKr14ziF5ZsS2y29Bx5kHCvTTaCXpIF3eMBvPQNb8PImUN/QHjLRHIYfRzVRB0l05+HIo9ISLS74kha4E23o7D/lfa4QsyS2S4IjDfD/3IBXgbIHZjT85xpCO8PfO5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46F2B68BFE; Thu,  9 Jul 2026 06:48:22 +0200 (CEST)
Date: Thu, 9 Jul 2026 06:48:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Baokun Li <libaokun@linux.alibaba.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: try slab allocation in bio_alloc_bioset()
 before mempool
Message-ID: <20260709044821.GC15144@lst.de>
References: <20260709020145.4011533-1-joseph.qi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709020145.4011533-1-joseph.qi@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

