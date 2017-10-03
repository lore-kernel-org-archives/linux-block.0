Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:49873 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbdJCKvr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:51:47 -0400
Received: by mail-wm0-f44.google.com with SMTP id b189so11911866wmd.4
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:51:46 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <6EA9CAAC-795C-47E9-AB08-35B4B9D9BC39@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_78B4DC00-A540-4118-8C32-6A974E788FA4";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/9] recovery robustness improvements
Date: Tue, 3 Oct 2017 12:51:43 +0200
In-Reply-To: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_78B4DC00-A540-4118-8C32-6A974E788FA4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 3 Oct 2017, at 12.05, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> This patchset improves the robustness of recovery - fixing a bunch of
> issues that occurs when removing and re-creating a pblk instance.
> It also adds a couple of debug-only prints to facilitate detection
> of L2P table corruptions.
>=20
> The patches apply on top of:
> https://github.com/OpenChannelSSD/linux branch for-4.15/pblk
>=20
> Hans Holmberg (9):
>  lightnvm: pblk: prevent gc kicks when gc is not operational
>  lightnvm: pblk: recover partially written lines correctly
>  lightnvm: pblk: free full lines during recovery
>  lightnvm: pblk: start gc if needed during init
>  lightnvm: pblk: consider bad sectors in emeta during recovery
>  lightnvm: pblk: shut down gc gracefully during exit
>  lightnvm: pblk: add l2p crc debug printouts
>  lightnvm: pblk: gc all lines in the pipeline before exit
>  lightnvm: pblk: correct valid lba count calculation
>=20
> drivers/lightnvm/pblk-core.c     |  3 ++
> drivers/lightnvm/pblk-gc.c       | 88 =
+++++++++++++++++++++++++++-------------
> drivers/lightnvm/pblk-init.c     | 47 ++++++++++++++++++---
> drivers/lightnvm/pblk-map.c      |  7 ++--
> drivers/lightnvm/pblk-recovery.c | 46 ++++++++++++++-------
> drivers/lightnvm/pblk-sysfs.c    |  2 +-
> drivers/lightnvm/pblk.h          |  6 ++-
> 7 files changed, 145 insertions(+), 54 deletions(-)
>=20
> --
> 2.7.4

Thanks Hans.

Matias: I picked the patches on for-4.15/pblk on top of the rest of the
series and fixed some of the commit messages. Also, note that Rakesh's
patches needed some re-work, so please pick them from this tree instead.

They should apply clean on your for-4.15/core.

Thanks,
Javier

--Apple-Mail=_78B4DC00-A540-4118-8C32-6A974E788FA4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnTa78ACgkQYx8FO3WZ
GMr4vxAAh9zJqX+2Qz9ufs6R1rM67dmQlqdmrV6ewsgj//eGqzwCuBXXxYHcSFpW
VNihUl0KjZSTWYrHP/RTrZGTecc0cTMySmmkPPOh3JbAqhvw99W6kPfA9x7iZmL3
d5X57Fhalx9tM1jp7ZsxTu0yOygDlkYlZmVuxXkrq/+2OWY5OqNSJyfC1rFEaupm
0e3Lk8ZN2yv5TwhWawQbQzetaHBlWUyLk8iW36e83r5WzHIC1QkUECk2DLgkAJZJ
HRu+MoXlZp8YYwRWIW1T652eA3X/9MnO5M6xu5jryNQ8VUmnUcPDdNMP4goiwsBt
+1oCcopGOxdizPDQJWp6vYNCU5xwVg90pp/7NxexOb6j5NE2u9rj9fxGaYImPj6w
B2yJ9XJ0Y6yvSznFh2W4WvXsUIs43lhdm4HiIPumuRRwO6mav4dX2VukKJ+Kj0PS
lWX7EfPf/0Sl8coElmBCXm35kAdJRViag22X6Jp7KUIYmvJfVi8Uw5UY677QShJl
jF5YVU/WR9+8145hpyMTu9f0T614v7CjkFQwLOfOUGs231mpiF+nb5jiNZfql0p4
/FJKCX4BiZ8FMiLAXx+0vRIo0/26Yj8Mgei8/jYAz4n22Rmil+n5tXvKh31cI1Tl
+twhU56HB6Rk+oBYLueoK8h95ip5S84znlAp+cm/w8fCgT1HPCI=
=Nkzz
-----END PGP SIGNATURE-----

--Apple-Mail=_78B4DC00-A540-4118-8C32-6A974E788FA4--
