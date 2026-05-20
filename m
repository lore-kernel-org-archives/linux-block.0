Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF93F1AAA
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289146; cv=none; b=tD5/UxVgxEqkz2tnjxs5YZPDlMyhd9WsZdElptJvm3Z5S7Jz9AO0Z2k6L7/PVhPvx1SlIZPInj2i0gry6xEE1Sm3emflfA773KaWmTT4kUcBlw3t1mFW+yAraThN/2TtedaAJNSOCwsK3TSUO/jVlSrIv184cTCz1p85497eoiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289146; c=relaxed/simple;
	bh=CtHjJh7+ktTrRO9Ir0V3TkF9kUm7XUmJtJUTrWK4ddg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuiuyrL/H2l+eMoB2TiviJ1msTcGWdV045ylp2Hn5REUKqN2vut4J66o/Ivj+trCMgbb8UAj3o8Pb+JexEOEl/+R3zdTAyEoVqYtltrp4sT7AwvZQ7L3A/w7b+F2qOLTPhW4SHi5YfSYzrJLeIiA9OOPw4xwhhfZ7hK5IBRM67Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBjmtVNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBjmtVNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF5E1F00893;
	Wed, 20 May 2026 14:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779289144;
	bh=jTt7bRJ0RoisONgOMkbEnwIOzCX0q+oug3Ww1t2/cD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZBjmtVNyv+hp/3TJNKb0yXb0oZyil5ks/tQRpv0KVNPpamr6AkVQmSth9kbq/qsu2
	 hwM1Nu6UYeIzdWCod6UD4wfXoYKwFsWNj1CWznxcMhM9Aoj2S/DJfb1QAwhw+/rcgF
	 pMRbaaYK8XIDv2eQDHWVsT+pLBAnLc/2oilXxyRWS0WjTKNvdrn5sRUU1GBdUTl/jb
	 9m7fjn1ufZ/kBVjhpVUtNshEPDrMKKZx0VDzBulHHM+6xqOJXXUsO4qiE5MA1v5tJX
	 nkvb+4wVviXuWyTuIMGX3zKfNwjzSAXVuU/KXakxXSJ+ECmnn/y8KX0BclZYtJu2y3
	 ZmKuo6gkONJdg==
Date: Wed, 20 May 2026 08:59:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: always take a queue reference in
 blk_mq_submit_bio
Message-ID: <ag3MNow98qL7Eewi@kbusch-mbp>
References: <20260520084905.1092158-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520084905.1092158-1-hch@lst.de>

On Wed, May 20, 2026 at 10:49:05AM +0200, Christoph Hellwig wrote:
> When submitting a bio to blk-mq, if the task should sleep after peeking
> a cached request, but before it pops it, the plug flushes and calls
> blk_mq_free_plug_rqs, freeing the cached_rqs. This creates a
> use-after-free bug.
> 
> Fix this by alway grabbing a queue usage reference in blk_mq_submit_bio.
> While past commit claims that this is slow, we're better safe than
> fast as a first priority.
> 
> The code had already warned of this possibility, and specifically popped
> the request before other known blocking calls, but it didn't handle a
> blocking GFP_NOIO alloc. Under memory pressure, allocating the split bio
> or the integrity payload are two such cases that can block. The blk-mq
> submit_bio function continues using the peeked request that was already
> freed and re-initialized, so the driver receives that request with a
> NULL'ed mq_hctx, and inevitably panics.

Thanks, this looks good to me!

Reviewed-by: Keith Busch <kbusch@kernel.org>
