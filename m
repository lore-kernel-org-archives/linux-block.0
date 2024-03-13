Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DA74432
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 18:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354529; cv=none; b=TMwdq8IrqWUOnT4fbibnWrwFsdxISWEJyCJTnu6bCipWw/zHEzBUA74oi3TSYNIH7noB3pdETZcuTUu90jWrScJeKWV9lTIt13M6e+ev3xa40Mdni/C4o0FFcQQNRgGSEVAmPyDbBE7bDvfoNwLAKq3Fw91kFmjKl4zz/zrAsJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354529; c=relaxed/simple;
	bh=O5b4S8MyyxU/eO/oAE74YccaDkSGDWwvTRCEjTwSjPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDHsU73qGmOzneXD0tpQ1E7Byq6zkstmHvF63bNxZT9oaywo5CaoLVcfiMcfrxRKeSLuOIR1jkcAV8FKMep2IkUJmQln7N8NVqi50NWWxP6Dr/dWmbztYXQFHPB8gnTqrH0Bal6Im5b7o96sxY4uea1lAaO2/jU9TITJ9Ekgcac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=husdh7kB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="husdh7kB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DKjit0WAzGXUPAzaYpxZha8KD2LhGchEo8dmnJRanG8=; b=husdh7kBYjYPpPV7t5z2OtjxpQ
	BC6AmBIRfV6HO4h6hQAZDDiB9uIxAQsD4eh14qZdSUsS/2Z/AAdZ+i8YjnPyhLNR4eZQhZUYNSgs7
	MCTeKWDasB7MeC403XmyE7FCOZAnb2AXdrRBrCgGOiT7pVfhnuez5zH9vgkhY1MBHtt9duu9FQqoS
	GxLG6Kw+Gn8h5sf49CANshNrDNxfdnrdNOnwZDRD+Zg/mciqjeR80pNauikwOe55NjGKvixrzWHBR
	WJhSocMp8/6kWVMpeK4Ai43ajXP9DhQLi8J3x3FSvIwlKO2sSrD6TvILdYvACdlBlcQO+2m8B157P
	sI6xotSA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkTLI-00000005zRf-1tUW;
	Wed, 13 Mar 2024 18:28:44 +0000
Date: Wed, 13 Mar 2024 18:28:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: brd in a memdesc world
Message-ID: <ZfHwXLr54bWl1fns@casper.infradead.org>
References: <CGME20240312174020eucas1p29cf41360c934c674fd1f36a808078e25@eucas1p2.samsung.com>
 <ZfCTfa9gfZwnCie0@casper.infradead.org>
 <d470e16b-b7bf-451e-a6e2-eb68adcc2635@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d470e16b-b7bf-451e-a6e2-eb68adcc2635@samsung.com>

On Wed, Mar 13, 2024 at 06:15:26PM +0100, Pankaj Raghav wrote:
> On 12/03/2024 18:40, Matthew Wilcox wrote:
> > Hi Jens,
> > 
> > I'm looking for an architecture-level decision on what the brd driver
> > should look like once struct page has been shrunk to a minimal size
> > (more detail at https://protect2.fireeye.com/v1/url?k=fdf5d9a0-9c7ecc9a-fdf452ef-74fe4860008a-d5306bf365c2b9b6&q=1&e=cbceae8b-61fb-4e3e-8f7c-6717d9b2431d&u=https%3A%2F%2Fkernelnewbies.org%2FMatthewWilcox%2FMemdescs )
> > 
> > Currently brd uses page->index as a debugging check.  In the memdesc
> > future, struct page has no members (you could store a small amount of
> > information in it, but I'm not willing to commit to more than a few bits).
> > 
> 
> Shouldn't we change brd to use folios? Once we do that, this will not
> be a problem any more right?

We certainly could change brd to use folios.  But why would we want to?
Hannes' work always allocates memory of a fixed size (a fixed multiple
of PAGE_SIZE).  Folios are a medium-weight data structure (probably
about 80 bytes once we get to memdescs).  They support a lot of things,
eg belonging to an inode, having an index, being mappable to userspace,
being lockable, accountable to memcgs, allowing extra private data,
knowing their own size, ...

None of those things are needed for brd's uses.  All brd needs is to
be able to allocate, kmap and free chunks of memory.  Unless there are
plans to do more than this.

