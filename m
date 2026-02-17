Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ACF1C4A20
	for <linux-block@vger.kernel.org>; Tue, 17 Feb 2026 06:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771308362; cv=none; b=sj4D3+ZxJpKSjpg8X8ylJLsWaAbbaSyrf/F9IQyBS1V/F7e9r8y7dGNK7FML9LyVLwmlrn8Xk6SMjCwTEb3FcCsiFRaJcfNoJP9k/uw+VRJdafFQwnxogorm3sNO5CkuWiKOkN9q2rWwwkFwUTinwWFtwO34uzLrzdrMfYvQ9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771308362; c=relaxed/simple;
	bh=wpfrFUNilhXF9ooiFvPpBXNWMbBT038vQndwRQio+pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gg2bQyan6YoaOiNI6trfvM9UIihhyZ/D/X7GdwsI3RYNMKFgaJY0CjJCzA7DtzRio423rSOmJa+H+DpvbsUjni9rHOpHFi3bDb9yUKKYm2CLOcHdlE67L3ZqKTiRyL5tIFitFtT4bxZGgyDHyf8pVXOQVTRKSk7KXk95l1byTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C09068C4E; Tue, 17 Feb 2026 07:05:58 +0100 (CET)
Date: Tue, 17 Feb 2026 07:05:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix folio leak in bio_iov_iter_bounce_read()
Message-ID: <20260217060557.GA6232@lst.de>
References: <ed27f009-4607-47f4-9d72-ccfc1b1e5de3@kernel.dk> <e19daf3a-b2f8-47ef-90df-5a746bf0b756@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e19daf3a-b2f8-47ef-90df-5a746bf0b756@zazolabs.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Feb 13, 2026 at 02:00:17PM +0200, Alexander Atanasov wrote:
> Isn't it better to move folio allocation after the while loop instead, 
> right before it is actually used - less error prone in future updates, 
> tighter loop, better cache wise.


We can't do that, as folio_alloc_greedy returns how much we actually
were able to allocate.
