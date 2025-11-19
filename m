Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3D32F5A22;
	Wed, 19 Nov 2025 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542121; cv=none; b=UIhGxSsXSddWnOiH+kHLW6HK75fd1X/An2U4og3RtIMda8tJ+CikDeMZwKI0IG6F4uxQ7AiOqfq0ICO4FhqMEyYdVwOlNeR2cVubzWmBRnniIy6E97JYkQdP8VRhFxtKm50gHRdspq4ucLmPIjK5+1CLU6lgQJydLLlQbkN/8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542121; c=relaxed/simple;
	bh=ZXDJCTG0a3wVBGkMR+gySyKqlObDwQn/SbGAsOSvlsc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aijpIE+vbn8DeUn0fO2WOr1zDmz+VdWb7S9YWx2WEXkSZU3s+LjPcYBJM5vTTwSsCrj1V84kGy89XgvjA1xMUJHOkgOhu5GLrVRGyoSR/SEcgAcyUG+Ih8zMSrEY4roh+JvVQPmDy3+W7Mx4ofzEA7OHqonnhcmXiL6O5BW9X9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=n05BBwMM; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="n05BBwMM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=ufP6pvj4SMFKi7WHnDZB+3cQCZeOtNt9XW3iW+AYQSI=; t=1763542117;
	x=1764146917; b=n05BBwMMMbOTne81dp8UlC7tW1JMMbcP/04eVh9MvUkxm6KU7zdd9gllxvhmu
	Yo3Ut6DARy2s7gxViPpfHuG964QEOo4LeXN2iuSjQTFIF6tiwG3Pm1bXq8afEJBavc6EBV0Er/bPC
	LXBtreCutjZBT9SAbDjTe/8ZSm9qTpEduHSyEp9q5NpJWJcpUzLjuLTBsipq7KFxqtyTCNqFiPeKF
	uIugfEGEkWrq3kbHZ7Nsjzlf+8pSjDohbkapmIcgVhL0u2SlUcldd6rVnbI/GVA69V9UadUxRonko
	E86ZcCQ4LdtembBwZuegzCkWT4ztblb/mhQr6E8Jgb6I0pUxeg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vLdrY-00000001IS2-2p4x; Wed, 19 Nov 2025 09:48:28 +0100
Received: from tmo-084-142.customers.d1-online.com ([80.187.84.142] helo=[172.20.10.2])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vLdrY-00000001YKa-1o91; Wed, 19 Nov 2025 09:48:28 +0100
Message-ID: <bb9b0a6720b8bba08981fb0d0d0de5e61b0cbb2d.camel@physik.fu-berlin.de>
Subject: Re: PROBLEM: errors mounting /dev/fd0 on sparc64 (regression)
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Nick Bowler <nbowler@draconx.ca>, linux-block@vger.kernel.org, 
	sparclinux@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, regressions@lists.linux.dev
Date: Wed, 19 Nov 2025 09:48:24 +0100
In-Reply-To: <u3aaz4bx7xwlboyppeg4y3eixzgxbcodlmw7cwqloskmg6oqw2@j437p47sfww6>
References: 
	<u3aaz4bx7xwlboyppeg4y3eixzgxbcodlmw7cwqloskmg6oqw2@j437p47sfww6>
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

Hi Nick,

On Wed, 2025-11-19 at 03:04 -0500, Nick Bowler wrote:
> With current kernels on my sparc64 system, I can no longer mount floppy
> disks via /dev/fd0.  Mounting the specific-format device /dev/fd0u1440
> works ok, and if I do that once then /dev/fd0 works afterwards.
>=20
>   # mount -t vfat /dev/fd0 /mnt
>   mount: mounting /dev/fd0 on /mnt failed: No such device or address
>=20
>   # dmesg
>   [...]
>   mount: attempt to access beyond end of device
>   fd0: rw=3D0, sector=3D0, nr_sectors =3D 16 limit=3D8
>   floppy: error 10 while reading block 0
>   /dev/fd0: Can't open blockdev
>=20
>   # mount -t vfat /dev/fd0u1440 /mnt
>   [works]
>=20
>   # umount /mnt
>   # mount -t vfat /dev/fd0 /mnt
>   [works]
>=20
> I bisected the failure to this old commit:
>=20
>   commit 74d46992e0d9dee7f1f376de0d56d31614c8a17a
>   Author: Christoph Hellwig <hch@lst.de>
>   Date:   Wed Aug 23 19:10:32 2017 +0200
>  =20
>       block: replace bi_bdev with a gendisk pointer and partitions index
>=20
> And digging in a bit further, prior to this commit the maxsector value
> in bio_check_eod (which prints this error) was calculated as 0, which
> would seem to effectively disable the check, but now it is 8.  This 8
> is coming from the set_capacity call in floppy_open, which in turn
> comes from the entry in the floppy_sizes table which is initially
> set to MAX_DISK_SIZE*2 (a constant 8).
>=20
> Using the latest 6.18-rc6, if I change the definition of MAX_DISK_SIZE
> in floppy.c from 4 to 8, then mounting /dev/fd0 works again, but I'm
> unsure if this is a proper fix.

This is a known problem and documented here [1] in the sparclinux issue tra=
cker.

The problem is basically that the floppy driver assumes that the page size =
is
always 4k which fails on any target using larger page sizes such as SPARC w=
here
the default page size is 8k.

Adrian

> [1] https://github.com/sparclinux/issues/issues/18

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
