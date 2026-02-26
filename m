Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16C368976
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122256; cv=none; b=SF3VZrW7/ciAYnlHeHMmVe51DdcoAAawjZt+BbuZBy4h1A85Gj0zk5Fv9Rl4IhqlE3fa4cWwYT7cgwqV4o/rw8ex9ds0AEm7EPJ2MRy4LteY0AwoCZMsbuEJ500zrfm8SakI6sENvlXgOntdr4V0vLah/wNBOvcgXtadOoeECsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122256; c=relaxed/simple;
	bh=SizxvNHyIIIub/kci3lpbHrNciXMkt4wDgh0Qedujbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEMKepU+TGxCt9UCCjO+TPzpqTFpac3WhlXJzRSWmukBgU+Oth52ibnc4VI8Zd2+u7sKpXeOjjTGFSGbLxvHCYXE7mc8TMG/9yju+njJbDXw5vMV+p7N+SH1zCfGs95CmIZqSbYmN64H0j5+z1ShMmAuOSadPiBoEFH78j7Eyek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KdyLX7kf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KdyLX7kf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XJD1uUbIl1Mm/G4UUvmqbKE+RB1RV1NvHVzJyMkIL10=; b=KdyLX7kf4ghUXSxmbl1B6sknVz
	D6KNET7D0trbRj+ximXIHrd43YoA7fHhrM6D7+IuATPmIRbEyzYaQUGr2cgk6JzfVyAFANso9g3SW
	B7QPaHmSOhf1LQOjOI15NBQYoZVrPuHYzAG7A2ezj9ATiyxfr1Nfbo7SRGKmSkzjML/BIiJwqnYPM
	8l4LoszXY2UbTRAus0vP5z9xWAH2a78h1UXNxPtf7Hd3EtB0ouz9a7aoyJs3C/vKmFxT44wA9htws
	jzGAOLsgvSYimy7lPhmxyRdDfT6ieX6I+ArU91dHmhVKg73C9S0tCavzLaeGBwAOu+CYhCZfhf4Sn
	XcJJiHyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdwu-00000006hU9-1ifM;
	Thu, 26 Feb 2026 16:10:48 +0000
Date: Thu, 26 Feb 2026 08:10:48 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/7] block: fix zone write plug removal
Message-ID: <aaBwiGGrS5StFlWX@infradead.org>
References: <20260226041024.2154806-1-dlemoal@kernel.org>
 <20260226041024.2154806-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226041024.2154806-2-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 26, 2026 at 01:10:18PM +0900, Damien Le Moal wrote:
>  		/*
> -		 * Check that a BIO completion or a zone reset or finish
> -		 * operation has not already removed the zone write plug from
> -		 * the hash table and dropped its reference count. In such case,
> -		 * we need to get a new plug so start over from the beginning.
> +		 * We already have a zone write plug. If it is flagged as dead,
> +		 * its initial reference count was already dropped. In
> +		 * this case, increment the reference count and clear the dead
> +		 * flag to restore the plug to a state similar to a newly
> +		 * allocated zone write plug.

This comment, both in the old and new version describes what happens
here, but it really fails to explain why.  The plug is scheduled
for removal if we either filled up the zone or reset it, so any new
bio coming in would result in an I/O error anyway.  So why do we try
to resurrect the plug instead of just failing the I/O?

Or am I missing something?

Otherwise this looks good.
