Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974021E0DE8
	for <linux-block@vger.kernel.org>; Thu, 17 Apr 2025 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744870590; cv=none; b=GVyKV4v3/f+puUzbkEBJKbO5BXrok/6F3YpVmHvCX5RcepuLOwocZxBcLoIydB+2/r0BPEVZzMoySZJVf4cJuw4Y1BrT4Z2m3Xxup7R+nZj3AsgBhJsr+vlSUL9P0jZHj9ICPhULaF/HDOHyPx52iAIkcD0QGxmIyiXhu27bKsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744870590; c=relaxed/simple;
	bh=EzsWLE8JXDm1OgdN2HYyQfDgqQMwD/Rz5+CUzwz5Bkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWmdwfwyAM+L4POwyzar57cgKFblUU9FGGhUafl5wcayqoWnhUkSKbh3Jkr5LFZPOAozUOIFimSK1HefQr6o8NVauLrT1e8UyQEifabl3endoDB16X6S50nxGBcmIlHa+yTTEMFm2yV3HA2PqIMPhOTrZHVjDjxIUD9A/Rm70n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BY6bdjQE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BY6bdjQE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kmCWEcLaTllF9+ezueZFC9ETZzTVe1VMWAvhSWHuDCo=; b=BY6bdjQE66va4vgdyWs4LwaOvh
	mU+BO55J+frd8mGVAHCa9hnbR3Uqh3F7RCkzBuC0mp111/KVOOKD9S+BPW06g6UDUDtjpTaBCJaSf
	e/LxX2fG7CQcPgKtpErMtr43JN9e3it52Um484pVqI6LwXtNKDoCGCFTxLvxjqogrhDqGTrJctqAX
	hJq7HK9f57el/mnT/xW/ifiwDT828T+cskhbNmxIvr7tP5GaAXnlwE0FfKFW51iv/FhltjGk9aGL7
	wNoXIUtOzuxsKCdOYq51TIg3LWll9kfXEjlJy5wzjNP2jCdSUDp3nRs7WW6qGrpkFKq3SFe0JB+dO
	NnPuYSag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5IXw-0000000BsXI-2xba;
	Thu, 17 Apr 2025 06:16:24 +0000
Date: Wed, 16 Apr 2025 23:16:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH] block: integrity: Do not call set_page_dirty_lock()
Message-ID: <aACcuGpErEsBcxop@infradead.org>
References: <yq1v7r3ev9g.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1v7r3ev9g.fsf@ca-mkp.ca.oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 16, 2025 at 04:04:10PM -0400, Martin K. Petersen wrote:
> 
> Placing multiple protection information buffers inside the same page
> can lead to oopses because set_page_dirty_lock() can't be called from
> interrupt context.
> 
> Since a protection information buffer is not backed by a file there is
> no point in setting its page dirty, there is nothing to synchronize.
> Drop the call to set_page_dirty_lock() and remove the last argument to
> bio_integrity_unpin_bvec().

Who sais it it not backed by a file?  Which that would be a very unusual
use case, there is nothing limiting us from using integity or metadata
from a file mapping.  Instead we'll need to do the same thing for the
data path and defer the unmapping to a user context when needed.

(Assuming we can get rid of this entirely, about which we have another
discussion I don't have time to follow up on as I'm on vacation)

