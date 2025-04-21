Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278A33C9;
	Mon, 21 Apr 2025 05:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745212943; cv=none; b=HyUwWxZZK4GeeTJannRDUQgbGG8qJCsilAnzwIj92J/Ml+kNzUDDrNRmxkJ5vK5pm1ZaFhMfvGFkb9xrq84rtF0PTPaQ0F+srV+S/RA7orgfquJaZOdXVGKd0ilNpB1vtE2mY2BgwvDe4QIxjUYUMVymZO+ct4gG/7/p+M2S4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745212943; c=relaxed/simple;
	bh=ZVtOQchghGZq5VmSi43RoucRP2rjqrsgRypim9+1bXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeaopQqNX+ojQHJnlKHT9vFJCFyRbAs+ed+k8te/jYmouU/wgUagrIlCdMi6eR+0RrOYXEXzI7ZA8WrM7WKGYMO8U5nEhWoJqnoWfVt4QHMJoIP4LIDiCmFCzbuHIgkWtkRPgnOTypopgpBYDYM1yv1vML8XZqLtm2UU+ejjVi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EmKJF2iD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EmKJF2iD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wGkULmpRKZDVVdqW1J8/CXFjx8kLFAWVmCHb5kS6f1Y=; b=EmKJF2iDRbX6j7AaOPML1Y75cA
	Uydy7+5ExyrNvto99WZK3i7ZkBvdGtSYM34o2NO+MJ3dgBjibo17FKXhIEMrWPpAjEV714LdInf4S
	NfC+BVRlLwP/82+86X6d6gSLzdbXISqA0lhRRzymTCkaPSxFvl0holRNrTYv/O7JBFfaDzjhQQ6K4
	Tm2Vlw8LFSc52tVMd6zv+LNtThgVp7AMuQXwJZJTkKKCvuf+GivLE6yw+dsBZBUcoT09qlcpH4dDO
	kOvusQWrnHXdQ/Di3OKdUxnG5mlCVhWHxObfvz3maYgqGfdMk3qum7UfFIbMfTw4urSSPyhiOdy47
	Mijk4u+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6jbg-00000003cku-2SLD;
	Mon, 21 Apr 2025 05:22:12 +0000
Date: Sun, 20 Apr 2025 22:22:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 1/5] brd: fix oops if write concurrent with discard
Message-ID: <aAXWBEQ93Y1zteOA@infradead.org>
References: <20250418093826.3149293-1-yukuai1@huaweicloud.com>
 <20250418093826.3149293-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418093826.3149293-2-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 18, 2025 at 05:38:22PM +0800, Yu Kuai wrote:
>  	copy = min_t(size_t, n, PAGE_SIZE - offset);
>  	page = brd_lookup_page(brd, sector);
> -	BUG_ON(!page);
> -
> -	dst = kmap_atomic(page);
> -	memcpy(dst + offset, src, copy);
> -	kunmap_atomic(dst);
> +	if (page) {
> +		dst = kmap_local_page(page);
> +		memcpy(dst + offset, src, copy);
> +		kunmap_local(dst);
> +	}

I don't see how this can fix any race, it just narrows down the
race window.  To fix the race for real, copy_to_brd_setup needs
to return a page and keep a reference to it for the caller.  The
caller then only needs to operate on a single page.

We'll also need to do something similar for brd_lookup_page to
ensure the page reference doesn't go away after the xarray lookup
but before using the page.

> Also fix following checkpatch warnings:
> WARNING: Deprecated use of 'kmap_atomic', prefer 'kmap_local_page' instead
> WARNING: Deprecated use of 'kunmap_atomic', prefer 'kunmap_local' instead

This really should be using bvec_kmap_local.  I actually have an
entire series to fix that and clean up some of the surroundings that I
need to send out.  Let me dust that off because it might help with the
above mentioned fixes as well.
