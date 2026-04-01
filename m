Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D8F4534A4;
	Wed,  1 Apr 2026 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052536; cv=none; b=b+O3DrC454RyKDyLzeXngr1/PcEB5LCJXr9RW3a/z9R59hO6gk+CBXM59sRpPGluF7YMYydllEtzofZcFfxJpJS/ghEimrv6IRX4MCH+GrxnsRfu+UwPkmw+Ogmhy2aC+CK+eLMVdHQ3eUIL8b2Zf7rRqjeSWCV559dlyqGiqBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052536; c=relaxed/simple;
	bh=oTzkBOsY9u/CXLHws0SFPImBSTPPadMk4DtzoglGaLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPzLvjgG8WAPXHc2fgy6+iBrHomEH3g/2g2xrAl0SNp0sRV7F8gjP5ikvkg0Zm8w+v9Eb4M0y0Bjdqj+fy9DAediyraukQ1ZMuBYGflLmDlm69hI+EjMe7ynt+KS6ukguCENkv6aahc6XCSfb8+Lb5qADzntVAYgqaoYKE4vycQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 171C668C4E; Wed,  1 Apr 2026 16:08:51 +0200 (CEST)
Date: Wed, 1 Apr 2026 16:08:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 2/2] block: allow different-pgmap pages as separate
 bvecs in bio_add_page
Message-ID: <20260401140850.GC21703@lst.de>
References: <20260401082329.1602328-1-namjain@linux.microsoft.com> <20260401082329.1602328-3-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401082329.1602328-3-namjain@linux.microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 01, 2026 at 08:23:29AM +0000, Naman Jain wrote:
> bio_add_page() and bio_integrity_add_page() reject pages from a
> different dev_pagemap entirely, returning 0 even when the page could
> be added as a new bvec entry. The pgmap check was intended only to
> prevent merging into the same bvec segment, not to block the page
> from being added at all.
> 
> This causes callers to unnecessarily start a new bio when a buffer
> spans pages from two different pgmaps, even though the bio has room
> for another bvec.

This is not unnecessary.  A single dma mapping operation can only
map a single target pgmap.  The old SG API works around this by
doing multiple mapping operation underneath, but compared to that
just having multiple bios is much easier and more efficient.

What is your use case here?
