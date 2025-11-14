Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EEC21D596;
	Fri, 14 Nov 2025 05:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763096658; cv=none; b=nJw3MQTXFZJuxy9CeQl9tjlbX6B527vnUnKWtVLG9Ozumr/Vh5h1toi2URkLudoswbric0AL2CGWmY1Y6E//5GgYo4fhaLdTzaxDFqHD061h55yOaKHmQFwhzP00fK2NyIUBGhDJm/p+Mx6u8Dhl3nCIYXx/817N8rk54tntxkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763096658; c=relaxed/simple;
	bh=DKVTp/o53NKKSomFUanDfsFTy0bTCGG6jhgap0M/0iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEqXEIcmKPN4KV6fFogp0hjqlBzA7/v38JKS6g+zTiJBXqunu8qs6BQOxTVALIqAkFxQFw91NNqE0T8qwBgnA/xMl6DiGXJEARSp7O2Lk2R4WKTdlNHC+54p4EaNhMeAmoZXO1dcgoyAt4WRCBMyJBRuuzJNuxWUs+F+7LaKYK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 37A73227A88; Fri, 14 Nov 2025 06:04:10 +0100 (CET)
Date: Fri, 14 Nov 2025 06:04:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] mm/mempool: fix poisoning order>0 pages with HIGHMEM
Message-ID: <20251114050410.GA26404@lst.de>
References: <20251113-mempool-poison-v1-1-233b3ef984c3@suse.cz>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113-mempool-poison-v1-1-233b3ef984c3@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 13, 2025 at 07:54:35PM +0100, Vlastimil Babka wrote:
> Christoph found out this is due to the poisoning code not dealing
> properly with CONFIG_HIGHMEM because only the first page is mapped but
> then the whole potentially high-order page is accessed.
> 
> This went unnoticed for years probably because nobody has yet used a
> mempool for order>0 pages before the new block code in -next.

I did a quick audit: and bcache, dm-integrity (config dependent) and the
KASAN unit tests create page based mempools with order > 0.  It looks
like none of those ever got much testing on highmem systems.

The fix looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
