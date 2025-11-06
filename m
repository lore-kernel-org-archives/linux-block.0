Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DE12222CB
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426869; cv=none; b=k+G5IT1j+PjmNHN8dLiYxN62X6NMmiE23sDo3P9Vib9SUthaY97barLX+9aE/4vYD4K68g8opHprUVn7SD/nUeVhA3/97SpwWQWzosjjP3QPDPVprWYM89YzaaJUoNEX97dyD1oMxMWJGT+jEM3kblloa40AVz9j5iHypXrwGcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426869; c=relaxed/simple;
	bh=O5TJGAXFLs+T73pr2Ra9RC1ly5J2h+1T4iU3TGKUJRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvwoFAkmCpgbnUnuzJJ9839laJtRfsc3Nu8QCh2pwjlsqwsLcf6W1K94t4CoXhMMqHLk95yzK29Kpkx1BXdI2K/qh/yvP5553jU+ijTDN2kmUz8b9mgHtgBqy2buaNRdblA8iNZ1y/9lRo7woaoQaUA6tpPT8kEuPqSmsL7Evrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7B617227A87; Thu,  6 Nov 2025 12:00:58 +0100 (CET)
Date: Thu, 6 Nov 2025 12:00:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: fix cached zone reporting after zone append
 was used
Message-ID: <20251106110058.GA30278@lst.de>
References: <20251105195225.2733142-1-hch@lst.de> <20251105195225.2733142-3-hch@lst.de> <ad303562-5b34-4156-94f1-516787e873b1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad303562-5b34-4156-94f1-516787e873b1@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 01:10:28PM +0900, Damien Le Moal wrote:
> > +	if (!test_bit(GD_ZONE_APPEND_USED, &disk->state))
> > +		set_bit(GD_ZONE_APPEND_USED, &disk->state);
> 
> We could remove the test_bit() here and unconditionally call set_bit(): single
> atomic op instead of 2.

test_bit doesn't need a lock prefix (at least on x86) and avoid
unconditionally dirtying the cache line.

