Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393B14F11A
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727547; cv=none; b=dA1P5WOLQPgYpIWpiHonRxiO4RtPDDOjq/Uf+Z+aCqdurh+gX/4272fx/p0NUfrjujOvjxsZzokpsC1Dm6jpk/3uoy2XBmLDle9EbvA70nZmStL0gqVmauGyKQW+e4C5LJDUNNUfbecjJS3OneI7hiO8P1wBZhxOkB7mw/B5V7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727547; c=relaxed/simple;
	bh=D1qHhrdelYHyml7xpNIB08iUsJ8qprnBKlb+weuTQ+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6Q7YZr5qcMw1XiOzYc/uoD6mH13dDfsMBrNGlpl8RpDRVbWCZaYaiNAzo0qg4Zgn6InvKjPUfEHJ31F86qmjFaxacKGCuPdqXW7ri5SYhjF+DmpQpxZQuMC3+1UynhoguIOUISZvovrw2pVp+FxjTKOZ9hiIcJnLTXwArbjOk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTdMX7ne; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTdMX7ne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8297CC116B1;
	Fri,  3 May 2024 09:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714727545;
	bh=D1qHhrdelYHyml7xpNIB08iUsJ8qprnBKlb+weuTQ+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTdMX7nenmuPukNMe/CmC+j8Mr6BSGuoL7Qs9dF4iJHTgup+4f2DVomNHt1dCIODC
	 R8zyAA3jvWES8EM2UNSiQuU7rO7WBa8xYe18sn9pAtQIIxKkvehpMVK890Oh7j2ab4
	 bWKzXFgPcF86223yLZJAqc3NUzcSzvIIiF4BLCdSEWJaXxJkwsO+uZ/89tUdtdj6Yx
	 XfWmX1OJLb36B4kpS6xUaRLBT3Mq9VB9qarrQo8v8By0dOfA/4JjVhw6YDijV2zmyj
	 MXIXJL6ByipQGndaBWyWnhDM6qXTlGbMM+Qggb1lvkbhXSz26RL1PsYtKFYOCy8nMH
	 EePBD3oN+znFg==
Date: Fri, 3 May 2024 10:12:21 +0100
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Lennart Poettering <mzxreary@0pointer.de>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: add a partscan sysfs attribute for disks
Message-ID: <ZjSqddKI4cDIgiPd@kbusch-mbp>
References: <20240502130033.1958492-1-hch@lst.de>
 <20240502130033.1958492-3-hch@lst.de>
 <6e70dd3f-381c-4435-a523-588ce2fafb39@kernel.dk>
 <20240503081612.GA24407@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503081612.GA24407@lst.de>

On Fri, May 03, 2024 at 10:16:12AM +0200, Christoph Hellwig wrote:
> On Thu, May 02, 2024 at 11:05:54AM -0600, Jens Axboe wrote:
> > On 5/2/24 7:00 AM, Christoph Hellwig wrote:
> > > This attribute reports if partition scanning is enabled for a given disk.
> > 
> > This should, at least, have a reference to Lennart's posting, and
> > honestly a much better commit message as well. There's no reasoning
> > given here at all.
> 
> I'm not sure I can come up with something much better, feel free to
> throw in what you prefer.

I think just explaining the "why" would be usesful for the git history.
How about this:

  Userspace had been unknowingly relying on a non-stable interface of
  kernel internals to determine if partition scanning is enabled for a
  given disk. Provide a stable interface for this purpose instead.

  Link: https://lore.kernel.org/linux-block/ZhQJf8mzq_wipkBH@gardel-login/
 
> > Maybe even a fixes tag and stable notation?
> 
> This is definitively not a Fixes as nothing it doesn't actually fix
> any code.  It provides a proper interfaces for what was an abuse
> of leaking internal bits out.

I kind of agree it's not a "Fixes:" in the traditional sense, but at a
"Cc: <stable>" sounds appropriate given the fallout.
