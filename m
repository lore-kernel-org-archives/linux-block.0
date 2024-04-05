Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A316F840
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329429; cv=none; b=TEntxj5CjEkKdknMl6BzhR1nVyl/2FRG7qzYMC1w1klufZ1xSMEefHEmVXfkG1cAJ7KlZQAJMst+gvUeaEe2xO9r5HcKWFhOcpIdAZLGfbKFyIdSPOT59v7rL1uVtZMGU18U0QFb3cXg6cI8mrb17gNg5aq2JtZ5kqGn+/024gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329429; c=relaxed/simple;
	bh=dXTTiVWFgc1vtmcr0X1BIZOy1WwUucJv2okTlq23MuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ro62iFV0S4fX+z3RaoWRd37cCKdZZeY4/9He3lYaeSLhgl5LDxHeBpUeTv8uijySUdP8sfIPThn3Dro8kGa25Ib9KMchwSWaHRHiIOX+OhNa0FloIM4BHapjhyBbphKB/p/jIPVN6FAIx2QumvKcNQXLYiTEaMVGVXhTBwH+MU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbMjwxy8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbMjwxy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C1AC433F1;
	Fri,  5 Apr 2024 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712329428;
	bh=dXTTiVWFgc1vtmcr0X1BIZOy1WwUucJv2okTlq23MuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbMjwxy8QRFDktIEUZUOQ+QBwqSocDOBqI7YNiks23QdI+cEvAIcQCb6L/G+/w/F2
	 JvXlx5E+1LAJ/Nh4M8GtaRK93PbJuFmYInW4y5yxcZK0Wma64FCMm9nxTGAPgzUYfz
	 3MIDoEayrlpbJSv47DAKXpOs4BAhjDj6n+5x+Pzj8tTDM8+8KaCr40mXIMxCw2gWh2
	 90lnLXj4qtP2HW4gSGoM1V2myH3snrGFCl8CvOTfrKhceNVptxNiakwDU0C3wBf4k+
	 IF9w5qbcy4LSZFeHbuI6rOUzSgE3Af26yQtpPlmzRYyCbqxdOCDi9LNjf8WreRD1Lv
	 Dgf8KLwi1owrQ==
Date: Fri, 5 Apr 2024 09:03:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCHv2 0/2] block,nvme: latency-based I/O scheduler
Message-ID: <ZhAS0YKfV07qlUes@kbusch-mbp.dhcp.thefacebook.com>
References: <20240403141756.88233-1-hare@kernel.org>
 <Zg8YNrSnZPjR4kan@kbusch-mbp.dhcp.thefacebook.com>
 <b255fca4-a9da-4364-a3af-eb699eeb4160@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b255fca4-a9da-4364-a3af-eb699eeb4160@suse.de>

On Fri, Apr 05, 2024 at 08:21:14AM +0200, Hannes Reinecke wrote:
> On 4/4/24 23:14, Keith Busch wrote:
> > On Wed, Apr 03, 2024 at 04:17:54PM +0200, Hannes Reinecke wrote:
> > > Hi all,
> > > 
> > > there had been several attempts to implement a latency-based I/O
> > > scheduler for native nvme multipath, all of which had its issues.
> > > 
> > > So time to start afresh, this time using the QoS framework
> > > already present in the block layer.
> > > It consists of two parts:
> > > - a new 'blk-nlatency' QoS module, which is just a simple per-node
> > >    latency tracker
> > > - a 'latency' nvme I/O policy
> > Whatever happened with the io-depth based path selector? That should
> > naturally align with the lower latency path, and that metric is cheaper
> > to track.
> 
> Turns out that tracking queue depth (on the NVMe level) always requires
> an atomic, and with that a performance impact.
> The qos/blk-stat framework is already present, and as the numbers show
> actually leads to a performance improvement.
> 
> So I'm not quite sure what the argument 'cheaper to track' buys us here...

I was considering the blk_stat framework compared to those atomic
operations. I usually don't enable stats because all the extra
ktime_get_ns() and indirect calls are relatively costly. If you're
enabling stats anyway though, then yeah, I guess I don't really have a
point and your idea here seems pretty reasonable.
