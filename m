Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DD97469
	for <linux-block@vger.kernel.org>; Mon, 12 Feb 2024 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722907; cv=none; b=p8uzQatWJIZRZSUK0wSTJV93iXW5+8RjebOAOa+frp9HvcVv3zS2vlCzpJgPehvsSx1SSqYLet2hiYO1p+BXtxrIbcHoxm6jglurmRu2q8aa07ry4o46/lj1GGpZt1jKEF73+RyK20ec8IYjzrWSht5dNh5TdUulD6MiVnYsh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722907; c=relaxed/simple;
	bh=9glyc4CqEPc2uR4X04yIFLIK6MSEsDdDAS9ov9sdtrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR0kcEeINSduBQelH/70VLIKgjACQ6F2Xwo0+lnE0ByLQvdWsuchGqQPs1lMp1EnYckoo82D59iibTnetbABiilc3i2C7sYu89kRLdGc491vFHtUaVVckg0O9owxyX/wZiqBUt6ZtmkQfPLmlRcYnoSKkgp2TBJv55Ess9ArDi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E4522227A87; Mon, 12 Feb 2024 08:28:20 +0100 (CET)
Date: Mon, 12 Feb 2024 08:28:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 03/15] block: decouple blk_set_stacking_limits from
 blk_set_default_limits
Message-ID: <20240212072820.GA19597@lst.de>
References: <20240212064609.1327143-1-hch@lst.de> <20240212064609.1327143-4-hch@lst.de> <74b1ddcc-4249-4b5f-89ef-6ebca70100a2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74b1ddcc-4249-4b5f-89ef-6ebca70100a2@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 12, 2024 at 04:14:48PM +0900, Damien Le Moal wrote:
> > -	blk_set_default_limits(lim);
> > +	memset(lim, 0, sizeof(*lim));
> > +	lim->logical_block_size = lim->physical_block_size = lim->io_min = 512;
> > +	lim->discard_granularity = 512;
> 
> Super minor nit: SECTOR_SIZE would be nice here.

Just a code movement / copy, but otherwise yes.  This code should go
away when updating the stacking to the new API, so I'm not going to
bother.

