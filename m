Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C713D3D15
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306902; cv=none; b=AnSSWYZMaPDjT/YV+4MStGeyhK0q/gY7IwTGuJmYTN9ULwK4VyTCV9ENLIt2rbZeeGX+O56v8ca56QgN90blcO2OZ5TMLYT622kVKm0LA9bc2nVSZ0EaSjuN6614pbaiufjy+dGoe4HDXdfqo10qLDU46ReKU6FoGI5yTvYqj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306902; c=relaxed/simple;
	bh=pa0tjH/BnbFvqsjRM1a2eAqIhD7gkV1PeS+I7GRPQgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mb+G/In2Jmsxd9DzurtEoIjbezFDWbZgG7VRr0iL12oQrRQP2QjU9lH5AoQ6DCh2FjlDBvn4IDxPfKMbQldXDqMqB3UHXqL+cyIzEF4f4t3wJPf5waxwjD+cwamX34XSJsB1IUm2jMVQiIe/jSPF5vAmAAcQqVDnP2rtLy8tH/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE19568D09; Thu,  5 Feb 2026 16:49:22 +0100 (CET)
Date: Thu, 5 Feb 2026 16:49:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	hch@lst.de, linux-block@vger.kernel.org
Subject: Re: [GIT PULL] nvme fixes for 6.19, final
Message-ID: <20260205154922.GA28226@lst.de>
References: <aYS5ZlwruxpNCdTL@kbusch-mbp> <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 05, 2026 at 08:47:48AM -0700, Jens Axboe wrote:
> After this one, iod in nvme_pci_prp_iter_next() is now unused, which
> will trigger a compiler warning...

Must be compiler dependent, because it does not for me.  But yeah,
it should go away.

