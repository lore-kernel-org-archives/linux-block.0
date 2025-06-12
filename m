Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85010223714
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749729381; cv=none; b=NPUqP9GxCU00cPW1PoUWXBEkWiRB3VR4fDvRgkszrhH50uZKupmrtvRdiK6PsSGdX1TxpFZAtDGvwRiCZgaVy2IXpOAWbLh1hPCY+TFHqbr4Uhy2fAv0pgbjxH9D2kaNV5LtKVe6skveoZrisfob6Jf8VZV4HhsheOuSNw9hiAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749729381; c=relaxed/simple;
	bh=Shx1H3NdIX0TrKgcF20Klc45+a3qDcf6R2gMUFB0YZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jc/oRMAUr+6x6vL+mOkAQZom9hlz8V40upZK0xzM6d8hIvVXBXyU0pxV0qi+tT9u3G9GVVLNzGE3xxF7NCajAC+0GBLpG6ZwxZByMOq1OIWKa0B1vE9KwsebaBV/7vv8+GwWmZOEOYCLaJJs4NvcP+oc9G6C3WkBWr9Afl3fesE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0MJbo4EU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0MJbo4EU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=gaTW6gUOfIZbZ3K8pT4B7LjJxmq4pq6+GLmaQhox4hU=; b=0MJbo4EUZxF75RmJvea16VXfM8
	qxhvheEyfdQxlJJWg+66mgthLsvY4tYerz5ObKU3UsIVHFoaXITYE7WB+NnRWcLHGXcv/rnip5jcv
	fV9c9HdnqsayzQ0dF3xxQlH/UdL9zsxsP7vLZjmnt/saVbhcheThtoZXSKHwDMLA5MBaCGBwg0tkg
	IrrE9czE3rVYns62saQra7iNMvVUkUOVq4rG+XVbqItMF8y5ZnECIKRWAXP2R3YrF5GZLVCoND0Y5
	NS7FG8iktxydd6qRcbu1YMZylZp5jKE1E5X2gp9C2DTpx4kJ5M0uwEe5M0pcFmDm4OMkrcIXCOVzD
	9xZOAy4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPgXZ-0000000DCOw-1rt0;
	Thu, 12 Jun 2025 11:56:17 +0000
Date: Thu, 12 Jun 2025 04:56:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: use plug request list tail for one-shot backmerge
 attempt
Message-ID: <aErAYSg6f10p_WJK@infradead.org>
References: <4856d1fc-543d-4622-9872-6ca66e8e7352@kernel.dk>
 <82020a7f-adbc-4b3e-8edd-99aba5172510@amazon.com>
 <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
 <aEpkIxvuTWgY5BnO@infradead.org>
 <045d300e-9b52-4ead-8664-2cea6354f5bf@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <045d300e-9b52-4ead-8664-2cea6354f5bf@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jun 12, 2025 at 05:49:16AM -0600, Jens Axboe wrote:
> > Maybe byte the bullet and just make the request lists doubly linked?
> > Unlike the bio memory usage for request should not be quite as
> > critical.  Right now in my config the las cacheline in struct request
> > only has a single 8 byte field anyway, so in practive we won't even
> > bloat it.
> 
> The space isn't a concern, as you found as well. It's the fact that
> doubly linked lists suck in terms of needing to touch both prev
> and next for removal.

But is that actually a concern here?  If you look at my patch we can
now use the list_cut helper for the queue_rqs submission sorting,
and for the actual submission we walk each request anyway (and might
get along without removal entirely if we dare to leave the dangling
pointers around).  The multi-queue dispatch could probably use the
cut as well.  For the cached rqs and completion  we could stіck to the
singly linked list as they don't really mix up with the submission
IFF that shows up as an issue there.

