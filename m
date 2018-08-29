Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr690082.outbound.protection.outlook.com ([40.107.69.82]:40736
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeH2R0X (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 13:26:23 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] lightnvm: pblk: collection of small fixes
Date: Wed, 29 Aug 2018 13:27:43 +0000
Message-ID: <3F0AC430-4499-4D2D-B989-45B5635307A4@cnexlabs.com>
References: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
 <5b8881cd-019a-a1d8-86ed-0131ef3b71af@lightnvm.io>
In-Reply-To: <5b8881cd-019a-a1d8-86ed-0131ef3b71af@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_E6BDDCA7-6A60-4262-ABED-C5A4D0778146";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_E6BDDCA7-6A60-4262-ABED-C5A4D0778146
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 29 Aug 2018, at 15.14, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/29/2018 11:01 AM, Javier Gonz=C3=A1lez wrote:
>> Collection of small helper function fixes, removal of unused =
variables
>> and comment typos.
>> Javier Gonz=C3=A1lez (4):
>>   lightnvm: pblk: calculate line pad distance in helper
>>   lightnvm: pblk: fix comment typo
>>   lightnvm: pblk: remove unused variable.
>>   lightnvm: pblk: guarantee emeta on line close
>>  drivers/lightnvm/pblk-core.c     | 13 +++++++++++--
>>  drivers/lightnvm/pblk-recovery.c |  2 --
>>  drivers/lightnvm/pblk-write.c    |  2 +-
>>  drivers/lightnvm/pblk.h          |  6 +++---
>>  4 files changed, 15 insertions(+), 8 deletions(-)
>=20
> Thanks. Applied 2-4. The pad distance does not compile due to missing
> update to pblk_pad_distance call from pblk-recovery.c.
>=20
> Also, it looks like pblk-recovery.c is the only user. Please consider
> moving it the function from pblk.h to pblk-recovery.c

I reordered to send the helpers, but you can see that all these are made
to support.

  lightnvm: pblk: recover open lines on 2.0 devices

Can you fix this directly and apply 1 too? I'm fine with moving it to
pblk-recovery.c. The patch above will use it.

Thanks,
Javier

--Apple-Mail=_E6BDDCA7-6A60-4262-ABED-C5A4D0778146
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAluGn00ACgkQIX4xUKFR
nnT4thAApVuQbg0NYTAdvAG5Czzb4phHk/sIF/RkKyGnPD25rcBGya/N2GwQSmUP
EEY02R2dTclNsdqu8uqevSM9e/1o5uymcIn367m1uU6rsJDL9sU0d3bxyIKgdEmD
BuQ+0kPwu9eKOVPYi44km/fKrDNPRrBbV8WBWtdQQR0zRYr/Yyej/ut5SglsMRyL
Wck0pxSV2xRZcOt7OclrH/I1ALsPaawbAXDbPfgukP21sHFL5O8m6AStwPrXfcAu
axO4/WzMQxs7hjpLZFeyCMavwvMGGNYT0dz8b+3nTaajVjdUDyXM+ngvtL7RLjC0
C2yvpuDa6KTPAM6EIkR+NHwtnQwtQqXNPLAK8dBfnEUqoF10cC4bcv03InnGn7ZK
vhKovfnxPPTz4mUGO/mlPIIUmeTdzFS6KAHJSfodCUCkdKDiXGIl+IPGpUv1eIE2
d6X6EnCWBwt3CCP6tV44qL1dYHVoFEHWhFsAeS7KaXIMInNlK7Bc9GbuucxW141w
bOU2LUAacth+pciWBFp4jAxMGXRNVHWupexgUNavGAVmLBuLWfQ/8LSYQx5uNT0R
WcFg+KAeoHgGch+gHBGkvTigmIm6DlOiLoXPZwaynBKp6XuXcJoBlEXm5hDDFS9U
heEaYWGU/jtYhcRJQwhWcmpJmJb1wFVeHUSpz6Kzc+RsC+Gmaxg=
=6qew
-----END PGP SIGNATURE-----

--Apple-Mail=_E6BDDCA7-6A60-4262-ABED-C5A4D0778146--
