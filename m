Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3059D221DAB
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744007947; cv=none; b=RMWVfC8GcAKkGBg0N65Apk6ucRGmXib+Gvbe8W3ZQtHzTmUpl2dDHsGz1LUQiFcrJZTaijeBeBJTIuKgwqkCIAC3aeHqtGCbBHKb1ERM0KWiq2uSKLKrhKZPdj/KT7uIsiXrAY1cWOCp7U87P3DKbUmG4xLBne+yPbUila3xXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744007947; c=relaxed/simple;
	bh=poBghNGz4hlb750IQ3Wu0740jtYVra8LsizCRs/XIvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Llc4Ox0SlF81mU1z61ga4UvL/fVZSGqAJwt15lHkzLLwKuf5ZUqHtylMaJcYzWJUOAIpQMTXBW/WdKAshwzS85zqFjVfGkMjkkOZiKzmzbcXtEXVhCEBcf+fadSoCtT0Rtb9m7TbulM8s7WzI5LeJofj7jBhPyj4W8PCeUChRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ad27Wh01; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ad27Wh01"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=drSbq0KZf46iWEvCfgHN7bHPFVJcUCPR/oNPquQ9VEI=; b=ad27Wh017aF5juAz+eeeUdLYOz
	w1DCjuYXTGs6CHMjXX2l/Aeuc0ZXqVVxqz8lA7MYffTvpmM66PmERpAJk71kMsfE63gJEbRM/gPTB
	K5lXgkylK8OMLbperHapLUbc3a7DxoPCjzFaiP8X0GmXi8KjQz2ntQBZEERG6BpnMXLbUyfqBvL6k
	cVF8ok3UeUF2Lr+SI2Zl3ZB24esZs/jRHcPnuz+CPG2WU5bLJO3QY5ba14cQrWJB4NsRdrRHKhxlN
	VHf1XWrY5YD07utROIGuYy1FxTebY6skg8Z4rdhLp8uBP1BpZHxSEU8tMyZc08jj5FHNh0LleIQKk
	CpSI+SlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1g8L-0000000Gb3M-0MzH;
	Mon, 07 Apr 2025 06:39:01 +0000
Date: Sun, 6 Apr 2025 23:39:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
	David Howells <dhowells@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	willy@infradead.org, linux-mm@kvack.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: Does GUP page unpinning have to be done in the pinning context?
Message-ID: <Z_NzBWIy-QvFBQZk@infradead.org>
References: <939183.1743762009@warthog.procyon.org.uk>
 <67d4486b-658e-4f3f-9a67-8785616e6905@redhat.com>
 <dcb80dc4-a9f7-44d8-b88c-7221ea29deab@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcb80dc4-a9f7-44d8-b88c-7221ea29deab@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 04, 2025 at 09:59:40AM -0700, John Hubbard wrote:
> > gup_put_folio() seems to only rely on per-folio information (esp.
> > node_stat_mod_folio).
> > 
> > So there should not be such a context requirement.
> 
> That is correct. The essence of gup/pup is that it operates on
> struct pages, and doesn't have any "moral" connection to higher
> layers or additional process context.

Hmm, indeed.  I misremembered why the block based direct I/O code is
doing the process context offload, which is to call set_page_dirty to
redirty pages where the dirty bit was cleared during direct I/O.

Which I think now that all block based file systems use FOLL_PIN
shouldn't be needed anymore, because no one can clear the dirty bit
while the folios are pinned?

