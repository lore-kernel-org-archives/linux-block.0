Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBA120315
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ALzy8dSx"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA93330D4
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 06:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ylkufeqxm4jQvedkx6BSkxTX3XMPV2p3Lflhm9zUwWI=; b=ALzy8dSx42pmFjFCkkNIScbt1z
	YPr+QimZDgQchZODX6/qkUVSgN3a+bH1t+3raXq1C/TUJXuHnMBWGc1kWGom1xlFODWg4T6/kfjOl
	c7ix99m82fCLcknZ2FviEouQkHe2xaNjTijfKTwm/A+sJ8gL/WitGZRIpBK6lEto3P/NpC4HMXeEh
	8pmwafd3lQ3QkbtP0p/Q19DmaOPOMdiJMa5E2g1u6cEkqruR3vqtNhqCmn0OwxyyxbaO5nhLTIj1I
	tFbBSO0iJF3TnGyXXK/9Do94NJEFNFZgSrXN0Cfmh0lFysdH91SwH2OM2ZA+bIzM6nWzc/f92Ped9
	iED65VYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r166x-006VSJ-03;
	Thu, 09 Nov 2023 14:34:23 +0000
Date: Thu, 9 Nov 2023 06:34:22 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] blk-mq: make sure active queue usage is held for
 bio_integrity_prep()
Message-ID: <ZUzt7hHEl7SPB9oY@infradead.org>
References: <20231108080504.2144952-1-ming.lei@redhat.com>
 <ZUyKggKLWnaZMRr7@infradead.org>
 <ZUyUSBrp+K5pPLPy@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUyUSBrp+K5pPLPy@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 09, 2023 at 04:11:52PM +0800, Ming Lei wrote:
> > >  	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
> > > -		goto queue_exit;
> > > +		return NULL;
> > >  
> > >  	rq_qos_throttle(q, bio);
> > 
> > For clarity splitting this out might be a bit more readable.
> 
> I'd rather not do too many things in single fix, which need backport,
> but I am fine to do it in following cleanup.

The resulting diff is smaller..

