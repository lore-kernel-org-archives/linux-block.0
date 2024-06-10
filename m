Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2112FB1A;
	Mon, 10 Jun 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028885; cv=none; b=ihzA48LM20ZNr6tAz9GDx7/E/7bpxticJObWjyvfEqQ+NPGYBzzSQsJVxfXR57h81se3bu8AepPPKwsn+nD5adi8PzmA/StK9xyvWy9+t+LsZKEReSqhql3twuIXiLOqUyJCA2e055X3grkrYMS0sqamAa2n1wkdR3z8nTTifWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028885; c=relaxed/simple;
	bh=FD5N5uRHdIwTmFxwbE42FcAyZnfdFcanXBD2EDz7GFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mgx+KIFayO5zqBbDeP+O7OZxDkPBhfo7c3wW87fYmU9IGfxmaUBVkQmKvAfSpCRF/PvQ2RlzDvDq8SsS9Z/rMTRU+8c4r1Gw9Ibw5hjQJ9jOYyBAPb/N90xxQyDPi8Uop6hjE1pYljO7X4MaIvTfV0OgtWBMNKph1GhaeWJQSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PW4DWXpr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PW4DWXpr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rE4tFE9CZ/+gRbB9ULW6+AF11oW7AZsnF8V1vYN9wWw=; b=PW4DWXprY5eszna0+c4qSpHEfH
	7bFkB/WIKlc5w4yHHRKOgCsOwmrBX2ssM9AbwjZimMgt1MHq+Y0L31L83GmpXBelMLuxyQDvr5sEY
	HZfCEysvvK9X2nm8MKc1voW7mIZw9uh8tscXEZPyGQxahtbORCUyvF4iRFgi7eZpfJJ2UX/79MzH4
	FQbcyk4TIZFD56CN1Tr2Fm95MoCN/0fkKAdDeleXxvJHZIqI7+eA11pS2FhAyhmZO5NoGYJR7NdYS
	m7uXox63OMoM/WPiC3iiQ0WJnxf20NZhKdii3BEEkO5cOXmBGbhzn1nyMTsMgbTGdJaB/z1zxZ7w8
	RUTmr72Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGfnH-00000005NB2-01jE;
	Mon, 10 Jun 2024 14:14:43 +0000
Date: Mon, 10 Jun 2024 07:14:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] loop: Disable fallocate() zero and discard if not
 supported
Message-ID: <ZmcKUgJXc9MOLvqj@infradead.org>
References: <20240607091555.2504-1-chrubis@suse.cz>
 <ZmPvNu-YijbtJkeR@infradead.org>
 <ZmcKA3zHsOYlyaiq@yuki>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmcKA3zHsOYlyaiq@yuki>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 10, 2024 at 04:13:23PM +0200, Cyril Hrubis wrote:
> Do we need noinline attribute for the function as well or unlikely() in
> the if condition?

unlikely sounds like the right thing here.

> > (and maybe one day we figure out a way for the file system to
> > advertise what fallocate modes it actually supports..)
> 
> One of my ideas was to try fallocate() with zero size in the
> loop_reconfigure_limits() to see if we get EOPNOTSUPP but for that to
> work we would have to make sure that we do not bail early on zero size
> in the vfs layer...

And the VFS layer doesn't know, it has to go all the way into the
file system..

