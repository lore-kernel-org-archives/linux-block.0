Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C031DF968;
	Thu, 20 Feb 2025 06:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031898; cv=none; b=aRvz3E9VyR5uWUaTGmP+G8iCoWgYEYoefIeGsUF3GccLf/polc543PXjy1SkxvN3TuKsR6SMX6LqMj1R46sjRzOpaeuo0gLCXXeKJwFyZN6UTIswfohmk+VcMt03S2/WTYlc/QMya7EvaZ5Xqnwb3TewPhOCewusQ81xHAh1aGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031898; c=relaxed/simple;
	bh=fOAKAOMb02qlaPRSYbtsDzZeWwGuxjX3eQZH40VJdtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spoTHoaDg49ar7HMd33J38jDWVUu/5rspd7JJmEGAVQEZf9unLe3wuTR1OAWwwd7MRTIQ2U877P36zNeNqlisnEUmDZRVIMSnCtF9ehphQ1ZzD2La57MbL2xgdVZy56zsUVFB9XbfqzEHULQxK5NfmCKwSBvPgLFLEX1FM7iui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TVEOIBDV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TVEOIBDV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T6N5G2zN2/Z/vzM8Fier7hm8h2aC+6z3mM0BMteNxMA=; b=TVEOIBDVaCFsUDP7+cSxD6KvUP
	k/UhEj7T7q68THrLUaGkfkU0p33rvduS++uKTiJqjpz3aPDN5L9Lvztzvzpb1fIstDe6aJvs86BRV
	C8O4ALYjfFWqqhb8Y9XBVwk12pS/KLgtRnz6CBko039v/EPrmVlm9JTI2ondRH2PZGl/ygZjGD4vu
	P5ErfAev7Dg43BT8ZY92RRHJgbTLmqY6yqdXm9o/kV++A1FFF0bVV4tesx1Pl+YZfw6LVvQ0hY2VD
	93yquXKuD+hfFie9yOMRWeQWwCWqOKK97dKJ1fy1yD5ioDS0lKN7ZmPc7NxtGOfgwzOelHe+MRHtJ
	iW3qtbUg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkzma-0000000GtUX-3kS0;
	Thu, 20 Feb 2025 06:11:36 +0000
Date: Wed, 19 Feb 2025 22:11:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Oliver Mangold <oliver.mangold@pm.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: set bi_vcnt when cloning bio
Message-ID: <Z7bHmJHI1ewrFZsa@infradead.org>
References: <20250215-clone-bi_vcnt-v1-1-5d00c95fd53a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215-clone-bi_vcnt-v1-1-5d00c95fd53a@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Feb 15, 2025 at 11:58:15AM +0100, Andreas Hindborg wrote:
> When cloning a bio, the `bio.bi_vcnt` field is not cloned. This is a
> problem if users want to perform bounds checks on the `bio.bi_io_vec`
> field.

Right now bi_vcnt is supposed to be an implementation detail for
bio_add_*, which obviously can't be called on cloned bio. Except for the
usual abuse in bcache/bcachefs that has mostly kept up except for a few
read-only checks in the completion routines which also can't be called
on cloned bios.

It would be nice to use it as a __counted_by bound for bi_io_vec, but
until that is supported on pointers in addition to the flexible arrays
we can't actually do that.  So as-is I don't really see a point in
just assigning the value if we don't actually use it.
