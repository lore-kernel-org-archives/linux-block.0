Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2985125A2DE;
	Fri, 14 Nov 2025 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763108188; cv=none; b=KEYso/jDbZijkEyZjmZU4P6cZHRbnsQPv5jg+fHxJ3johKXFb8ZtvOkR8MRhMUjBPqzFwVaDt6xzdfNV611hcdEz0gphq0SXqbSlayplwPVldFHnb0lQKTXFdXHY2eFdDycJA2yswH+VuRT9KYL2zX1mW7nNb5B658xBj65vQLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763108188; c=relaxed/simple;
	bh=/GKXEoBtcXx0a0NjG6jUraQg+k9dQvuk/Fg5FkEDWFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcRuz0BRbK87KkNBmRSSNi1DJbBRHJLtSRyfwRtUtN4iaaQmYWMAMmC3hzu7Z0P9gLjLXPuJP389836cpGxaYeFQF9DGsRhHhnb9VsfOiN8TnEB0LWvip8AtX++aIuTIaJgoqshFlcmiN50TtjzVQdW2yV6JJ3E/MU3ErWj6wxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOf05MVj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOf05MVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3CBC116D0;
	Fri, 14 Nov 2025 08:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763108188;
	bh=/GKXEoBtcXx0a0NjG6jUraQg+k9dQvuk/Fg5FkEDWFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOf05MVjrdRhj/0Yd+x4tuVND9kaU0XV73O5OHkWW8Mq2O5bQXMgxARIBMgCEymc/
	 Em8yXhLFvhRQjNfr/pAILbNT/krqQDSRuHeFftF1VifoLo2S6o/uiVitEVa4qrbO9t
	 0YVd56YATKVnr1fzblG68tp8oehiZ4RVdD64YNI1QBnn6TlaW6mATf0gVgx3oenpKp
	 NhMTR0DkPLSugOhWQ9MvKsq3/dFDsjhZtQMok0qKieO8YKVfPL0ZYWkSNJVR2eIHUy
	 srbbkj28JGCqDctUigibzl6RX/fMjxwMN/FyRqtKwMB7VVie+ulvesrOfDNZaRKm1o
	 1WSlR0mF0TShQ==
Date: Fri, 14 Nov 2025 10:16:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
Message-ID: <20251114081623.GB147495@unreal>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
 <aRY28IRvBFmTW6cz@kbusch-mbp>
 <d1641814-5ef8-4ccd-8a41-42bf99a61d0d@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1641814-5ef8-4ccd-8a41-42bf99a61d0d@kernel.dk>

On Thu, Nov 13, 2025 at 01:40:50PM -0700, Jens Axboe wrote:
> On 11/13/25 12:52 PM, Keith Busch wrote:
> > On Thu, Nov 13, 2025 at 10:45:53AM -0700, Jens Axboe wrote:
> >> I took a look, and what happens here is that iter.p2pdma.map is 0 as it
> >> never got set to anything. That is the same as PCI_P2PDMA_MAP_UNKNOWN,
> >> and hence we just end up in a BLK_STS_RESOURCE. First of all, returning
> >> BLK_STS_RESOURCE for that seems... highly suspicious. That should surely
> >> be a fatal error. And secondly, this just further backs up that there's
> >> ZERO testing done on this patchset at all. WTF?
> >>
> >> FWIW, the below makes it boot just fine, as expected, as a default zero
> >> filled iter then matches the UNKNOWN case.
> > 
> > I think this must mean you don't have CONFIG_PCI_P2PDMA enabled. The
> 
> Right, like most normal people :-)

It depends how you are declaring normal people :).
In my Fedora OS, installed on my laptop, CONFIG_PCI_P2PDMA is enabled by default.
https://src.fedoraproject.org/rpms/kernel/blob/rawhide/f/kernel-x86_64-fedora.config#_5567
and in RHEL too
https://src.fedoraproject.org/rpms/kernel/blob/rawhide/f/kernel-x86_64-rhel.config#_4964

Thanks
