Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AD83A8EE
	for <linux-block@vger.kernel.org>; Thu,  1 Feb 2024 04:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761099; cv=none; b=YyxW0YoFz+S7hSFT1CAhHqVcBIv5UQOoIv614m2jZiOUnbIayDW6GSadSuFhq448K67G9sHPqvGIlNgZGTnx+HlSQMsdyjDFZE6S+VBr5NexpTsJW4LMTEtWdRCOohEWBHh6ZEn7dW7Ip7mbklpYobAG86W1uHFSRcLL8jLB6+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761099; c=relaxed/simple;
	bh=zl0CgDGM3pBafgLwN5vLK03aDl7OGTiKzxtmTtiTGjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwNwMl2W2/ZcQ34pK98+Hf9+krC1XjIj+te9KU8+pNU52XmGO9RPtPN3O2eh1gZRmnw2SbTA8kky+UBp3wzJdqTmwbyAXdM05exUclOlFK5J1D9Vxu9u+N6c1Ks06UqcyzT9/6F5YDyYw5yzBLQWJ0mI5eCqbwO58nqZDOOWSYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E9EDF68AFE; Thu,  1 Feb 2024 05:18:10 +0100 (CET)
Date: Thu, 1 Feb 2024 05:18:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, virtualization@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 05/14] block: add a max_user_discard_sectors queue limit
Message-ID: <20240201041810.GA13766@lst.de>
References: <20240131130400.625836-1-hch@lst.de> <20240131130400.625836-6-hch@lst.de> <ZbrngpaAisIJGQ0T@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbrngpaAisIJGQ0T@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 31, 2024 at 05:36:18PM -0700, Keith Busch wrote:
> > +	q->limits.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
> > +	q->limits.max_discard_sectors =
> > +		min_not_zero(q->limits.max_hw_discard_sectors,
> > +			     q->limits.max_user_discard_sectors);
> 
> s/min_not_zero/min

Yes.  Fixed up right after when converting to the limits based update,
but this does create a bisection hazard as-is.

