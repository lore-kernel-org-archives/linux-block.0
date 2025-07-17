Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A91618C31
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 04:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752726675; cv=none; b=EcNI67g8NkWeK+F9Z7eg6rT7p+OTpu19AYp2EA3CuZd/ydsUdUV223bO87eImYUS3QouHxY9cOgxr9IYN++6dDI9RMW9Ed+4lq8PKOiW9RoUw4pTtfQ5FMp3YfQi/hRfAAlJSnxAvIs0OtzJd5P8pO8muHOPelGwgU6F9WTOcnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752726675; c=relaxed/simple;
	bh=+YOQidQWamoztpxxtfv7+/0y861bxn2U1bmANuUEDwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iY44XqVCeDU8cWTvpPUc0+RI8cvh9FGv41/zHoJlueB9DTqi03pCHsCapga3ZjyrMT7wpK7KwRJ2ZJCkZUW1URKKyQIOghEHOHFvHEu1/0QfvxdtDSmxF/FVOK31OUs4fbVS3SNNqlPRb3pz4HZ0LVyaF9yFkuHYd/xa/btHQQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PhpT8wOc; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PhpT8wOc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=X37uYxc5Gzs4TZvfzMgGDpInXJ1bmisLzo5/w2kjyaQ=; b=PhpT8wOch6iP1mjfyxbzWmdgaj
	oxBZlaZHoU+BoxmRzwzLHR/xY8aULh/DbrJnrG52LlQ2LfbkncXAtb5Cli0LDbjSfB9aX0/FZgKqH
	oI6jTGJuw9A0cmSAi4nAy/JcKhE5igwwTe76jgXmqcGBLUZU624Pav5onmWhYz89bpR2ESbNO5EAB
	2Rvln65oVAzFlx5NcbI6IT3xDhLF6gODjV01RN1+SI4Tm4q+m9bmDsPLsPX78EqrJdW+226ru2tUn
	8jva5tUzlV3O6va6iCPn41EmReDLpKb4gtLHr2YnpJoEgRLpV79GO59N5BOPZwaW/XkdZ50jgZqXo
	tJFujgAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucGH3-00000009Adr-0n0x;
	Thu, 17 Jul 2025 04:31:13 +0000
Date: Wed, 16 Jul 2025 21:31:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Changhui Zhong <czhong@redhat.com>
Subject: Re: [PATCH] loop: use kiocb helpers to fix lockdep warning
Message-ID: <aHh8kTquWhbxP7si@infradead.org>
References: <20250716114808.3159657-1-ming.lei@redhat.com>
 <aHeZA3sT_o2O5JWs@infradead.org>
 <CAFj5m9L=zOs4JkzMZMZ9S0rWJaH21Ntxk1d_0fR0SBu_QAAdAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFj5m9L=zOs4JkzMZMZ9S0rWJaH21Ntxk1d_0fR0SBu_QAAdAA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 16, 2025 at 08:31:56PM +0800, Ming Lei wrote:
> On Wed, Jul 16, 2025 at 8:20 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Wed, Jul 16, 2025 at 07:48:08PM +0800, Ming Lei wrote:
> > > This patch fixes the issue by using the AIO-specific helpers
> > > `kiocb_start_write()` and `kiocb_end_write()`. These functions are
> > > designed to be used with a `kiocb` and manage write sequencing
> > > correctly for asynchronous I/O without introducing the problematic
> > > lock dependency.
> >
> > Maybe explain what it actually does.  That is drop and reacquire the
> > lockdep notion of a held lock, because the process is not holding it
> > but instead handing it of to the one handling the completion of the
> > asynchronous I/O.
> >
> > The change looks fine to me, but this commit log is rather confusing.
> 
> It is actually the typical use case for aio, please see use in fs/aio.c.

I know, that's not the point.

