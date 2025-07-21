Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A382284687
	for <linux-block@vger.kernel.org>; Mon, 21 Jul 2025 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083522; cv=none; b=LDakEwNcy/5TKy87r54kp6tUllx+R+ZjvO+teonWhEo9n/n2pgp3Dg5sdNJtY2vTZ/FK7jGNojL/KV8PaLZFfFGFD09VNAuQ+Kyr2OZv37oqwJmkmUDLmo7fQEIxbXHq0VCNPkXbzao7ZAKmLEIBgQTCxkxuaRZQr7nLeneVATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083522; c=relaxed/simple;
	bh=rJU3H4kB83XPslcQwtgfysNyqh7QQ6mXlDotk2J2iVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9HfGiyeCJgxR9+N+G8k8AiRJ6qshunRhBYw+SsM+WZfp+9JuizZfT4e5xQJpZzQyWGJ4epab7Yz8VlCpvWRVuB0cnTdM/6tE9qUh+nvVUSNBEDyAV7NjSoyPdmjw476VkugtL5gFr96ufobtKBz/LIIYW4C8SDxut77WkJ9HiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0BEAC68B05; Mon, 21 Jul 2025 09:38:37 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:38:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/7] blk-mq-dma: set the bvec being iterated
Message-ID: <20250721073836.GB32034@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jul 20, 2025 at 11:40:35AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This will make it easier to add different bvec sources, like for
> upcoming integrity support. It also makes iterating "special" payloads
> more common with iterating normal data bi_io_vecs.

You're not really setting the bvec, but the bvec table, i.e. the start
of the contiguous chunk of bvecs for the bio / bip.  Can you make this
a bit more clear both in the commit message and the structure member
naming?  This really confused me and took a bit of careful reading
to understand.

Otherwise this looks fine.
