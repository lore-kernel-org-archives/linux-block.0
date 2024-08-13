Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573839FF2
	for <linux-block@vger.kernel.org>; Tue, 13 Aug 2024 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723531834; cv=none; b=EPMV4cvuc6g7lnvFr+FDJ0Vi5iB8YugQhj3p0q8f/8uuV8/XbMXfaGQt/1UbcjpcS+nWQSGS1zi/oP6EjGRvJXX9/w5W3DRLm/AKNpe73az4bF/X/BTvxTC8NpKmRcBMD+k45fvxmN6xTdYP1GD3hnsBaeSC8BUBnyGvcGcC2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723531834; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQLIl91rlhniecx+Sv0trD3SdxkcwRrHgmeGbtaD/xpkbbXuBfyVKZ5Xhe8n7WhLDVkuL/9qsfjJQG3TGCpsBmS/XkE7YqUg5e/8PALsnFaCviDO9Rh3Gs3YcwPhV31Ciy0RLKeKpizsnxD9T2958sv4JPkwv7JP98g2c27GQp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HHNvyt/D; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HHNvyt/D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HHNvyt/DAMLN1kWVuJyU4Y8XKh
	MkFJ5PjyZxqr4fR2jgjrs/sBDoXNYA+gMEIDDRkrtwOU7u8pBhxdBUVbLr78N0Iy4LEgxq2Yv3V2J
	rYh8aJn6zzXDTC8sGIXuNe7dDLKd5Utt2sTNPVFmMOa8AXBHM41HUhbS8ZATYBpQ4Oqd/848qNQPb
	BNgx26zCtwie+/W/mbXHnb5CgoUDtznCjARaTCL2XRPVDk/yOVCOAjV4mfK5dpK6yQMpttPPi+Ylb
	0PQk4pSm+uqEaaq1SB8Q8Mt2a8SJLUGVxuXFEWQRpVlxW3cFcT0e3XxuUe9FhpvxJ8TAmVfSrft7+
	Ipj/E3hQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdlMX-00000002cOm-08T6;
	Tue, 13 Aug 2024 06:50:33 +0000
Date: Mon, 12 Aug 2024 23:50:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: delete module stuff from t10-pi
Message-ID: <ZrsCOR_jrbpES3BB@infradead.org>
References: <216ccc79-5b80-47b2-b507-990951aa810c@p183>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216ccc79-5b80-47b2-b507-990951aa810c@p183>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
