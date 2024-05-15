Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A690715AD83
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715806533; cv=none; b=HlRF0rqR2uUidoa0/zJo/OEDih0dajqOrBokZeVLHoPReNiY2IkKbJudur4fESj80ISNm7B4wNrxWZFrT3g7xIlntWy5NEbFNeMojoMyJqIMlVKPpZDvaR2R3QVBF9hb3HHPhMF8lMXwjkPC1HFceZEU3fyqz16/wsGEzg/nYGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715806533; c=relaxed/simple;
	bh=QD9vsP2ElAUmTy+nmhwp3aHXEVfC7Kc2gwkmvmTS3S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1Z+c4W/c9mF78HKZVcWqn4XLabDvL1edFUbFN0YIIR1BFat32rn8jrzYiCiRDPxN9b9xap9AMmQviPWOwKcXMwKJ0O/dvw72Ff8V2VwVMfwP6XQk4I4H8+/V6x484tj6/3XSYv0FfJz2qdkWu319MT1AriMqvN6PUdnHrsGxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KbDp1JNZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KbDp1JNZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fyJlbpFwcRIlpk11CzpL8loQ8nicymIY+63J/Tv5MaM=; b=KbDp1JNZUVsjzRLIuvvVAWZgdV
	vnlkpOEz6/wCHhjew4k0lX63V1e8q8Qgrb2lQJhVAutTHrLSLODOmaF+yIqIOTvdjcylYRNyTuICP
	U/L7vBe8pLD6DzLQqVSPV4jXpsSAcmFrYuYYbE1TK+mbWetgC99C5fWKgt/ABsWXZlPHKi2aCzlaX
	JY3tjjKNDOMxqa6RrrChCQyxQzyPt1ncSyauRyRSNYGL82bQbGb52g/OvrP2BkQGagewJwqQ09Tzk
	2+PqofZpQmHEqoZSG963fn84su2PtjcFqL1oNJmtNdqULAsXT3OMcSkTKSUAcXXLXEBm9dK/IccIx
	RAWzGwKw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7Lep-0000000AvcO-0Obq;
	Wed, 15 May 2024 20:55:27 +0000
Date: Wed, 15 May 2024 21:55:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	joshi.k@samsung.com, mcgrof@kernel.org, anuj20.g@samsung.com,
	nj.shetty@samsung.com, c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v3 2/3] block: add folio awareness instead of looping
 through pages
Message-ID: <ZkUhPoWnvxPYONIA@casper.infradead.org>
References: <20240507144509.37477-1-kundan.kumar@samsung.com>
 <CGME20240507145323epcas5p3834a1c67986bf104dbf25a5bd844a063@epcas5p3.samsung.com>
 <20240507144509.37477-3-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507144509.37477-3-kundan.kumar@samsung.com>

On Tue, May 07, 2024 at 08:15:08PM +0530, Kundan Kumar wrote:
> Add a bigger size from folio to bio and skip processing for pages.
> 
> Fetch the offset of page within a folio. Depending on the size of folio
> and folio_offset, fetch a larger length. This length may consist of
> multiple contiguous pages if folio is multiorder.

The problem is that it may not.  Here's the scenario:

int fd, fd2;
fd = open(src, O_RDONLY);
char *addr = mmap(NULL, 1024 * 1024, PROT_READ | PROT_WRITE,
	MAP_PRIVATE | MAP_HUGETLB, fd, 0);
int i, j;

for (i = 0; i < 1024 * 1024; i++)
	j |= addr[i];

addr[30000] = 17;
fd2 = open(dest, O_RDWR | O_DIRECT);
write(fd2, &addr[16384], 32768);

Assuming that the source file supports being cached in large folios,
the page array we get from GUP might contain:

f0p4 f0p5 f0p6 f1p0 f0p8 f0p9 ...

because we allocated 'f1' when we did COW due to the store to addr[30000].

We can certainly reduce the cost of merge if we know two pages are part
of the same folio, but we still need to check that we actually got
pages which are part of the same folio.

