Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1CE2747B;
	Fri,  4 Oct 2024 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728044565; cv=none; b=APGd3p+okJT8m8lSjyDpJFWQC/eNWtQM/WrtszgjzigABuXCU0Z2ju6UMNTRavI2Nn5JtiRj/xDFpGWdeBRJOW4gIzq9NL3FoCBaObtXPcviA8i9DyAcG00JyhdplHHGktVJw8GoOK2et2RSIDVk4L01xpCSK1vcTDHvJqvIPJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728044565; c=relaxed/simple;
	bh=TyHSRI3L4cfbP3BXDNXwKj5At4pFXhGFhjjXSW7DkMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ja/vitSIqudmDVzKifFzfDNewwqkoPBQJCqthXBQaNsgLykWnvcloRlIY+1nVXxEyWLOa2jKBtc6Z2gkUj2kXPmZWVflAhlVwARvCDT99/wRkFj8Zf+msgAlJ/4ODaoP6D0G/mU/vwDFZbD9GTs81gppHer4klVBE81Sy4j3/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TkrKOPR0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TkrKOPR0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oirPc73rnQ0PnuxgYQBLNVUSt1lRfzN8Bl5Q7U1VHl4=; b=TkrKOPR0hiNKnsPsFjJfFdn/Eb
	MAd3IS/8TjJHTKiP3xvtESrxPemC/4d5pRggmnU7mdjve2PVLKYKy1c3GIJT/nu7A89GxmY9W2oEq
	Q2XflXF4V3q1W18N5kXlRdSd0eEpmXfTeXCb+Sub/XIZRMr/4bRAczPkF4m4n/R5XNs7lYnvNHSfv
	prcqJajjtcNrDJioRhSQ/Y2ZUlO6wv848v7V01ry8l14GCuxWst9rZwUBLOr60XDYmrjjGaQR1Nzk
	kKniUCs610rH9LDMEONNIsqzR410JY+chOahrool5N6ojh6GjpgYl9txl0TUrpY71ZIZoVOZcFTS0
	eS/u+1uA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swhKW-0000000CHlT-0ngN;
	Fri, 04 Oct 2024 12:22:44 +0000
Date: Fri, 4 Oct 2024 05:22:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: SurajSonawane2415 <surajsonawane0215@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Fix uninitialized symbol 'bio' in
 blk_rq_prep_clone
Message-ID: <Zv_eFIjstVns-ebG@infradead.org>
References: <20241004100842.9052-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004100842.9052-1-surajsonawane0215@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 04, 2024 at 03:38:42PM +0530, SurajSonawane2415 wrote:
> Fix the uninitialized symbol 'bio' in the function blk_rq_prep_clone
> to resolve the following error:
> block/blk-mq.c:3199 blk_rq_prep_clone() error: uninitialized symbol 'bio'.
> 
> Initialize 'bio' to NULL to prevent undefined behavior from uninitialized
> access and safe cleanup in case of failure.

Please explain how bio could be used uninitialized in this function.
