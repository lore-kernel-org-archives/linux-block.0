Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D63216CD33
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110700; cv=none; b=l7nDsU21YZlX2AjPxo0KPIUDHS5/7+pdc3CP4zT0aIoo5bCXU7/flMMqI48u+fKw/2TJU0D7ZWIPJibBko7XorYjOGD6ewq07sQVKQJ8nkiw+vnaM5OphG9+KMmB4QI6hbTfh03RnDg/hUBx45ZTLUBL+sBvujXeXhIUSf6bu+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110700; c=relaxed/simple;
	bh=bqHN4M0tMzEUD3tgrkA2J67eLDAiNkI5yh7oWkpGrwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/RnvgGx1oCI+N5gCXOHQTxJXSwNEcc8iJOQME5PdK4mtgcE31GXPKWam93fNU2CkDlMeNEeKNlbjOyPVnKudP/K3prdCzPSfoD82pBr54Zjf2DJCHqhGumluHThYntLzbvuhAHa5jkO93JyCh3CcPfQNUlzL69gD3Q7RnM1VBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V178G5jz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V178G5jz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787FB1F00893;
	Wed, 10 Jun 2026 16:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110698;
	bh=AQD32BfbZ9XnvT8oNSSwLEQ7Yygc1T3/c2pZfDbSyr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V178G5jz2Gwcy20G2iTSb2RCFdRd//LS8kIFJyneUG42mwGDeGTFH6gllP7M/8A6E
	 kbRBUrcf7Hg2d1ORLw4YnatPbpwdnp5aJh64pLiD9lcxoAReT0yvWb2WJM11ydPbFi
	 gdMgO02iRIXeaHQw9af84Ip0fpd8hoGpeC2N5PxCoyuX97QmysVtuT1Zdk4ogJpxt7
	 H5ImVZKJwCOY7YJhbNff8e7wX9h/n1JtTczRUMjYi03OWFDiCmwS0Jks3V+Fj4pnb0
	 IqQ/jTfG30GA7VGgfBZkLotHn+Uu7EKfx8yn5XXfzSMq8xnYUo7tye08cCI1GIvqNm
	 hDg7eWy2pQYXQ==
Date: Wed, 10 Jun 2026 18:58:13 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: brauner@kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: enforce DIO alignment check in iomap]
Message-ID: <aimGzU_UY3jV-ece@nidhogg.toxiclabs.cc>
References: <aimCIEpCwUUyoORf@nidhogg.toxiclabs.cc>
 <aimErft1NoW-4Map@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aimErft1NoW-4Map@kbusch-mbp>

On Wed, Jun 10, 2026 at 09:37:17AM -0600, Keith Busch wrote:
> On Wed, Jun 10, 2026 at 05:27:42PM +0200, Carlos Maiolino wrote:
> > The DIO alignment check has been lifted from iomap layer to rely on the
> > block layer to enforce proper alignment when issuing direct IO
> > operations. This though, depending on the IO size and buffer address
> > passed to the IO operation may lead to user-visible behavior change.
> > 
> > This has been caught initially by LTP test diotest4 running on
> > PPC architecture, where the test fails because a read() operation
> > with a supposedly misaligned buffer succeeds instead of an expected
> > -EINVAL.
> 
> It's not supposed to matter where in the stack we determined this be an
> invalid request: it should still fail if it's misaligned. Could you
> clarify how this is succeeding?

Fair enough, can you point me to where the alignment is supposed to be
checked? I've been seeing kind of different behaviors with different
machines so I kind of am not sure where the alignment is supposed to be
validated within the block layer (I should probably have tagged this
patch as RFC as my understanding of the block layer is superficial).

A few runs when the test failed (because the read() call succeded) I
could see this for example:

openat(dirfd=AT_FDCWD, pathname="testdata-4.2063", flags=O_RDWR|O_DIRECT) = 3
_llseek(fd=3, offset=4096, result=[4096], whence=SEEK_SET) = 0
read(arg1=0x3, arg2=0x25960001, arg3=0x1000) = 0x1000

FWIW, on my laptop, the test fails because read() returns an -EIO (while
the test expects -EINVAL), I'm pointing the fingers to a faulty hardware
now but I didn't discard the possibility of an EIO being returned EINVAL
should have been returned instead.
I'm trying to find another machine to test and see whatever differences
appear...

Cheers
