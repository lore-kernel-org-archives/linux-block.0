Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD01A3EE1FD
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289672; cv=none; b=KfhfGwMLcJ4R0XNKLmcaXd7+U/WmhEU5KK3HNodld6MVoxVPwY8i4EM2SKxrQuFAj9DBnwc5F9ofp4rt/5/f++KnDNbM84qV7d2ve6/XBNL4zdks07Zdc6jJeVfumabKL9/dNxpvuuGfBsztxTS1Z7mWJqnKMbCMg+AQke7rHcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289672; c=relaxed/simple;
	bh=T45+ITuGycMs1FD2QyVsalQe29yM+1XXtMPeU+HAl9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnPARidq1VBnbbgF7JQ0izVFx6OoiLLk4OrZwOZk86pSKycXBz9MuhjogNdsHpPDEkZTXmAykNoTOz/qGi2LfdVZIiE6llUPO3AhdVkWXYkemRyZK1vzpZupbpB+hMoL1W7AMu3K/8VFSYTOYMNWp7Mbxk5PLjdMUnKWBflZ8KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9s7TLcW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9s7TLcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D551F000E9;
	Wed, 20 May 2026 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779289671;
	bh=T45+ITuGycMs1FD2QyVsalQe29yM+1XXtMPeU+HAl9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b9s7TLcWnSjFzaGVGi5BPYO/oGSLu4+c3z4MEh55zX9F7aKiJa9qeNU6F+W6NpDDq
	 5kICPbiaLOrnH7Y0462st1tCLeMmmwk1w32e3VeFeDK/xqwjgIsIhMq9Z76d+uH5Yl
	 nDpIpTOFfVpMUW6LKXTxm8fowbezf/A4cKaWa9vdLSsdClobZL6uwC/d+O36zEc2Ie
	 FW3zxtdF3YYor/kSuwRSLr/oYH50kD6Njd2nsLkAWPsl7hYBvxY1gxWlNf5vgHooqI
	 YQV00w+mh8SQJnmV/zechlNShA4HfHPFxGIfj2+1UttrduOTSfxlObS9T0NTgPT0X6
	 9z+YvhGCydU1Q==
Date: Wed, 20 May 2026 09:07:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	tom.leiming@gmail.com, coshi036@gmail.com, Igor.Achkinazi@dell.com,
	dlemoal@kernel.org
Subject: Re: [PATCH RFC 5/5] block, nvme: add failed_bio callback for
 multipath bio failover
Message-ID: <ag3ORafKCTyn7TBA@kbusch-mbp>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-6-kbusch@meta.com>
 <20260520072746.GD14937@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520072746.GD14937@lst.de>

On Wed, May 20, 2026 at 09:27:46AM +0200, Christoph Hellwig wrote:
> On Tue, May 19, 2026 at 10:23:26AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> >
> > The nvme driver has long utilized a zero capacity to indicate the path
> > isn't reachable, which creates a race condition with IO dispatch when
> > paths are being detached on a live system: when the block layer rejects
> > a bio early due to a capacity check failure, drivers with multipath
> > support using the original bio have no interception point to redirect
> > the bio to another path.
>
> Trying to reverse-engineer - the problem is that the block-layer
> code catches being beyond the capacity and directly completes the bio,
> right?

Yes, and in the case being addressed here, the "zero capacity" setting
is path specific, hence the driver wants to attempt a failover. I
imagine general capacity violations are not path specific though, so
this is kind of a weird case.

> IMHO the right fix is to get rid of the capacity hacks, and have a flag
> we can catch in the nvme driver and complete through the mechanisms.

Sure. I think we can at least remove the unconditional set_capacity(0)
from the nvme driver because the block layer generically does that if
we've done a surprise removal on the namespace's disk.

As to removing the hack from the block layer too, it's been a while, but
I recall it was the easiest way to get forward progress for some
degenerate case of continuously attempting to sync dirty pages. But
maybe we don't need it anymore: it looks like there are more checks on
the GD_DEAD that might make that whole capacity trick unnecessary. I'll
try to whip up a quick test to verify.
