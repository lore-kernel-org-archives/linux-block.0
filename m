Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0D363089
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068861; cv=none; b=ZwMrcFCsopd3lmpIVCXApHFnoE0WsVH94ycUo1dnFEzFBuALtHKQrRDWZ9spN7SNKS8C3gfmake8e/axhIRVtaLGuoPIT805xCV1J9w6lOEC4JPpkeodtDsm1T2QGiDOE77t4lGHz3ZFwIoZEJRFTEcxF3Cm7eDQtMwoTyOo7Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068861; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuLbXhpisuvoElODN6UzZVjHy1ajCf1PVZxfeqD6dpxzJ7yIh1ByKDevnU/D9fE7ToMPPiYGqY0oI2eZguEEDYepNQ2PuBvqCS1OjQdTrsnHvvIoJUJTgdB6eVbqfiCvwHagaWYld106wtMGLb8lpdXGf+TJqNhBp2UUal6iUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1SQqsbVH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1SQqsbVH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=1SQqsbVHNPRgCI/3KyNMkCDTCN
	qt21EsmilGEjt0784Cd5RQsZMKk1uun4xBQ8wcTsdTuiN7Kia8zdl42L1XQIZSmKUBLEmnHO3t38x
	jQXvkXMSwDCqEqd7hFQZ83X4SlCtg7TAQeG7421qaX7nFae6IGKvP5BVrQZjZvt9lfusXCZG3hkSm
	o1vCicyTiNgkydyQ3AxSWWQUnXHAZL3UQpg7sipb3lAIRrIO/cdrslWAcGlv6nfEv0zwaMCRgOU11
	wdc+m9cUF9dn6qPr3Bg3ororuA2e/wbBrnc3CqrON9atAjTbuaDMXfjE95OwBiPkwpbu1faHsdTlG
	XSasCrHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBN4-00000006onv-3iO8;
	Wed, 10 Jun 2026 05:20:58 +0000
Date: Tue, 9 Jun 2026 22:20:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 07/27] drbd: Move two declarations
Message-ID: <aij0OtSCAXjIOIRh@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <7e40961a092b149aa2e3b6fc3c510da650ee0401.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e40961a092b149aa2e3b6fc3c510da650ee0401.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

