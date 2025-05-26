Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9411D5141
	for <linux-block@vger.kernel.org>; Mon, 26 May 2025 05:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748236964; cv=none; b=gjNF/ZiIclKyHzwmD2L7pWYODgqNyRdrpXPhNe/J1koemtOGFIZryAGdDvKw9jBngX0W2IAvsXRo08M6o1kPYxLZmh2TEASdpKcxnP/H79PM4vM+IupFgth3hvh293obk4XwaoXQpike7c1Z6SgxPRB+HcM+aMDX+jCsai1ZB8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748236964; c=relaxed/simple;
	bh=AKEHyf8/5NQ3RJZ1/EkuLZRMUj3UbtBraPc9Auhp3XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+D7iuEmZxDie+k6Pca6oOoAqtoQ37aGrgXZqJlUmnu8IHssbnNBPpWR3V9SKMtQXL1xOUnTjzvT9s+lX0GT0WO3z/1aJm9gGN060gEPDI/mqpC5AX4/+DUtb4qit69WU4x6ArWYgLhHrF9JG+mYQ35PpwfkEeycF4suhRMHjc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R1+u6atG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R1+u6atG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PQheV16VevNN/q0/UOqEHhyv6Hi0ZcDs9WhRLgTvdq0=; b=R1+u6atGJbL+mAKll48khm9HjA
	bKYz/OQVo+gFejcAxooqrFBnn9nx4cRArQ7FAElenc0ybB//JiynEF8lYI9YfZNKfvP9Z7qdty2hC
	YK55fSVW4H+tzsr2XmvaHX/pEEEJ+8+148W5q/JDb2+97R5zcC4DZVoGoxScUNhOxYJvp3TChAmpC
	e2CCgMP7aC+TcxnJReRkGX/JRv05da0iu8M3i6pv5/95mm9uBfQaOHvxu/nooPX639m0FghI7aTKy
	2oHbCGNWvarmsR5dVNBrOFoLdhmEMXcy6AHd00cfhFFEqdBgeH2SlSCooZ7s5IqJJkNPjRmjlSJ0N
	06K5kgkw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJQIL-0000000866Z-3b6d;
	Mon, 26 May 2025 05:22:41 +0000
Date: Sun, 25 May 2025 22:22:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] block: add support for copy offload
Message-ID: <aDP6ocJef8JBfFBc@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-3-kbusch@meta.com>
 <aDBuQbsBRVjOc5wU@infradead.org>
 <aDB3lSQRLxjDHTSE@kbusch-mbp>
 <aDB6Hdp9ZQ1gX5gr@infradead.org>
 <aDB8xmc3Up0STRVO@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDB8xmc3Up0STRVO@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 23, 2025 at 07:48:54AM -0600, Keith Busch wrote:
> I like that idea.
>  
> >  - bio_add_copy_src not updating bi_size is unexpected and annoying :)
> 
> Ha, I currently have the submitter responsible for bi_size. Your
> suggestion will make this easier to use.

Another thing about bio_add_copy_src:  currently it gets passes a
bio_vec, which doesn't really help it's own implementation much, and
actually makes the callers more cumbersome.  I'd pass the sector and
number of sectors (or maybe byte length to be closer to the other block
x`interfaces?) as separate scalar arguments instead.  For both current
callers of blkdev_copy_range and iterative interface where they build
up the range without having to allocate the bvec array would simply
the code.

