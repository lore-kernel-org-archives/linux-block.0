Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DEC24C068;
	Fri, 31 Oct 2025 10:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904803; cv=none; b=AFjpyxM1j6XpM75k4e4ddsozJhdN7DNce5Jl4NLC3MzlrOgexgQGt70QelNqiwy8oBXQYkDIMxPGEHzf6g70ttgtsSXKKTSiYmyGYOBgWIieF7DIiZnyFirm7jj+urBlVI3kXJZcOvQkouGuuZrSSX2DP55mRVy9EKy8cJ5GcSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904803; c=relaxed/simple;
	bh=ZEhi2Ft7fop8DZXM4+Z56TzYm8lC0546nprbV4iSeTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdgVKYL/EWtr9J2CDgZwf5gfpwyJgBmPS7tqNUPiLecSgnftjvebFR/+lvb8OSMwrui1uZlDJzGIXNrkve0urDGGKzi1YJwc37J8Gs68nxiWA+bNFSus5GHW28UwAGcqerNMZOLokv51NWuym4P4W5bqP2KOvkGoml2fKsUdE2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CBCE2227A88; Fri, 31 Oct 2025 10:59:56 +0100 (CET)
Date: Fri, 31 Oct 2025 10:59:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>,
	Martin Wilck <mwilck@suse.com>,
	Benjamin Marzinski <bmarzins@redhat.com>, stable@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3] block: Remove queue freezing from several sysfs
 store callbacks
Message-ID: <20251031095956.GB10293@lst.de>
References: <20251030172417.660949-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030172417.660949-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Oct 30, 2025 at 10:24:17AM -0700, Bart Van Assche wrote:
> Freezing the request queue from inside sysfs store callbacks may cause a
> deadlock in combination with the dm-multipath driver and the
> queue_if_no_path option. Additionally, freezing the request queue slows
> down system boot on systems where sysfs attributes are set synchronously.
> 
> Fix this by removing the blk_mq_freeze_queue() / blk_mq_unfreeze_queue()
> calls from the store callbacks that do not strictly need these callbacks.
> This patch may cause a small delay in applying the new settings.

You'll also need data_race or READ_ONCE annotations to satisfy the
memory model.

