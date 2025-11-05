Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8216343D90
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372312; cv=none; b=QrVOJWsOIybgXmhymDvXa+q0Xzvb+f4sZ47FJt1Vs1xpkLcsb3OwpsI2JBHqkYb+IqW4eF6H7vLDQrrzaxOPbyvotafVhggaxYHS10J+ZdH3nyxMVNnCMY7a9xzXbX3SFfe/299llNlpbVOuol8q0Q+3mPTOSQL+bOMNvHmvxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372312; c=relaxed/simple;
	bh=7UDQ4lGRbgdF1bySbAAzvr4rbLtp6BEFsyYsLzXC8H0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ft0V8nd0k7scyGsjVVoyufs5R7lNQ1Guw88zCwGKMCTbuG85UBotfuSbN/7CulxW/c+AVwSUqGKjomv1oyCA3442SeFxbHJVeDip9KiDmZaT0MeMRhg6bBOmtWfkfDR3RGyVkmmP8IuGku0kc7Y7NGQX0Cynw4a238G/zMQTwyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 37FB4227A87; Wed,  5 Nov 2025 20:51:46 +0100 (CET)
Date: Wed, 5 Nov 2025 20:51:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: Unexport blkdev_get_zone_info()
Message-ID: <20251105195146.GA5998@lst.de>
References: <20251105193554.3169623-1-bvanassche@acm.org> <20251105194703.GC5780@lst.de> <f7bbb2a2-8342-4fd0-b906-7be5f5e59721@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7bbb2a2-8342-4fd0-b906-7be5f5e59721@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 05, 2025 at 12:50:30PM -0700, Jens Axboe wrote:
> On 11/5/25 12:47 PM, Christoph Hellwig wrote:
> > On Wed, Nov 05, 2025 at 11:35:53AM -0800, Bart Van Assche wrote:
> >> Unexport blkdev_get_zone_info() because it has no callers outside the
> >> block layer.
> > 
> > The commit log for that clearly states we're going to add them,
> > but it'll wait a merge window to avoid cross-tree dependencies.
> > 
> > I actually have the xfs changes ready right now, I can push them out
> > if you care about the glory details.
> 
> That's fair, I'll just drop it then if there are planned additions.
> Would've been better to add without the export, but then that'd be
> a bit of a mess if multiple folks are going to start to use it and then
> all need the export patch.

I had that some discussion with Damien.  If you want to merge the patch
that's fine, let's just hope we don't have more than one file system
wanting to use it next merge window (I think it would make sense for btrfs
too)

