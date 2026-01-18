Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE06C8F0;
	Sun, 18 Jan 2026 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768723274; cv=none; b=ZrOdRjmRLswz++2cgxbiR5/ZXab/MY46J0zoTRCt94f210b0fOnzV0L/MSMgvkc/bdYi/CQvyc4jEO4MoMpWBfw3uJyXu4sbjcCH0LnL9Pgd0gRZLzOCwbHmn16JPhw4Ls3EoDcgLQSSVR5h7poYFeui20LOtNYuRecvKjr56V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768723274; c=relaxed/simple;
	bh=ZHXGQGtNa4CtQM5yect8NajKgpW75mjioCPaStMkJEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kO3Gn7Wn48UoJp27AqHMGyB72X2YqVMNMrjZnqrGIgGmSovIeJ8N8aeRcn4pjWWE4yNaAe0KkOCwtmjd4oZpTqHNKMGRTY5Se862lN1b4+sysfts2UE78sB/QkpW6lXn2nes56OPUWqD3q2fSE3Y0oXjXBXPGOP78rKsC3Nrjn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYK6FFFM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYK6FFFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114C2C116D0;
	Sun, 18 Jan 2026 08:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768723273;
	bh=ZHXGQGtNa4CtQM5yect8NajKgpW75mjioCPaStMkJEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYK6FFFMDRn4t8ckgA5LnPZ+9penG4NJrDXajUHue1DxxD7WPIKULGEgyvvcF9axd
	 VMU9xo99te4g112iR6psrqipjQBdLlN285XfeABKgfNPnt1GZdPFc5/HboUmor0y8Q
	 bZst6HVHYufbBu84zijREYz/E7qDzkh0bsauKi4l14NX4zO7q3hidE+CrYkBkBxfPi
	 PGHtVjXXj1A/VkgKbIyjXYfwRlmrdmh6/tMBqevYGtkCiwtw1ScalfFY+K80ecPajp
	 cJb6VAvRkaTvwd1gZA0O/ByI1FArR8Mvk5rak8iz9VUnQF86dDnbOSnT0bB13FOsjs
	 CsT09M/zvIPpg==
Date: Sun, 18 Jan 2026 10:01:09 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Alex Williamson <alex@shazbot.org>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
Message-ID: <20260118080109.GA14182@unreal>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
 <176775184639.14145.18318539882421290236.b4-ty@kernel.dk>
 <20260114133241.5b876b40@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114133241.5b876b40@shazbot.org>

On Wed, Jan 14, 2026 at 01:32:41PM -0700, Alex Williamson wrote:
> On Tue, 06 Jan 2026 19:10:46 -0700
> Jens Axboe <axboe@kernel.dk> wrote:
> 
> > On Wed, 17 Dec 2025 11:41:22 +0200, Leon Romanovsky wrote:
> > > Jens,
> > > 
> > > I would like to ask you to put these patches on some shared branch based
> > > on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
> > > and DMABUF code.
> > > 
> > > --------------------------------------------------------------------------------
> > > Changelog:
> > > v3:
> > >  * Rebased on top v6.19-rc1
> > >  * Added note that memory size is not changed despite change in the
> > >    variable type.
> > > v2: https://lore.kernel.org/linux-nvme/20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com/
> > >  * Added Chaitanya's Reviewed-by tags.
> > >  * Removed explicit casting from size_t to unsigned int.
> > > v1: https://patch.msgid.link/20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org
> > > 
> > > [...]  
> > 
> > Applied, thanks!
> > 
> > [1/2] nvme-pci: Use size_t for length fields to handle larger sizes
> >       commit: 073b9bf9af463d32555c5ebaf7e28c3a44c715d0
> > [2/2] types: move phys_vec definition to common header
> >       commit: fcf463b92a08686d1aeb1e66674a72eb7a8bfb9b
> 
> Hi Jens,
> 
> I see this is currently on your for-7.0/blk-pvec branch, thanks for
> splitting it out.  I haven't seen this merged into your for-next branch
> though, which gives me some pause merging it for a dependent series
> from Leon.  Is there anything blocking that merge?  Thanks,

Jens,

Could you please merge the for-7.0/blk-pvec branch into your block/for-next
tree? The VFIO changes depend on the blk-pvec branch, and the RDMA changes
are based on the VFIO updates.

Thanks

> 
> Alex
