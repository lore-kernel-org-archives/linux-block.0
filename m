Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5582868A2
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542824; cv=none; b=R9DS5ZSRtXy2EAjURrGF7NuIrv/QaIFt/Oegcj/ngYMtsP0KrkvkGGnETgpoFpQGNYOgaeaWJecgM00WuGG7eFHGxt7+152db15ivDLYKQIkEGQ0+UOOGNCSWM/+U9tmmtN0b17z2WTNnWvYUNr3yrcs5b5ufTEc9kPVO1NMgfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542824; c=relaxed/simple;
	bh=vjs9/0LdjelK+1+JfTkvSTS3plYFv51sUeGPqkVwOTk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P+oPN95dPJJJIq2GnzorbQleDOaY4rg7JrNZuJvv/W75P8EpNjqzp/6l61RHbu6BWUv2n0VkJmPIq7SZvHZfsBw/JliPIQp1CkeEjVIZsKzN4O93O3oVc3QeKUuYNhc+d5LjG8xSb7eT73THrIP+Z32lUD9/irxqOJo8aJK+pW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=cby5hv4L; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="cby5hv4L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=6n9N18+ykyrRs7rHKMF9otNd9kCSetBPcxN0JD05J6Q=; t=1763542821;
	x=1764147621; b=cby5hv4LiCddnQcoX08cHa+16fg7gzNFK16Q9ZNQh68zfmVmhX+Y4ICFbwbEg
	3RORiGsj/8OMVsHxvr78vy/oiAAuRhhxEKV6bbtU+Eqi4UloE8OeBaHxgBqxccHUkZ4CjfK0tMm7r
	jkn7wCkB3CwxqmrNx/w8RnrbXoR62Q2dcrmPcAEn/nwixSkT2NNmwCkjesc7fmN6PdALKrNH+2hoT
	Rtb/8nZQt28OmoQwZz4id/f4t+KRIJwRIUYd1b44Iktg/cMQl5eKaYXgLLtHW4RlaQxfFWDCWKIlw
	wCHhRUfaBh6Dbi8iQ5jPVpM5VsMrOTfbeX06cj2q2EIE4YCLVw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vLe30-00000001OxQ-1VN2; Wed, 19 Nov 2025 10:00:18 +0100
Received: from tmo-084-142.customers.d1-online.com ([80.187.84.142] helo=[172.20.10.2])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vLe30-00000001a4v-0W53; Wed, 19 Nov 2025 10:00:18 +0100
Message-ID: <57be21424d0e23142ea67ca9de3ca4ca033e1ee7.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] fix floppy for PAGE_SIZE != 4KB
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jens Axboe <axboe@kernel.dk>, =?ISO-8859-1?Q?Ren=E9?= Rebe
 <rene@exactco.de>
Cc: linux-block@vger.kernel.org, efremov@linux.com, Nick Bowler
	 <nbowler@draconx.ca>
Date: Wed, 19 Nov 2025 10:00:17 +0100
In-Reply-To: <c8cbccc1-964c-43ce-a992-624d2efcfd4a@kernel.dk>
References: <b1e17016-3d4d-4fac-b5b0-97db357d0749@kernel.dk>
	 <20251114.172543.20704181754788128.rene@exactco.de>
	 <fec67c88-53f5-4482-aeef-86e1213d187e@kernel.dk>
	 <20251114.192119.1776060250519701367.rene@exactco.de>
	 <708B7962-86CD-489B-AC33-4B929F2902B6@exactco.de>
	 <c8cbccc1-964c-43ce-a992-624d2efcfd4a@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Jens,

On Mon, 2025-11-17 at 06:23 -0700, Jens Axboe wrote:
> On 11/17/25 2:56 AM, Ren? Rebe wrote:
> > Hi,
> >=20
> > > > 64k is 4% of a floppy disk! But I hear you, works for you.
> > >=20
> > > Again, still only 8k or 16k for most of such remaining workstation
> > > floppy users.
> > >=20
> > > > > But if someone wants to refactor this code some more, ... I'm hap=
py to
> > > > > test it, too ;-)
> > > >=20
> > > > I don't think refactoring would be required here, it's probably jus=
t
> > > > capping that probe read to something constant irrespective of hardw=
are
> > > > page sizes.
> > >=20
> > > Well, the floppy.c __floppy_read_block_0 does:
> > >        bio_init(&bio, bdev, &bio_vec, 1, REQ_OP_READ);
> > >        __bio_add_page(&bio, page, block_size(bdev), 0);
> > >=20
> > > Is there an easy way to limit that to less than a page without
> > > refactoring it too much? Otherwise we could just apply this hotfix fo=
r
> > > now.
> >=20
> >=20
> > Any chance we can get my initial one liner constant PAGE_SIZE fix
> > for this over a decade old bug in? I currently don?t have a budget
> > to refactor the floppy driver probing for efficiency on bigger PAGE_SIZ=
E
> > configs I?m not even having a floppy controller on.
>=20
> Yep we can do that. It'd be great if we could augment the change with
> what commit broke it, so it can get backported to stable kernels as
> well. Was it:
>=20
> commit fe4ec12e1865a2114056b799e4869bf4c30e47df
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Fri Jun 26 10:01:52 2020 +0200
>=20
>     floppy: use block_size

Yes, Nick Bowler (CC'ed) bisected it to this commit in [1].

So, I suggest to add a proper "Fixes:" tag so the patch is propagated
to all stable kernels.

Adrian

> [1] https://lore.kernel.org/all/u3aaz4bx7xwlboyppeg4y3eixzgxbcodlmw7cwqlo=
skmg6oqw2@j437p47sfww6/

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
