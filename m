Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9FA145A16;
	Mon, 18 Nov 2024 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731911311; cv=none; b=Sf0He6NdvBZ0s/hYug1v76loQwd3Xd+9vQAWEg3JNMK5y1dMd5BIfZHnXNKVYeAP7LMh2On+ItGOhk2xsWV5lOuRJw7X8tgI3dyNzFRQ20bbmV9r0bxSg95r/wE0pjzq130v/ReS9r0q/SiUo0NUeVTIHjF2IxhCgT9FBq0fcXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731911311; c=relaxed/simple;
	bh=OfLUomwrbK7TrYHwyGvz8j5D0IPCw/XwLpDet6Re2VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMrmqLOKzxO0DIPHXIFh6kYBtbxg4GSxfqjyXCCIl7sw5GNRx1w2/h7b3sRI1fXftzbr0sLTgopkJOJ9f6/vTM50CQjoh5u8Sf+0fPKZy2vox/b49OVAyZGBzvMcA/dsqcZhaVbZVzpNK2Zd659oRioamJ3QIKH3blmFZhrXaEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ePvGHaOH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ePvGHaOH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=neqIiB8snErKjVPML0anXES4Lrhl/U+lJb4xDHwVEew=; b=ePvGHaOHxxQ3+2uEizo+0Ty6iZ
	zigiMRTTaKjz/IJnpt5XJm+txEUrqsIl8iNH9YQZEG/ew93RVEr3dbqoKQKk/2RXQpctAjjR+lLT3
	qS5xZv8xacGp0Tyr3xwE21saTVqKc34CdwbWp+OzWVuwB86QB3YNs67InKzRoj1Fv5uLsOwUeRpYN
	kXjGU8Fz2AgI2pBd1t2QiWAEbOgjylJM9GKseIJw7D3Fd4/kGkTfUkK2hMjTZJxWEtyxxJBbRMNn8
	jg1KjDECYNRRx9p0lIlbETd4CaxaxEYTyxbyKJ0zXzPdNlikXWp6+0rrgs9PGxFG+r/cw4zETgny3
	4aFBEcMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tCvFJ-00000008Wcd-0Kwl;
	Mon, 18 Nov 2024 06:28:25 +0000
Date: Sun, 17 Nov 2024 22:28:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v4] block: Fix uninitialized symbol 'bio' in
 blk_rq_prep_clone
Message-ID: <ZzreiYfmoG-s5127@infradead.org>
References: <20241004100842.9052-1-surajsonawane0215@gmail.com>
 <20241008175215.23975-1-surajsonawane0215@gmail.com>
 <70996029-be8a-4f97-88fc-a27cff4f5df4@gmail.com>
 <f6a50924-e3f8-4175-a97e-4e77ed24b72b@kernel.dk>
 <f90b485d-a78e-4bcf-bb77-94f68ad575cf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f90b485d-a78e-4bcf-bb77-94f68ad575cf@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Nov 16, 2024 at 05:02:57PM +0530, Suraj Sonawane wrote:
> Apologies for any confusion earlier, and thank you for your attention to
> this. After further analysis, I realize that this change isn't necessary, as
> bio is already set to NULL by bio_alloc_clone on failure, preventing any
> real case of uninitialized use. My initial patch aimed to clean up the code
> and satisfy smatch, ensuring better readability and error handling.
> 
> I appreciate your feedback and the opportunity to learn from this. I now
> understand that no change is needed here. Thank you for your guidance and
> understanding.

FYI, I still think the change is useful.  It makes the code a lot
better to read for humans and machines, and fixes a static checker
false positive.  So I'd still love to see it, it just needs a better
commit log.  Feel free to contact me off list if you need help with
that.

