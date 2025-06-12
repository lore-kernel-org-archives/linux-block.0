Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DA81361
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749705765; cv=none; b=PTHQz7F8R1iCK5b/jj8XScyHKWo8FFLGWsAXh19JamM5iwQvR1CUgAs0Mjo8dVwimMnZD1wvlwKZgYkK6qg0F0l95nsDnTIqPCev85RMtD0Q1eYcKaDs2hP0KPR7iF6r1Kcyp2SFZNwGP3J5QNHQwR0GXbIVn1BnB3PbTCv/uws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749705765; c=relaxed/simple;
	bh=q7F/lL//lKSDoknpKFP7w3Kn52tR82N2AVHctcKepOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyaC4cjjWhGLhW7BN2LT0+6YkYzgWsWpUMSD3CmR8HfwVtvUfbtbsAxxsHMD8rV/pdWQjfAJbxgxKlvDCfYkSfxBUueir68SsmD8GgfWo2brBCEqyJ3DOJMRBThYoUx4WWFiJPWv9xptQxeD87miIIHmoA/uBX9v9VT2TXJiJ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PyRuIGhb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PyRuIGhb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2Je2qY+0rk39xr9Aj/IUIyPMHgA6nMP3kc/WcwfETog=; b=PyRuIGhbSHZcp9RlAAd50IM+cc
	F0cC9FbAMb4G971GS5q2x852qVaHOOKLaHWaxeQ/Wyq/I3eLqFLuJpRJSNB6lFLHbRvXwElsQEaAV
	LuE7tYwiVOzZVMkevvg1izWZhOi19izi/ZOpQApVKei4iAtRo1uT9VCw0i9v/K0u4xhY0jItFwuse
	vrKInEOEKe08mmlGsOCmna/me1mq68VMMS6QxKEFSmYmoy28oQJcSPAqFC50DvMsFaRF4B0lEPvkZ
	+CBj3uejqsm2BqGhnZ525gxA5pJhc/i4wmQ3lMG67Z6uTc4avhr8mdc4BmXsJbnFZUGzB21JrOaKI
	yI2HrBEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPaOh-0000000CDoX-2H4x;
	Thu, 12 Jun 2025 05:22:43 +0000
Date: Wed, 11 Jun 2025 22:22:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: use plug request list tail for one-shot backmerge
 attempt
Message-ID: <aEpkIxvuTWgY5BnO@infradead.org>
References: <4856d1fc-543d-4622-9872-6ca66e8e7352@kernel.dk>
 <82020a7f-adbc-4b3e-8edd-99aba5172510@amazon.com>
 <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 11:53:07AM -0600, Jens Axboe wrote:
> Yes we can't revert it, and honestly I would not want to even if that
> was an option. If the multi-queue case is particularly important, you
> could just do something ala the below - keep scanning until you a merge
> _could_ have happened but didn't. Ideally we'd want to iterate the plug
> list backwards and then we could keep the same single shot logic, where
> you only attempt one request that has a matching queue. And obviously we
> could just doubly link the requests, there's space in the request
> linkage code to do that. But that'd add overhead in general, I think
> it's better to shove a bit of that overhead to the multi-queue case.

Maybe byte the bullet and just make the request lists doubly linked?
Unlike the bio memory usage for request should not be quite as
critical.  Right now in my config the las cacheline in struct request
only has a single 8 byte field anyway, so in practive we won't even
bloat it.

