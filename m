Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB7B191F94
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774507181; cv=none; b=V4O074Jnl8j2U4R+S4E/gEsAN8igFuIoJRFGL76+0OcpNyHTwFcC0WhyNRo6OyKKh+YsnwxppC5WY9oTwylMjIk69RXamud9jKYV/E50gcqJgRdUtmNJfQIL7Ccj9G8h40YK60LwD9ucPGd3kHwytVP2650KOKpeglso2WRhE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774507181; c=relaxed/simple;
	bh=9X+d6g9pltL9Cm2c5IeKdb+mV7SvT8GTt/8/Bp0N/S8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3Y7Ena8X/Jo3bZz034CPBXuY1xrcP0AmFfyp+Q/EtkHM0n66lYpUdGgONvRvfN4/93m1gHKNC2806xVaMbrvFnXoe8SZmXSaXH3bjDQ3lUVOBP2sbYmEVP1UdfCUJTkXwKaSt/pmNMPAtXcoD/KUPZCu5NpcmaSDNLmKciR6TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B06168B05; Thu, 26 Mar 2026 07:39:36 +0100 (CET)
Date: Thu, 26 Mar 2026 07:39:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 10/26] block/ioctl: Add lock context annotations
Message-ID: <20260326063935.GJ24071@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-11-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-11-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 25, 2026 at 02:44:51PM -0700, Bart Van Assche wrote:
> Add a lock context annotation that is required for Clang's thread-safety
> analysis.

This doesn't explain much.  The problem seems to be that ->synmc
can drop the holder lock.  I think we need a proper way to identify
how function pointers acquire or drop locks as said before instead of
using a big, misleading and incorrectly documented hammer like this.

