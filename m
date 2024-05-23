Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A813B2BB
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716448575; cv=none; b=Sw9Wg9r6/9OLtycizzjuhXn8bSmvigmQC4fW1bmn5pNZofWYRC/37cUt543Xqtkyf8vfwgLUZ2eAc97UDcHbvx1qOauKtI2xs/ErdVsiJUmTvnu+PehhaC9otq23NF5WrFPYRq3/rhcOCLBjSl6r9KbthS5ck5tuQskJHKK7kSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716448575; c=relaxed/simple;
	bh=BN9MjZaP8RkuvpKJyJ1NVDl1a7V68AtkrBSyT09IlzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYFxcQ2IVMrjeR6w7MbnHDZFR5sTllQcEBrJnEfN20hjX4KftBbtMBUtFKvG7Xuf9tC5kE6LwdXs7CCTTw4cHCPiO6gwNgGdQ1zN2Vm1bEP451mZvjruGNf3O9+bqR+a713fvbdn4U1cXWmKfggfasg+AkRBM5VpNE2qkGSdN78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D4A3E68BFE; Thu, 23 May 2024 09:16:08 +0200 (CEST)
Date: Thu, 23 May 2024 09:16:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	Ewan Milne <emilne@redhat.com>
Subject: Re: dm: retain stacked max_sectors when setting queue_limits
Message-ID: <20240523071608.GA29651@lst.de>
References: <20240522025117.75568-1-snitzer@kernel.org> <20240522142458.GB7502@lst.de> <Zk4h-6f2M0XmraJV@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk4h-6f2M0XmraJV@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 22, 2024 at 12:48:59PM -0400, Mike Snitzer wrote:
> On Wed, May 22, 2024 at 04:24:58PM +0200, Christoph Hellwig wrote:
> > On Tue, May 21, 2024 at 10:51:17PM -0400, Mike Snitzer wrote:
> > > Otherwise, blk_validate_limits() will throw-away the max_sectors that
> > > was stacked from underlying device(s). In doing so it can set a
> > > max_sectors limit that violates underlying device limits.
> > 
> > Hmm, yes it sort of is "throwing the limit away", but it really
> > recalculates it from max_hw_sectors, max_dev_sectors and user_max_sectors.
> 
> Yes, but it needs to do that recalculation at each level of a stacked
> device.  And then we need to combine them via blk_stack_limits() -- as
> is done with the various limits stacking loops in
> drivers/md/dm-table.c:dm_calculate_queue_limits
> 
> > > This caused dm-multipath IO failures like the following because the
> > > underlying devices' max_sectors were stacked up to be 1024, yet
> > > blk_validate_limits() defaulted max_sectors to BLK_DEF_MAX_SECTORS_CAP
> > > (2560):
> > 
> > I suspect the problem is that SCSI messed directly with max_sectors instead
> > and ignores max_user_sectors (and really shouldn't touch either, but that's
> > a separate discussion).  Can you try the patch below and maybe also provide
> > the sysfs output for max_sectors_kb and max_hw_sectors_kb for all involved
> > devices?
> 
> FYI, you can easily reproduce with:

Running this (with your suggested edits) on Linus' current tree
(commit c760b3725e52403dc1b28644fb09c47a83cacea6) doesn't show any
failure even after dozens of runs.  What am I doing wrong?

