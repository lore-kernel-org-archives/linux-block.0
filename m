Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDFF513
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845290; cv=none; b=Evb1+s03P9mcj0ktAxXkO/pp6IpVszQ8LOklrdhf6DlaB5aSmpC1ZB6QcZDajaAS6LuSvYYqQWd00x5qvk6TccevCZx4IkG72zZ8L47HI+EfgpjyfiLZWt5Vrd9A33wKmzk/Kh2aSLdyVbyb/nhA45BPzlDncy0kISmdoZU/eGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845290; c=relaxed/simple;
	bh=04+5KjgisiLHiiEW99zbS9wzJTW6Tibh80TlX1ZK+Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjRY9lHxuIr40wQWvLYqO/HWv8eAZf9AGFdls3qGM8OAXSMAm1X51Tzg+MnfZVPuZkAC5RYP/CPyf84wbbIPu/+b79fOsJqqibWVbzwnuZvmEPF0MoeTpP6zAsmw9VXTBEfcB9fszALOPL7VOtG5H7eGqgMpqNa9LKkKWOHvfdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF1FA227AA8; Tue, 11 Nov 2025 08:14:39 +0100 (CET)
Date: Tue, 11 Nov 2025 08:14:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@meta.com>,
	hch@lst.de, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <20251111071439.GA4240@lst.de>
References: <20251014150456.2219261-1-kbusch@meta.com> <20251014150456.2219261-2-kbusch@meta.com> <aRK67ahJn15u5OGC@casper.infradead.org> <aRLAqyRBY6k4pT2M@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRLAqyRBY6k4pT2M@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 10, 2025 at 11:50:51PM -0500, Keith Busch wrote:
> Thanks for the heads up. This is in the path I'd been modifying lately,
> so sounds plausible that I introduced the bug. The information here
> should be enough for me to make progress: it looks like req->bio is NULL
> in your trace, which I did not expect would happen. But it's late here
> too, so look with fresh eyes in the morning.

req->bio should only be NULL for flush requests or passthrough requests
that do not transfer data.  None of them should end up in this path.
