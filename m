Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3061B4F0A
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069441; cv=none; b=h3KroY4PmX19/syKXUP77ty1DYpAvn2mdLYDg/2mK9SGxTjaOeKO6BFTJld0Pefx5hxjtqCELAtcO14b5GYxSRHqrnit6sA+O7mv1t8oSFl0PVaKFkoEhRD4+9pBKBPVrCHz5Jc3Ih26Fjqa9YQL3GdZw9SuHe86pH7AssyQsAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069441; c=relaxed/simple;
	bh=AOThTDT62sMkcc7KruWBpFBaDeCZ/buTP+ChDmED5Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNYp2/DJM1jnT7JGb9wxbvDHilaYHKU0iUJMM6sQeEBfrIhc+MN+yeJusSTFymUDgpc4xKHzoJgluzWMmxT4frRZRIPmxqIyo1yiOBA8RgaucMEGyuCpA0BFdpfuGDrriMhLXdXdb0bv/7s1DHpHKrogGvPapmt7vSqF73QLriU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SweU3zjB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SweU3zjB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jhlleyT4OWEygTVz0DEKmomoSEt08R1kx7Eeqj9y5Ww=; b=SweU3zjBcwVDtaUSVCTxK3baRw
	aMwvIQYd/pxhrbt9n/lD4PPZSEEGnd49B8wUpBkt4RU2PVlxf+JwpR2eB57wfqOXKPf4yR/m8mH/Y
	ASYzjdsQsw33hIKtJiHYlpFdnsHuj8xy5cPMO8gh7d3Se7AmtgKpskk9tMip9g82BuZ+UzaP2jsBU
	2B4V5LcT3jMljJ0idH/MG+X4Exhz6XBHICVXNozqsDTyJd9aOfRC3MPF3VwgrCCtkEginjRuD4w+y
	o2/BOwixrlze0jO/sG0XZMFHpjf66re6tPJBnbeiLGVBefxjGum1sujQ1BAwDC+PKRfgDJMwtSGX7
	8gDuWSZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBWS-00000006pGs-0jDq;
	Wed, 10 Jun 2026 05:30:40 +0000
Date: Tue, 9 Jun 2026 22:30:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>
Subject: Re: [PATCH 15/27] loop: Split loop_change_fd()
Message-ID: <aij2gBmDwQl7AxTl@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <f835863049bc0364d80c69a7eeb9514e2a698ae2.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f835863049bc0364d80c69a7eeb9514e2a698ae2.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 09, 2026 at 03:05:02PM -0700, Bart Van Assche wrote:
> Prepare for adding a second call of __loop_change_fd().

A bit confusing message.  Yes, you latter add another call, but it's
from the same caller to sort out the locking mess, and that is directly
relevant to the scope of the factored out helper.  So please state
that.  Same for the next patch.  All in merging the first free loop
patches would probably be easier to follow.

