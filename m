Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0047.outbound.protection.outlook.com ([104.47.41.47]:55837
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750847AbeBHJfS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Feb 2018 04:35:18 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] lightnvm: base 2.0 implementation
Date: Thu, 8 Feb 2018 09:35:16 +0000
Message-ID: <DA4E2087-F1E8-4903-9B53-95CFECD6B868@cnexlabs.com>
References: <20180205121505.27563-1-mb@lightnvm.io>
In-Reply-To: <20180205121505.27563-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4F195F56-F6B3-4532-99A2-9D6D4F042D41";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_4F195F56-F6B3-4532-99A2-9D6D4F042D41
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Feb 2018, at 13.15, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> Hi,
>=20
> A couple of patches for 2.0 support for the lightnvm subsystem. They
> form the basis for integrating 2.0 support.
>=20
> For the rest of the support, Javier has code that implements report
> chunk and sets up the LBA format data structure. He also has a bunch
> of patches that brings pblk up to speed.
>=20
> The first two patches is preparation for the 2.0 work. The third patch
> implements the 2.0 data structures, the geometry command, and exposes
> the sysfs attributes that comes with the 2.0 specification. Note that
> the attributes between 1.2 and 2.0 are different, and it is expected
> that user-space shall use the version sysfs attribute to know which
> attributes will be available.
>=20
> The last patch implements support for using the nvme namespace logical
> block and metadata fields and sync it with the internal lightnvm
> identify structures.
>=20
> -Matias
>=20
> Matias Bj=C3=B8rling (4):
>  lightnvm: make 1.2 data structures explicit
>  lightnvm: flatten nvm_id_group into nvm_id
>  lightnvm: add 2.0 geometry identification
>  nvme: lightnvm: add late setup of block size and metadata
>=20
> drivers/lightnvm/core.c      |  27 ++-
> drivers/nvme/host/core.c     |   2 +
> drivers/nvme/host/lightnvm.c | 508 =
++++++++++++++++++++++++++++++++-----------
> drivers/nvme/host/nvme.h     |   2 +
> include/linux/lightnvm.h     |  64 +++---
> 5 files changed, 426 insertions(+), 177 deletions(-)
>=20
> --
> 2.11.0

Thanks for posting these. I have started rebasing my patches on top of
the new geometry - it is a bit different of how I implemented it, but
I'll take care of it.

I'll review as I go - some of the changes I have might make sense to
squash in your patches to keep a clean history...

I'll add a couple of patches abstracting the geometry so that at core.c
level we only work with a single geometry structure. This is they way it
is done in the early patches I pointe you to before. Then it is patches
building bottom-up support for the new features in 2.0.

Javier

--Apple-Mail=_4F195F56-F6B3-4532-99A2-9D6D4F042D41
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlp8Gc0ACgkQIX4xUKFR
nnThRhAA2WJXLv0cMnWZjfxH5QYLcCzApf2A6vsQszHvLQphjYkHOt72IzCUV+Do
SaHWTX1n/vfQbvt8GnH54kDd6eqmi8Q1eleDRDx+kLlpeZym/lmRJ31WdGP3rlCQ
deK0PwnEBL5pejocoE02gAIL4e/+mJZGj855MaYrgohFmZWODeJBk83XafQkp4Qo
XE+wjEBFH33KZ7ycbk9jdWpmUci5PIM87pToKZL4bDoM19sb27PiqqkEN1b/dQsc
zO4BWI7wZvcfZWLqPYfwVAog4vheb0DVvud3r2yyPRqHRL3x7jON8yJn3wOqkzTJ
F9htEGRfvn+RgAdlhlyIgf6uzkOKadreIT7lYkiu3mvh0rlnlsOHcWxZJPLhK3/W
07piOdkup8wdZef8RSsymQzxWLqdnnmq3QMuRtNBV6fftkLy5lipDIq/06M4egge
MmU/n8uLmJkheMcQMSK0BimnNck619+U53AJ+LdVTupoi23Q1cBVS+86G5qFywFv
g6DuilBXrnMcyBvTj3DN0CpN4qXQabQ7qZCfRfASHIlm/niWSmwm66rDlJ4oxpGN
jiYzu46MEnhqi2jVEwiorIhaNkDc6UpT7zJXfufUz5jPb+rzVmRLSoTDheF6MlX8
gPXXDEujVTFvx983T9+ngccVLJH6lYYEp6orQAgVtyT+lEp0QY4=
=93iq
-----END PGP SIGNATURE-----

--Apple-Mail=_4F195F56-F6B3-4532-99A2-9D6D4F042D41--
