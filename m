Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E025486F
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932215; cv=none; b=jcqha87N6JL36zxO9qEeePOasPOTM4ce7oFH8Bd21gmgb/SJqhZm1vAGdpQpBnmqts4pRikAutcVtb2GXqPyYkHRiGp+wnwlstntxsCcwhSpapMqpCChGyRNQg/vgaoFiDAkurXGM10ufV30jHgejfbPxhis+3R3vdbwNZ0f2nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932215; c=relaxed/simple;
	bh=Q/3Q+MOrCjOHubqJCo/KOw2SeyxZyWfokxhGYpVBieg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eydCVP9sS3Lz91p7Q7zA5dwEcW/xE2wNuKBPuXR3JTWKRBeaMlLHH3pTWXEaqZeqoGIY5d5+eazvgmcAyR+vF4lXzM/lpYFeQpdS63KTM3bDhUCrkoxjFLAyVdZwWOCeK2xq0fDUOFJ5cK2qmSPIytDvJpNEPbhUP7etY1b0I1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQXKds6E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQXKds6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD801C4CEE4;
	Thu, 22 May 2025 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747932215;
	bh=Q/3Q+MOrCjOHubqJCo/KOw2SeyxZyWfokxhGYpVBieg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQXKds6EEYQ3AjvbWMbUCgZv21WbhJPGRsWAdTSEb6WFHnZ0t5gX6GkV6tGTAUUbU
	 cNp+p0LKHE+m4XjrcFFIiXr6oGjiwAQJ9b7Y0C9KreLOO0doHJDQmUNAtB/NxY2aPF
	 niZGTfu983iJ1iHWEGziGkR3/cyzW22k99mZEyDHb83JfMJ1dahJP8gBkO9YnCP0F9
	 BMAnBhePn5cUYdoYZJNbSCa02C5GVsTiJRtiX9Kw/cxqMCkr+C2G4hfLKzcsn5zkhI
	 OxxIGwB8y4ndteFfDXf9AaKApP1nf0bGUjfBY4qp3+GQluB1LHp44iqiIrrggc1I41
	 v5tjdCtgyBDTg==
Date: Thu, 22 May 2025 10:43:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aC9UNDRpy7KraJCz@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <dc0206b7-1224-409f-960c-11549722482f@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc0206b7-1224-409f-960c-11549722482f@suse.de>

On Thu, May 22, 2025 at 12:02:07PM +0200, Hannes Reinecke wrote:
> > +/**
> > + * blkdev_copy - copy source sectors to a destination on the same block device
> > + * @dst_sector:	start sector of the destination to copy to
> > + * @src_sector:	start sector of the source to copy from
> > + * @nr_sects:	number of sectors to copy
> > + * @gfp:	allocation flags to use
> > + */
> > +int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
> > +		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
> > +{
> 
> Hmm. This interface is for copies _within_ the same bdev only.
> Shouldn't we rather expand it to have _two_ bdev arguments to
> eventually handle copies between bdevs?
> In the end the function itself wouldn't change...

Sure. To start, I think it could just fallback to the non-offloaded
instrumented "copy" path if you have two different bdevs. Utilizing copy
offload across multiple devices is a bit more complex, so I'm focusing
on simple copy for now, but want to leave it flexible enough for such
future enhancements too.
