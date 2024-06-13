Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6FB2119;
	Thu, 13 Jun 2024 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718266078; cv=none; b=D8oZ1wKR16X42Jf/lQDRD2vGwFAqNDKmiz1V8FMkLZIc+uCn6IhhWs+Kx43TRazkGL9DZeQLSVgxH3KfCQHsNudlYZUN3RlXAu+5wlqaruuRUk7NwjFDg0uLwesSboZPUW3l94Pmwo9jVZUA4zI2DwhtdQcIIIfY9JefcGGCjRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718266078; c=relaxed/simple;
	bh=SmsNy15uyD/TzUDtWIhCgHtRNEFA5w6AYmsB1+aVIdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFWwXKj3DX+FYjCF6FVZenyS6kNacoX1mMmT9/6+1ccbpVu7OR3an0KVX1RwNi6AAZ7PLXHExd2s4MJGHOCk9lHPzZ+TcKtv9O+9YfDfvAO2S7MgGaHL/gRT9fFiB3yRtl6DPYGmID6Pz+WiFW+2U3pkjBkgDMEFfj3VKYKp9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FaHvTBms; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FaHvTBms"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r5xQob93awwH8AHPQnk1aPKPoTke8Y/tJve0giiYzgk=; b=FaHvTBmsMRohvGi7Ehm7hs98ym
	6We1O6sdIiZomj19tkfeIxL21W8cxoP0TnTFn5V/uwBnVnBlsZCoG/k+ZiIf9uy2I7vXydklQct5g
	rcJwTEi/too8DQF84dLKmRd4u6Ni+eEFi2Cr7oNd5qV3yDMK9qOcX+5pfthzOISLd19strlI71wDr
	cDcuFZEN4ZN/SxTU+HlN9rh7HZBFz7rrltyF+key+ylHEPp9kAXldXk84HtMw8hQ1VE0mOCal6TZc
	kg5aK3UhAiW6HWq7fejp8cPKM+PlXPtIzgxSOqySk05Tr9wV8fWCBGkhWLZatKGK21QWRcQ/ANqSc
	MddvaFuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHfUw-0000000Fce0-1PzS;
	Thu, 13 Jun 2024 08:07:54 +0000
Date: Thu, 13 Jun 2024 01:07:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, hexue <xue01.he@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Avoid polling configuration errors
Message-ID: <Zmqo2iAHlAwANA40@infradead.org>
References: <CGME20240531091021epcas5p48fdbd6302bec7a91ff66272c600b0dab@epcas5p4.samsung.com>
 <20240531091015.2636025-1-xue01.he@samsung.com>
 <ZlrQCaR6xEaghWdQ@infradead.org>
 <f092f5b5-68c8-4e76-9ea1-f319bcf20444@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f092f5b5-68c8-4e76-9ea1-f319bcf20444@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 12, 2024 at 02:53:27PM -0600, Jens Axboe wrote:
> > So we need to ensure REQ_POLLED doesn't even get set for any
> > other I/O.
> 
> We happily allow polled IO for async polled IO, even if the destination
> queue isn't polled (or it doesn't exist). This is different than the old
> sync polled support.

Yes, and for that to work we can't start returning -EOPNOTSUPP as in
this patch, as BLK_QC_T_NONE an be cleared for all kinds of reasons.

So if we want some kind of error handling that people don't even
bother to poll for devices where it is not supported we need that
check much earlier (probably in io_uring).

