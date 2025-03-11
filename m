Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10925DD00
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 15:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705805; cv=none; b=BD2jPwhYZlePG8OpblhSHmEKXvcMvd5JFZLmgxUmZdmRLEfs8w3Lag0iL+7QhjzVDkLuVmAitWQ+o2UYvqKRK00dit029UVKXwW6jkXqd80LYfxclrumeknQSaIptWeofiaRSPsc+0Wyp6pxdXCUBHKgXTV/J3gC5dlT3oubfkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705805; c=relaxed/simple;
	bh=kz5FZ6VGD//YbzXYqMGnZZ9QSrVwcX8A/vpoVZ+1fFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nycKDTnD2HHago/dO1ABboql92YUErbsTAPR6Op1DcvXo+hHvNVL734zOwd5SJY39EGEIPeRDcGB/dJMMd6NTKi1wiQy6x7PZY2y9pWAPFdeR5ngVjMF62LY5//D14wxS0rsOa26WKJ7KCNZCv4JBEnUb3Aj8Fm5Ujb2qeSa8ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OhIsrKo2; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OhIsrKo2"
Date: Tue, 11 Mar 2025 11:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741705800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yHQ/3yWeYvUmfFvWg4w7w2liXEhS1hnwcN7g+EhDS+I=;
	b=OhIsrKo2H8jJCO6jnoFxohpfmryRh8lZTR3zN9LWrJAouDoayFmZqUJBYeD0gCIU8Z/b0b
	e+1jFu/v/r/oDkrADSJYydo00XTpWOOgShzAlwYzOQLcYfSYLXKcsxwhJr0HuXB2Sj/5az
	/UZOrjYA3iiPKPn602mOwpGSfVvILSo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] block: Allow REQ_FUA|REQ_READ
Message-ID: <hdmneeoznjavat7aexujktuxbderhj42n7qj3l7i4srrgnq2eh@kfc3m6jghogw>
References: <20250311133517.3095878-1-kent.overstreet@linux.dev>
 <Z9BOf7WljNX-Rnl7@ryzen>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9BOf7WljNX-Rnl7@ryzen>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 11, 2025 at 03:53:51PM +0100, Niklas Cassel wrote:
> Hello Kent,
> 
> On Tue, Mar 11, 2025 at 09:35:16AM -0400, Kent Overstreet wrote:
> > REQ_FUA|REQ_READ means "do a read that bypasses the controller cache",
> > the same as writes.
> > 
> > This is useful for when the filesystem gets a checksum error, it's
> > possible that a bit was flipped in the controller cache, and when we
> > retry we want to retry the entire IO, not just from cache.
> 
> Looking at ATA Command Set - 6 (ACS-6),
> 7.23 READ FPDMA QUEUED - 60h
> 
> """
> If the Forced Unit Access (FUA) bit is set to one, the device shall retrieve
> the data from the non-volatile media regardless of whether the device holds
> the requested information in the volatile cache.
> 
> If the device holds a modified copy of the requested data as a result of
> having volatile cached writes, the modified data shall be written to the
> non-volatile media before being retrieved from the non-volatile media as
> part of this operation.
> """
> 
> So IIUC, at least for ATA, if something is corrupted in the volatile
> write cache, setting the FUA bit will ensure that the corruption will
> get propagated to the non-volatile media.

Corrupted in the volatile writeback cache is not the expected case - we
don't usually read data we've just written.

Generally, the data will be in the device's cache only because we just
read it, and we don't want to retry the read from the device cache.

It's possible that either the device's cache was faulty, or there was a
transient error in reading from flash (SSD ec algorithms are effectively
probabilistic these days), so in either case retrying with a FUA read
has a much better chance of clearing a transient error and correctly
reading the bad data.
