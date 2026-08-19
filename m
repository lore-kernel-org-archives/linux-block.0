Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B04F3AEF2A
	for <linux-block@vger.kernel.org>; Wed, 19 Aug 2026 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787149658; cv=none; b=S39u2/j7DitkxF2e9hT0PWcIm3MKNw9fxHqS1B6fIrmaq6TueRMuWYu1+sxH/sAUm6FQhRNYaWHUZNhdMkX0/xesrRa52LvufC7yS1KL4wZSiowfHNq3MW+xkUIfwi9OftnwcDWuyFMYy0S8Hoq7j9Ybc9pb0tXaB9NUNjigbzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787149658; c=relaxed/simple;
	bh=iNWGTtn3ivHsECuX8wVhccMsBs1zqRvX4etIB+Stsr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+Yag0vbcZkP6XpP6MblLTlmssDg9qj8K2rGdgtzZuXmpC81W4K8ImdheDs2fXk+aDfmcrVSYPCsYU+qWHQiVwTngejlfMDYXB8hhX1qZ+R7yDdYrFmn2e4IoOaOuCxT45D6T8mKwOqusZDf4vRmrRl0wzyHCmnv/ijKjvqKbYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 97B2568C7B; Wed, 19 Aug 2026 16:27:23 +0200 (CEST)
Date: Wed, 19 Aug 2026 16:27:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, axboe@kernel.dk,
	Eric Auger <eauger@redhat.com>
Subject: Re: [PATCH] block: save page offset gaps in cloned bio
Message-ID: <20260819142723.GB825@lst.de>
References: <20260817165908.137682-1-kbusch@meta.com> <20260819052306.GA32364@lst.de> <aoW3-6U0XkrHudpy@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aoW3-6U0XkrHudpy@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 19, 2026 at 08:04:43AM -0600, Keith Busch wrote:
> > > The split remainder meanwhile can reset its gaps to 0
> > > since it advanced beyond it and will start accounting from there.
> > 
> > I don't really understand this part, though.  As in I don't even
> > understand what you mean here..
> 
> The accounting for the vector gaps happens at the same time we consider
> a bio for splitting. When we do split, the gap value applies only to the
> front bio because that's as far as been processed. The remaining split
> bio should reset its gap value to 0, and it will be recalculated when it
> continues through the split consideration.

Ḣ. but bio_split is used for a lot of different thing.  Then again the
bi_bvec_gap_bit is only used by the low-level blk-mq code, so it might
not matter.  But this for sure warrants a big fat comment explaining
the rationale for the clearing.
