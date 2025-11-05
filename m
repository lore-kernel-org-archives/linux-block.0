Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85EC32BF41
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352114; cv=none; b=QMLDKTWG369RrXHIXWxiRBtRibcug1V2eZG1H5wksAVS5Xu5MMPfTw29wAkC1xhUUrYfTlBLBsIJMYru2Cfg9Ydlzpll/npiwNSR467683/gT3zFmGan6ZcyNZOjUkszX13Loa6e8qvRj6k2c8HN479Ohw/vG5kwlBif6c2gOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352114; c=relaxed/simple;
	bh=HjK0vytf19mljV0dY7AIJ3uO3+1wHGtYeLW9xNvrsuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpjFqY0EZdZgcaloIYLO7vr2pWfKcfRGE3orq36VCtWO/vyw6amcRZzQ+lq02/UsavkeHBD5RKlxhIiAkdZz6RVIYAtN51JRApYQB0si4gXGlpXHt2XpwQJYb7NWBcgcmkKfOGKcML1hSsMxwHW+YxBRlMA4RUAS//fv+x9Sr8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3EED8227AAC; Wed,  5 Nov 2025 15:15:06 +0100 (CET)
Date: Wed, 5 Nov 2025 15:15:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, martin.petersen@oracle.com,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH] blk-integrity: support arbitrary buffer alignment
Message-ID: <20251105141504.GC22325@lst.de>
References: <20251104224045.3396384-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104224045.3396384-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

I have a hard time understanding how this actually works, mostly due to
"union pi_tuple".  What does that union of two pointers buy us over just
passing a void pointer and deriving the type we need deeper down?  Also
given that taking the address and the comparing it (at thbeginning of
blk_tuple_remap_end) how is this actually going to work?

