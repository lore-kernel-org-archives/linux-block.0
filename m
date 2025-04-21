Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E720C485
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745236301; cv=none; b=nHymMVQ69EhXmLFWAnCN2qkJ5C20C/Jf+gWns57NTAlJlHXqoDtxuFS1iz71qhXeu1CRcj4PYsKF4txY/9+mm7sH6ej0oGf77vq5KXte2wPUe14/y4gsjXRCWypAQyuEBNWQCscNcrCJFp/RISop4T2MxTKGc72AFJaX/uZGkGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745236301; c=relaxed/simple;
	bh=SQ1ndiKqqC2bv1vqomUuO3rpI1E0qkInarETXVUzdAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7GOM/Im4USOp3jPMkGiesm8bQu24n3jEcamm7Ui643RtQa4f0yF9f0v0JReEHVO4LbtHlHsYJfpBAqI+p1vmgdXYvwso7Jxcmn2Ymh7NL0TDujUAG2u9FlEOFz1wtFcWXHf7tsEbdNJeEUpq7phS/szrRwAWn5anxevbmPW6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WytncQYz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WytncQYz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ssJs9DWpvofyiMWz8KMZAcvt34K7h6qV1Y8TKwZ7DXU=; b=WytncQYzrelZ/UP83K/IkAMjFD
	IfrqSK7pG6+DrpCqDKDANPDB02Y37iabULba+qegUi8QSXzUD6Jdogwo9+mMslEc7Pjj8bJaxpKf7
	9glx7iz5A9kkpssVDH2TiM09fg2QEYnepmHudBQRC41uHtBBRk4DxRGvabakjodQgykH6lbO9Ab1y
	HFg8+4FCvzWUvK4CMI8cBGhsOV0vXdj4qwbCIuLT/cZbOs477xcyrW+w5WijObqBRsrq1JDgmFV66
	w15f/C4Pt9jI9d4P1nagHBPeNEcen159Z8zmHNwwlenoTs3qVpWZ7YTs1P0/hOTsSSMrDj8P8Zz7o
	ddaruGaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6pgW-00000004E8B-07e0;
	Mon, 21 Apr 2025 11:51:36 +0000
Date: Mon, 21 Apr 2025 04:51:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, arnd@arndb.de,
	ojeda@kernel.org, nathan@kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH 1/1] block: prevent calls to should_fail_bio() optimized
 by gcc
Message-ID: <aAYxSOxeM-mQgNyF@infradead.org>
References: <20250417163432.1336124-1-prasad.singamsetty@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417163432.1336124-1-prasad.singamsetty@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 17, 2025 at 09:34:32AM -0700, Prasad Singamsetty wrote:
> When CONFIG_FAIL_MAKE_REQUEST is not enabled, gcc may optimize out
> calls to should_fail_bio() because the content of should_fail_bio()
> is empty returning always 'false'. The gcc compiler then detects
> the function call to should_fail_bio() being empty and optimizes
> out the call to it.

Yes, that's intentional and a good thing becaue we don't want to pay
the overhead for the fault injetion helper.

> This prevents block I/O error injection programs
> attached to it from working. The compiler is not aware of the side
> effect of calling this probe function.

I can't see any attachment.  But if this is a bpf program or kernel
module using kprobes then there is absolutely zero expectation that
a static inline function actually exists in the binary kernel, so
you should not rely on that.

