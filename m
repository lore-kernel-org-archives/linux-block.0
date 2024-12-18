Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B743C0B
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734505202; cv=none; b=O6lmtLWqXzCVHoJJLYf36qxSKTH9yuMaGUeMLF2kbpzCmo6KcemCn2+SEnoABWzUWUpK3jtowprGis+yhV5ccB3H8bCcLb/iQ4PS8Uj8kUU3UPyOGwM3j+8z42yq6PBNyXYcaUdP6sHdpF/pitFhAYFFT0kv5magqdIYZA6OASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734505202; c=relaxed/simple;
	bh=pzPojgS5j13UL+DNfKofG+JbjtghX94lPFXHvpYA2UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFX0Al0DZMXowhT675r4waqFPXIEyh5DMi5ymPnMHXAeBYRjNGOZbmqXiPr2kcirtOpidW8aMRxjn5vC8Dy9Fm/ME8oUR2bdfSsH0oat6QyBa6F8JQ3IG7B976otjOjm/Sa5FcFXYxIMLc4aXp/UbzWJs29Z1zuoitD/C9kpqi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8615F68AA6; Wed, 18 Dec 2024 07:59:56 +0100 (CET)
Date: Wed, 18 Dec 2024 07:59:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/2] block: Optimize blk_mq_submit_bio() for the cache
 hit scenario
Message-ID: <20241218065955.GB25215@lst.de>
References: <20241216201901.2670237-1-bvanassche@acm.org> <20241216201901.2670237-2-bvanassche@acm.org> <20241217041647.GA15286@lst.de> <d655783d-185e-4ecc-aea9-875789cfa9b4@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d655783d-185e-4ecc-aea9-875789cfa9b4@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 17, 2024 at 11:22:47AM -0800, Bart Van Assche wrote:
> For a single CPU core and with the brd driver and fio and the io_uring
> I/O engine, I see the following performance in a VM (three test runs for
> each test case):
>
> Without this patch:      1619K, 1641K, 1638K IOPS or 1633 K +/- 10 K.
> With this patch applied: 1650K, 1633K, 1635K IOPS or 1639 K +/-  8 K.
>
> So there is a small performance improvement but the improvement is
> smaller than the measurement error. Is this sufficient data to proceed
> with this patch?

I think it's sufficient data that should not claim that it is an
optimizations.  The resulting code still looks nicer to me, but
arguing with optimizations feels like BS.

