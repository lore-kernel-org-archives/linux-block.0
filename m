Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2343F58D8;
	Wed, 27 May 2026 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887502; cv=none; b=eLLHFa4FD6H/ZqQXwS8U3DcMKuf2y4NqDCN6tWSuWXjgclWhCca1xEzjDr1tiAtPcFEOQSMzy8FZd3VM1rO2imaeZbddKxO84HTIaFgncj7AU3iCCYlUZWdWkyVAYQu+jMy9S//9qLRDfPOKXUSbkqx2cguZC8kRrqCuINgnahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887502; c=relaxed/simple;
	bh=KRjI3j7pSCgQKVD1ucuHwuGBYNbkr7Zx7nJ+oTQ9u2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQDtGwbPi2equAkEVN6ImV/AVMdr12qXSoy56edEdBt9U8LxEm9iZY7e7DYzofDC9ydWDDHaDNjzypj7qO9qRwALywJx9qyQPw2mn5EPoPC8d/U98L+LC3M43hoz7BQHU3tmP9T/si+fyWe16iTI8bJuwlOhiFjBNjvgXdytztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gQsiIwZf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gQsiIwZf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lKdKxKK/XLyDZgjYlRAOMdbXKe9G4yc7L87Z59l45+I=; b=gQsiIwZfpnwpCOlrDJk/DJmUCJ
	tBGAp1b4xqu9IOlVIRm3yQ7Du2CSS/4R6c+dC4dGREdVbyxiNzDsuf+qv3F0J3epwa0L8P25C8IFg
	TpSvsQM2ZQc9Z13KqKstR9Lzj0d8m9MnzqJPQwgcaKLqel7YD+IPalb1CXf7hejnN2oPuBNsYyizc
	GxU4ZC9YSkodOqCX/ktDejbSE2xni0IDFcSwV0sDksJrkpsiSaUvPrS+KFnTOoBlOo5ySzFXz1DHT
	AFDgseiiNiHZYc9LgT0R1RnvRNm9LQAnN1SE2Prh+IwZ6UI8MwiunkGTKeRLxrGruxujoSb3WozvN
	LeMTza8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSE2t-00000004A1i-2QpC;
	Wed, 27 May 2026 13:11:39 +0000
Date: Wed, 27 May 2026 06:11:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Vlastimil Babka <vbabka@suse.com>, Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] block: partitions: replace __get_free_page() with
 kmalloc()
Message-ID: <ahbti6M8zRWR1oGa@infradead.org>
References: <20260520-block-v1-1-6463dc2cf042@kernel.org>
 <ahPnX-CwVgK-9chp@infradead.org>
 <ahPxmSqT4Y4jcAbQ@kernel.org>
 <ahP3R2nH8-bHMVf0@infradead.org>
 <ahQX_JCgS9JWIhY-@kernel.org>
 <1dea9df9-18c2-46f5-bf47-abb3f088574b@suse.com>
 <ahWwD0eqj3cUgaKn@casper.infradead.org>
 <8b780901-8184-4908-8bda-56fac42fe6b3@suse.com>
 <17258981-d5b3-4ed1-9b3d-56a0b6ecb3f9@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17258981-d5b3-4ed1-9b3d-56a0b6ecb3f9@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 27, 2026 at 12:04:29PM +0200, Hannes Reinecke wrote:
> Precisely my reasoning. In most cases, __get_free_page() is just a
> lazy way of saying "I need some memory and the allocation should not fail".

Huh?  __get_free_page and kmalloc can and should fail.

