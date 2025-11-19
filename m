Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1A143C61
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 05:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763530932; cv=none; b=K0BXf2zheriMopdHNUQRGccsN43bPKEy0yaBiVFsOIORlAwszIvHsVKoaAaCudcbN9O4tkx8bVEbXp86a6TYlKtt/6C9MJTpiuZIeqXwXDE/3TrWJ9wrt169RtOKAFmOC2ksj8+UQC4GVlI5jJScZg5Px2DbC2pZpEAn1pzPnpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763530932; c=relaxed/simple;
	bh=IBEwcHwjKrPfHkJHp6XgQzhfIHpWo1NdUQqjEkFiN60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om9C+4s41pmzP9jw+M9/gafrrUBY6eVJsR0/CBgBKpUN3wAgEFy9uI9Yf+UgV/g0syr9yvHGPu2aUgSYO3ZQp2ARwEDIhdiZArD+ivL2DLN7ds51EfbBR6Kr50QrsZfBABVhu7QHq9A+d/sdhHePcoigEMe/zGK4FG6277ffGY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wYa/WKad; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wYa/WKad"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IBEwcHwjKrPfHkJHp6XgQzhfIHpWo1NdUQqjEkFiN60=; b=wYa/WKadYmVKr2mcdSpxyEbtcv
	nFKbGiTS98Fvt8yg69iLQ+/6NAEF7KeSqg89fQ/jCWRYxTxe3MhT1KA6mXnCTOrxpNI/eUOeMGt9a
	5GCeKiPYLinWZJbi7W+Cx2JwTt7VIP2IZjTFq4Fz07u+J8echqpkSOZl/fFP+Nxc+BjlALg8S1bpL
	+q/T0XgP9gq1w4mx/yP3n2TFjAVwpMPhhN4kwgB1P1GGpxcqeNSnafYr63bTKhFmuAmfho5zlmIJs
	EKi3c6OR3XUS8n+ZLj1pmBxf67i+enTiWwB2yj/9haLhzzuaw/R8zvqA4EgzaOOlrU81c1Ld5MhPy
	wZZdJ5EA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLaxC-00000002Mmk-2BcM;
	Wed, 19 Nov 2025 05:42:06 +0000
Date: Tue, 18 Nov 2025 21:42:06 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: add a maintainer for zoned block device
 support
Message-ID: <aR1YrvGYP6IiD5LP@infradead.org>
References: <20251119030220.1611413-1-dlemoal@kernel.org>
 <20251119030220.1611413-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119030220.1611413-3-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 19, 2025 at 12:02:20PM +0900, Damien Le Moal wrote:
> Add myself as the maintainer of the block layer support for the zoned
> block device code and user API.

Yes, having you automatically on the the Cc list for zoned patches is
a good idea:

Reviewed-by: Christoph Hellwig <hch@lst.de>

