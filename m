Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8675E339A0
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454303; cv=none; b=KgH7H04ektKoWabSYwYebUlL6trrpGP+7/pNJajSf44Q4m61ir+jKwVdnAcI1cIYWVvb+iCMvVSp/rizDxWRfgyGXfdY1MOFq/YmdwAm9mmzPWdotmwKnVrPVXa4ekHhB0NxsvsU4KVZOiBEONEEqY3tWOjALUZGwso8RJk+eEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454303; c=relaxed/simple;
	bh=MAs72L0ZrkT7nw1L2Kjb3wt7tc0/OdB4aUfVJn0UJ1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMpI7TtJvmlsoykjYX7SDwyhbKCO2gfxdNAH2J8u1Hf355470YiY2AGS71nRs/ng8u5v+4fT/5AdgPHXDfx0XQy4J7QfCajIWFtALz+ac7AQcgezawjsICvbcen+FcKqjzZ+VICoZj75nqd8PRu7M42DAscsRQBLNgJBOS+A38k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 33EA968BFE; Thu, 23 May 2024 10:51:37 +0200 (CEST)
Date: Thu, 23 May 2024 10:51:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, willy@infradead.org,
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v3 1/3] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE
 in offset
Message-ID: <20240523085136.GA4777@lst.de>
References: <20240507144509.37477-1-kundan.kumar@samsung.com> <CGME20240507145251epcas5p29e95da982219c6a1c196182fe70a45f5@epcas5p2.samsung.com> <20240507144509.37477-2-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507144509.37477-2-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

This needs to go to the nvme list and all nvme maintainers.  Please
just resend it standalone while you're at it, as it's a small and
very usful improvement on it's own:

Reviewed-by: Christoph Hellwig <hch@lst.de>
