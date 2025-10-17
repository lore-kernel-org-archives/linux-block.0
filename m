Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345230F956;
	Fri, 17 Oct 2025 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681628; cv=none; b=pOCZfVCpcxk/iNjEDzCrOyeK4Ae5cYFoZlarVIr5y2DQnZNg7duw4jmAFyf4NiVpqGr1/d9Zcxw3x/NFkijPQ889F6cikwn3jlQbhpy6wAujCMNmPdI6qmquyLdCdRj8DkzsmgG2HmmlknZFUfIxMziVr8RSPmbWqSOgFkAcOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681628; c=relaxed/simple;
	bh=B3oTq1X3UfVVA6wULV7boY1lSHRqJV9x+hD7TQljc/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Flyi+oUMLhrkD/p7fKJc1nd+m0yh7iOxGIXa0I5gyQh811fU3gFqo/iZ7kxAXGGQXYOLq9B+hF1qYWhrr4AMlYegOpaIZsqCOOCMWSk0mcM4xG11Rid1J7o6ixIkJ2J2WEA4gshpJyA2BzMbzZ2wViFheRh13NySTcTeFaSGJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cNh0C2rR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cNh0C2rR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B3ERNiD8bT/cav44ItalBsHpd8WUoQcmN300xSEydCk=; b=cNh0C2rRxf9WXDLuepaXvoz1FK
	5DUOx3Bf3k2IrAt+PcZXYrcrEOiA3eJZ0fIipatgBiXeLMiGNOkmyt8+no3VCXNDPOLYz3y3Vt+9U
	cnIisXQk6dLKcmwXNYKBg+GkmpK0d1gw4IjCITFueUAjiIqXeQnbLSVWXACWkZriNcpuqTqQhFSOx
	Qxh/3Zd+tZaCDdB1JTFPA/FEAZOUlR9ZvsITKwvcudXmFeCSL12BOkVw65hgrFtPEqbngD5VZtUNI
	i7mPw2JpYe+o1UKaVo++pXriXqJu3SuwbV35099LNfZtcEqRo3IkM1D10q/OrMxw/Ty3mKMThTRH3
	brPxI5+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9dik-00000006iTa-0bvs;
	Fri, 17 Oct 2025 06:13:46 +0000
Date: Thu, 16 Oct 2025 23:13:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-block@vger.kernel.org
Subject: Re: [GIT PULL] block-bio_iov_iter_export
Message-ID: <aPHemg-xpVLkiEt9@infradead.org>
References: <ov54jszhism7mbeu74vtyoysxnx3y3tsjbj5esszlrx3edq77s@j2vtyy45gsna>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ov54jszhism7mbeu74vtyoysxnx3y3tsjbj5esszlrx3edq77s@j2vtyy45gsna>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Umm,

besides adding exports without in-tree users, this is a patch that's
never seen any relevant mailing list, in a pull request that the
maintainer hasn't seen.  That's now exactly how Linux development works,
does it?

