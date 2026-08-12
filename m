Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D59441600;
	Wed, 12 Aug 2026 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541789; cv=none; b=bBoOV/44/VvbyJMsSULxGMB5LV+EZtkFPt0dTn7vUW/N2U+o0snKxwikrRduay0SjvkNmdCDswgUjeSJI2C+cRwE5ubikYBOGlYkxpZLWdkoadl2NaMCZhhmmR8lsAZ3sCaUaA/CQP0I6OdcpUZ/sgKQtO5f6jbqBQ+GG2FPYyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541789; c=relaxed/simple;
	bh=/Qobh448Dv5tTHA1k2VWfJU+RM9M7P3peEswJXnOarc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qg9sax5SSppVj5/OBPs5OfASjpk2HqC/UYkDnKigdTi/PrIMYrgS/HLXzkPNgRY8ZoeEOw7V2WiwHQ3VwK2KxYcgd0DAEyYpvAyYKRubuXewjhqVAS1WZYMlucYdr854tjtwBHfEUjbOMOtlOA3Li8ICBmcw0N5oMwUSqeajQ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gg2fF8Zo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gg2fF8Zo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YnJETK1+o9oP+uK3aPBFgY1q4H/u1vtWfML0eAyTy4s=; b=gg2fF8ZoPDj3hwc3z+I8OA+N+D
	bHqO7CfLgwyPS34s4r6tGLLAH+LSmHxt+LSoJA2WlKdGB2BGYUq81oq6Dt+957rFdQVx3XZRCyDmi
	NRNhL8F7QwKfSSlrmApJpmhIjewcRvjhkrFC+sq1ldbUAXdEVm91z/xWqsY+8nNQQq50y91DiR9MF
	kwgeU2oNfnIRCXeaaJ1gqfX+ngxJlxsMPsIMvmJPo7S9dBShUDAXb3ZbSc+aWuts9+araTqXoJDUi
	j/vqL8br2ywOb80pO7g2pUPe+XHyWkAjMqSXhmas72pDSWyZNFzvLygvdKcJafscXtEMhdRmxKGVL
	UoSlY2OA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu97x-0000000GIoc-3Z5t;
	Wed, 12 Aug 2026 13:36:17 +0000
Date: Wed, 12 Aug 2026 06:36:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 2/3] mm: support fallible mempool_alloc_bulk()
Message-ID: <anx20bxfhD05jeuM@infradead.org>
References: <20260806221031.79050-1-ebiggers@kernel.org>
 <20260806221031.79050-3-ebiggers@kernel.org>
 <ann1i5VjTmgChjs7@infradead.org>
 <20260810161404.GA1930@sol>
 <anoIiy0V-m-05yZc@infradead.org>
 <20260810182215.GA270444@google.com>
 <anuCcb-Cma6JOAb0@infradead.org>
 <20260811210338.GB1905@sol>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811210338.GB1905@sol>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 11, 2026 at 02:03:38PM -0700, Eric Biggers wrote:
> On Tue, Aug 11, 2026 at 01:13:37PM -0700, Christoph Hellwig wrote:
> > What is actually efficient is do skip the mempool entirely from the
> > original submission context and do a non-mempool GFP_NOIO allocation,
> > and only in the extremely unlikely case that this fails fall back to
> > the rescruer thread.
> 
> It definitely is *not* more efficient to fall back to a kworker for a
> small task (removing elements from a mempool that has them available)
> that could just be done synchronously.

That is not the point.  The point is that mempool_alloc_bulk frequently
fails to allocate all pages, and just filling that with a plain
alloc_pages is way faster than calling into the mempool code in any
form.  The case where we actually need the mempool entries is extremely
rare.

