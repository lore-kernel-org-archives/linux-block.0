Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:45673 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeAaBza (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jan 2018 20:55:30 -0500
Received: by mail-io0-f194.google.com with SMTP id p188so13640474ioe.12
        for <linux-block@vger.kernel.org>; Tue, 30 Jan 2018 17:55:29 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <0FC27C54-C199-4A6A-9948-E7AD9D3B86BD@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_DB1E0402-3C01-4D72-A1DD-86D2A5AFC2B2";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] lightnvm: remove chnl_offset in nvme_nvm_identity
Date: Wed, 31 Jan 2018 09:55:11 +0800
In-Reply-To: <20180130143050.18355-1-mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <20180130143050.18355-1-mb@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_DB1E0402-3C01-4D72-A1DD-86D2A5AFC2B2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 30 Jan 2018, at 22.30, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> The identity structure is initialized to zero in the beginning of
> the nvme_nvm_identity function. The chnl_offset is separately set to
> zero. Since both the variable and assignment is never changed, remove
> them.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/nvme/host/lightnvm.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>=20

Looks good.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_DB1E0402-3C01-4D72-A1DD-86D2A5AFC2B2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlpxIgAACgkQYx8FO3WZ
GMowKA/9F/+E7j9dKWNC3V3RclaZ16XB2kakTmFGQSObwC/Pir2jl4BJnhGlhkwU
1CnLDyRA6M3fSHJ4mg6riwVcSJCQNsxBIUG+6tE4hHTdu85yvxNROXoMfq5dLHVW
rb1wTaGULk5O3lJJS4xNd/l1GGxRhpM+r9rShSbJmHJlx7xVAWJAX39uKFT9YmOq
jF2yd/i/ZF6+H/uXB9/nGOPdpoXCCzbbwAGIfQu7qhx8WVXdumDxwl8O+rvHf4M/
dslgwInOZ3sRig+TNhhlDPHk57KxtA1Dkng7OYgEV++wmq8DpgWyljW4Gs2nvr2s
OIyzsBF8P52y+TaovSxQn6+qL+ZGVWOAt2qzxNzCPm9k5Nv3UIblam39MMYTrw0V
6RpxEdNW8kWzREb/R0hxKnkZWh2PhfJzwAEzNZ0QM2Ov2fFkfj0t+WHgnWCXmP5+
UneRECK9z3bygjwDaGIkgTRwTP4O+z8QqiRtePfCPpCGWlysoRjBNlRBN19c+NJY
5dllLKkVde7LW/2pGz6AJZynokjpSxUkeDrKmALvEw/zpW8JWPT5yna8qE1ZHAHI
eUvz5Gx3aoji4if7r5fJbg6n6S1CkLOFRxCW1DRGYOCfgkNRmLg3ywsd/4oAZxGL
b9qnMgXYLFANRaGjXeWWBxFMJ53mJODO+lKlsmqsgv6qYX/GG7s=
=j6gu
-----END PGP SIGNATURE-----

--Apple-Mail=_DB1E0402-3C01-4D72-A1DD-86D2A5AFC2B2--
