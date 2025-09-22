Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308ED17A2EA
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560263; cv=none; b=CjPr572tuVErDHF+Mvz5lG7uXCaMFpJ4ieyW9rJ37S7Fs/xW3lSqBek2UxaltlGYbLCtOVr/u91mclGIg4rsC6gMsZX7rM9t4Hv+fHA5w+tzik0pZOKCGIregAHvnKjT89nljbwZo9t/wi8n+0Pbej036cecwII3ZLeGrGyhFfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560263; c=relaxed/simple;
	bh=bLy/qm9oYGpjkvjYbzt118+LvOcdCbaCGU5AL7a5BL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2u+Yc06FP4iGmvNmPwbStKSHdwzB/FrYnO/nxulEXx73blLxQN2lRAae0Q+PP0gxYOQGPoU7PM93nuXUfI6/Km/C57/ZgYVpoWz4k9z8sYubfR+q4BTu4L2PgiAzUhyMGo/7zxbGBptLsArS81Kdn+q3VYilZqWjLT6Zb17P4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WpoIQwkb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WpoIQwkb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sC1Isi/8DfbzYqgf4iEzKIWox75+OPyXGpiifIwsE1c=; b=WpoIQwkbIPISv1E8NhRaYpWRvj
	9A2RzWWvdAwODZznTxcoDLHw3GSAccmuHbL7jNQ9ZY9/kfLp/2yWUxCiN6uf+WNaqM3ws1Ys4+nqd
	w6Viq1ukUjBYVi2M9Xjj5UOO+aqW7yEWvExXHSTRTz+X0Vbwed5VK/gqxvkUkH98yelnfxV5wQ3eE
	DlxkxsjwDLK5ONAY0zpSr325pr7SnRn2cZOHwkj+S8qN1q3q1drhF8hRgtIUAqkUcv50iG8339qQ9
	dZtWKFLin/bzKjiTJPjrERZm3c5oPuSgKON8VoHRF08W2iKJkwbfc7qIsuXAOW/mrxOdDT1uzdRJY
	e9vg21zA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0jrB-0000000B2fM-1Xnr;
	Mon, 22 Sep 2025 16:57:41 +0000
Date: Mon, 22 Sep 2025 09:57:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Sahil Chandna <chandna.linuxkernel@gmail.com>
Subject: Re: [PATCH] block: fix EOD return for device with nr_sectors == 0
Message-ID: <aNGABRlhT6KHk5-C@infradead.org>
References: <855243b5-1226-47d5-9ca8-c023209f5ee7@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855243b5-1226-47d5-9ca8-c023209f5ee7@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 22, 2025 at 05:58:41AM -0600, Jens Axboe wrote:
> A recent commit skipped dumping the usual "attempt to access beyond end
> of device" message if the device size is 0 sectors, as that's a common
> pattern for devices that have been hot removed. But while it stopped
> that message, it also prevented returning -EIO for that condition.
> Reinstate the -EIO return, while retaining the quiet operation for
> triggering EOD for a device with 0 sectors.

Ooops.  The fix looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

