Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E24F32E748
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542713; cv=none; b=Bih68zAlcHg919I9acblmUNQWBzLWjizgwJOYS5UJ7rSlzJrbSbV9/8XsFe7ILH2H5c4/Nz/qRO3OeXHr/6c2kmv1WHb3+qWejAXDRAK06I1SlgrCCX1+0ppzaoLaRnT/KQifb2UmU05iOov/xroLDzqvL+rgGzP1RDi/2+pFBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542713; c=relaxed/simple;
	bh=aBeJVcGUyUQ/yP7qBCu7C17SN0M2/rTszTBGNrknguI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hXtf5Kb4CyeeMU0rF1TwNZUAhTO9ynbF+Zi9QHaQH2FlrmmacQjPWnWR0HjClHsPXNxl5vQP/4kVcqeDGkxkshmZKSEzrfTrmO7733yIcI0NYHk/UBo+WzzLTzV9BWlfO2VRY4wbFGWbxElxzwoAchvuqxQQxJ4o8AK5Y775vNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=bkLzHROz; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="bkLzHROz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=N3TEVd4dB7UtlQteHr5dZM1OQYqQ8R5i7nvj5arl/Gw=; t=1763542708;
	x=1764147508; b=bkLzHROzTmF3kiWYuHKo5Nkre8y7lPgKFahrDPwoaPDrSvdTweiWBtuMhgxU5
	UMCn36jm8AbVeyASEtJo4KXZ5oGv2PmJlSrlg2Q0G+Cu9QNDHstCId+3QydRNxULI5SKW/3zG8hge
	vl1xE5PpB0j9S+F7XGSO+HR3SRyGbTlbqKGlKJam7HmwbK83oubTcbiN6OfcJ+PqDPQdqlEDEIZAb
	EafPYPsNjiIQzcaBMzyPAIhW47jKmsRWN2rhyD4e8aPR7etNLV1zjVq8+/wvQ8uizIHR67w6fT0fC
	gkafCv78R/sljaOVuzpYT//j/2PtVogSUmeJQepNnTcPJPnv5A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vLe1C-00000001NEt-0ZzP; Wed, 19 Nov 2025 09:58:26 +0100
Received: from tmo-084-142.customers.d1-online.com ([80.187.84.142] helo=[172.20.10.2])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vLe1B-00000001Zp0-3ozx; Wed, 19 Nov 2025 09:58:26 +0100
Message-ID: <8b4a5870169b4468a94479299882aab61ad0b20a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] fix floppy for PAGE_SIZE != 4KB
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Jens Axboe <axboe@kernel.dk>, Rene Rebe <rene@exactco.de>, 
	linux-block@vger.kernel.org
Cc: Denis Efremov <efremov@linux.com>
Date: Wed, 19 Nov 2025 09:58:25 +0100
In-Reply-To: <b1e17016-3d4d-4fac-b5b0-97db357d0749@kernel.dk>
References: <20251114.144127.170518024415947073.rene@exactco.de>
	 <b1e17016-3d4d-4fac-b5b0-97db357d0749@kernel.dk>
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

On Fri, 2025-11-14 at 09:11 -0700, Jens Axboe wrote:
> On 11/14/25 6:41 AM, Rene Rebe wrote:
> > For years I wondered why the floppy driver does not just work on
> > sparc64, e.g:
> >=20
> > root@SUNW_375_0066:# disktype /dev/fd0
> > --- /dev/fd0
> > disktype: Can't open /dev/fd0: No such device or address
> >=20
> > [  525.341906] disktype: attempt to access beyond end of device
> >                fd0: rw=3D0, sector=3D0, nr_sectors =3D 16 limit=3D8
> > [  525.341991] floppy: error 10 while reading block 0
> >=20
> > Turns out floppy.c __floppy_read_block_0 tries to read one page for
> > the first test read to determine the disk size and thus fails if that
> > is greater than 4k. Adjust minimum MAX_DISK_SIZE to PAGE_SIZE to fix
> > floppy on sparc64 and likely all other PAGE_SIZE !=3D 4KB configs.
>=20
> 16k seem like a lot to read from a floppy, no? Why isn't it just
> reading a single 512b sector? Or just cap it at 4k rather than do
> a full page, at least?

My understanding was that the initial read is necessary to determine the
size of the floppy disk. And the easiest approach was to just read as
many sectors that fit into one page which would be 8 512-byte sectors
in a 4k page.

Since back in the days, the standard page size was always 4k, this never
caused any problems.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
