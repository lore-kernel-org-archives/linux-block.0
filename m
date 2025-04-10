Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D01FA262
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 07:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270127; cv=none; b=oI7ap/1guL8IN7/rIS+zCwTqRHWSqtbJ1zRQyofr5ZNY2oPYjtxtcE/dpkr8S3YFbU1AH8y+N3uW6A98w0GHPJmQJQjQ8XMxmXwJw+UOfbUaeVVbWTlHAl6mNJs1P/vDX94B9GXBPqf5jHDKB9JGl95AE2piA48XoQWTuCmhM6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270127; c=relaxed/simple;
	bh=u7E456XuqP97lAjDuLRHjbtGsRYpjEqva31llOZqTp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZwgl7xQ4kFMYtmsopWOHDV0gxFU6zCXmbzdSRFcHYhrqNeAAwIEckWgo2paaBpfA73cvbvCGz9CT9KGxsucQa1VZNSLA6tFWZuIMyMxpVqTrEv/xT2FwCIpw1HqKS2I/mIx/WZlLp0Jmq9RCyFKnLlQ5s6qs1Za3uezHI6N0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3T5OHHOO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3T5OHHOO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5tt9Vmj5QLstTl76VcOwF5BGity5lMjGCb09kYesARo=; b=3T5OHHOOK9cc9iZBZ8i+YC++qO
	mKr6F6kzGiruNP4epYruf2pI5VVqgZBRiPxn2HjMz8kCqy0VQIFQgJDAC9XI9cKi+DMpCiw08BsT1
	I8L1fs/0GnC0tzcvSHFq8hHgOaR5Cbo1Y7vy3Ra+y61sDpyM1N50f+S+OIRNyCaMEKbTdJLg4Ou2Q
	jM9yIbBYxduo5KDNexctT9STlcNQ8KpkzYk2hPbtySn2npJaIo5/NitTTUTTLlxyLJsaO1rPihaxr
	snlqoObUDKYhQMNSKp+Js2XtVy/ZSqDSyIg2VI4N8Uf68UVdUzR4ZWvE+NkMGd7KUxoQscpQEhOaO
	TyEV6UmA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2mL3-00000009YVs-3fr3;
	Thu, 10 Apr 2025 07:28:42 +0000
Date: Thu, 10 Apr 2025 00:28:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
	David Howells <dhowells@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	willy@infradead.org, linux-mm@kvack.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: Does GUP page unpinning have to be done in the pinning context?
Message-ID: <Z_dzKUp1ukaArcSx@infradead.org>
References: <939183.1743762009@warthog.procyon.org.uk>
 <67d4486b-658e-4f3f-9a67-8785616e6905@redhat.com>
 <dcb80dc4-a9f7-44d8-b88c-7221ea29deab@nvidia.com>
 <Z_NzBWIy-QvFBQZk@infradead.org>
 <f04289cd-128a-492e-a692-6f760e2271e2@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f04289cd-128a-492e-a692-6f760e2271e2@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 09, 2025 at 07:56:07PM -0700, John Hubbard wrote:
> This topic always worries me, because the original problem with
> dirty pages is still unfixed: setting pages dirty upon unpinning
> is both widely done (last time I checked), and yet broken, because
> it doesn't do a mkdirty() call to set up writeback buffers.
> 
> The solution always seemed to point toward "get a file lease on that
> range, before pinning", but it's a contentious design area to say
> the least.

For the bio based direct I/O implementations we do set the pages
dirty before starting I/O using bio_set_pages_dirty, which uses
folio_mark_dirty and thus calls into the file systems using
->dirty_folio.  But we also do a second pass on I/O completion
before the buffers are unpinned.  Which I think now that we pin
the folios is superfluous.

