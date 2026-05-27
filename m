Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96DD322B72
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890673; cv=none; b=i0hZE/fRXPD/gU2OdMhRdzaS9dnNJtizZZawdJMfUgXYYLtDALZNlwGlhCGBaUEer3SvcwjPJpgY3C8zwVgUMm3O0dmCFSGvU/aTD/USXpn++KxcKHZIOMkodvxcSWw63cAGIOlbreoerngSK4Z1/3NodaWfTEl3kKHimbNdFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890673; c=relaxed/simple;
	bh=DWrr03LvbO8D8qepMo/3tnL7A7Kf9TEGWsziEGI3/w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT3oUT85tXjPfFvi67XYjnluNVL1FiOjjmAlInYUKzaJY1VFmbLqBFeLZ/KT9+KeuiGi/XnA1vqXprmolzNuPJ4zrxlgivAZJYCWAmgaaHyspejarx6FGjdzgxX0YuooLn6H0O7PpbEbmyaEHTE56ca4ZBHCHPHCxb5hbv2zzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CCB9968BEB; Wed, 27 May 2026 16:04:27 +0200 (CEST)
Date: Wed, 27 May 2026 16:04:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, tom.leiming@gmail.com, coshi036@gmail.com,
	Igor.Achkinazi@dell.com, dlemoal@kernel.org
Subject: Re: [PATCH RFC 5/5] block, nvme: add failed_bio callback for
 multipath bio failover
Message-ID: <20260527140427.GA12705@lst.de>
References: <20260519172326.3462354-1-kbusch@meta.com> <20260519172326.3462354-6-kbusch@meta.com> <20260520072746.GD14937@lst.de> <ag3ORafKCTyn7TBA@kbusch-mbp> <ag3Sweie8nWMpmqq@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag3Sweie8nWMpmqq@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

Sorry for the late reply, took me a bit to catch up after conference
travel last week and a public holiday on Monday.

On Wed, May 20, 2026 at 09:26:57AM -0600, Keith Busch wrote:
> > Yes, and in the case being addressed here, the "zero capacity" setting
> > is path specific, hence the driver wants to attempt a failover. I
> > imagine general capacity violations are not path specific though, so
> > this is kind of a weird case.
> 
> Oh, and it's not just the zero capacity IO error that multipath wants to
> hanlde. It's also that we've marked the path's disk dead, so there's a
> race if bio_queue_enter() will call bio_io_error() that this patch
> handles. I should have mentioned that case too, which wasn't handled
> with the BIO_REMAPPED flag suggestion.

Well, how do we know the bio actually is owned by the driver?  Callers
both in file systems and remapping block drivers can call bio_io_error
before calling into the driver that owns bi_bdev.

I guess we'd need some flag to desіgnate it is owned by the driver,
and bio_set_dev would have to clear it.

Alternatively we could pas a bdev to bio_submit* and only update
bi_bdev just before the bio is passed to the driver.  Given that
the idea to set the bdev at allocation time didn't work out this
might be sensible, but it will cause a lot of churn.
