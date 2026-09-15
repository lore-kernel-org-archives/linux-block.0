Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1A46A5E1
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462917; cv=none; b=Y0TpB7qGs8uMsJEB6B5xJ5XRBro/30QrxP5Tw4/WBWzX2jjjYNXU8FGsLaVcwKE/gK0EIXg/8Xy0HEuR1IsEDPQRcTsRGTuu6Lj4o8QOtfSTOxPxhj/w+m5rA+7TqgAJnPfG0vQJjO2ncbPERJOEicSp0boO3W8TvVRzuFKe+XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462917; c=relaxed/simple;
	bh=F/hpHDllWz8PbpRukOF49YB0JOsqj0A71tOIOIGdV0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nch47o9vUj5LdL7siIvhC+4v8vhKqDi4Z7x4uHSqkr2AzpqAaPurd360T17DlKvjV777r8N3lu2KaX1TXEdS/1cGUIC6CQgfWsAI4VFHtDILeUcstwVidxuxLZPjHGCXnd6PsZI97QUq9jdRHK07FhqlSxBYTNzrpeffo9b08ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 06EAB68C7B; Tue, 15 Sep 2026 11:01:50 +0200 (CEST)
Date: Tue, 15 Sep 2026 11:01:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@linux.dev>
Cc: axboe@kernel.dk, hch@lst.de, mkp@kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] block: cap atomic write size by PI buffer size
 constraints take #2
Message-ID: <20260915090148.GA15715@lst.de>
References: <20260914132323.208321-1-john.garry@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914132323.208321-1-john.garry@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Sep 14, 2026 at 02:23:23PM +0100, John Garry wrote:
> Commit 1418b5633ca9 ("block: cap atomic write size by PI buffer size
> constraints") attempted to fix atomic writes limits according to integrity
> limits. However, it just reduced the atomic_write_max_sectors. The other
> atomic write limits - unit min and unit max - are not derived directly
> from this value.
> 
> Update blk_atomic_writes_update_limits() to properly set the atomic write
> limits according to integrity limits.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

