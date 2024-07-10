Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48C15CB
	for <linux-block@vger.kernel.org>; Wed, 10 Jul 2024 05:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720590830; cv=none; b=uRk1crgbIGnCdvG67y0Eea1iz/0WNua0kck+o5DPId4sB6XtHnsPsoGJ4Lh+mNedU1Ak04HqcGDGMYfCm6M/bPOahZ3APEN0fs8ojzHeA34kEqvHio7GBOnbnWM8DFpuwQcP4ud7KMbWbo/CgmcbBeEgPHI03qgJ12kvsJk2diY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720590830; c=relaxed/simple;
	bh=q3P8IuyThO/IBXH7LtSwuFFu7hbPTKupi2i4cP2YH+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogN4NwUpg2Fi0L09es78nckA+oSjark6FSNhkXti+BSTqgrwP8c6OuAs26DmccTPgCx3xlyf+RqbwwIX9/EeqLoW6eA11d3ynhwB6pqfiadaRQQLcnZZzSr3/3YcG/toFUUAiYFPbzpdpG8VXTlVRkIUIIgDKTX37OPlQamE2WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3DDC227A87; Wed, 10 Jul 2024 07:53:44 +0200 (CEST)
Date: Wed, 10 Jul 2024 07:53:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: also check bio alignment for bio based
 drivers
Message-ID: <20240710055344.GA25282@lst.de>
References: <20240705125700.2174367-1-hch@lst.de> <20240705125700.2174367-2-hch@lst.de> <Zofzm6TRrOFb5iy9@fedora> <20240705133630.GA30748@lst.de> <Zo1AOKOK7dCpPll2@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo1AOKOK7dCpPll2@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 09, 2024 at 09:50:48PM +0800, Ming Lei wrote:
> > That doesn't mean we shouldn't look into actually holding q_usage_count
> > over the entire bio lifetime for bio based drivers, but that's a
> > separate project.
> 
> What if logical block size is changed between bio submission and
> completion?
> 
> For blk-mq device, we need to drain any IO when re-configuring device,
> however it can't be supported generically for bio based driver.

Many bio based drivers do the same, just reimplemented without
block helpers (e.g. md/dm).

But as I said the point is that I really want the sanity check to
always be there.  I'd also like to eventually make freeze work for
bio based drivers, but that is a separate issue.

