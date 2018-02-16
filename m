Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn3nam01on0074.outbound.protection.outlook.com ([104.47.33.74]:34371
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753313AbeBPGs0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Feb 2018 01:48:26 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2 5/6] lightnvm: remove nvm_dev_ops->max_phys_sect
Date: Fri, 16 Feb 2018 06:48:23 +0000
Message-ID: <918E7340-05D7-4E2F-BC43-2B81D435C3C6@cnexlabs.com>
References: <20180215131200.3354-1-mb@lightnvm.io>
 <20180215131200.3354-6-mb@lightnvm.io>
In-Reply-To: <20180215131200.3354-6-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4786F3EA-DA27-459F-9A97-E71A9CB717A5";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_4786F3EA-DA27-459F-9A97-E71A9CB717A5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 15 Feb 2018, at 05.11, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> The value of max_phys_sect is always static. Instead of
> defining it in the nvm_dev_ops structure, declare it as a global
> value.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/core.c          | 28 +++++++---------------------
> drivers/lightnvm/pblk-init.c     |  9 ++++-----
> drivers/lightnvm/pblk-recovery.c |  8 ++------
> drivers/nvme/host/lightnvm.c     |  5 +----
> include/linux/lightnvm.h         |  5 ++---
> 5 files changed, 16 insertions(+), 39 deletions(-)
>=20

The patch looks good, but I have a question. If a target implements the
scalar interface, then it will not be limited to 64 lbas/ppas and it
will not make sense to split the bio base don this value. In fact, it
looks like in time, we will move to a scalar interface in the 2.0 path
to align with the zoned interface, so this value will be dependent on
whether the target is using the scalar or vector interface.

Javier

--Apple-Mail=_4786F3EA-DA27-459F-9A97-E71A9CB717A5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqGfrUACgkQIX4xUKFR
nnR4qhAApHPsuY+VDzpeKEgVr40k1slDSVta6dG4h3ZuEiYKf5Sf+IQdi2EGg970
R8g9HvBNucDHETNxTksojcOmJM9SDRLMnMFxwOS1BI39YWYHu3ira3qjJEZea7CZ
5ZKGY/qERt/wxyLPEIbZ7CbF6GVICfgMfOvL4xMQLJQc+F2V/INZkmek0NO9Sjvu
vi3qDHTlJhQRpUdHmOSDaPrQ+fvohNYb3o5JHS/NvMX6Mm/qLOskbY3658Zp0tHH
oqs26nWRgz878ns6zCdfFCgUrCofQkZiTD6UMkY3hVpuspZU/MIslsjhj04hpNS1
MSjOV0Djp0XaSXlWZN5AggpOXymnh/NxmojgP2eEBS7bn/R9CuN2+OKmtx5OEvO9
o0Lhq+INzDD8p3E1MnyCssf9IezdcG+6C6Ap1EOQIkky0t1jiYEQd3uArMJTiRFN
NP4M2DAw/jCFtWNdLumapSbWdqEfEkldAlrzkjfYG4Ccp4LH8VYBA4f4I9S+9pOu
qr/F1U+5b/i4jwDEBSPPMdgHHgPXbAZYwWqfKV62IftVnSBi9Wz1gzi+SlQ1fLaN
aSmIotRtmo0gsdczKYy1TzFmuf4bLNltdO+eD1Bqlc1j41cDmGBawy7NwL3LPhh9
O+vI8iu/D7Lcmgj8TO2HV20WKDy+o4l+MkubzLaaGBAGO5AdYhY=
=qVlh
-----END PGP SIGNATURE-----

--Apple-Mail=_4786F3EA-DA27-459F-9A97-E71A9CB717A5--
