Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E733FE;
	Wed, 12 Jun 2024 05:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718169586; cv=none; b=Dsb9Tu9rP1Pw7QHNqzezj+NdX9tyWX6YAAkAJP1Z1rzRkPqVaoNSX0YZ+lMffL8ksHYHf68KRe4pu9ffafznT6N1dW/cJJ5EH7B3AyOrz7ZOowVGdjIVHy8EdCrdVaEwNcztr+t6lSB7lyrL2F/KJiJDsqQUnggGnlnLbj+pFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718169586; c=relaxed/simple;
	bh=rjWqG5Xd0t0OhjIOD7U3J8u5McdvpmMHGBY3/A95F7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbuhgp12Jh5RkUl4xHaAa/pIsqjAsKPJbMDf+qqFVtrXjBconQjMUczr4WOIWm6ukHan2V6Iqk9xik4lwndW2Q0/1xa0JTrEqCTt6Rw0W+ILiRGrYgdI5DU8Rbagn4KggrKHbAKA5uytrlhGC+EDPHYKsY2JhqgiqP7mOpvdTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E09B668BEB; Wed, 12 Jun 2024 07:19:40 +0200 (CEST)
Date: Wed, 12 Jun 2024 07:19:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH V4 for-6.10/block] loop: Fix a race between loop detach
 and loop open
Message-ID: <20240612051940.GA27294@lst.de>
References: <20240607190607.17705-1-gulam.mohamed@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607190607.17705-1-gulam.mohamed@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 07, 2024 at 07:06:07PM +0000, Gulam Mohamed wrote:
> Setting the lo_state to Lo_rundown in loop_clr_fd() may not help in
> stopping the incoming open(), when the loop is being detached, as the
> open() could invoke the lo_open() before the lo_state is set to Lo_rundown
> and increment the disk_openers refcnt later.
> As the actual cleanup is deferred to last close, in release, there is no
> chance for the open() to kick in to take the reference. Because both open()
> and release() are protected by open_mutex and hence they cannot run in
> parallel.
> So, lo_open() and setting lo_state to Lo_rundown is not needed. Removing
> the loop state Lo_rundown as its not used anymore.

Looks like LTP still expects Lo_rundown to be set.

