Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A29F28B4FD
	for <linux-block@vger.kernel.org>; Wed, 10 Dec 2025 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765350422; cv=none; b=SQUHyroChWXwUd0XNv97H1j0LoHuNWv6w28FQcKKE4X1w4kp8N32+eMASmjvJOcGnKqZjh+foh8ENwqSFsSE7IV6U9640kvdgNhib35caD4b70HrKTmYMls9wn0jnbI6H8ze5icAEyO9M9Z/sTJaele89I/rb3/YKGqzb54yuGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765350422; c=relaxed/simple;
	bh=wYUJ6/cLJrno4R/8OV4wT8d4i5E61N0d3L116TB8D7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/Ik6LumEO0uQAE7we57UlvrvvZsJNoruR261BbPFf122ONVsC9+iKCrwPdUIuwwN1uUf3XTnk2Mk4OnSpKFuKaXCEpbdr7QaCjERRCbsnlVSI78z+j5wqpcBS2sju0voQDR0NPfvF1NnQYqH0/75Q9NDY+L3TMPkO73pZ8OmRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaJwPGZJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaJwPGZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11985C4CEF1;
	Wed, 10 Dec 2025 07:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765350421;
	bh=wYUJ6/cLJrno4R/8OV4wT8d4i5E61N0d3L116TB8D7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SaJwPGZJZhBIISe2tVd41g4U+hi4nl/9+AqLpfBvh0Kbzj1baD9ahTEPZGOMsxLFE
	 UpfZNRFlQNjjn3i6H8UPg+D20kKCVsdLccy85Mvc2qMdCMdizxK7KrTUGAdr68uNgX
	 ELKEER911zPqlQ4KA1CUM/HrJrblXgm7Arc7QGxPkpCXZJyJjSWTVzz2vsAwskjqoT
	 cwwv8IqFLV0FZzpmuVUM3ji7zFw3az4YRRshjq4rJCwZp3N8TD1SVVityoRm4lNVqW
	 StOgMIoL2kgVE33ylrq1JhRaDATVeUpacxScZIHrQQbAx84In+ea0hq4TjncSDde+5
	 5Z66FP4DKjXsg==
Date: Wed, 10 Dec 2025 16:06:57 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, Sebastian Ott <sebott@redhat.com>
Subject: Re: [PATCH] blk-mq-dma: always initialize dma state
Message-ID: <aTkcEeRFPHuN8d9f@kbusch-mbp>
References: <20251210064915.3196916-1-kbusch@meta.com>
 <20251210065407.GA650@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210065407.GA650@lst.de>

On Wed, Dec 10, 2025 at 07:54:07AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 09, 2025 at 10:49:15PM -0800, Keith Busch wrote:
> > -	if (blk_can_dma_map_iova(req, dma_dev) &&
> > -	    dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
> > +	if (!blk_can_dma_map_iova(req, dma_dev))
> > +		memset(state, 0, sizeof(*state));
> > +	else if (dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
> >  		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
> 
> What about just doing the memset unconditionally?  It's just two
> 64-bit fields so no real overhead, and it gives us a clean slate that
> avoid introducing other bugs later on.

I didn't do that is because dma_iova_try_alloc() also does that, so it'd
be two repeated and unnecessary memset's on the same address. That feels
undesirable no matter how small the struct is. I could remove the memset
in dma_iova_try_alloc instead and make the caller initialize it. There
are only two existing users of the API, so not a big deal to change it.
