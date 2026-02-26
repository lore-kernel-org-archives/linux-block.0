Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B755B368967
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122338; cv=none; b=VqlfwVrdCdBxGzURRjvHfRJJK5VTc4fqmMFODwhNu2RdFaZV86HDdaoCTn1MsREOE0Ydw43JvZ2EMd2AdNq1BIhepP7RZiqgA8BVJa5+YBkTbRW8HWCdf6Xv7T+XxCULy5/jc5XEBP+u+BChuvR7eTWLpm6HTf9yn3nFGl2L68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122338; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUuDq7Vh6qPSth+qu4TxxF9yMlgRCs25bUjAd0AFH5nuVeEVsw7XxfRS8UhDFzYpUbCI3pXoQcAi7ypQrSNl4Tv8A1Gual2yI/QYf73TFw1T9+hljuRG9Eg3z0QrNGjm+muvR2n517psfqsOqgkRdiTp9My+ywoIS7fhaCWW8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Li0bcMP0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Li0bcMP0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Li0bcMP0IaTYmeSc2OshW0J3Cs
	eW/llsOVBsRQ/4W1xzWy+eIisRh95gcqoJtFF0xSVh8xBkY/4pXunLLIOdO3INop+AS95ZIHDbdys
	X1RO1XV2+cn+yKZUOr9vlunyX6xmOZhfXU886jyLBpZ9Ne/fLGn+tZvsuXO4/vBg+GdAh2znSCdYq
	ephUxcBqZv9OiYbdapZ06sR0FEluvaAc0UY6bxjQWSPTbPEKmvGnHWZD8As9bRwasAcGhL8xv6EVo
	i8dq2uOVCArNJVEVX2xTcJz556ujEJI56BH+8SubZjDkMapSi+EdGLvQl9I/X7ag9qJyi/6mkccwP
	RI79YOTQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdyH-00000006hXc-45z6;
	Thu, 26 Feb 2026 16:12:13 +0000
Date: Thu, 26 Feb 2026 08:12:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 4/7] block: rename struct gendisk zone_wplugs_lock
 field
Message-ID: <aaBw3RaVVop1s1Lz@infradead.org>
References: <20260226041024.2154806-1-dlemoal@kernel.org>
 <20260226041024.2154806-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226041024.2154806-5-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

