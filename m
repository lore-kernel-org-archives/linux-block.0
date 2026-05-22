Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BBE39060F
	for <linux-block@vger.kernel.org>; Fri, 22 May 2026 22:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487739; cv=none; b=gZKCvLQwHw2+OvHL/dcZeIm+TD8Ig0SuOLxXHUPx+DwqSAu0C/3+gE3QmA+Lqy7Jb7msF8UPgofHlUTRbqgawAxdNKypc8fMjeyM2Gp5GF4QGfan5SSCkKGV9dJiyoqtvPLpsx31+ooCLeKZm0fB/+u/yPzkBhwMBSzbEL4LXKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487739; c=relaxed/simple;
	bh=Wgloa7tDjPCQnc0o4IGXZK5Du1tgDGCBAzXJQCHffyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA6tzOdm/YfyajLMG3VKIaDuJCyvsDHD3kmZd2DBv7qP6526o+5zvtyd+nlOpoH+H3Ojim0y5wGa95QYeVkjj6Cq+sjVR0Qi+H6rSUGG8dMuLzw43MRdbuZ6/CPE3WgOKIfNpL1PRcMaRfSO+2JUsOJunMcBm1XytSYYg5PnmZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac8hLL+y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac8hLL+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E821F000E9;
	Fri, 22 May 2026 22:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779487738;
	bh=l6nILBVdvoGAHKJjRko9yzeXcWJmsz5mYf3Yy7MMfaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ac8hLL+yvKYOxBfL91kXufAC3rH6TD10dJdg/1yYllDo/xUlKJ4n0EeSLYoCdMDH+
	 FPwApKfxbx8TI9gDorSw9CGAyHHs5DoXS6zvb7cZ8h/3VqYujhzs3x6RJ8UhCTVC9b
	 cyTnZaLvODrD7dBte3aUJLbbOxtvSf5klSjxJXLZU1t2c3PvsZ+xDcEARvVWqbpegk
	 JSZh8lb3NAtd5iYwVJSpnkv6REvqg43sPZ9wr2E1K+zPJPi+CMNC5HF9Uu5eKazpTM
	 7UrBVREMQKP3k9YFpjlWeR3uay3S/KSQ7gja/HVNvf9zP4yPOjqznc8aFSO0V4F9Ga
	 eaSkIPoQb4cxA==
Date: Fri, 22 May 2026 16:08:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv3] blk-mq: pop cached request if it is usable
Message-ID: <ahDT-JZZGyyTXyii@kbusch-mbp>
References: <20260521190253.242065-1-kbusch@meta.com>
 <ag-WUymW2vwVyMJB@fedora>
 <ag-1EoopSdp0JZR5@kbusch-mbp>
 <ag_XoloTHEgt3Y8s@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag_XoloTHEgt3Y8s@fedora>

On Fri, May 22, 2026 at 12:12:18PM +0800, Ming Lei wrote:
> On Thu, May 21, 2026 at 07:44:50PM -0600, Keith Busch wrote:
> > On Fri, May 22, 2026 at 07:33:39AM +0800, Ming Lei wrote:
> > > 
> > > BTW, as mentioned in v2, the request may be added back in case of merge,
> > > but seems not a big deal given blk_mq_free_plug_rqs() doesn't free requests
> > > in batch.
> > 
> > We could introduce a special goto label for the merge case to push it
> 
> It can be done simply by replacing the added `blk_mq_free_request` with moving
> it back to plug list.

What I'm worried about is hitting a blocking allocation, then the
cached_rqs list is freed, leaving the current request from it the only
one still holding a queue reference. I think we ought to re-enter the
queue in that case.

I suggested a special goto for the successful merge because a plug merge
couldn't happen if a previous allocation did schedule since that flushes
the plug. I guess we'd have to distinguish a plug merge vs a sched
merge, though.
