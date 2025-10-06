Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C81DE887;
	Mon,  6 Oct 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762092; cv=none; b=SjSmtVKw3RGelkdnK68g05BizuaZ+cy1mBksOD5wq2ranIN8gEu8/JDSrfLqcitcbIgPu8mSLvqLWPhqF7R5PlmBdYOQciQPK3HMPDkfShKIGFKf8PpN6Rjh2bL/6ZN4KoLrEXpPDpHT27HWYdfhv7YWowo0PqEKvWWSB+5PU8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762092; c=relaxed/simple;
	bh=fwAzFzgYYqKMsi/+jH1fKNFJ9VHgpxV+bXbMYhiX/X8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EQeaTFRioCkf+6LAw/IXBrgsiyHiT42R0aPWyov7Qa1rxaHvjh4Wzr0roGSZtnFTbxrvhGIjgR7TcHfLteELmkh0A4MdmacK9gWGCiwv2wz0Dl7NCMURcGWHSYzt+JNvPnOY6idl02RtpgUNx8DYEamEPSHCHQuDOSgUhtrtrcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=oDNYzy3Z; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="oDNYzy3Z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=5Wm3ETjVyISlPlN7DSrYCbT+fhXJZiuM2/CVIR4HuLQ=; t=1759762089;
	x=1760366889; b=oDNYzy3ZQF4VXaasCsKhwf7PBqTc4E9esQmw0U9lGovP66Jr96ZhJxbffpjIt
	aVoWxqLlPKqFVvuOXepdYyL5+7S6T+kf8ME4y0wF17o8xX3D5ZjsnWFBbRdIrPc/iI2A+cg+BYPBo
	f+3AllwBzxjwFWKqvXEWbEPOCYKdo4UEv+EymEldGTBhmyeV7A4Z6SdtD/vz2HVLLSrX6NrharlRZ
	t6zKQw+kVRwpvp78z4OhTKEqVOXtQjCrs5gwwCdX6u5Ckzn0rKDKML3osFogxWOLYSnZABY4IYEkA
	RMYvrsSMpsJhnf1VGkhzFmwzBRpWj0NTJlyzSX3qmXgxlY7W/g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1v5mVS-00000000nGj-2Bkp; Mon, 06 Oct 2025 16:48:06 +0200
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1v5mVS-00000003LLs-19Vh; Mon, 06 Oct 2025 16:48:06 +0200
Message-ID: <576197870bdf21ea97559a1d84869fdcb9535156.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] Revert "sunvdc: Do not spin in an infinite loop when
 vio_ldc_send() returns EAGAIN"
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Andreas Larsson <andreas@gaisler.com>, Anthony Yznaga	
 <anthony.yznaga@oracle.com>, Sam James <sam@gentoo.org>, "David S . Miller"
	 <davem@davemloft.net>, Michael Karcher
 <kernel@mkarcher.dialup.fu-berlin.de>, 	sparclinux@vger.kernel.org
Date: Mon, 06 Oct 2025 16:48:05 +0200
In-Reply-To: <d23fa119-c1df-4861-99e2-c35c1214baa1@kernel.dk>
References: <20251006100226.4246-2-glaubitz@physik.fu-berlin.de>
	 <d78a1704-31dc-4eaa-8189-e3aba51d3fe2@kernel.dk>
	 <4e45e3182c4718cafad1166e9ef8dcca1c301651.camel@physik.fu-berlin.de>
	 <a80a1c5f-da21-4437-b956-a9f659c355a4@kernel.dk>
	 <e6a7e68ff9e23aee448003ee1a279a4ab13192c0.camel@physik.fu-berlin.de>
	 <cef07e8f-a919-4aa1-9904-84b16dfa8fe6@kernel.dk>
	 <5b3caa0e218dd473c8871c1b1f09a8dc1c356f1e.camel@physik.fu-berlin.de>
	 <ecb74c6c-8de6-4774-8159-2ec118437c57@kernel.dk>
	 <6ed7112cb4f338ba02d9ab67c14e7a3af4afbca0.camel@physik.fu-berlin.de>
	 <d23fa119-c1df-4861-99e2-c35c1214baa1@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Mon, 2025-10-06 at 08:27 -0600, Jens Axboe wrote:
> > > But that's fine, it's not uncommon for drivers to miss things like th=
at,
> > > and then we fix them up when noticed. It was probably written by some=
one
> > > not super familiar with the IO stack.
> >=20
> > FWIW, Oracle engineers actually made some significant changes to the
> > driver that they never upstreamed, see:
> >=20
> > https://github.com/oracle/linux-uek/commits/uek4/qu7/drivers/block/sunv=
dc.c
> >=20
> > In particular, they added support for out-of-order execution:
> >=20
> > https://github.com/oracle/linux-uek/commit/68f7c9c17fb80d29cbc1e5110f6c=
021f8da8d610
> >=20
> > and they also changed the driver to use the BIO-based interface for
> > VDC I/O requests:
> >=20
> > https://github.com/oracle/linux-uek/commit/4b725eb64cc10a4877f2af75ff3a=
776586f68eb7
> >=20
> > Could you review these two changes and tell me whether these would
> > actually implement the changes you would want to see? I think the BIO
> > layer is a generic interface of the block layer in the kernel, isn't
> > it?
>=20
> Moving lower down the stack to use a bio directly is not a good idea,
> it's in fact going the opposite direction of what we'd like to see in
> the storage stack. And it would then mean you'd need to implement your
> own internal requeueing and retrying.

I looked at the virtio_blk driver and that seems to confirm it. There is no
use of the bio interface either, so I guess we should not pick up this
patch.

What do you think about the out-of-order execution? Would that make sense
to upstream it? Does it look reasonable?

> These are the kind of changes that happen when development is done and
> changes aren't submitted upstream. It's unfortunate drift...

Well, the problem here is that Oracle stopped working on Linux for SPARC
abruptly, so many of their improvements were never sent upstream and did
not see any reviews which would have caught this.

> > > > > > For now, I would propose to pick up my patch to revert the prev=
ious
> > > > > > change. I can then pick up your proposed change and deploy it f=
or
> > > > > > extensive testing and see if it has any side effects.
> > > > >=20
> > > > > Why not just test this one and see if it works? As far as I can t=
ell,
> > > > > it's been 6.5 years since this change went in, I can't imagine th=
ere's a
> > > > > huge sense of urgency to fix it up that can't wait for testing a =
more
> > > > > proper patch rather than a work-around?
> > > >=20
> > > > Well, the thing is that a lot of people have been running older ker=
nels
> > > > on SPARC because of issues like these and I have started working on=
 trying
> > > > to track down all of these issues now [2] for users to be able to r=
un a
> > > > current kernel. So, the 6.5 years existence of this change shouldn'=
t
> > > > be an argument I think.
> > >=20
> > > While I agree that the bug is unfortunate, it's also a chance to
> > > properly fix it rather than just go back to busy looping. How difficu=
lt
> > > is it to test an iteration of the patch? It'd be annoying to queue a
> > > bandaid only to have to revert that again for a real fix. If this was=
 a
> > > regression from the last release or two then that'd be a different
> > > story, but the fact that this has persisted for 6.5 years and is only
> > > bubbling back up to mainstream now would seem to indicate that we sho=
uld
> > > spend a bit of extra time to just get it right the first time.
> >=20
> > We could do that for sure. But I would like to hear your opinion on
> > the changes contributed by Oracle engineers first. Maybe their
> > improvements are much better so that it might make sense to try to
> > upstream them.
>=20
> Won't help this case, and it's actively going the wrong direction
> imho...

OK, so your opinion is then to add the patch that you proposed on top of wh=
at's
currently there in Linus' tree, meaning adding some code that will requeue =
requests
once the retry limit has been reached?

Can you maybe post a proper patch then which I (and others) could test and =
then
hopefully add their "Tested-by"?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
