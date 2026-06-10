Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308D165F1A
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781115600; cv=none; b=dCN/ewpgt4orSLhSilSGJByWEEJGbVSue16euG1dsan8MbWkiWx6ATbQdNc9DLV69I/Ll/c1FGOmKV7XOCmJXP55vcKA4hnjZY11JprlXJF/FTvRhCHN4jYweNQ/73fjHoAQMHXHXnts7x8IutstRQvouAmYufQNAyUQ3Hg+U00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781115600; c=relaxed/simple;
	bh=2q/DlnFRQMOkN4Y+AHLOpQIJt8h+RwHhBwYXR3pGXSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1o/G36SggUTZ7a//Dz1su4ihlHyBhw6Vft6DVlP1d8bFtfA/g09ImWdDZpmM8DRvYgzUg/45/OV/BP20ok3VxH22DCOaR2vh3VaG7AE4wSFY4S+moab8OAAgIgTRB4ewkQeJhJ1sDxzBf8gYPtMEEujz4Uk7b49CoS2/nw7rms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIESI0r5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIESI0r5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623901F00893;
	Wed, 10 Jun 2026 18:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781115599;
	bh=kaXOpvgaKxv0waAzUADvVbNQtHveg504KmaIcV4AKAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gIESI0r5WRr1veFhY/XEjoph/otMEuQx94STDaiRGrnPeu+3kXz8Bm9gKafHDSNzk
	 60IseCcTQN2FSe5V3bn9tYF2ZcnyRuJdG44kTvLRPcFswg6kN8Bax9jaOBtmEP300E
	 mgIvIvoJPaQursiScwRE7wYgqC5vWphBWOf20FQpyVulz02snhtBzknoJRqlxGKILW
	 veBadZdW1+pRndmNusnSdoNjmMA91/FLKkEfJhZTFNCfho8cdCXJsOqxwYxvVtXy4X
	 HJv8gxyG1NH/Al4hjYneEKHg1fewQUZQxlZKE+I33OY0KxrWRRlPUl1vMkMls612Ho
	 rSCD2JADNr4Fw==
Date: Wed, 10 Jun 2026 20:19:53 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: brauner@kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: enforce DIO alignment check in iomap]
Message-ID: <aimn3kipMHdRmTTe@nidhogg.toxiclabs.cc>
References: <aimCIEpCwUUyoORf@nidhogg.toxiclabs.cc>
 <aimErft1NoW-4Map@kbusch-mbp>
 <aimGzU_UY3jV-ece@nidhogg.toxiclabs.cc>
 <aimbdmqC10uXrZuo@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aimbdmqC10uXrZuo@kbusch-mbp>

On Wed, Jun 10, 2026 at 11:14:30AM -0600, Keith Busch wrote:
> On Wed, Jun 10, 2026 at 06:58:13PM +0200, Carlos Maiolino wrote:
> > On Wed, Jun 10, 2026 at 09:37:17AM -0600, Keith Busch wrote:
> > > On Wed, Jun 10, 2026 at 05:27:42PM +0200, Carlos Maiolino wrote:
> > > > The DIO alignment check has been lifted from iomap layer to rely on the
> > > > block layer to enforce proper alignment when issuing direct IO
> > > > operations. This though, depending on the IO size and buffer address
> > > > passed to the IO operation may lead to user-visible behavior change.
> > > > 
> > > > This has been caught initially by LTP test diotest4 running on
> > > > PPC architecture, where the test fails because a read() operation
> > > > with a supposedly misaligned buffer succeeds instead of an expected
> > > > -EINVAL.
> > > 
> > > It's not supposed to matter where in the stack we determined this be an
> > > invalid request: it should still fail if it's misaligned. Could you
> > > clarify how this is succeeding?
> > 
> > Fair enough, can you point me to where the alignment is supposed to be
> > checked? 
> 
> https://elixir.bootlin.com/linux/v7.1-rc7/source/block/blk-merge.c#L352
> 
> It does require that someone calls the bio split-to-limits routine,
> which I had taken for granted as a given, but I realize that some
> drivers don't do that. What block device are you using for your test?

In the PPC machine, it's a virtual scsi vdasd device from one of the
virtual nodes

NAME HCTL       TYPE VENDOR   MODEL  REV SERIAL                             TRAN
sda  0:0:1:0    disk AIX      VDASD 0001 000a508a00007a0000000175dcba35ac.5

ibmvfc                262144  0
ibmvscsi              196608  2

For my x86 machine (remind I reduce the buffer size to 512 on x86), it's
a commodity sata samsung SSD:

sdb  6:0:0:0    disk ATA      Samsung SSD 860 EVO 1TB RVT02B6Q S3Z9NB0KB82416J   sata

Both with an ext4 straight on top of a partition (no device-mapper or
any other volume layer in between), although I also tried with a
linear device-mapper (lvm) device and the results seemed the same.

Those are two machines I have had more reliable results. My laptop with
a samsung NVME makes read() return an -EIO but I can't tell if it's a
device failure or just a wrong error being returned by now
