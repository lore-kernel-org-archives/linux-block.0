Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5339A14F70
	for <linux-block@vger.kernel.org>; Tue, 26 Aug 2025 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195079; cv=none; b=YwWgnjV60y0u70NlKiIXGEfvYzvOS2gzhCLfi9y19Qq81E2GYzeyF3+1G5QlQKecDDioeWy/d92Gxd83al+28FBT64jKsE8CXlWTcp0OOr+ru9oeweiyt0UbMKkzRwr3/M628SvGLUVOVyE9eLElhBPA99fci80n2jsQVlSz5KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195079; c=relaxed/simple;
	bh=l1UHK+CP86ubIiPrRNgBCXDEEoQ4KaXhIZYLMzVW7I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6oj3GcbvdUIPE/pE0Lazb8XrdwgyA69H1QQhHcD1oURMIV6fmVINTlRba2RBW8s0LrG60xyKyUjWLlDD6Z0RJUEFd356S2x68M7ssn9as0f9TN2p1pnZJT7nuzanReJnzDWXMZuZdJ0JQmdMFUy+idpyRHpzst7Nn4CanxjsPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Iy3KzVUs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Iy3KzVUs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cFsV8hCnRcTrUySGzP7bjM5svSuddtMIBBDx2iW63Qw=; b=Iy3KzVUs/jEPqY4prmr94fvTmf
	8Ca76E/ietBfXj5de6ps0MESJCLj1gRmiDsMRqavY7X65u8G4bjjVrp1TYY3/q2cCaMhY4M3tYoSf
	zQEOxl+vzyXutt+6EcZa/LSNbPEO4z9xDmtRqsyMAecrGNDZ9eAgrBYQ+BmwJD6AX6X3Si71OUqUe
	TOtko7P+Uat9OqR4zi9IBpq/KKaK+55z9keZsRdMW/NAkC4dXfNUzx0VETMwl+cXUQHYeHIRsMb8/
	96TTqtYLm2aOhtLqrFBuX5sx77jobck5iXxoBORiwnwOD6kFPcvj36pfm7M8GSMAuh9DvpVFYbA4a
	Jvda/Qww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqoZ2-0000000AvJF-1QQg;
	Tue, 26 Aug 2025 07:57:56 +0000
Date: Tue, 26 Aug 2025 00:57:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH] block: rename min_segment_size
Message-ID: <aK1pBJ7q3XxqQj23@infradead.org>
References: <20250822171038.1847867-1-kbusch@meta.com>
 <aKwtMbB0LQGURNMF@infradead.org>
 <yq1h5xvqkij.fsf@ca-mkp.ca.oracle.com>
 <aKy-cfmAckSnbrvG@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKy-cfmAckSnbrvG@kbusch-mbp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 25, 2025 at 01:50:09PM -0600, Keith Busch wrote:
> On Mon, Aug 25, 2025 at 03:18:43PM -0400, Martin K. Petersen wrote:
> > 
> > Christoph,
> > 
> > > But max_aligned_segment also feels wrong for that. It's not really the
> > > maximum alignmnet, it is the fast path alignment. Maybe something like
> > > fast_segment_granularity or nosplit_segment_granularity?
> > 
> > Maybe just segment_granularity to match the other granularities we have?
> 
> I'm not sure I like granularity for this limit. That sounds like it
> defines segments to be sized to some multiple of that value, but it's
> perfectly fine to use smaller segments.

I guess I stuck too much to nvme terminology where those boundaries
are called granularity.  We also do that for the discard granularity.
Maye it should be boundary?

