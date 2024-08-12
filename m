Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E7817BB14
	for <linux-block@vger.kernel.org>; Mon, 12 Aug 2024 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469929; cv=none; b=ipsroQAbIR4OYckdGTJe4DM0oc3JAaAXGY/iYPfo39iMXwuvE+gBSAWqxEQGlzNrmx3ldk1DB+K4coPIjD8v3CFhgG6uUJ5RuJbXEGnVtFREohsM04sKDP7d1BHftprgNZda6dNwCHWecW2owPxw+r6FtXgwdYuVuU5xbeIb+Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469929; c=relaxed/simple;
	bh=i2TopCfxA35jt5R9+xgsJwJF5Hih2D+XHUrfqA1tags=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDC/btfZnnvo/yWdGAgmnOA5CoWNT43jYvV2hbMM/J6kicxYeU0D98VrO6GelEnLZujaIldJ8osGtnKpq2gYF2yZFCphpYp88dSFLuAQUaBq3AHIQBPW2r17Y+eRLGGqqsy2bVs7bn6mOLWP1KCArQVY3MEB16rMCMyNUGk+8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 27577227A87; Mon, 12 Aug 2024 15:38:44 +0200 (CEST)
Date: Mon, 12 Aug 2024 15:38:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kundan Kumar <kundan.kumar@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, kernel@pankajraghav.com,
	axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v8 0/5] block: add larger order folio instead of pages
Message-ID: <20240812133843.GA24570@lst.de>
References: <CGME20240711051521epcas5p348f2cd84a1a80577754929143255352b@epcas5p3.samsung.com> <20240711050750.17792-1-kundan.kumar@samsung.com> <ZrVO45fvpn4uVmFH@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrVO45fvpn4uVmFH@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 08, 2024 at 04:04:03PM -0700, Luis Chamberlain wrote:
> This is not just about mTHP uses though, this can also affect buffered IO and
> direct IO patterns as well and this needs to be considered and tested as well.

Not sure what the above is supposed to mean.  Besides small tweaks
to very low-level helpers the changes are entirely in the direct I/O
path, and they optimize that path for folios larger than PAGE_SIZE.

> I've given this a spin on top of of the LBS patches [0] and used the LBS
> patches as a baseline. The good news is I see a considerable amount of
> larger IOs for buffered IO and direct IO, however for buffered IO there
> is an increase on unalignenment to the target filesystem block size and
> that can affect performance.

Compared to what?  There is nothing in the series here changing buffered
I/O patterns.  What do you compare?  If this series changes buffered
I/O patterns that is very well hidden and accidental, so we need to
bisect which patch does it and figure out why, but it would surprise me
a lot.

