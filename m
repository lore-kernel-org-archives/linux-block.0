Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6A248861;
	Wed, 12 Mar 2025 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794768; cv=none; b=hNofte/l/DzDqrt9IYRLtNoFscRWl8MLwA8ti1Eza3iI5P6VmV2LRMXkszA2zr0CHcrcEB1oWRE1Z304ecq5/klPAG6MZKuNG3//GTGAjuLd31F2LEGZaGooENc+MVjvAxT1LLnIbp7NnzJxSVGD05+ab0unU6JxHilo3HKoEdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794768; c=relaxed/simple;
	bh=I8wgomyOs3Wt3ERwjYgHKZRI1UojjOp0qDqN31SjGW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWP56QbsafQDAdvFj0mxXkJPhU3iFqEQjv8M75edCF+S3sjktGAU1M2wDFa1XnKvW4xx6zvel2uxXuWhpo6dH3TXVNVymV11q1UbCXN/FJ2UIYl8CQ+B91D6Dy84lotGsu/TgRc/kJdm/J+2qZkLujgrG4lqfzO/QmsZYImeEJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=InvVfMr2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="InvVfMr2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BA+vangJmU2MWPmyUHrEQPZDn+27OXCjp6/uwvx3BKk=; b=InvVfMr2PcPuYc21hDzGu4Me5n
	t079CxJlzAbW5lOJtX459zBdZ3oxaGtnb/mOAh/EMCrLCYtRRyeP/rVW4xwXsWi90uuVLlGjYuMNp
	DXd0Lv2pJnr1cAbqM7Z7XNI33gf8VF8usmLtCrPtElN2AcX3HYze7gW1p/QapRHOT7Sk3yUgBa8C8
	00lt5IosXIClyJUUc9xG/f/GAk6YQUX59e4MRV+ZAIW0Kwley0mVoAi88gE/2TpiUfFN5DOtz0lhV
	j/zcPlV/ViM8pgsiVouJHsG+sZJTkZGahwZlpbMTBpPEV0lahaAIhd2Y1daLz74eGBY5wymAwiDLD
	JQpH+x/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsONv-00000008wMF-2vJ1;
	Wed, 12 Mar 2025 15:52:43 +0000
Date: Wed, 12 Mar 2025 08:52:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Sooyong Suk <s.suk@samsung.com>,
	Jaewon Kim <jaewon31.kim@gmail.com>, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, spssyr@gmail.com, axboe@kernel.dk,
	linux-block@vger.kernel.org, dhavale@google.com
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct
 IO
Message-ID: <Z9Gty3Ax-2RslqDX@infradead.org>
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com>
 <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <CAJrd-UuLvOPLC2Xr=yOzZYvOw9k8qwbNa0r9oNjne31x8Pmnhw@mail.gmail.com>
 <848301db8f05$a1d79430$e586bc90$@samsung.com>
 <CAJuCfpHjV=nRmkAGrf-tyCxEEygZ0CuW-PRp+F_vHwFbfYS8dA@mail.gmail.com>
 <Z9Gld_s3XYic8-dG@infradead.org>
 <CAJuCfpGa43OQHG9BmnvxROX1AneCvkuLxFwM+TdxAdR1v9kWSg@mail.gmail.com>
 <Z9GnUaUD-iaFre_i@infradead.org>
 <CAJuCfpEpWQV8y1RKb3hH+-kxczTUvpvCBNNzGJufsAxpkhB4_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEpWQV8y1RKb3hH+-kxczTUvpvCBNNzGJufsAxpkhB4_A@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Mar 12, 2025 at 08:38:07AM -0700, Suren Baghdasaryan wrote:
> I might be wrong but my understanding is that we should try to
> allocate from CMA when the allocation is movable (not pinned), so that
> CMA can move those pages if necessary. I understand that in some cases
> a movable allocation can be pinned and we don't know beforehand
> whether it will be pinned or not. But in this case we know it will
> happen and could avoid this situation.

Any file or anonymous folio can be temporarily pinned for I/O and only
moved once that completes.  Direct I/O is one use case for that but there
are plenty others.  I'm not sure how you define "beforehand", but the
pinning is visible in the _pincount field.

> Yeah, low latency usecases for CMA are problematic and I think the
> only current alternative (apart from solutions involving HW change) is
> to use a memory carveouts. Device vendors hate that since carved-out
> memory ends up poorly utilized. I'm working on a GCMA proposal which
> hopefully can address that.

I'd still like to understand what the use case is.  Who does CMA
allocation at a time where heavy direct I/O is in progress?

