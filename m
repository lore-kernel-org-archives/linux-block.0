Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9A322B87
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891250; cv=none; b=dGIlRyfIzq/l4iJ75r6Mmc88ntLXb+K0eIelJS8ZhxGJW6wt5YyRAVzKue86SHzLbmyvgJj9B+e18k2Zm3n5BG5+LbA0MgIEShJNRTodU2eyP781EzW9N4HJbJfzKnGDbtRAlYQqrhZ3LQ7kEDo40XeOyZDwl4bCa9UshwEn/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891250; c=relaxed/simple;
	bh=UsQ3TEkBS9VN9Rkl/5w6YSuKtFnkMCOfWFAwX/Q0Q0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvBL9pPN6IDdRNxq8/00qALfPmDNX+tGGrsPRdRRi5lVFnuu1YK+GVsdOItdreCgoDK1XF40Bjkx9uRdABjtQVLBqBk9wkFfTIrZ+FUwWXQzuFlUOkPr3uNwqBLyNnj+NevTmAJ5WztkSuWtDKHVr4lnK5qqzzmm6slu+bk/q+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g5FAxy7o; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g5FAxy7o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=G2njepDg6hOsCtFhivj4zpznE/vFa1BG/vKtDM1tUkc=; b=g5FAxy7ogEQfDJYOvInOeyXJiy
	4fw1+SN0hxcCt3oJNtXIMy2BFruXHQdfoXlxkK0S2B/83tbgC6XZl10xDrZWlY0fgPUPo1P7VEnLZ
	QyK5dMKpdFUbMzdrQFrdpek9nioseV+HYakGicHhY1bmXbRERFmYv4MO/VUm0x9qMf1s2GykuYw+5
	pDVRvbIAXBoWhALqIrOTy0uyYyB8bp0n5w4RlOEd/VPglEcedzashj9hqAZf8kTu7UGnDNYjjK98n
	I8fH3ogY15k5dIMtm4mJBa2DyFfD1LcoGszd3CppaUdOULLXhwBaWG13WyNju4VR2/NquN7ZjeNZJ
	1ZfygQ+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSF1I-00000004Gr6-22bV;
	Wed, 27 May 2026 14:14:04 +0000
Date: Wed, 27 May 2026 07:14:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>
Subject: Re: Should the "loop" driver reject using pseudo files as backing
 file?
Message-ID: <ahb8LHhDSMaXGEwC@infradead.org>
References: <d38e4600-3c32-491f-aa49-905f4fad1bfb@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d38e4600-3c32-491f-aa49-905f4fad1bfb@I-love.SAKURA.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 27, 2026 at 10:52:02AM +0900, Tetsuo Handa wrote:
> I noticed that /dev/loopX accepts pseudo files, for currently
> loop_validate_file() does
> 
> 	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
> 		return -EINVAL;
> 
> and pseudo files are treated as S_ISREG().
> 
> Reading pseudo files via /dev/loopX causes bogus results (tries to
> repeatedly read the entire content up to the size visible to "ls"
> command). I think that allowing such usage will confuse userspace
> programs.

You get what you pay for.  Many other in-kernel and userspace users
will be just as confused by them.

