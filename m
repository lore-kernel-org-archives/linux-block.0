Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87D471433
	for <linux-block@vger.kernel.org>; Wed,  7 Oct 2026 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378553; cv=none; b=kSKxXAinsx+xUECzstNSV5oulA10OsIB3eyez6A9ondBnorY7Tz5FidgR3jjTrXptNwBnyFy0e+xwANZ5BEfAGmNk/RY9Vlv2O1eYN3YfLlZqJNJ+rmqTNJAbUUIi9+sLk0SByl1lCYC8E8aGtCRIOnE/knYpjl+Zwp2KLKtlgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378553; c=relaxed/simple;
	bh=po1s57Qgs4t+Z5psDUzYfIKtgJelJIgNgIl0iJfoqjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azyojLxJLMzy8jxVOUoI2+1/MMMsTYmPfygtwqTy22m8S2oUTOHZ/qluhjE44mBas7r6PoIhqv3g+AsSq6P2BBUiH/7Id/tPPetkwZnH3zQ0+l9igYmvM4hxO59bqeJlpaddouJJvSP78WtqWcWln+7yZRQIq60rkT5PRHIbeek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E526568C7B; Wed,  7 Oct 2026 15:08:51 +0200 (CEST)
Date: Wed, 7 Oct 2026 15:08:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Edward Adam Davis <eadavis@qq.com>,
	Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH v6] loop: Wait for I/O completion in __loop_clr_fd()
Message-ID: <20261007130851.GA30117@lst.de>
References: <fb1e0f16346994e32b479e4be596436b2a614b03.1791234123.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb1e0f16346994e32b479e4be596436b2a614b03.1791234123.git.bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 05, 2026 at 02:06:02PM -0700, Bart Van Assche wrote:
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> Syzbot reports a NULL pointer dereference in lo_rw_aio(). This crash
> probably happens because commit b15e4310633f ("jfs: Set the lbmDONE flag at
> the end of lbmIODone"), merged in the 7.1 merge window, lets the JFS log
> code report a write as finished while it is still in flight. JFS then tears
> down and releases the loop device with that write still sitting in the loop
> workqueue.

Why do we go offtrack messing with loop instead of investigating the
file system misbehavior?

> Although the root cause is in JFS, improve the loop driver by waiting in
> __loop_clr_fd() for ongoing I/O. Release &disk->open_mutex temporarily
> because otherwise a deadlock would be triggered.

We can't just drop the held lock.

