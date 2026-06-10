Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5967E2772D
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111673; cv=none; b=VxoY1GfAY8lfUvJ4WJOQin94un4gM42DDnPSYY2j8ArCsWtNzlGsKpQ1Q5fukxK2h82Hiw/9hA7MAq1Z5c34CA3fnfi+QhCNxSUZgdFQ4PXSEnzdX8Inr1WnsRrd3HJ319pszIye4MlOFKwujPak0fCV3dPYcOCSHmvFYXQbocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111673; c=relaxed/simple;
	bh=ViyPAkS0JiwqM5uiHpeS7Gd0RzPFotqJ/9ZwkLQnd60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX9o4EPITVCsT0J2v6vZX9UFmCsnUSsNRaIn0htQC/z5Jws41LjBYnnVNqFJBAqpNZ5fO6Sp6p7H9whesQV08AVU8qI+1MrpJn+i67M0948h6ypi5xjnOR23l+tknkgJT+W48K8FaCELoyMhI9azr2mxKulISvSwy66U+mClb4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCiIsJfL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCiIsJfL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A13C1F00893;
	Wed, 10 Jun 2026 17:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781111672;
	bh=cnMgFnGvSZFZjZOSVqZ7r3+Zr5F5ejnrlX5AjXwRLWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OCiIsJfLHuwsZJHNGBHT8sl0GzdawcA5yXf4ldAKhN6/jRASulHEXoBOCplsmPqVz
	 1c9l8JZZtfVZzTA20Nag2aa9Qq/8pPuSZ7btxAS/7tH7I9dZMMb2RMM6NLlbWJ90CO
	 75l/JKLiBY43inAZGMXWyO5xwX8ZYxfU3le3/1iRz8R1ABHcB+9f/jzxTTv4WItaNl
	 fmP8gnOi/T7F5FHiGfTPacFBfxave2Gy25kr9fhkfApN+d/ff8h0K8leOdkJRaxJxH
	 jzBZOHDlxlF9sh4/gCCbih5v9yMIXVGHUFxu/ApujCK1eLCNLchQ1/UkBXv4NHqtjP
	 xAEx0u4SD3bLA==
Date: Wed, 10 Jun 2026 11:14:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Carlos Maiolino <cem@kernel.org>
Cc: brauner@kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: enforce DIO alignment check in iomap]
Message-ID: <aimbdmqC10uXrZuo@kbusch-mbp>
References: <aimCIEpCwUUyoORf@nidhogg.toxiclabs.cc>
 <aimErft1NoW-4Map@kbusch-mbp>
 <aimGzU_UY3jV-ece@nidhogg.toxiclabs.cc>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aimGzU_UY3jV-ece@nidhogg.toxiclabs.cc>

On Wed, Jun 10, 2026 at 06:58:13PM +0200, Carlos Maiolino wrote:
> On Wed, Jun 10, 2026 at 09:37:17AM -0600, Keith Busch wrote:
> > On Wed, Jun 10, 2026 at 05:27:42PM +0200, Carlos Maiolino wrote:
> > > The DIO alignment check has been lifted from iomap layer to rely on the
> > > block layer to enforce proper alignment when issuing direct IO
> > > operations. This though, depending on the IO size and buffer address
> > > passed to the IO operation may lead to user-visible behavior change.
> > > 
> > > This has been caught initially by LTP test diotest4 running on
> > > PPC architecture, where the test fails because a read() operation
> > > with a supposedly misaligned buffer succeeds instead of an expected
> > > -EINVAL.
> > 
> > It's not supposed to matter where in the stack we determined this be an
> > invalid request: it should still fail if it's misaligned. Could you
> > clarify how this is succeeding?
> 
> Fair enough, can you point me to where the alignment is supposed to be
> checked? 

https://elixir.bootlin.com/linux/v7.1-rc7/source/block/blk-merge.c#L352

It does require that someone calls the bio split-to-limits routine,
which I had taken for granted as a given, but I realize that some
drivers don't do that. What block device are you using for your test?
