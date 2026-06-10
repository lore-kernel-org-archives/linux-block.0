Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C8A1DF25C
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069514; cv=none; b=bMQ6cbSMJ25MCL3vaaAfd2LC4d1b6daeV/VJyQdUP9SLEXypsPf2Uyh2DKZGuy3hHMglTiaJzIjgxI0OPoEBOpKtHtE81JvsFjCa5z48nzXdi80raNE60hXjjfR+ypdAUQLnVbaTH2CVMuJ2zX0ZaDmNgniBZsmWKh7r1NNgY5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069514; c=relaxed/simple;
	bh=hCN3vOqZE/aZETQC9aFfuZZPyE7rXw3WySAR/0hy+Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcFbeZMdv3M+aCF/8O5afR5ad1cXf5vTKfZ0wKpUT/Uhym6mIWOMewbtVRuhaq7x1gWzM8/fVFLxkaVTOhcqc7mN3qsHYWrGqCHIgGj1R9FBl9jxHiG1Cyd4ISbvq24R0aHBK6/IQD9r7G+iGeM0Ul2xy3pSUL+BNb2sD4t9qIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WetgRqGP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WetgRqGP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ObHtvbMkAC0FpC2QnEH8f0yiany2W4382iUdsNImNZk=; b=WetgRqGPlsmej5yHehagd3pnRZ
	5FQ1c2XtCVJUU5El1crxDC0KxQwXzCUmK1SWvQMMlq+ii6RPIyd8lyt76w8OpHtSuQsKmQcK9zbcr
	tUoUamu4/6eIpyxbZRwHGruqbDsJZ1WCSlYIONvqebWwwl23QFX9PKZtYkzEBOM3CsL45yT2z/zX1
	omrYuOI4N3jkTeQCy8q9rD/Hq/MEHvRlb8Xi029J6HDQLlz0ZO6udtc8NP4kexVkqA49tAL03RGo3
	qEGtu2cJbVO4+rt/yIBltkxDQyHJoaKSXayxjYdfKPFBp2/89u0nvWyk+PQP1y3MUIBL5iy4urfHz
	yBi7/+yQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBXc-00000006pLZ-1eI5;
	Wed, 10 Jun 2026 05:31:52 +0000
Date: Tue, 9 Jun 2026 22:31:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>, Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Genjian Zhang <zhanggenjian@kylinos.cn>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 21/27] null_blk: Enable lock context analysis
Message-ID: <aij2yP1Y1Dven4Bz@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <b70422c6f243b9275e336430071b52eb92dd40c4.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b70422c6f243b9275e336430071b52eb92dd40c4.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 09, 2026 at 03:05:08PM -0700, Bart Van Assche wrote:
> Add __must_hold() annotations where these are missing. Annotate two
> functions that use conditional locking with __context_unsafe().

Please explain why that is needed and there is no better way to have
proper annotations.  Both here and in a comment in the code.

