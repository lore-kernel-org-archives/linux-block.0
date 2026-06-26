Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A5879CD;
	Fri, 26 Jun 2026 06:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782454343; cv=none; b=l1FCgmgIHmFC4iOO+nm9b1Zalq7aCMLTPB3b2LxiH/8NERdy2c7VlH6Hw8dyzVreDo8JBGvkzWjLx0BUaqOvYYCK8pigbJ0+UuOawtSBc53kzmPdcAGggw+rmRfKHP+4zMA5Hs3e5z85hcOOX7kFCJqyrb2UBMsd8C7VpMipFM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782454343; c=relaxed/simple;
	bh=72LllRTw1K9qVyXLc5n096+oNWQPBAMhr3HchgBBcuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX/bN1kMdTqYIBZRHq/xkahNMEX8Ndnh0q//Jg3asFNr16lDvyBbX24wtgebi2atSHscOlitoJloZ6a2PctPog7sXmSGMhMPtHmboWhIyY+e1zwzKylLPvi45kUSmhuqGagUgJeNT6mkfqFO8ZHn0yz3sK9U3CFzElqDR2nuckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W9k3id0V; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W9k3id0V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kn9ri5Ko9DRXfSLkJq9kzwsQowhyDCQCO7Ox2z4nc40=; b=W9k3id0VRJ2pUncr95D/JOfo4p
	e188qTYD1Y0tTKqzFMi/mC+/If+zmlWtHi4OlEAuLTf7ztnhFFzODAe/emXu4oPT1zHxS77tkMvQI
	f0i+xDaegBXkGq+VkyeLsXAlM8Q1CHHLWePK7k4Alr0T2TzJ//17uDN6ZoHl/XrfRbA4YfYZTuoDL
	zXzohc5S9R6i55xYH4bpax4LWBJLPdpZLJImi8JiZeYVWDGbYdP6kI9O3AvADjCF3Z+myj1A1yex2
	KsaVbnKpctW+zgXwrFV5mskYimQFSN3MY6MFaYCvA4t6/QwXsxk+4uObVJcPft2m+yle6So/VrMFk
	JwnVi9tA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcznY-0000000AZuj-2Pkw;
	Fri, 26 Jun 2026 06:12:20 +0000
Date: Thu, 25 Jun 2026 23:12:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karina Yankevich <k.yankevich@auroraos.dev>
Subject: Re: [PATCH] block: bio: check offset/length sanity in
 {__,}bio_add_page()
Message-ID: <aj4YRCjECYjLg6yk@infradead.org>
References: <20260624203327.25553-1-s.shtylyov@auroraos.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624203327.25553-1-s.shtylyov@auroraos.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 24, 2026 at 11:33:26PM +0300, Sergey Shtylyov wrote:
> Sum of the *struct* bio_vec's fields bv_offset and bv_len is calculated in
> some functions in block/{blk-merge.c,blk.h> (and that sum is often compared
> to PAGE_SIZE) -- that sum may overflow (and so the comparison yield a wrong
> result) if some bad arguments were previusly passed to {__,}bio_add_page().
> Add a check that the sum of the offset and length parameters won't overflow
> to {__,}bio_add_page()...

I'm not really sure there's much of a point in this, because the
error handling isn't really going to help to recover either.  I think
we have to trust our programmers to at least get the very basics
right.

