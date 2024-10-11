Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1F216A32;
	Fri, 11 Oct 2024 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648523; cv=none; b=aEk/UmkZmNjoQIML2pUCgUpbJbp937+1kIT7Ivna4DwAnXB4sKEFe2zKWcGgiEMGcTxfpqht0EViJFDvA5doYV0uBRV78M2L6nO94Bn/JWHR0F21hNde4iNO6IJpmFSh8ISyNSuc/DIspq3d0RZoVuzo7T6s7WYvR3JotsJchdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648523; c=relaxed/simple;
	bh=U/5+TvST8RYm6Vx/SW+yEw2KSsIO43A37LW1cxhFXJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/+M3gzAXNvK79ZzT4N6zehXhLD8qpD1wXu5jzREyx/hPPa6ZIBPen3UcZKbDYS38lsGaKbYhFHDf+GH8KAHhqeVQA0ntV8KLpsUbHuhQhdqPqtHOOXg9/OPHc2+uE1yLTqdpQf+FA1VEYV2aXGjy+c4r3jXz0IPoJWJzdtc5B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FA513NLe; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FA513NLe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U/5+TvST8RYm6Vx/SW+yEw2KSsIO43A37LW1cxhFXJQ=; b=FA513NLe4ISGXPUL03UaITqFzO
	7WgEC3UWLz40eaUAKPqSXaQEWdTMpAo8w51+95U+5siUV+t1mjMa66BUIlhE/QzEZCAvwI5x7MeNF
	r8AVwn/6p5Sn1+rDmXuBcigfn49yyj4A4TH6GBRm7IyTds1pRzYqPVo+4wm3cOFRI4yEP8Hy5MvD1
	CghGqxwcON9UtLFmRB5a7/SRsYUbHXnYdJ0w8u1ruVwdLaIassMw8PFQPO2FDwXrqJ9ToXi6Xyn2O
	5LHvjkHbz+E8DyvXWoKntWSL7lfdKF3QU2TeWnIsljRv3PEJ4kDFuB1DaRCkVeLF1EUSydgrIorYp
	Db6X+lKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szERh-0000000GEWK-1ox0;
	Fri, 11 Oct 2024 12:08:37 +0000
Date: Fri, 11 Oct 2024 05:08:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH V2] lib/iov_iter.c: extract virt-contiguous pages in
 iov_iter_extract_bvec_pages
Message-ID: <ZwkVRW25x6MSaBmk@infradead.org>
References: <20241011035247.2444033-1-ming.lei@redhat.com>
 <ZwjlXoSu6zA5Xcy7@infradead.org>
 <ZwkUJaXM8XLgl8in@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwkUJaXM8XLgl8in@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 11, 2024 at 08:03:49PM +0800, Ming Lei wrote:
> Looks open-code iterator is more readable, the patch looks fine, and
> I have verified it works as expected.

Do you want me to resend this formally or pick it up from here?
(either way you should be credited as my take was just a trivial
cleanup)

