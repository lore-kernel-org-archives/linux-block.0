Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F34D34DB66
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602208; cv=none; b=t86DkhgJ0hh0kwb35Aumt8ujE7ZPH94VJuh5D4z345pbEACFwV/d6k1GijIxUWKn82kazWaHCI3zNfvhnn+tTa2v+7QzoipZCHsbBAxXNgl7Lv8MxsnqsbGoiO27KH3puRa2s44zofF6XRRwM6JhHRGd4jbbMqxGzVTKQSA1Eqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602208; c=relaxed/simple;
	bh=a3y5oZNGVSvjHDnGtJCCbDDu1OWRCuQGE2un63HWQ9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGo2SyM71AmyJapjNkTgIb+4VR3jGNSJTojEmJZQvsKRtKcyP/tosk6f/LqRUQ7yDvWp5pxctr/Y7tMSOiKUk7TV7DPfOOaKJYp6o2rUV09Qd6Bx7ovXBS8LhkTLMJHC3NcROZKIGnlXcuGv6BjzyDrIfIxkY5N3MHHUAKFlW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C32DC68B05; Fri, 20 Feb 2026 16:43:24 +0100 (CET)
Date: Fri, 20 Feb 2026 16:43:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Correct comment on bio_alloc_clone()
Message-ID: <20260220154324.GA14632@lst.de>
References: <20260220143233.3500551-1-john.g.garry@oracle.com> <20260220151019.GA14027@lst.de> <26f345ba-9cb6-49ad-89f4-1ce0153fd86c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26f345ba-9cb6-49ad-89f4-1ce0153fd86c@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 20, 2026 at 03:36:41PM +0000, John Garry wrote:
>
> So I can have this:
>
>  * Allocate a new bio that is a clone of @bio_src. The caller owns the 
> returned
>  * bio, but not the actual data it points to, bi_io_vec.

Well, bi_io_vec isn't really the data, but the indirection pointing
to the data.  I guess we need to come up with consistent terminology
first before we can make good sense of this.

Allocate a new bio that is a clone of @bio_src. This reuses the bio_vecs
pointed to by @bio_src->bi_io_vec, and clones the iterator pointing to
the current position in it.  The caller owns the  returned bio, but not
the bio_vecs, and must ensure the bio is freed before the memory
pointed to by @bio_Src->bi_io_vecs.
