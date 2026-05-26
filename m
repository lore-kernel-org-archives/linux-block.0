Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C117915A864;
	Tue, 26 May 2026 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779776858; cv=none; b=lszUBftIx8nrCn0gnQaaBmsJabstnyFDNklbpcrPf1X7oYOJynSpmgKk2vSirZT0xPvMmOBbq/mw0JHhYxm1ZSgp2K80KafEwoWWGdfYNOsoCLGGs/z76g7ilFabxyv+GPedxKWtEkQkycvhW4W8Bb9sx01O8GW8SlsQA+uuZMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779776858; c=relaxed/simple;
	bh=GnFCOdVdpVpwTPk3TO4NHThm3cGeO/Bh1MOVHph9ljM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGLSOabej92zf2CQeUupjHMeQOUPh5M3o0fJfVRAzf6NGLA/OIrnydnDTgK+uI60j3hERWWygGkCgdVKr6a6OBmblkklmc43LIlY8xwHobRWVeKxCI5EWMp6SvWC1ETtL7v+0wWpGr1I4gy4kmd585kbfPbtAYQe7YvZFZGUNHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NaA+mXD9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NaA+mXD9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AtttO4w0Ny6Z+XbNsM5i4+9hfhHRdRMxhnyuFgaQ2TA=; b=NaA+mXD9nHpYj0k802Ap/0C/t7
	XOGO2ve1EkLOdt9Pog0eglVcIxyTXNa6c5s0lqcxiZ9rfZ8Ncppi0cpNLcsUGKjXgahfpEjpi3Bb/
	vQdVdC0sfuhVgToeBHEtAqvl9wjKY5s9N+B7+MRNxY1L6xSu2V/2s/agmIDvuE8S9NX4/aGWzMv8y
	xnZTz04iDpbnTDsAc5U5zxPLrTuhqj3yYmwcaXCOoqHiVWo4CaOBIlFDvyaajGentI6AhTYsjS6pS
	tyWFk5knvZGDd6o8Rvobepdce6PQPDTVEo5TggbAr5+bh4ihSiWowBwJw/161lfDm6cgZiS0UO392
	JKhWlbsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRlGH-00000001AFD-0INz;
	Tue, 26 May 2026 06:27:33 +0000
Date: Mon, 25 May 2026 23:27:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] block: partitions: replace __get_free_page() with
 kmalloc()
Message-ID: <ahU9VQAxZE_jXi28@infradead.org>
References: <20260520-block-v1-1-6463dc2cf042@kernel.org>
 <ahPnX-CwVgK-9chp@infradead.org>
 <ahPxmSqT4Y4jcAbQ@kernel.org>
 <ahP3R2nH8-bHMVf0@infradead.org>
 <ahQX_JCgS9JWIhY-@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahQX_JCgS9JWIhY-@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, May 25, 2026 at 12:35:56PM +0300, Mike Rapoport wrote:
> > This does, but it still fails to explain why kmalloc performs just as
> > well as __get_free_page(s) these days.
> 
> I don't think that in this case - a single allocation on the cold path -
> the performance difference is even measurable.

Well, please state that.

> Nevertheless allocations from slab caches are way faster than
> __get_free_page() (i.e.  alloc_pages()) as it's essentially lockless
> cmpxchg. Allocations that need to refill the cache do alloc_pages() with a
> little of slab bookkeeping overhead.

Please state that too.

