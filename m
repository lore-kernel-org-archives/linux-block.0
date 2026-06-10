Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42C0343D85
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068839; cv=none; b=oLLm4/G1gPmY83DWNL5IsOOSv+7ywRqsN7rbuDvQcmVbUAqEV3C98u08lV+5zRlEFjfnoN/HDeKKobtLsO2s/eCFQxazeOrmAk2c5fXhc5BZajA6gDfeH2WVNe02Yi3NgUPDXLjVWB4KsG4G35CsLKQXMWDuIuCs/x0h3XH/pNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068839; c=relaxed/simple;
	bh=dzJqPAequDWzM4VD5VBJwejmHJTyYCCWNcN4fUIJKNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z824v+bpkuR5YqXQiLy8fmSBq0SZsP8XFp4EtHDkMguGV/jeJgy0dPNKtK3w/9y925G0UL90qn6uMxG0S5iVBVcklpxC7NSpPbMN+SxMLn0IcvHygiexSPRxxXVpQnCVRsAhmdFqFK5TmLtxi7YbWB0i14zr3slAXfxz/x2NWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RgqYvwZO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RgqYvwZO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dzJqPAequDWzM4VD5VBJwejmHJTyYCCWNcN4fUIJKNo=; b=RgqYvwZOqMLhZ59ZvzM/1dNkmK
	FD2zh6wN6HdaljFhQH66pXBHaVTq01jgEeBwMVNoCzmQg+z6YVyt2FYD12XHnS9Sx9R/sR/kZMtlu
	UWrKjuJir4gKFCpLzCBx1AS4R9VFgSuVCnu5ro+DZVJD80OY/MDs/c5BzBxYLkT7/Pb8kcve3TkVz
	U5PY6uWzditvgyUu6MPiCazC+5BEsOP16mgtHnm5StUcYUZw7/qGGeKvPWETxKlRHIwWN8YscKYYO
	axzdFQDrZvvBHW+piXNHhdM81cpswXaNKetdkLuoqVQJ1GiZ3pOHmCrueWIv/AsSevhIizQEzVk2g
	uPKfNZvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBMj-00000006omu-1tJV;
	Wed, 10 Jun 2026 05:20:37 +0000
Date: Tue, 9 Jun 2026 22:20:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 06/27] drbd: Simplify the bitmap locking functions.
Message-ID: <aij0JVDaCJJCvQ8s@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <b5a5c65d4f10572a112071033c105d54c9ad0974.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5a5c65d4f10572a112071033c105d54c9ad0974.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 09, 2026 at 03:04:53PM -0700, Bart Van Assche wrote:
> Call mutex_lock() instead of mutex_trylock() followed by mutex_lock().
> Remove the code that depends on device->bitmap == NULL because this
> can't happen. All drbd_bm_{lock,unlock}() callers guarantee that the
> device->bitmap pointer is valid.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

