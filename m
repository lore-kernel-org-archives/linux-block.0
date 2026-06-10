Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7062302149
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781069072; cv=none; b=iz16vz4wdl8w9yffwThWpcdE06nHFT7qizNfwM17IoCIESG8LQVfCd0AyP3YX2bBh0b+zjjVwx0aqr3mbzGx+2H7nquvXxgqvX75FUGyBd4TrSNv/rzVNfX5qEmFDXmB3b2e30/lkhU0S2ZTWtf+tI+PBymgeGfqI3xDiP/wWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781069072; c=relaxed/simple;
	bh=yNlDyzkAl9i9NZlPqw5aCLmCXXAJU3BEE0qEySFvTMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kf35tGRNnt9uOW9BEIS8Sp85PTrgpJAdvukARRj1kuXfAIS1qZl03kI63Wr1uI0LYlimr+oIPXb0MogBHunM0pP9bx4UiK2fZBygkUd8OP+ZrayMaMcCsRMeEEQ3oUajNH4RD2KgixcTsGa9kX+FXnGAdkRP478EEUp80JGIfLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SxSUiMNd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SxSUiMNd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7w0240EWL56p+X10hTqniHS0bsGaJZx91xbNyAwIf5c=; b=SxSUiMNdPW9GKj02lHSUR2+Qzu
	sPnbyoMybGhiWtAcf49d/MWSVFOzI4s7TNpvq61FHvIRLkwA7V4RUBbJWQGP69dCh15Foq91n3DVP
	tgVw3WX1sqC5lTI9iaJxKBBgIFcwLzU3XhY8iCCElBUPBeI+9nUZdmVyGOA/TN89HZfVBLlP8VaYU
	5vG3fSh5erwELqBaSvNPUcfOdlY5BR4LRIXAAJAP4HRouiSfcFEW7wloQxZIDsqTtKG1NjZPh9F+r
	BLQTTV74KKoXopVuumCZQFZ6dwLSsx9ZzWA9+BIUkgAT2JwbUgbwI9105v7yh3bDM8KEnrXgkw4/c
	64khC85g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBQU-00000006ouX-4Adl;
	Wed, 10 Jun 2026 05:24:31 +0000
Date: Tue, 9 Jun 2026 22:24:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 11/27] drbd: Split drbd_req_state()
Message-ID: <aij1DtWM8N7O3q-E@infradead.org>
References: <cover.1781042470.git.bvanassche@acm.org>
 <83d144f376580f491b42d7533e004aced7d26d7a.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83d144f376580f491b42d7533e004aced7d26d7a.1781042470.git.bvanassche@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +{
> +	enum drbd_state_rv rv;
> +
> +	if (f & CS_SERIALIZE)
> +		mutex_lock(device->state_mutex);
> +	rv = __drbd_req_state(device, mask, val, f & ~CS_SERIALIZE);
>  	if (f & CS_SERIALIZE)
>  		mutex_unlock(device->state_mutex);

Wouldn't something like:

	if (f & CS_SERIALIZE) {
		mutex_lock(device->state_mutex);
		rv = __drbd_req_state(device, mask, val, f & ~CS_SERIALIZE);
 		mutex_unlock(device->state_mutex);
	} else {
		rv = __drbd_req_state(device, mask, val, f & ~CS_SERIALIZE);
	}

be either to follow?  Is there much of a point in the CS_SERIALIZE
clearing here?

