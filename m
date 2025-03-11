Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B400F1386DA
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679759; cv=none; b=OATZVPEZUywKUBf7zCLkBJ+/qbTJXm+xvfhw67LF9jShT3q3ES/+CbQbz8HXEecMLG/XXTfE9jbJ69CghjC5qIcSbYFtff/dRGjy4imuuIz77E/WF5WzMdBpDnWWtVCcDj2wr5Xpc9y/RLU3iN0XaxMs/7CyWZxNEGCnOc79rq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679759; c=relaxed/simple;
	bh=Okq+1v9NEdPKwOb3O215R2+MStexhrZ3oYXLvvutfSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=goGZvBcXTvYDZThp9i+TS3DYOrNwJbj4gU0zQZm4wwQgb8ZqvCSJ4vGNOf4od0Hi9k2w8A4rJxxm8ZX8zmR+f3rHyQu+A8Uem25rPdhP2Ee4H4wHbjXErYacSbqi0//6GjTEmC/z+CQ7QdE3jfNrfk+Myur9ZENGg+xO0Gj4ZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MsNtWFor; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MsNtWFor"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OBcIZcRrYFb3+twY7RF1QjKLEnz41Q/mw1744q6rvd0=; b=MsNtWForzMwOLRdRV2CtOH1Xrc
	ZlfgKOs5yGtTwd86O6Vb+DeEjNTGwnaqlXGvCFgnS0/nifsLJ9bgsUv4fm6lhlHug7DS2QYqN2unA
	E22iUBxFKOuOHrw9B0D/s/BwaKOQkv/EaUaGhG40mMCd6lNizFOq2m4QIGiWgvQ4bCxSC161h+wrc
	DxpGRliNp6jz8bcnKV13BB/XKRO5lTc9pT7zHkt+F0VBdHsEZS5PTz4bflOk5bhpQBYyTN9CIZFWX
	uAN6jAL6i7CxtNuruZmOMEafX1dmu8kuKf9eaToVa+C21jw59aQ89LJI5D+yHjrEnlrkO9OgBjB+5
	Ga5kMAtA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1truSz-00000004vEl-1ZZz;
	Tue, 11 Mar 2025 07:55:57 +0000
Date: Tue, 11 Mar 2025 00:55:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [RESEND PATCH 3/5] loop: add helper loop_queue_work_prep
Message-ID: <Z8_sjelbOZ3KjeUH@infradead.org>
References: <20250308162312.1640828-1-ming.lei@redhat.com>
 <20250308162312.1640828-4-ming.lei@redhat.com>
 <Z87I2C-J6YxojQ6h@infradead.org>
 <Z8-QCgotmHgsGNWB@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8-QCgotmHgsGNWB@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 11, 2025 at 09:21:14AM +0800, Ming Lei wrote:
> On Mon, Mar 10, 2025 at 12:11:20PM +0100, Christoph Hellwig wrote:
> > On Sun, Mar 09, 2025 at 12:23:07AM +0800, Ming Lei wrote:
> > > Add helper loop_queue_work_prep() for making loop_queue_rq() more
> > > readable.
> > 
> > Looking at this and the finaly result I don't really see any advantage
> > over just moving the code into loop_queue_work.
> 
> loop_queue_work() is required for handling -EAGAIN, that is why I move
> loop_queue_work_prep() into loop_queue_work().

Yes, but please just add the code directly to loop_queue_work instead
of adding a not very clearly defined helper.

