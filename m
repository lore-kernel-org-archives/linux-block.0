Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9FB20B206;
	Fri, 11 Oct 2024 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635077; cv=none; b=WVuvudrWZ5KjyxsLX2YmG56JOExxvHmSeh0BFL+koQ3pR8QIKUrJFWeLWxjbOgVJyGuC+wDMyBHJBItu0Jnp7JviakMbGXFPyxXmaIggArOqrKyuw2V78kYlt9zqCwXkwrzmZmnCRgl1YffADXDrfqHGxDJGza07HIYrI2ZPOEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635077; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVPKaNc8DJ0VYNNrtDdU3qs1HatVcfSFpAvTk7WcgMrpXrWdfRkGIl1GeoXME4Twlpooit8VukODODVFgJsMx9CbXcjSp1ebTAFRxAF7KTW6e+/gGuqsjGXqoG5HdNFlD+pFhsrPi6UnRDO0DBt5VoLjr7DL4TJ3x/GajKjD46Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0WqWBsb4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0WqWBsb4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=0WqWBsb4wOY3z+1H9hPz45EJnT
	eLm8H6aaZDu+7tKj9LYnB+4QEhXunePug4pojsejT0erWU2o9PXYHn8jQ5cvDhvoyXQKqAj1RH9Xy
	BIE5O/yBdbCeisqhsnWdE373XVGFiu7OX5s0trwBwUuJXXe3cwQGlsMNv+ew3gidh6b30GbK8/Mst
	UrRB+uqoj+E6jDZ/5cWAsjc+/JSlvM3grFQ50iaNkZRTf06hu1KIrxP4FQGeUJrTTy8j9KLdwarDF
	wK93n+nX5v9JXwsKpCMPjNcOsYQRM8B6pFl3zp/Ik2Paib8zQC0bor+OJUBepVVbhcwjF5uP43jWg
	OEZzhMhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1szAws-0000000FgK5-39n5;
	Fri, 11 Oct 2024 08:24:34 +0000
Date: Fri, 11 Oct 2024 01:24:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: linux@treblig.org
Cc: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, axboe@kernel.dk,
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drbd: Remove unused conn_lowest_minor
Message-ID: <ZwjgwtjPT7IV3XAs@infradead.org>
References: <20241010204426.277535-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010204426.277535-1-linux@treblig.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

