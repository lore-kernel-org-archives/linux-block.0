Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE334164B
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763545170; cv=none; b=tCgrejzqNZlP4fU5NRh/cG4QVUrPkIp3Ib1CnnP6YNDcfE4K1hOpPDPU1wzYa0LWYnAMm5utUxGupVkidl384SiJINdWqGfrwcWjZ5f3O3ymnjsP7lURHWx5Z9KPAypR/pvhWAfaWIAVYow+rVxAptfdmJ1zqLXk3/uGFbG18aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763545170; c=relaxed/simple;
	bh=828wriRukm1Hscc/LN/b8y2buq2ikPiwc62EzahKk4M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rgNwalaO7HBmwIceNuvqO/nuxg4BDLcw0sarXKvSfynCKJhJOickvtRthqScbSBtyjSdSYUNBbWiBD765A83aeSviG1FqsxbSLxWkbWe8yhBo8wjh6zoN0meTI23dk8XHgOWkdCxlyxFuUoa+eDRUq8kJiHJ4jP817ZjW7l8zz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=DLC4/x2n; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="DLC4/x2n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=L1lb9SIBvAoXaP5z2fRMc4ltZB6rjV+5yohY+QhUbZw=; t=1763545166;
	x=1764149966; b=DLC4/x2nFw5ec3XQT/RuB7kOiywXu0ENP/wPMgmHwarcMuBcgGSDYReT60qPT
	X3mVbkDIfKuHkOuM/HDIIi0GuWVQiE37cwd0vA355vRAfU7DBOyFyjnPIVYFY7SbMowwgy8dJMRsy
	9f64fd1kFKCixDcFVMauHEKIIj4iQ6JSwcrCQf3ARKXLYMDqYr1GMbnVDJwhUU77FlIMbyVfOARcN
	q1cOpF5+tle+eOK5d4mHcBR6YqdZTqDs6t9o+9XO+A8Ao5e+qzwnzi0sdyPnB+x3aEPlZ3e1uY5QL
	OzLZWv322DH1GxpFyyBV+LjvVqiTbhy8/utoAMhDXZJ8ydC16w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vLeeq-00000001jqW-2ryU; Wed, 19 Nov 2025 10:39:24 +0100
Received: from tmo-084-142.customers.d1-online.com ([80.187.84.142] helo=[172.20.10.2])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vLeeq-00000001fmi-1rVr; Wed, 19 Nov 2025 10:39:24 +0100
Message-ID: <792a2d8cc1204c5b3fee76826ab24569c1fa152e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] fix floppy for PAGE_SIZE != 4KB
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	efremov@linux.com, Nick Bowler <nbowler@draconx.ca>
Date: Wed, 19 Nov 2025 10:39:23 +0100
In-Reply-To: <1E5D751F-0DCE-4AE2-9DC5-4D9EF0D8FA8E@exactco.de>
References: <b1e17016-3d4d-4fac-b5b0-97db357d0749@kernel.dk>
	 <20251114.172543.20704181754788128.rene@exactco.de>
	 <fec67c88-53f5-4482-aeef-86e1213d187e@kernel.dk>
	 <20251114.192119.1776060250519701367.rene@exactco.de>
	 <708B7962-86CD-489B-AC33-4B929F2902B6@exactco.de>
	 <c8cbccc1-964c-43ce-a992-624d2efcfd4a@kernel.dk>
	 <57be21424d0e23142ea67ca9de3ca4ca033e1ee7.camel@physik.fu-berlin.de>
	 <900D7C37-DF73-49D5-950D-81D84D6DA9CD@exactco.de>
	 <4d3482372549a7746c639299c50319bad6b4b6c7.camel@physik.fu-berlin.de>
	 <1E5D751F-0DCE-4AE2-9DC5-4D9EF0D8FA8E@exactco.de>
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

Hi,

On Wed, 2025-11-19 at 10:24 +0100, Ren=C3=A9 Rebe wrote:
> Hi,
>=20
> > On 19. Nov 2025, at 10:22, John Paul Adrian Glaubitz <glaubitz@physik.f=
u-berlin.de> wrote:
> >=20
> > On Wed, 2025-11-19 at 10:12 +0100, Ren=C3=A9 Rebe wrote:
> > > > > Yep we can do that. It'd be great if we could augment the change =
with
> > > > > what commit broke it, so it can get backported to stable kernels =
as
> > > > > well. Was it:
> > > > >=20
> > > > > commit fe4ec12e1865a2114056b799e4869bf4c30e47df
> > > > > Author: Christoph Hellwig <hch@lst.de>
> > > > > Date:   Fri Jun 26 10:01:52 2020 +0200
> > > > >=20
> > > > >   floppy: use block_size
> > > >=20
> > > > Yes, Nick Bowler (CC'ed) bisected it to this commit in [1].
> > >=20
> > > Nice, thanks!
> > >=20
> > > Carefully, it appears to be another commit though:
> > >=20
> > > > I bisected the failure to this old commit:
> > > >=20
> > > >  commit 74d46992e0d9dee7f1f376de0d56d31614c8a17a
> > > >  Author: Christoph Hellwig <hch@lst.de>
> > > >  Date:   Wed Aug 23 19:10:32 2017 +0200
> > > >        block: replace bi_bdev with a gendisk pointer and partitions=
 index
> >=20
> > Yes, you're right. I was briefly distracted when writing this mail.
>=20
> No worries, just checking. Should I send a new patch with the Fixes:
> or can Jens just add it?

Jens picked the patch up for his block tree already [1], but he could still=
 take
a version 2 from you and force-push the new patch to his tree.

The proper tag would be:

Fixes: 74d46992e0d9 ("block: replace bi_bdev with a gendisk pointer and par=
titions index")

It's up to Jens in any case.

Adrian

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/commi=
t/?h=3Dfor-6.19/block&id=3D82d20481024cbae2ea87fe8b86d12961bfda7169

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
