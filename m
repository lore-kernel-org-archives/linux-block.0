Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF3B248893
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762847352; cv=none; b=RgIUix92g9DSgskFguhRWQidGoxhUeARFKdBfPZuNESZ+gd5cHj4AmSDODeRP8fyl73R1uUFqfDdJyRf/EIkM/nxFms1pMih60fV6VlupDKTSdLrT9rRTnTw6tvUa/DeY8jm9acj0b880zhY6NaR0iFlZ7D5XNVWl2oyn/xAnMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762847352; c=relaxed/simple;
	bh=CcTjsTEWpL67PSAUTS5bJBERwXGfmOSdypCc+vJCG6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1uxzREg12DUcNN72eMZ5LrabN7Mv0s4MmZQnYGhwsUvxdxwUMBqen2UR3Bv+QE1Gal9cJAKBU5U3z8pUtbm+JhopOBNg1z1bVF90qhD4N+FZ5BW/YO4GXN8hQ0SVzd+CfPaevgck5sF0Uup8XXhs9g6litC5KTrO2uGk0HWD2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D065227A87; Tue, 11 Nov 2025 08:49:06 +0100 (CET)
Date: Tue, 11 Nov 2025 08:49:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/4] blk-zoned: Fix a typo in a source code comment
Message-ID: <20251111074906.GB6596@lst.de>
References: <20251110223003.2900613-1-bvanassche@acm.org> <20251110223003.2900613-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110223003.2900613-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 10, 2025 at 02:29:59PM -0800, Bart Van Assche wrote:
> Remove a superfluous parenthesis that was introduced by commit fa8555630b32
> ("blk-zoned: Improve the queue reference count strategy documentation").

Or just drop the pointless parenthesis entirely?

