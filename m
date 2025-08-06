Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46142944F
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492683; cv=none; b=CyIHiEeFkCirBWLfjmR2YSZmMp7T0IVdt7rbeDUZemAP3bm9NxmIEiunLu8GAdIi2rD9riv3D9isDONbZqTwQqjRPoIeOuqH1QkohVrIH3qLXfBYUemli4a56ZLHas/hQtcIeISIUhgru9Vr7JNxxue1LGCnBCGmCTGrOrSxqvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492683; c=relaxed/simple;
	bh=UYqCNGyT3EmjFK3mZkAylSZ+X76TSycu9O7yKJ+mh1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eU0LhAkdMKVylX0n0SHZVbIN2hFJ9L9A15+OsXuvCtNfTotB6ztYlByNM5t6jQTXsxegcVH4u0R3/G3b6PCoJCuyneER9MSLZqB00afbI5QbH5cke+5UaTUOR9orngscgSybLH1ku2ZWPsaIZiIJ4gLe2jlX7IwVa5n0CLeNwCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iph8x/TO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iph8x/TO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F8FC4CEE7;
	Wed,  6 Aug 2025 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754492682;
	bh=UYqCNGyT3EmjFK3mZkAylSZ+X76TSycu9O7yKJ+mh1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iph8x/TOWRyaus5Uiz2WYsGsEI/z2wj2GYEEkcKdS7FmhUa06ENCuHrYm8EKOAmGR
	 UY5mcKrLIZ0gjz3+wex3oapU0/VAdHY1bnohB9Z5VUbehAP6MTj/IBLQws9veijsG2
	 /G+qZKzVx/NDN9cc6d7TYLjN9fovgDG0AFDYvfsF7gZecxUPwgUg/WhlqrNBHAS4Ud
	 UXdJ+/3aExPbrFv++2LYJxW09iTxoizP0M5B6H7Is6QMiROW/BFlWpHPV84SWWstEb
	 DcJAucdFZ5+Dg6aLoUqvzRY7yYWCmxyP0ewb2kYr1/NpeLGmegDyKriw3f8YmeOJTL
	 9oY9SLVgfuMOg==
Date: Wed, 6 Aug 2025 09:04:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 2/2] nvme: remove virtual boundary for sgl capable devices
Message-ID: <aJNvCOZeiah3jeMR@kbusch-mbp>
References: <20250805195608.2379107-1-kbusch@meta.com>
 <20250805195608.2379107-2-kbusch@meta.com>
 <20250806145514.GB20102@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806145514.GB20102@lst.de>

On Wed, Aug 06, 2025 at 04:55:14PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 05, 2025 at 12:56:08PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The nvme virtual boundary is only for the PRP format. Devices that can
> > use the SGL format don't need it for IO queues. Drop reporting it for
> > such PCIe devices; fabrics target will continue to use the limit.
> 
> That's not quite true any more as of 6.17.  We now also rely it for
> efficiently mapping multiple segments into a single IOMMU mapping.
> So by not enforcing it for IOMMU mode.  In many cases we're better
> off splitting I/O rather forcing a non-optimized IOMMU mapping.

Patch 1 removes the reliance on the virt boundary for the IOMMU. This
makes it possible for NVMe to use this optimization on ARM64 SMMU, which
we saw earlier can come in a larger granularity than NVMe's. Without
patch 1, NVMe could never use that optimization on such an architecture,
but now it can applications that choose to subscribe to that alignment.

This patch, though, is more about being able to utilize user space
buffers directly that can not be split into any valid IO's. This is
possible now with patch one not relying on the virt boundary for IOMMU
optimizations. In truth, for my use case, the IOMMU is either set to off
or passthrough, so that optimzation isn't reachable. The use case I'm
going for is taking zero-copy receive buffers from a network device and
directly using them for storage IO. The user data doesn't arrive in
nicely aligned segments from there.
