Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC8C21370
	for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357472; cv=none; b=FrmstpiXFjmWcW3whWGkzel8SL+zdiXbTNL91KjniD2FfB6UkInl090OXnQnISb8bMJTIN2WPNCziYvhXcKLQCIxGqVw+xDiOdrCECogcwNzFbo+q06kSLCeB6KDGeZ0eVxr6VZki6KVmSBDfoPWg5G0T4+SKNXo3KCYtMgFBqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357472; c=relaxed/simple;
	bh=NmfEK6L5+fopktxibmRTDPM9F2T+mchbo4YQ1kT1Blc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lH5lS8l1peoA1C81+Hrok9r03OaEcooAvTTzQJHoHRLm+n5HWYxckLSENxRItX1O98ofvzq92y3QzKr74JG3bm1VCt2GEVy2wmAiR5uXv2MX/A2P8DDaPWYyzEe7J0AgILWCNlLhn0kDzm7E8JPvFZK2Dg8uX7dy6JOIEpCeSfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PhmX1chm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PhmX1chm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y7No5BwSBcNxAZE4T0od85sb/fUSBA4xSBUxPEwP8vU=; b=PhmX1chmLgkAVW3std5UqfdxDP
	rwyCiSKjNl7ij3pV6kGYxMnljYFyCvXcI4tslQ2y88inn3vZJ1G13rc9rD9IFsIn37Mlhko44St52
	8GOs/9TtkekpiUW5IupsRk+0m0r/wFZiFyOMLOA8yt9r6ktHwHEii+kleCKf0+LNwS5bPlQlBMN9I
	9rq/GrjWGE3IPje6ExSR4G0BDf46vpMPcIUujVUq2VvHBftHGZ7nfDM2fvWYlljDOD7fOEwmOBzHn
	4mesg1rIM7BGM5Q0vPwsfLa29GFYNlTXxiR25H3tH0Hj/1WyRRXViXRO9VdZtReSnCEx5Fi/LOsGb
	PYa4WUCw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkU6m-000000064wa-18LU;
	Wed, 13 Mar 2024 19:17:48 +0000
Date: Wed, 13 Mar 2024 19:17:48 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: brd in a memdesc world
Message-ID: <ZfH73MgTAK2BOFK6@casper.infradead.org>
References: <CGME20240312174020eucas1p29cf41360c934c674fd1f36a808078e25@eucas1p2.samsung.com>
 <ZfCTfa9gfZwnCie0@casper.infradead.org>
 <d470e16b-b7bf-451e-a6e2-eb68adcc2635@samsung.com>
 <ZfHwXLr54bWl1fns@casper.infradead.org>
 <4605ebb7-2fcf-4570-b849-7aaa80a21954@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4605ebb7-2fcf-4570-b849-7aaa80a21954@samsung.com>

On Wed, Mar 13, 2024 at 07:36:01PM +0100, Pankaj Raghav wrote:
> Got it! Probably moving to folios just for the sake of retaining the
> debugging checks is not enough.

That would be my assessment, but maybe Jens has a different preference.

> > None of those things are needed for brd's uses.  All brd needs is to
> > be able to allocate, kmap and free chunks of memory.  Unless there are
> > plans to do more than this.
> 
> I remember he mentioned he wanted to support bigger logical block sizes
> in brd, in which case moving to folios might be justified.

Using folios (or some other data structure that embedded the order of
the allocation) would be justified if there was a proposal on the table
to support variable sized allocations in the brd XArray.  Hannes wasn't
suggesting that; his patch series used a fixed size per block device
(which honestly makes sense; I don't see the advantage to supporting
variable sized allocations).
