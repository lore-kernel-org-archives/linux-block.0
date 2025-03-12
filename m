Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F024E4B1
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794561; cv=none; b=AMCG4UXCpgADwSm3it15D9uYzIU/UWvAAKNeohMgwZ8N1lYzs3OLVwhgd99Fa/OqJjZVODzwnhKRmf2g9r5wXJ/T4232FnYjpj+gAfHXCsc4s9Eh4G+6Xv1ucYb8uB/sX3V3IBbYeY9YN8VqUx+H33+oqidJFIcze41xPGEGO1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794561; c=relaxed/simple;
	bh=+cWntcQGDdLod9UlfcFgPmq4SFd2ivxoCGZ8ykeS0Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MF+RSbp3eHmc/6//5K6QdhlbZbIDzlmraDPYiGPwNORgStkp7aRynOx8FrKja5z7Z1Vu30w35XF37ZUj0SQml8STZSe1EY9p6LonHmZ9J/QIw870bDCAphLgEZPHT3GrJN9NoRa74bqrKC3kVO5axlVjmAK62bzBelwK2Sp9TdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tXKyVV/n; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tXKyVV/n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y31dMfui2EjHLJ3ZByMDwupJBzCgqnpcVJIzftRq0jY=; b=tXKyVV/nlOzdUdaIUuqAAm2fOR
	UPJLYKRPalh4/SCQugyxMEO/NLYt693MIVjBTYTHnfFg9LyKvvVN0+R6b/BaEJ26i4GVk8cVZswNV
	eqiDP592UmO8QGF7KU52RxRrkGqmJgmguu+v3C3J3Mabp2D+wr9AbhFD2CV2rZO6Xez1wc/I3k2fr
	wNvgAaXBHFtp0UL+rDqcSrAOebxvI+f27qDf6zQyUFUk7ihCuCSETGlNeyPYzjB3uSzB4A/JUXidN
	JhJuCiUHcoKd3VDFx/j2qeb/MZhkJM0WMvbXMy73EZW6iOAMbXyBR1uJu34bpz/+iwjwRBZbqFXQj
	lnzl+1kw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsOKZ-0000000D0Nx-46NK;
	Wed, 12 Mar 2025 15:49:15 +0000
Date: Wed, 12 Mar 2025 15:49:15 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kundan Kumar <kundan.kumar@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH V2] block: fix adding folio to bio
Message-ID: <Z9Gs-wIhjSmBBIXx@casper.infradead.org>
References: <20250312145136.2891229-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312145136.2891229-1-ming.lei@redhat.com>

On Wed, Mar 12, 2025 at 10:51:36PM +0800, Ming Lei wrote:
> >4GB folio is possible on some ARCHs, such as aarch64, 16GB hugepage
> is supported, then 'offset' of folio can't be held in 'unsigned int',
> cause warning in bio_add_folio_nofail() and IO failure.
> 
> Fix it by adjusting 'page' & trimming 'offset' so that `->bi_offset` won't
> be overflow, and folio can be added to bio successfully.
> 
> Fixes: ed9832bc08db ("block: introduce folio awareness and add a bigger size from folio")
> Cc: Kundan Kumar <kundan.kumar@samsung.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
