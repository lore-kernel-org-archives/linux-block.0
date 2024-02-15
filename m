Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024D12B87
	for <linux-block@vger.kernel.org>; Thu, 15 Feb 2024 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984367; cv=none; b=PqpE/jEoMWQCCgNsljRhxoeBhnoT2AXdR+E+07Ld4dtpTFGTucrct/dr35Us6uCZwekv5rIe2k9WByhkpWJTJWC//IduXdywdQwWRifIbZgHEdyn2Mpe8l+M8CEPb/HYptZQorIRe0y8DVV6Iyfnop5VEgPDSBrGe5LH5iMK0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984367; c=relaxed/simple;
	bh=Cb8e+ErhMeh4l+EkhTl8Vjm5cyC98ZMjd61DkNCcY+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZR2ogFaR38N4NzdMde8nwwfk2s5VAqryLpkxBVHhHIRcqTo+/k/1Nn2RVwIjv4dX002+teASP4qoeWMzHA9rDsw+WoIECcsoRePNHw31gmidJPg1qBz44aCcZtZNz4IkX71TvG4tV5EzEqOE8Qq8SgN8UM6pCFeKP3R8hojDX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 829C668AFE; Thu, 15 Feb 2024 09:05:55 +0100 (CET)
Date: Thu, 15 Feb 2024 09:05:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] null_blk: remove the bio based I/O path
Message-ID: <20240215080555.GA10997@lst.de>
References: <20240214095501.1883819-1-hch@lst.de> <20240214095501.1883819-2-hch@lst.de> <Zcz3pd3A09dJScHH@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcz3pd3A09dJScHH@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 14, 2024 at 10:25:57AM -0700, Keith Busch wrote:
> On Wed, Feb 14, 2024 at 10:54:57AM +0100, Christoph Hellwig wrote:
> > @@ -2036,11 +1813,15 @@ static int null_validate_conf(struct nullb_device *dev)
> >  		pr_err("legacy IO path is no longer available\n");
> >  		return -EINVAL;
> >  	}
> > +	if (dev->queue_mode == NULL_Q_BIO) {
> > +		pr_err("BIO-based IO path is no longer available, using blk-mq instead.\n");
> > +		dev->queue_mode = NULL_Q_MQ;
> > +	}
> 
> Seems pointless to keep dev->queue_mode around if only one value is
> valid.
> 
> Instead of checking the param here once per device, could we do it just
> once for the module in null_set_queue_mode()?

Maybe.  Note that the code would have to be quite a bit more complex
than this - not only due to configfs as noted by Damien, but also
because NULL_Q_BIO isn't rejected but simply ignored to not break
blktests.  I can look at this at parsing time, but my gut feeling
is that it's not worth the effort.

