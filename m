Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1AA5811C
	for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425759; cv=none; b=HZyx+V1hdDXPFzzpPhnAjtLVaUNsVppony7jioS26LsmZPtLPOTrPJRHNP8d3h3eCv0ol+siOs6ACGs89GsulrMe6A8ArBItUw+o4YnusBy8FRQquoZTg3p8mflUSbz4XlcLIW90sGmVTITcWc5m+WFI9kUwYNh5dGoA1PhCEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425759; c=relaxed/simple;
	bh=M6667Wh2li32mzjwCOvp/fptR+/dW71OKBrRDGYVuiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VY+WJrYTt/D2Fus2gJ8lIiYue2gSTJUXScRS6NZtaKsi8Vk5bzbJZpL/IYt11M2Vw1bKR5ZAc3HgW9BwcJ5PdcWBmbYTNlmXWydi8VfhFTHBbsXR0ovHUBBlKLnA+SWaSJhQqvICgp1GrE7dj02h41tbrwoRxoUzuFiLf2Dvt3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N1kusd6t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N1kusd6t"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w2R7s8qU3kXnWekYLwTAxzb3rS1apBQsRtsNFnXuR2M=; b=N1kusd6tXe9gkjSaKuUeJDBVs8
	Lv2rA+JgMQU+Bzu1u9asTuYVB8tLfRDKKKvQsVKdpqz1Q7cm9rWE7k1fgfBVeH8wc5V2lsTV4hQBS
	BlsDX4L8FTzbhTjI8ROPpH28T/oQncPG+2x9mXQttkicKz4+5DLZ/8Maf5lWyfGQm2HbJTx1cZM5c
	Oesj3ImCD/zEmR0WQjqGizpS/aHxdnc5+5S63WGEnYz4fDfzkrE8ot2Wft1LiF796Sgp9tBC884wp
	MFpchma2MylzgJ1x3AppbW29TGkC3J6zP0je9a2Uq00jDqkEAQu+Jh93GcsnaJxXWJHTkmV7Slp+S
	t+Qg3A7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkls3-0000000806t-1Lnf;
	Thu, 14 Mar 2024 14:15:47 +0000
Date: Thu, 14 Mar 2024 14:15:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: brd in a memdesc world
Message-ID: <ZfMGk_bu4wFRWJUZ@casper.infradead.org>
References: <CGME20240312174020eucas1p29cf41360c934c674fd1f36a808078e25@eucas1p2.samsung.com>
 <ZfCTfa9gfZwnCie0@casper.infradead.org>
 <d470e16b-b7bf-451e-a6e2-eb68adcc2635@samsung.com>
 <ZfHwXLr54bWl1fns@casper.infradead.org>
 <886d8bde-e608-4e15-b13d-c891b4689b4f@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <886d8bde-e608-4e15-b13d-c891b4689b4f@suse.de>

On Thu, Mar 14, 2024 at 12:11:18PM +0100, Hannes Reinecke wrote:
> On 3/13/24 19:28, Matthew Wilcox wrote:
> > None of those things are needed for brd's uses.  All brd needs is to
> > be able to allocate, kmap and free chunks of memory.  Unless there are
> > plans to do more than this.
> 
> The primary goal of my patchset is to make brd a test-bed for the LBS work;
> devices with a sector size larger than 4k are really hard to come
> by. But really, it's just a testbed, and I'm not sure whether there's
> a need for that in the general audience.
> I can resubmit if you want ...
> 
> As for the memory overhead, I guess it only makes a noticable difference
> when moving to hugepages, and have brd allocate hugepages only.
> But that is future work for sure.

As I said, this is talking about a memdesc future where struct page is a
mere 8 bytes and most of its contents are reserved to the MM.  At this
point, there's no extra overhead to your patch, but there would be when
we get there.

So I don't think the folio conversion is necessary, but I think
supporting larger sector sizes in brd is a worthwhile extension.
