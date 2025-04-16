Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9239CDF59;
	Wed, 16 Apr 2025 04:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777967; cv=none; b=N+qyIQOKpaQKJFToydzggmuWYrdi5Dq8GIxb0TnsIevMjF1qjAGfFFvKCuhOxuGVGpAr4dx+vRbYJbFEMyoN1t26BaYqqG72Ct9BD7HOq/efwkJDyG6tHcLZ+fjU7DEgaBh8bUE6JZcTsimU8LyOYxYd4H2kclsToaEmq9B0oj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777967; c=relaxed/simple;
	bh=5xJFzVMWk+E76kKDdhjA8Gw1TaRs8YEhnA6cWqhiAEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJ8jwAahl0RR04h9dfS7sv3vKUmzcfcBJrsP240ctDjBEfOa/EHoPuo9Oq0LLxj1hFpmRZOvAxHmdn10Ia2MYKnmiaDAQlDdlA/QgptFJC38ohhsv8HmnemA8cukobpbiATg3WFsQLwZNZQUd6S98G8u1Y6Ve2WjvI6Iilalh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rn8Zu8BQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rn8Zu8BQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OEbKpslmMvpwmpfO6oVXe58NvRWk6dKBaxpuRUYOBA8=; b=rn8Zu8BQzyvF8zNSPAV62MxTjU
	0ltj4z0k1DARz9b2w8HqsB7ThVZtZDX0ewiQqHPUnbWZ//rSPrfCEjqp2hDUJF9Ytfim1WZnxI2S5
	J8gmllCaGJlvoiAG5GL49gHq4GT9DyqNY9dykfy23LZVFuoIT1tkJud7aFJ2y+0sl5z+E1ul83cuP
	mM2ahJQ2SaYXys1ko65H0a2C3RLoTp9s8bVghXiVZdJKrku5M3Zj3vzIzMJvjdZ0ONxn3t8Nbdqra
	h7IAzZ21AVK+4mdbbg+nPqNMEUFY/P8J8nRragatxsp5urhvpfGCoilKAreSYkGOU72LLVXzD5vpo
	B4h1J6CQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4uRz-000000089pv-3MFn;
	Wed, 16 Apr 2025 04:32:39 +0000
Date: Tue, 15 Apr 2025 21:32:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yunlong Xing <yunlong.xing@unisoc.com>, linux-block@vger.kernel.org,
	bvanassche@acm.org, niuzhiguo84@gmail.com, yunlongxing23@gmail.com,
	linux-kernel@vger.kernel.org, hao_hao.wang@unisoc.com,
	zhiguo.niu@unisoc.com
Subject: Re: [PATCH V2] loop: aio inherit the ioprio of original request
Message-ID: <Z_8y55Y6qgqgEYHW@infradead.org>
References: <20250414030159.501180-1-yunlong.xing@unisoc.com>
 <Z_ynTcEZGhPKm5wY@infradead.org>
 <e0dc38e8-9df0-40e3-a0e3-fd4b40b3fd80@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0dc38e8-9df0-40e3-a0e3-fd4b40b3fd80@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 14, 2025 at 08:47:51AM -0600, Jens Axboe wrote:
> I think we layer yours on top of this one, which is something I
> can just do without much trouble. Do we want the vfs_iter removal
> in 6.15 or is 6.16 fine for that?

Sorry for the late reply, I was travelling to my Easter vacation.

Given that Darrick somehow managed to hit this old bug due to other
setup changes 6.15 would be great, and it looks like that's what you
did even without an answer from me.  Thanks!

