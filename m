Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F476BB20
	for <linux-block@vger.kernel.org>; Tue,  7 May 2024 05:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715060753; cv=none; b=m0UdMWhEpKAwKNkjoarzTiXhE7xDpUKl1MJcpdX+sPsK4hwKVxEF8VJR74k0WumPSrR9dg3k7S8pFfsmXWTT0MUisKrjotYq6/Aew5kbLi2p7onIn39mAKX5G1KrfazI7dDXn5QkP57h4z9hZGefVWKcsw08VsyS9YQeeHXbLMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715060753; c=relaxed/simple;
	bh=Xg+/vmMrL+5yNdskO7uB5gqGiS27ieXFuhz8oZm/vBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfNb3KzTzLch2bU0P9yLtu0bNVfGjjNDZuGh/KVUCOh+L3Fgz5MxZmGdAxCIwWMhfA26tGSX1rZvG78V0Eo5niD1/ShlnoYrpg4dVe2ACX6tlqQmDuxdJrRVVCLMgZZXJ43Ytum1PzicBeqaQvn20Yl2hxDvURvdHE7xZps/imQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A4A2168AFE; Tue,  7 May 2024 07:45:47 +0200 (CEST)
Date: Tue, 7 May 2024 07:45:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, anuj20.g@samsung.com
Subject: Re: [PATCH] block: streamline meta bounce buffer handling
Message-ID: <20240507054547.GA31832@lst.de>
References: <CGME20240506051751epcas5p1ed84e21495e12c7bf41e94827aa85e33@epcas5p1.samsung.com> <20240506051047.4291-1-joshi.k@samsung.com> <20240506060509.GA5362@lst.de> <Zjk_Nnn-T0SgWoNv@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjk_Nnn-T0SgWoNv@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 06, 2024 at 02:36:06PM -0600, Keith Busch wrote:
> Unlike blk-map, the integrity user buffer will fallback to a copy if the
> ubuf has too many segments, where blk_rq_map_user() fails with EINVAL.
> 
> For user integrity, we have to pin the buffer anyway to get the true
> segment count and check against the queue limits, so the copy to/from
> takes advantage of that needed pin.

Can we document that somewhere please?

> That EINVAL has been the source of a lot of "bugs" where we have to
> explain why huge pages are necessary for largish (>512k) transfer nvme
> passthrough commands. It might be a nice feature if blk_rq_map_user()
> behaved like blk_integrity_map_user() for that condition.

Who wants to sign up for it?  If we also clean up the mess in sg/st
with their own allocated pages that would have the potential to
significantly simply this code.

> > Sort of related to that is that this does driver the copy to user and
> > unpin from bio_integrity_free, which is a low-level routine.  It really
> > should be driven from the highlevel blk-map code that is the I/O
> > submitter, just like the data side.  Shoe-horning uaccess into the
> > low-level block layer plumbing is just going to get us into trouble.
> 
> Okay, I think I see what you're saying. We can make the existing use
> more like the blk-map code for callers using struct request. The
> proposed iouring generic read/write user metadata would need something
> different, but looks reasonable.

The important point is that the unpin and copy back should be driven by
the submitter side, not matter if it is bio or request based.
