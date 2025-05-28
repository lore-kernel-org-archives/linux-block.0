Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2BE5C96
	for <linux-block@vger.kernel.org>; Wed, 28 May 2025 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748418475; cv=none; b=an29YB36Ls/X6nExBbZ7qY05I18oD/lwAI+Q/z6nxDxlJpEsXPJVAhoHx6cw/ENoLQeatY5o/Gta7gGuwukupBjj3ki2Q3X+83n7QMaekUgW05TdFOTeL9jwG4e0B0qPmcZqpOSsSVMtm8P7O2khY+sJu+2PHUyyp8/iYFBhaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748418475; c=relaxed/simple;
	bh=fJV27tA4KAFzf889JP1Q+CNB1X+5Ej7uB1xANAdFTBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCe+0GC1SolYGgXmbh5Je0gJkjo4sF3sS6SubrCkEL26xi5OLjE19Xo/8DzSfbqYpu/uSu1nk1vZwvJi7XcdeTHfX06cQ49DvZk3vkepgYM5dpUyITV8JDnfPY8H4W/jCRK5mQywI/0KY0ghX+oxuHAxvcaaiujFEwMNZO+pExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IB+2/5nw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IB+2/5nw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1KSnxV8E5tXXWxKDGB7gBUeCXSko2BGWxnALWyX/09c=; b=IB+2/5nwNaU9XVM5xE7KRMsjOc
	ShaUW69yGVN5cu+iV8ll86X32WAyYcI47ttKHvxicTYEmh2ucNd4sDlPjxpPU5WNL7vBWCN42L+4U
	10APzlKXHHRn3fPNHeCyOxxb7kNlqFxKjyVi6EvdTNEqwhY6HA+jqovSv8tLc2yRnRVbgG+JS8rSM
	i4GN9D+PokLrR+3MVxWHIo7fCd3v4+VONRVIfkmTQoN0DaiIBRdYVDb+7xytrW9deLoS9eoogZDu+
	9osdStRJE3xm30N0qv6EGXnAcbQvPPiF+SJn0BiNfEDLdpqYm5DmrzUDzm73cYlsLSCCDzCUGeCVY
	uHGlnU5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKBVx-0000000CTBu-0Fk5;
	Wed, 28 May 2025 07:47:53 +0000
Date: Wed, 28 May 2025 00:47:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] block: add support for copy offload
Message-ID: <aDa_qVKA0uuamxKY@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-3-kbusch@meta.com>
 <aDBuQbsBRVjOc5wU@infradead.org>
 <aDB3lSQRLxjDHTSE@kbusch-mbp>
 <aDB6Hdp9ZQ1gX5gr@infradead.org>
 <aDYvjGcswPkbHlR7@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDYvjGcswPkbHlR7@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 27, 2025 at 03:33:00PM -0600, Keith Busch wrote:
> >  - copy also needs to be handled by the zoned write plugs
> 
> This is about emulating "copy append" behavior for sequential zones? In
> case it gets split, we can't safely dispatch multiple copy operations
> targeting the same destination zone, right?

No, it's just about ensuring there is no multiple copies outatanding
that the HBA could reorder.  i.e.g just serialization.  The only thing
that should be needed is adding REQ_OP_COPY to the switch statement
in blk_zone_plug_bio and make it go into the blk_zone_wplug_handle_write
case.
