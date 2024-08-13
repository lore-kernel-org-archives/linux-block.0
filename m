Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968183BBF1
	for <linux-block@vger.kernel.org>; Tue, 13 Aug 2024 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723531857; cv=none; b=cXR9bArpLMpd1LxqL2zteZBJqqCPDr9AXv2U+jxyfpMREcJ7qbZkMV0fj5Y/6ybiNZXiGce/mjMfT20Ay/iMZZcxUQuBNV6UaZt8MIzkKoxJlNmLVjxivOapWK5HVUGiJh0EwHcWND7GGI30Bu7wd3/yMzGWXPu3PYV1W+/J4Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723531857; c=relaxed/simple;
	bh=fAt26EdeYJET4eRC5sk9OCkwBTW9PKp6/fi9l/rg0NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfKFrtNaju+Mjz8fWbRsuLerpN0mSWThc/9j6NCcUsFMNTY7WBnxNt5sIh9gA5URj/7xCCvJTZidBvWxIfLl1+AbtzJE3Q10SCcCnMS7YtzOCZ0/tkIQpxBKDRCKIq3gkfZgE8AgrL0f8ZzxW+80miYQEH/uqAONTlLkY/X7DNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y9dlbudK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y9dlbudK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fAt26EdeYJET4eRC5sk9OCkwBTW9PKp6/fi9l/rg0NI=; b=y9dlbudKiVU4spJCPbIDl8K7YI
	ipy7p+0xd2F8NeUfVCNDVSbnp4+kZHGCb7LlR8jXwSfoeSue0hTYUC43YLNWpG5V03+gZaH5Mu63L
	HGyyhdBH5Dj8JzAxm8JJfYEWICxzy3jwpq3UM5XzDM81A6Dr2l2HdnLjbNINjqvbuonPm/+7wlyYM
	ih3HWnglby12k96UVHSEELXGXZyUOKiTtaL6ZmPiypYU9MxSDvc2YLL5pxYxSX8uZpiMKqAKhqm8j
	KBnUutZQ1SUTE61zZELH0Dq7sgPsM5knnZSW4FlTy8DBM/m/Gb37xijYJWoWb1UZ+PW4SeVEgs1Oo
	udPPJsVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdlMu-00000002cQW-08ib;
	Tue, 13 Aug 2024 06:50:56 +0000
Date: Mon, 12 Aug 2024 23:50:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: constify ext_pi_ref_escape()
Message-ID: <ZrsCULttlA3CEgPk@infradead.org>
References: <d24611b3-dddf-473a-903d-39290db03b11@p183>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d24611b3-dddf-473a-903d-39290db03b11@p183>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

If that helps with anything..

Looks fine either way:

Reviewed-by: Christoph Hellwig <hch@lst.de>
