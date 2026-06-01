Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08683383C89;
	Mon,  1 Jun 2026 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297874; cv=none; b=qh97hOZbX6X4rBSlMwbrdGXlODA/XIgdt9srBMNNl6WyinN/HcYKTWUiTzOIFBISSVYhiSIjX4anwIlctk6C1phtpE8S0afLKcRlKZOPexQ8qK1hu7MS1Ig+/cF4M7pLOMc3u+VY/UrfeCoEISW6WmqoLKjzpO1M33LnuqDCo3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297874; c=relaxed/simple;
	bh=EBreistolfcYr71R7dNCxyEebU0mm3KaYy7JiiAwFJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXSVqhseWpkyPd0bJpDk6LNo9m2Ht759mAM/psET1ZXmr4oi+2SJDzRQwD+6fEjyeblYl/2PNc6ze83vUD1HUcK1pfK5/6Fdb754ZBYtO3IdKT1qXcwgO/7JQGeuftWjQf9ks3PuRC8jUlquXWpDM0boU4NtL3OqQcQaGUTDHBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0BEF068B05; Mon,  1 Jun 2026 09:10:59 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:10:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Qu Wenruo <wqu@suse.com>, Hillf Danton <hdanton@sina.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] loop: reject binding to procfs and sysfs files
Message-ID: <20260601071058.GA7468@lst.de>
References: <148efba2-a0b6-47d7-ac76-b19d2f4b696c@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148efba2-a0b6-47d7-ac76-b19d2f4b696c@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)



On Sat, May 30, 2026 at 10:48:17PM +0900, Tetsuo Handa wrote:
> Writing to pseudo files via /dev/loopX might also cause undesirable
> results.

So don't do it.

> Therefore, explicitly reject binding to pseudo files on procfs
> and sysfs for now. Other filesystems can be appended as needed.

NAK.  If people want to do these stupid things we should allow it.
Hardcoding random superblock magics in random drivers is never a good
idea.

