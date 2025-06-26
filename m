Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A551A1BC9E2
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 05:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750915703; cv=none; b=gqnIchtpBWh9P/IzNlyM1JKAxEXfub/EsS7nowKcvJBfY0GDCg/1QNqD6INcheiHTuelVEvnGzlzPoD/oLH3JFZuBZdPfbTgkhQhrpN49tVifcdnc8XGxaiK6VrZ5QtWEpAk/3eVF2RKQXILrSWdsO61PBivxNn8ilX4+sQkVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750915703; c=relaxed/simple;
	bh=ioQoA74UBDFsrLWPhCZyUAi73rjAbuq/MbglLNqS9Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+ZPDGOh4WeSTVff2ggcVwrk4Pkn6QV7AaVQShmPs8jbWNdWWE0DmHF88Q9nM2ILSzvaWhIy6fEIY/Vip/MuLDk/PxY9X9c69ISaX0w2B1PkpL6gfxHTa+72VmtvZ4JumGU1hJ2RpcGCWJVnJQXH6DFcx/kHumLIfH7lTucl6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LpORe5QX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LpORe5QX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jni6bJzfbToQ4ROxSIpya6isSLFzNhbrqkEyVTAFKo4=; b=LpORe5QXKBkHk2SaXpT7uUOFT7
	axRAdFExxWHoX+j7215hsparA1yjKo5ZeBlnpMZeDlnIFreojCazY54KACGKzuOnhWtmm1J8Pr+ik
	OUKLgcNihYfwD4tV8PL6JZQVcxA2qOtG2O2E8roxKlIvF1RFX+MMMIi40A3odruqNysKzRNOiSh7W
	ISgpul5e2tm7wIDELrYQpYpGqG5f2/SsjYCoPlCBtAV4Hf6/tXSbTfN/TW85TxZ+UGx3L9SBR4V+3
	OZzKpnJ0MCt4ArbckzVlTBGfLQiOsqLFez2P2ngNwQUW926scJOfB6R/cm19CN4l6F5eIUHL5yd5E
	AEhBz9Ig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUf9q-0000000Ae1F-0OxR;
	Thu, 26 Jun 2025 05:28:22 +0000
Date: Wed, 25 Jun 2025 22:28:22 -0700
From: Christop Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/3] block: Rework splitting of encrypted bios
Message-ID: <aFzadpzYv14Qbs5K@infradead.org>
References: <20250625234259.1985366-1-bvanassche@acm.org>
 <20250625234259.1985366-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625234259.1985366-4-bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This adds a lot of mess to work around the blk-crypto fallback code, and
looking at it a bit more I think the fundamental problem is that we
call into the blk-crypto fallback code from the block layer, which is
very much against how the rest of the block layer works for submit_bio
based driver.

So instead of piling up workarounds in the block layer code I'd suggest
you change the blk-crypto code to work more like the rest of the block
layer for bio based drivers, i.e. move the call into the drivers that
you care about and stop supporting it for others.  The whole concept
of working around the lack of features in drivers in the block layer
is just going to cause more and more problems.

