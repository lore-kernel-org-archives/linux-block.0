Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6CD3C0C;
	Tue,  8 Oct 2024 04:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728361401; cv=none; b=kvHjJ05GkoPrjyjIrbqQ4sjbuzlAAv8WjD0YG/UsmAjynGheuCIPVaQb6trqlK5H2K15UVP7J+OHdv8KAxTxAWB2A9hoC3A4S5sZ/f6WxlJSPLg3/7XAlCI1Wma1qpKIRNqgfefs9MojGDL8J3+4rLAvq9a/vJrU8RhK5bV3hdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728361401; c=relaxed/simple;
	bh=OeHQXTSacYDSwiwOw29E549B2VBdFZfskgN2zjl0Nq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXsB65IfrsSqQQkIcJ9BcOpUv3xYwkAYbDI+DBEG327gOBCVzNSriXU+lpF87beSS56TloaIAZolD80hpUYJHb5mc+m1q9CDaOhmtjY3wwVm8gKdCV1V6LOQMn08ai+3kxSIVJF10sAJxZF81e+9IQ8+OHja8bsS2W2jI6vQZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yx1ejueX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yx1ejueX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hMDsMEBBIb9pmCM20u0vcLlEnKug9C+t6uyxWGFULM0=; b=yx1ejueXNf7XadEYjTcNOzIoJ1
	61kWBbp5sUSBp6sUC39RekHIMvJ9xg9eF4ejaFc9CtM5sZ7EphVe59PooHaPxZu4M25P+3nfm+1vO
	xRzMlOH+mfxWmgrSLfzYyp/ZGUTZCfVHuvIK4nodnjlFN0DM0j/b5AaP2G1JBlAlnoYAI84u0Mg9i
	ZlnZRlCrxJuQnKTIjwXVRnbk0AHxf6jU35tvVKuCLrbCcXT0OF5U7+xfbvdZe61XysKSI9vpsMCI6
	DAP1Urh7fuvtmcb2CXGGkI0Rm4f3mV2yE+5b2hbr8Ccb+0SUw/oj9x8nH/1EdTurnC6aCYBtr7jG1
	GIo6Exqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy1kj-00000004U8C-1166;
	Tue, 08 Oct 2024 04:23:17 +0000
Date: Mon, 7 Oct 2024 21:23:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: SurajSonawane2415 <surajsonawane0215@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v2] block: Fix uninitialized symbol 'bio' in
 blk_rq_prep_clone
Message-ID: <ZwSztY8oUH13Botl@infradead.org>
References: <20241004100842.9052-1-surajsonawane0215@gmail.com>
 <20241007195836.52576-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007195836.52576-1-surajsonawane0215@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 08, 2024 at 01:28:36AM +0530, SurajSonawane2415 wrote:
> Fix the uninitialized symbol 'bio' in the function blk_rq_prep_clone
> to resolve the following error:
> block/blk-mq.c:3199 blk_rq_prep_clone() error: uninitialized symbol 'bio'.

Jens' comment baout the commit logs apply here as well.  Otherwise
this looks much better than the first version, but please also move
the bio variable into the loop scope while you're at it, which also
removes the need to clear it to NULL at the end of the loop.

