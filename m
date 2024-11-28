Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FEDAD4B
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 05:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732771003; cv=none; b=u/4qPBRAsnWEfaDy+nyVRMw+mjCbnXSrCQToqpZI5pgA7pzAWKnKC2cDHPMamdp6JaSaEdGmNbfpopRBvxHJ49bRZ9GmeRws+mgrLXZoWd9zitcoHX/lCEuujhcWjh2JP2L4hmKUwxkRY3LmDRA+ljPwRZV5HkpRFZZ/bgRZ1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732771003; c=relaxed/simple;
	bh=hmnhN9dUUPhpcIKiy3ajz37CSjhCPA1aTSAi857dV5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coc+5IO7v5ex7R/C4wDOh2nNiPsswxIdiLOBk/7arciG8BVn6buYeKzRwh+7pr8bNKKp+L2gnRQqFtYvIgHDBYi5r7mZsm0k/M3+W+U754RW2L7HyGpLwnG+41e9cbDzV0Rw7RT6NZK18+45KfveGaoOUgyWlluJHsY0HhVAj1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KIYLZiio; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KIYLZiio"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/orDizsjXiYL2N6FdplNMTSTsRADJy6AGwK5VkHT8dk=; b=KIYLZiiov30hxcKnUzqNP/uKqu
	h8n9NlqB0pQRMHRzpOVyLwqspruRY0/dirfyUY+46k8jB6tFtikgi11J5FND1/i42Ap47JMRsR37i
	QR+feeWN/r7ZJZWMJvXXbCMnbxjDrPPmFtWWI3BOTxcD5czhTwTKa5Um2v71aNkauGuP8q/F0q53y
	wQi3uUC3MNWDYo43jWU8sqjKaDex+uEJhWzPS4pHYl1bhMMpHEcYB9k+rIWH3fcibLrQVGG5y6UX9
	V8keHJ7a7qBFx6Vwc+N0Mla5m5JrnwgL1kyl39jsKMribqFiIl520ZuSA1u0m6bHQGK1IPrrePd50
	NVK5I/Rg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGWtM-0000000EipX-1chh;
	Thu, 28 Nov 2024 05:16:40 +0000
Date: Wed, 27 Nov 2024 21:16:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Subject: Re: [blktests] zbd/012: Test requeuing of zoned writes and queue
 freezing
Message-ID: <Z0f8uAFz5C60fung@infradead.org>
References: <Z0bfKNMKhLkEHusz@infradead.org>
 <3bc57ef3-4916-4bcf-ac1a-9efed89fc102@kernel.org>
 <Z0dPn46YnLaYQcSP@infradead.org>
 <2b7afce4-fa13-47b6-a3ed-722e0c11e79f@kernel.org>
 <Z0fhc8i-IbxY6pQr@infradead.org>
 <16e543dd-c4e6-4f79-b401-8030d7ba1514@kernel.org>
 <Z0f0B6Xf-jdc_fx-@infradead.org>
 <43c0f15e-7f3b-4ed9-bde9-dca2cff57afa@kernel.org>
 <Z0f47wft_sVto7pM@infradead.org>
 <a9ad27f7-b799-4322-ba05-944abfc0fa88@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9ad27f7-b799-4322-ba05-944abfc0fa88@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 28, 2024 at 02:07:58PM +0900, Damien Le Moal wrote:
> A bad sector that gets remapped when overwritten is probably the most common,
> and maybe the only one. I need to check again, but I think that for this case,
> the scsi stack retries the reminder of a torn write so we probably do not even
> see it in practice, unless the sector/zone is really dead and cannot be
> recovered. But in that case, no matter what we do, that zone would not be
> writable anymore.

Yes, all retryable errors should be handled by the drivers.  NVMe makes
this very clear with the DNR bit, while SCSI deals with this on a more
ad-hoc basis by looking at the sense codes.  So by the time a write error
bubbles up to the file systems I do not expect the device to ever
recover from it.  Maybe with some kind of dynamic depop in the future
where we drop just that zone, but otherwise we're very much done.

> Still trying to see if I can have some sort of synchronization between incoming
> writes and zone wp update to avoid relying on the user doing a report zones.
> That would ensure that emulated zone append always work like the real command.

I think we're much better off leaving that to the submitter, because
it better have a really good reason to resubmit a write to the zone.
We'll just need to properly document the assumptions.

