Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62203265620
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 19:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063326; cv=none; b=HdUayAyEhEtwQnXVYC5qEEt0y+SzTT9RxqOzgDqlk6nWhf36Z15n9lDU2EUu/g6EQeYb4yxB6auBRo5vp7b8BzFyBSZKW+T1c9GFUCTI5l31d+w9xjbOUrtvvuRN2IwXy0i1NH7o596HDlFXr8oQtJGU73PoJGQ0o35nx2Z8szw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063326; c=relaxed/simple;
	bh=c2leRc7MVXK4X5nZeoFFW/Vu/KSw51nOHhX2VKTsmGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6hIArYOMQ3pSiLAZgACTDLz0ERWTEtr8vIs2ioj1JhrR+tSltMa+zRkdjU8TecGzIU5YyImiX1RmC+eb8fv6nO0ypV2cEfxWVjHo9Lo2dSq1obBfhVhHYcchp3JK+g2MVX3gdkbnadXpVWB9lC6+b+fn3HQsqvS+K2T7QYs/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMpNOIoa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMpNOIoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C3BC4CEF8;
	Thu, 13 Nov 2025 19:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763063326;
	bh=c2leRc7MVXK4X5nZeoFFW/Vu/KSw51nOHhX2VKTsmGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMpNOIoaE99C8wXROLXABUkmXUGXSrdENluAZY4EtXeeIzFh0NUq+qnWgLGpwyHpn
	 uALnZvV8uURvStghnwzFjEEgJcvl0mjeLvCnyyeukGyKV13drXOvIq2mBJhfNZCpT2
	 gofJ3Lsp0TP6G9C3F00C+UYSbe+MOX8RtglIkLGJ72iZ6Lhz53BW6OjblT4riH4jb9
	 YOEBNpaZCc1wQjwPKBuWO8arotuESkUqDVyp8jc+ZzGbGN9HUEu1EGLvYTV9cQdfBO
	 H+3vpnaGHRa7eADYOEPkCd/dbJ50PcdzKs+jamiQXVwef66pm7We24aASexDdZBd8y
	 hdg6lHSZyoicA==
Date: Thu, 13 Nov 2025 14:48:43 -0500
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, hch@lst.de,
	axboe@kernel.dk, "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv4] blk-integrity: support arbitrary buffer alignment
Message-ID: <aRY2G6xEgEVqLBgb@kbusch-mbp>
References: <20251113152621.2183637-1-kbusch@meta.com>
 <20251113173135.GD1792@sol>
 <aRYf9S-UuJqa37fi@kbusch-mbp>
 <20251113192022.GA3971299@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113192022.GA3971299@google.com>

On Thu, Nov 13, 2025 at 07:20:22PM +0000, Eric Biggers wrote:
> On Thu, Nov 13, 2025 at 01:14:13PM -0500, Keith Busch wrote:
> > On Thu, Nov 13, 2025 at 09:31:35AM -0800, Eric Biggers wrote:
> > > On Thu, Nov 13, 2025 at 07:26:21AM -0800, Keith Busch wrote:
> > > > +static void blk_set_ip_pi(struct t10_pi_tuple *pi,
> > > > +			  struct blk_integrity_iter *iter)
> > > >  {
> > > > -	u8 offset = bi->pi_offset;
> > > > -	unsigned int i;
> > > > -
> > > > -	for (i = 0 ; i < iter->data_size ; i += iter->interval) {
> > > > -		struct crc64_pi_tuple *pi = iter->prot_buf + offset;
> > > > +	__be16 csum = (__force __be16)~(lower_16_bits(iter->crc));
> > > 
> > > This just throws away half of the checksum instead of properly combining
> > > the two halves.  How is this being tested?
> > 
> > Yeah, this is the only guard type I've never seen a device subscribe to,
> > so not particularly easily tested on my side. I just forced the code
> > path down here anyway and checked if the result matches the result from
> > the existing code calling "ip_compute_csum()". Maybe I can just continue
> > using that as I suspect devices using that can't handle split data
> > intervals that I'm trying to enable.
> 
> Wouldn't csum_fold() combine the halves correctly?

It doesn't look like that would be correct if we assume the existing
code is correct. The current result from ip_compute_csum() just
downcasts the result without folding, just like I'm doing here. My new
code is produces the same result as the existing code, so worst case
scenario, this isn't introducing a regression.

> Anyway, it needs to be tested.

Like on real hardware? I'm a bit at a loss as to how, I've never seen
anything subscribe to this format, not even in emulation. The only thing
I can readily do to test this is run random data through the old code,
print the result, then run the same data through the new code and see if
they're the same. That test is successful. Not good enough?
