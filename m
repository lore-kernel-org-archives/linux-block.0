Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EABF327BFC;
	Mon, 10 Aug 2026 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377548; cv=none; b=GXVvIPgbl/XbciYoYoFppGLVZs9EuD6EljNaD2QOlUZPn5vq8yQv1UpiA6BjrN33vnO+B8PvRnBn1YN2MCuQk5Nob4LIyTKCAvqXRoO166W2Of7L4rWAeaAhUtFRcXIv427wgb3yxrC9mQahQ8ZOmkqDl9X3qPYymiuOmzoYeCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377548; c=relaxed/simple;
	bh=Fk75NUD/BmoiB1CyVr2P7UQ2xkUj1UE45Y6IWow9sxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKi3QpW4UK7zmtxdU1B0iavQLpcgLcsjVnjkbR6XOzbGa+gmjdFS5J8X2x3nN3j+wp1IaE6+CYG2e+Dq9dfxkxwN3oEojFHGyJzyHwLjjdVdJsZerrfhWYmXzBFsAUyoMJxj3e4yoVCd3rXW5zdLA4WqfbZYEDx3Nj1GfFXnUdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZJ3qN0ej; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZJ3qN0ej"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Fk75NUD/BmoiB1CyVr2P7UQ2xkUj1UE45Y6IWow9sxo=; b=ZJ3qN0ejtXFSKHlhFx934iM4Mc
	NVQuNBntP9qwBdLgfzWCZ0K1a4LCDWTQVcLlW4GR8N2CQXWq8GB8ONYKMBfAN8+2O+725VzA7YCYE
	QkfoiSrDe5P7CocJOj3zxI7aRR1Wcm/Efb1NCHQlRLn1w7HOpZ3gE5jk75om9tkj1spkhMfWhdGgv
	kgEwBmnPZsYCaLb8nvky3FizzWwqoCfJRJ1PyhERMQBiaICMuT/6KxoM3DkQM0/vbyrYtsD/Erlgs
	vtoIY5EkkMxBzet3M4Bd8/LDDf66I0mQPXwHoAXowOuG1bivYa98kO7QV8MuvvuLIQpjfJV18eE3b
	KkGdZqNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtSP3-0000000CKCT-2eON;
	Mon, 10 Aug 2026 15:59:05 +0000
Date: Mon, 10 Aug 2026 08:59:05 -0700
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
Subject: Re: [PATCH 1/3] mm: make mempool_alloc_from_pool() return bool
Message-ID: <ann1SXYaljourJMP@infradead.org>
References: <20260806221031.79050-1-ebiggers@kernel.org>
 <20260806221031.79050-2-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806221031.79050-2-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good and matches what I recently did on the slab side:

Reviewed-by: Christoph Hellwig <hch@lst.de>

