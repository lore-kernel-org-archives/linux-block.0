Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279602;
	b=Bkzyj2NxxFUpTpzcwoJqavsBa4JvJCb52GL3Ateqyl/mf+qYODwnVoWoZm6rEBxaAQJb
	 KaDAkGfCTvFklAb07ug/kLXQCWAQ5Owt5fgQ+q8y+nGEfMQ717L1GDAqwjknA12Xc2ALR
	 Lg96nczGU/qSfAKVzQHLWzsADzglbVOjywExJ31IPc2b+yU39ukaRwQj9ySvErgd3ahFq
	 HV39AdymIhUwTiFZ4JVjUjogY3KxAD1lP9bpR2Meh3TDPI7qDaiUCiWYN9En9vC9Vns6F
	 SblLNIW34D9ldiziPtiTncgdem+Jh3TZJO7ftzlPnvnlJ4r+yqJHG9ShIOJSPNw+TGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279602;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=MbcNtzL9jFzWwwQyF2H3GKoW1/nFmh1r+H1zQwxMak4=;
	b=lkReEFr2O9pKLIV2+ei7Sen0PAHn54Ri39vfLqwHfOQ/TX5YhZ6RTzefj1teegLi4a8R
	 SzsANy90Kn4cx+k8yIplpwZDkPZcZTJXlTfIaDSbr1W1FFFm1RsqhJ+UGJN7qwY7H6By5
	 tdvRYQvC1SD6mFzHaULP6754LJQPGZcgHkcolet/peiB46JSq6QCdrxMrAceSIveKn6Xf
	 676Wap4BW7dul8pTq/MnMi2xGxUZ77Ke2GapLcGegvGJWqUs/LPCEwokuYbO94NodfVHr
	 1ZOXVpsHcXTIqHObNOngq7FFM75QWxeVLu3MnIVj+I/Xwp2Xo54327guVHMecpiHCQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IP4ueGtc;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CC9606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 13:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30CC9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IP4ueGtc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MbcNtzL9jFzWwwQyF2H3GKoW1/nFmh1r+H1zQwxMak4=; b=IP4ueGtcjwy/7T3kjMw0jF4E9j
	mgnY0Dcxju1ekhbnRAgwqqedOXSFNAK9BV0wlhkXEWPC1Nv05O+WGrZgpT4w6Bk6ZehJDDqbpoT1U
	dM/vWteOTZdpKEhMNKXOYJCltltWs3frJCdcWaKVUS3OIVCaDLSKz6Vb6yME0NortjQohH/twW09K
	c64FIT+CM0kjCv+0rpck6XU79M91tW35R6HfR7vv4FwCkxmnBRnQVdM3iFlHiF8JU0E9cVdWnx4un
	GqGKEn9NxSrKGYFOGmn5L89c+mVpUqA9aLo/uaOvERF2nVfSoU7iyOn2xILVFzWa50XNClM878kFW
	BbzNQQhw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPwX-00000009JTJ-33lk;
	Thu, 29 Oct 2026 13:13:21 +0000
Date: Thu, 29 Oct 2026 06:13:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 44/98] block: apply the segment size to the integrity
 buffer
Message-ID: <auNGcfDMeggXW1M1@infradead.org>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-45-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028164415.1262013-45-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 28, 2026 at 10:41:47AM -0600, Jens Axboe wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> The integrity buffer is a single segment and must not exceed
> max_segment_size. max_integrity_io_size() applies that limit to the data
> size instead, which is off by a factor of 64 for 8 bytes of PI per 512
> bytes of data. A SCSI host that doesn't set a maximum segment size gets
> 64KiB, lpfc and qla2xxx among them, so a DIX disk behind one of those
> does no IO above 64KiB.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

