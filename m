Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:44982 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdJBMJi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 08:09:38 -0400
Received: by mail-wm0-f44.google.com with SMTP id 196so2362713wma.1
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2017 05:09:37 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <5E8B439C-5971-49DF-BDC4-3B53268F8FF4@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_36C3D052-5364-46D3-AE8B-19732AC1EBAA";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 5/6] lightnvm: pblk: free up mempool allocation for erases
 correctly
Date: Mon, 2 Oct 2017 14:09:35 +0200
In-Reply-To: <20171001132555.GA5763@hercules.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20171001132555.GA5763@hercules.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_36C3D052-5364-46D3-AE8B-19732AC1EBAA
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

> On 1 Oct 2017, at 15.25, Rakesh Pandit <rakesh@tuxera.com> wrote:
> 
> While separating read and erase mempools in 22da65a1b pblk_g_rq_cache
> was used two times to set aside memory both for erase and read
> requests.  Because same kmem cache is used repeatedly a single call to
> kmem_cache_destroy wouldn't deallocate everything.  Repeatedly doing
> loading and unloading of pblk modules would eventually result in some
> leak.
> 
> The fix is to really use separate kmem cache and track it
> appropriately.
> 
> Fixes: 22da65a1b ("lightnvm: pblk: decouple read/erase mempools")
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> 

I'm not sure I follow this logic. I assume that you're thinking of the
refcount on kmem_cache. During cache creation, all is good; if a
different cache creation fails, destruction is guaranteed, since the
refcount is 0. On tear down (pblk_core_free), we destroy the mempools
associated to the caches. In this case, the refcount goes to 0 too, as
we destroy the 2 mempools. So I don't see where the leak can happen. Am
I missing something?

In any case, Jens reported some bugs on the mempools, where we did not
guarantee forward progress. Here you can find the original discussion
and the mempool audit [1]. Would be good if you reviewed these.

[1] https://www.spinics.net/lists/kernel/msg2602274.html

Thanks,
Javier

--Apple-Mail=_36C3D052-5364-46D3-AE8B-19732AC1EBAA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnSLH8ACgkQYx8FO3WZ
GMos1xAAy2LtMnOqkyamFKZV1yPsn8YNiW+g1TfSSUFxBHrWs5gAtn88GHSD2Bxm
4VEUoNEfFy8vv+E0+ypPuYzzdF7eOFN152ltX+Z7eQVpjuPhMFoCBVjHwmet160X
v41rO/zhJfrC+rE1+c8o6saHKTLHnByRmmQI85kjUZ99eu/OwX/qEgXzsu5vQ2hs
joV0eykzJ5GZxStmtBy8CWUhgbqYqkR0w5WMphJ9CRkisDZE+zFlR5Dh+4UeYNyb
BcWJb1xOVXR8Af2ozP3FMumBoTUgpvtw737WQUQFP1ucYHBqGnfkI7+EoOrLNST3
wLiqxvzbjXNaAlHRAoPme0uim6Vlyt/mUQk+v1WtCFFHUoiC7KneVo1JLEfymYWF
nESyyZ9mOgjhMBQJyNXaUwPxCYoFIKp0cS1OV00hvLp2Z8fbgII+oCLbVY+LLfBt
MjELJesjJyviCcCg5bTRn/3hjGrWqGOGVWkweQtcLIGlTZEbRwoAYFkmKVWb28S8
xcncWCkpsL/s5y/8dki8dhIq9VzyUZ/eDZszCC+IRxWgdECvACNmM18J03mo04Af
PICmSXTne9ahNONMD4oOlkD1FbCgxgtVLyMEwsUDPdEV5OxDk4lGhwxYl71pcvGs
KHlj5311pOzFI+wLcxdRq0pkTjC2DkcectX4+3pjjUBMSFnlkJw=
=XwQv
-----END PGP SIGNATURE-----

--Apple-Mail=_36C3D052-5364-46D3-AE8B-19732AC1EBAA--
