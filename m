Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A720A33EAF8
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372032; cv=none; b=Z1pukEXs2d9ShKEZRAryn+92Sl1g1wHcWJ5jytuuBrYmlgLSWT6qG6gPRoLpWrYSSlCrtYo6mptRvuGcHClYyuqnXVdMT701pTt4OS1foFij9Rm2fGP+wbtFeWQeyFBV4MPeg68ogIzmKB41e40+/Q7SxHmfYviLn3VCf0hEArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372032; c=relaxed/simple;
	bh=ARTDiz14Jj1WrykiweUglzUlc+H7luBEl8d8onv3xcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eS7aewd69R6lL1m5dEawicF12wUH8YS5C76OtAU7HsjB/JItHoR2UBZCwvoZCha1QHfxBUmKVuqJCZq3jfXOPJ3XHLiW9C+TH909vOUG5+DZpxoSg3WCYggEE1pxo57vAk92pPzGPLSowhyHsJh4ixd369MnuYdmtCqxitcCunc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BC849227A87; Wed,  5 Nov 2025 20:47:03 +0100 (CET)
Date: Wed, 5 Nov 2025 20:47:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: Unexport blkdev_get_zone_info()
Message-ID: <20251105194703.GC5780@lst.de>
References: <20251105193554.3169623-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105193554.3169623-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 05, 2025 at 11:35:53AM -0800, Bart Van Assche wrote:
> Unexport blkdev_get_zone_info() because it has no callers outside the
> block layer.

The commit log for that clearly states we're going to add them,
but it'll wait a merge window to avoid cross-tree dependencies.

I actually have the xfs changes ready right now, I can push them out
if you care about the glory details.
