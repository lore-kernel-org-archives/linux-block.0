Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957A3BB4A;
	Wed,  8 Apr 2026 05:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775625478; cv=none; b=dC3O7IERFjNI9jn4h9iY4KrpEeX2OxYAhjnCMPkrpmKHyFN0NmhshWymRB6xrvFgyUlfiWF3eLDWhkPKghUgGZQoVVaMNTXGxKxEEe85B4Vt725IvLOEZwjQj0ZIUMb4LzMWZaL6MrTQgowVbmgOYdRXzXBRvxh9mfZwkNT7XV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775625478; c=relaxed/simple;
	bh=AvKsivDtHvgBw6YESEd969tQX9qxDI4tHJVTF9hUaOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaXN9qjyNLO1192BgaC62yIGmOH2i7trHwG2wDO7SBaM9JZa1As2WLpT8EaLRjpkwRG4WJ/gSJ0N5fgj0jt80dnlwZH3FJIXGMc8+BBNGCBFhXzxs7+WCUajadRrQQrgwDUAPXlhcNX+wv5BKE8tuTlhft7V1DeHYu9B8J3UHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WyJc/fKW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WyJc/fKW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2iO/eYli0MZ+1t9Myyo/dAixMD8J4gebm1v3LO7tDTU=; b=WyJc/fKW7z5rI6Fq1W6c5Fvi+f
	hR9wBm0jGGDSh1fYORDczeORWSs2NUVW7uZ9BMv0ujlDLrqnB2kD0oAjjWo8+1gK6PtsgUG80ek8N
	r1sQeHnGvJ4W3yF3/OkSJlee+NDdVzBUru5j7HhlU8pws8jjvV4yISvkIqcyRn/f/eZauVbX0rJe5
	y74Hiian/bj4BRfGuR3H26tymaZCOtO+HKa4dYmy6cAJ5cXfpjWD/9JXRbm+XrF8g7Wpe6y1EJmvR
	W28tGoIIIPgisLg23EOqiYHHTH306zRBrfLx6DtF6S0K0OUjY9Bk3ZKEJIO5rLuRW28JsvRkhr8QA
	ZXkeGtcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wALIU-00000008HXY-2Hap;
	Wed, 08 Apr 2026 05:17:50 +0000
Date: Tue, 7 Apr 2026 22:17:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 00/20] DRBD 9 rework
Message-ID: <adXk_m3SbRcWTOIC@infradead.org>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
 <ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 02, 2026 at 07:30:35PM -0600, Jens Axboe wrote:
> On 3/27/26 4:38 PM, Christoph Böhmwalder wrote:
> > As discussed (context: [0]), here is the first version of our DRBD 9
> > rework series, intended for for-next via for-7.1/drbd.
> 
> Will you fixup the kerneldoc (nits) and the assigned-but-not-read
> issues and send out a new version? Also looks this series doesn't
> actually apply to for-7.1/block, patch 12 fails.

Looks like all this went in without any review?  Since when have we
started these grand replacements anyway, as they are known to cause
bugs and regressions?

