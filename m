Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A83126E6E4
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442661; cv=none; b=MNGQdQxpKhvMvOoPAkWYrVBr6MxwLxsIip2z3/jkHa8dUWUSjEzVISI7xJYcRDYr8ZDrWXeZ+csAfx4RaP1EKr6VMmEMvgBdcB0MSXVk/9AvgikCvxUjeob98QRA4kJOgzekS65cfylXVzBL+UPA+YfqC1CuHGeF5A8daNCoF6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442661; c=relaxed/simple;
	bh=Eap0sLCWDwgCAY0qS4MSYJJlEly7mGaZm90iVvqMbBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG6fELgfWcdfDevMuLA1Kqt8H/7Hyb3hoOORCozzEzQyhv9TW62aFizbesLIBhAdb3lmbCRsemG/J5A1KsXFjPAL4Ml9Qao9fPTzFdRXlXpCaTtTRQlmx7irr0WDUg3xcOnI6u2ipceP9L0fS8aMnNkXui3jlTHM49ymzzHnqz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmqQYu9o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmqQYu9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33332C4CEF7;
	Thu,  6 Nov 2025 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762442660;
	bh=Eap0sLCWDwgCAY0qS4MSYJJlEly7mGaZm90iVvqMbBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pmqQYu9o1f533NvDPkkP5sNP6nrmEIwM8VhgilMIenFZqlbmeJR88VHP8lvY15avl
	 keDnkdHxqfUQYieb6mX02e6RtpcGPbHaOF7G7RqKTKjsnNydjajapeBmtY4R1xHrd0
	 XNGUUv0JYhpaNn10JU7rlEJRKXfDcVkZWvmMDIrPzcFjmWMknyHCce4tESB3FJu8dN
	 DGR8M7uA6xaeGc5lr7FrcxSMvDJ8TldxIP6krgoIMn0pRGIitlIKQuWPusJxwJz0/O
	 7gdmUsPNkBeIErlDXPSVfutn+gSHY43nkw8O59sFWqZvvLS8jOzygCvxXZLir/ch5R
	 A+IWM1LAKi+HA==
Date: Thu, 6 Nov 2025 08:24:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, dlemoal@kernel.org, hans.holmberg@wdc.com
Subject: Re: [PATCHv2 4/4] null_blk: allow byte aligned memory offsets
Message-ID: <aQy9onvbbLaD_6Gx@kbusch-mbp>
References: <20251106015447.1372926-1-kbusch@meta.com>
 <20251106015447.1372926-5-kbusch@meta.com>
 <20251106120131.GD2002@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106120131.GD2002@lst.de>

On Thu, Nov 06, 2025 at 01:01:31PM +0100, Christoph Hellwig wrote:
> >  static blk_status_t copy_to_nullb(struct nullb *nullb, void *source,
> > -				  sector_t sector, size_t n, bool is_fua)
> > +				  loff_t pos, size_t n, bool is_fua)
> 
> Is it just me, or is n are way to non-descriptive argument name?  Can
> we fix that if you touch it anyway?
> 
> >  {
> >  	size_t temp, count = 0;
> > -	unsigned int offset;
> >  	struct nullb_page *t_page;
> > +	sector_t sector;
> >  
> >  	while (count < n) {
> 
> And count here should be done of offset.  I really had a bit of a hard
> time following the code due to the naming.
> 
> >  static blk_status_t null_transfer(struct nullb *nullb, struct page *page,
> > -	unsigned int len, unsigned int off, bool is_write, sector_t sector,
> > +	unsigned int len, unsigned int off, bool is_write, loff_t pos,
> >  	bool is_fua)
> 
> .. and the indentation here could use fixing if we touch it anyway.

I actually had an earlier branch with all sorts of little refactors like
what you're mentioning. I don't even like the loops counting upward: we
can remove "count" entirely and loop backwards from "n".

Anyway, it started to look like all those little cleanups were
distracting from the feature, but I can redo the series with more prep
patches to tidy things up.
