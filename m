Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651FA352C35
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068880; cv=none; b=cP2hn44drbRMGlSdwa147P1Qz2eauPnihoVAguadLpYjP4L8jy18hP/s1nDyJhoC4KUXWZ7Cx1cUKfPoUEs74utf8EfXPnugD3NSS6eb16hcHWs8d16B+ho0nP+pKlayF07BfCvWGCtTKPC9Px7/1V22IUOrBoR/z86JRsa+bas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068880; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWiZylugxG4bxoEgT0QLwpREcE0qoVBuWqzL2MDwR/VrsJinIxZzCoL7sB/e64pHotI+PBYNQfJVxeitQQSBSSqYqVq/SBHI6ns2PW+gsRh87hTQRzaavngSX47KfxPGrjMmFJpxGruyLIJ8SsgdY/32dinkHZz63Q2DLKEFU8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=11d3+YME; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="11d3+YME"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=11d3+YMEuDjJm7sXiC5SiBLKNk
	bYmRRX1JGiIcbOPCbA78sYiqSczudFNlkO6WVmNuG25LsmS7WXFiG6kt66cwJtyjSa7/yvOz7qwrf
	GxVAUJ/fBXixkDA4gvcFAJPZnBrAur2Pfc7OZQhl/yIely7Idr2HkiCzMURURYp850M2S299zsLxJ
	tbpWnJ/TmQ7amTrfgr1Dnzm4V9ib/isA6YwEbqmbFf5K0vsz7mNkNZoH5Q1J3SqLOBXyV0yh8r+XK
	tqWU90PGb4GR3s1ppTcKN5QFq0TAOO4Y7mLuyNQCMhFDVApvZPxu41SZwdRQRPk1/g2ABFTK7lyi6
	4InF50aw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBNP-00000006oot-0835;
	Wed, 10 Jun 2026 05:21:19 +0000
Date: Tue, 9 Jun 2026 22:21:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 08/27] drbd: Pass 'resource' directly to
 complete_conflicting_writes()
Message-ID: <aij0T7JIR5EpYcf2@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <77d0fd75811d7f604fa80b5c93172b5653b52880.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d0fd75811d7f604fa80b5c93172b5653b52880.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

