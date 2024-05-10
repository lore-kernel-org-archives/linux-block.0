Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEEE16F26B
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715380513; cv=none; b=HevTduNI4BWZIOVFCQa5NcMFPENUw9jD10bGudo6a4fK1zdBNH4TgiPfol4FWFpvU+elBueM5TzxZXtd85EZXM5HG5wtzUPgO3Nkj/AFub9SaTC9pc1hhr+ndl/wa8/9KxwfnCoRzB8BEaft41lJia2fL9y9CPMQtT4R1/+2g14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715380513; c=relaxed/simple;
	bh=EOtva+T8vs80F79iO56jpetcgtMxSTktGczYZkTrl7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTZhaSBksl/QQz8joZLCEr1VCOmKiDdWbrHV4d07T2EtBykkpyfa5+EO63MIY+2QE4aPRAJIuxRtVSAQKSYGihqWkYvXxp3RhR6Tf8IwodSaHT6G/oAga2fWZtOJPf2Os4sdgciBtwfmCz5iBNtl9gnYyBiQQlZfYyZY1mpESMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aRqc1QYN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aRqc1QYN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TYX1t3P8vxTyrszZ12OaRCKgK8HzCeKMv9sFCKEnUk0=; b=aRqc1QYNpkhRlH0e068qaaEp3q
	/2aDRoZhx/jxbft4rshF0vXCLfdvflZEtHkglS2m6SIa/EIOdpiU3MlK7z/ny/+Xc0ddnChNLi9Rm
	9XeWa91jWxfdE1PJ339P6mAH4WtL5gfOAv/E0LzX9b29Wo5FJk6lxqPTEtnlmmqeL6LKhDaG7nWFn
	Gt4mtEafFC7rfXiraatWwDdADS2q33AQpq61ZR50y2x8/2IkJboCLd5H5D/O2obYDO7t1zDJqTOfc
	VjvBhEKfDjbWeHRkLD7qu8k6ylzbR4Ogvk1UsKRJaFlhGxZlugxD5ZDF99/h6mlyJsbBcKwtEnB/t
	Ig+blKOA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5YpY-000000045I0-1zRq;
	Fri, 10 May 2024 22:35:08 +0000
Date: Fri, 10 May 2024 23:35:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/5] block/bdev: enable large folio support for large
 logical block sizes
Message-ID: <Zj6hHAVWSev-xe4R@casper.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-5-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-5-hare@kernel.org>

On Fri, May 10, 2024 at 12:29:05PM +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Call mapping_set_folio_min_order() when modifying the logical block
> size to ensure folios are allocated with the correct size.

This makes me nervous.  It lets the pagecache allocate folios larger
than min_order (all the way up to PMD_ORDER).  Filesystems may not
cope well with seeing tail pages.

I'd _like_ to be able to do this.  But I think for now we need to
call mapping_set_folio_order_range(mapping, order, order);

