Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007AB223DEB;
	Thu, 24 Apr 2025 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494166; cv=none; b=i1+/GdvgP11ExVi+qT1qi/LefC9kutVfhK9pG9U54BpsEcFpCIcI0iyCY3Cq3bZxQHAEABEeM5J+CHjxyp5lbog2ekUjWsTv77CRdFTC/SsUh5GxZI74QZYROsnz0s2aCJ46ROEDV+s+84L8w3SY5Gti5kQtU0P+/+hob+Mp0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494166; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYhcZjVWUgosGkygymDvFU10br+8zG34X0Qm/7RgdU3mOdlZKGaQRK85cOlkSqTtGRK+UZ+eWhtk9ioyKmzLPFKkgiERbj7V0mobm/b0K44/5x0SWgZ9qNbE/0O6l+NURoUfP/+J2hlwQzo84lAumnmP7fp9w9tfhUIM4Abyxxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bvw0QMA3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bvw0QMA3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Bvw0QMA3zYr8UGPCFhSiLX51ef
	YtQqfg0nD6GfWItL7IL7VG19CHlK5Xr3bvlg3hOi4G1Ie2lDMpAkgbxULLrvVrAD7uu3n86lsGywi
	qqC/an/i531T35SbTz1nlt6/g8oK1WdN7GXcXyrrKOxUqS2hBZGPwghcX+deIItlQJ8PTGX+kHngC
	mv/bYm62cjnaRnP8uJduKXEdMNwwHJ44excM0nimzvglqpDGlerJh7qm1Dqd3ylMiHxbpZlVjUWFu
	rUjMeGoEan65ix9Sc80EXPS2m9yQbtltfPBjKtYP/9OlyyLZEADPtGNQD2fK/UrmZRSjkDpQx8pRX
	7xn2jMCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ulf-0000000DrIm-25TQ;
	Thu, 24 Apr 2025 11:29:23 +0000
Date: Thu, 24 Apr 2025 04:29:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] block: take rq_list instead of plug in dispatch
 functions
Message-ID: <aAogk9ky94KKt3w4@infradead.org>
References: <20250423205127.2976981-1-csander@purestorage.com>
 <20250423205127.2976981-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423205127.2976981-2-csander@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

