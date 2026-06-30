Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5297382F35
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 05:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782796361; cv=none; b=ZeEugkYLhBDohbdGTfTD6bne8ffBlthoTbr47PChCig0JOshg2hZoXJTcdov7PgfxPdO6CG+tBRfqNVq6e5EMoJAs4Yq0c54hPLxzSXLyxV3pg02bnMDQ2gvdAQDamuV3/l17sRC+IyyUeImtwU+GUo71sF7QwAXOPwmD7o1Nmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782796361; c=relaxed/simple;
	bh=7svnU0tyl7+xpPVau1xWGc0tkKoJ3gmYvnl3xnMiVkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnFRL+Tprh3/rLS+Y/1ZMyKhMMhrjruh6oBzYLRnfHF01I119EZL1cIfHEdPnXPIhBFjPx8k54draWwFOOUtYEdgecGOc0J5yrnf49b/OP9WOJ/KDM+gT4SiOPwFJ8hyF8pQJRSmHmAjA/QLFmvqs2SAoDe30Vvuq4ngtct68u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6376F68C4E; Tue, 30 Jun 2026 07:12:35 +0200 (CEST)
Date: Tue, 30 Jun 2026 07:12:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: avoid potential deadlock on zone revalidation
 failure
Message-ID: <20260630051235.GA20771@lst.de>
References: <20260625062824.2013244-1-dlemoal@kernel.org> <20260625115232.GC18076@lst.de> <535959f9-b6fc-475e-b5e7-99b0dae839a4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <535959f9-b6fc-475e-b5e7-99b0dae839a4@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

> I checked and this is not simple to do because most drivers (null_blk, zloop,
> ublk, virtio_blk, DM and nvme) call blk_revalidate_disk_zones() *before* calling
> add_disk(). Which makes sense as we really want to check everything before the
> disk is visible to the user. SCSI sd is an exception here.
> 
> And I do not see a better way without the addition of something like a new
> disk_create_one_resources() that all drivers would need to call.

Ok, then let's do this simple version:

Reviewed-by: Christoph Hellwig <hch@lst.de>

