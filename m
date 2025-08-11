Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C088223A9BF
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929083; cv=none; b=llQDYmjUB6susVVc5Y8cGOXwhQRaqKoI1i/1edkyYRAFbZqbKaHxDN/5WZlqfl2///2F9Qs1nkp7Ui6U3L3YK0VGxCKPzai17vEbu+PoDryaFd+NA1xKPFqRz5aAzvHHg8/+hUswwuUYFkjZCLOsXAS+Qzj7EJKkg8Nm5/MEDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929083; c=relaxed/simple;
	bh=K6/7yPlwOZhquuul282eYeDj7tsyOIoAHqHzxkGfDwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FR5u2OBOr+Ef4mousQmxcuhMKrLQ2J2BMsD4P4APnjOb4Zaa6/mf4hvOnl/tuIwrOmjGpBJBaHbCiK0dzWiby8gy1msL0TOBnqTdo64taZ87qzpqEsjLUojVKsMgiv0xphGZFtrzxEHsitksnSOmgNPoya84LCPtNOaBh1WXHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 57E0D68AA6; Mon, 11 Aug 2025 18:17:56 +0200 (CEST)
Date: Mon, 11 Aug 2025 18:17:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250811161756.GA25496@lst.de>
References: <20250805195608.2379107-1-kbusch@meta.com> <20250806145621.GC20102@lst.de> <aJN4b6GS30eJdQLd@kbusch-mbp> <20250810143112.GA4860@lst.de> <aJoL1rsvI5bXkod_@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJoL1rsvI5bXkod_@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Aug 11, 2025 at 09:27:18AM -0600, Keith Busch wrote:
> I initially tried to copy the nsegs usage in the request, but there are
> multiple places (iomap, xfs, and btrfs) that split to hardware limits
> without a request, so I'm not sure where the result is supposed to go to
> be referenced later. Or do those all call the same split function later
> in the generic block layer, in which case it shouldn't matter if the
> upper layers already called it?

Yes, we'll always end up calling into __bio_split_to_limits in blk-mq,
no matter if someone split before.  The upper layer splits are only
for zone append users that can't later be split, but
__bio_split_to_limits is stilled called on them to count the segments
and to assert that they don't need splitting.
