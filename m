Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3387E339365;
	Mon, 10 Aug 2026 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377614; cv=none; b=dyXXyZ5l/yI200oA2c/qaKpZgRekQp/5LceAPcln65O9Er8lyo5EXgObu34b8Nf+k1J39rEp7FqkFlPIiHuwZcy17zOe5ZlFCT2C8T5cc4Xjxc9I20lTIzYPCUajW5CqtdVt+gAR4m7fq7+p8tiUGjetu1+YD7+fOk92OxyKHiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377614; c=relaxed/simple;
	bh=/g0yLnciYPu4uQFtlKMlHL32ZKKryw6X8Rapw23u+9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPw3iKMn+B/rZ9Ib3iFJ9IokELhXdX0RbC+YQbXQ/zyAaGIFc3rWsjyhcxHi0QzE3dRr/L42iQk2P0Rwq4BwLjADz+xNyyXCs9M9DwJleGOPR3KtxNXEMByp+A0Al8gEWEjnHMClwbyyH6ssYF46K9EDsAeRD+f3wa8FykKeOKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pSFqQ1IK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pSFqQ1IK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fM1TmwL+V6afntTWcbDSTRYQvzGnvPI5cULUs8c5LhA=; b=pSFqQ1IKQaxnP5/zrtrDlgaL1e
	yB42zQ70EPHn0xvIxANDJF0HL6Fo29/IHA+ehHzvFAflZDSpVaXw5tlLZc+Z4I2KDnaXNygIbZdg8
	YxQPls9GmlbnMcE+/DSJLIdj5I3X+QpMzbCXEU2le7e/lylqahd5QagvZOFArxXDhBHKwpX1r0dne
	q5gLD+gVrfFiJWdFVSYsr6HYoM3JcqtKlNd69o8rhrErGiZhnKAT1sqcVOlYr68+fegUzHXNsGoFS
	6andjJc4az9aRVoQpoh51/AY6y3pkUOgO3lL7N89+Lsy90qrvWMeoZtFsHA5VNvndKl0a2dH4EPER
	rM2szIGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtSQ7-0000000CKMy-3kRJ;
	Mon, 10 Aug 2026 16:00:11 +0000
Date: Mon, 10 Aug 2026 09:00:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH 2/3] mm: support fallible mempool_alloc_bulk()
Message-ID: <ann1i5VjTmgChjs7@infradead.org>
References: <20260806221031.79050-1-ebiggers@kernel.org>
 <20260806221031.79050-3-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806221031.79050-3-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Aug 06, 2026 at 03:10:30PM -0700, Eric Biggers wrote:
> To fix a deadlock, blk-crypto-fallback needs to be able to make fallible
> mempool_alloc_bulk() allocations.

It doesn't.  fallible mempool allocations are a concept that doesn't
make much sense.  Please just go straight to the backing page allocator
instead for callers that do not need the mempool guarantees.

