Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr720068.outbound.protection.outlook.com ([40.107.72.68]:29738
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933005AbeF2L41 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jun 2018 07:56:27 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        Heiner Litz <hlitz@ucsc.edu>,
        Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] lightnvm: pblk: expose generic disk name on pr_* msgs
Date: Fri, 29 Jun 2018 11:56:24 +0000
Message-ID: <13BD1F74-4DBE-44BA-A774-4844E2886F73@cnexlabs.com>
References: <20180629114543.28510-1-mb@lightnvm.io>
In-Reply-To: <20180629114543.28510-1-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_EA280E78-9C45-4A7A-90D0-1B183DD9B940";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_EA280E78-9C45-4A7A-90D0-1B183DD9B940
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 29 Jun 2018, at 13.45, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> The error messages in pblk does not say which pblk instance that
> a message occurred from. Update each error message to reflect the
> instance it belongs to, and also prefix it with pblk, so we know
> the message comes from the pblk module.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
>=20
> ---
>=20
> v3:
>  - Missing kfree's when spec not supported.
> v2:
>  - Forgot to test with NVM_PBLK_DEBUG on. Fixed up the broken code.
> ---
> drivers/lightnvm/pblk-core.c     | 51 ++++++++++++-------------
> drivers/lightnvm/pblk-gc.c       | 32 ++++++++--------
> drivers/lightnvm/pblk-init.c     | 80 =
++++++++++++++++++++--------------------
> drivers/lightnvm/pblk-rb.c       |  8 ++--
> drivers/lightnvm/pblk-read.c     | 25 +++++++------
> drivers/lightnvm/pblk-recovery.c | 44 +++++++++++-----------
> drivers/lightnvm/pblk-sysfs.c    |  5 +--
> drivers/lightnvm/pblk-write.c    | 21 ++++++-----
> drivers/lightnvm/pblk.h          | 29 ++++++++++-----
> 9 files changed, 155 insertions(+), 140 deletions(-)
>=20

Looks good to me.

Thanks!

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_EA280E78-9C45-4A7A-90D0-1B183DD9B940
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAls2HmUACgkQIX4xUKFR
nnSSPBAAjHYfi34kgXD4L5EX1DKwxH5Ja+wJcm5XrrS6E2bYEuxClKnOrfPv8PWu
/s3qd7AsafJcb8+iGrOHIMs8nGBOo6sZRueKHN6/Mjk6AO6HVzAwFjJgC5DcCzrP
bPhD6TxZHesqNIQNwpB2EoGdcxzFwWoxB7+dBZSjsAWSe8qkt4DebdQKq7O3Utyl
DpxhrwRwMnwYypv9ASR69N6q7qjj9xC4gNH375weh737wi16uSDERUAsBrP5Yegh
8wKDAigJ7gEhUziSH+c7CCVNN0yjfxHzAfE4p3Lsaskijo8jpJLnTTMcvKGLFFg2
/lKjVf3A+zuZwIkt1kGwbQieF9BoaAfzO4aU4WzpbqkQPvBnaLsoPbgiaj/VZxvm
hpATnxuCpKDZ6T8SwoBw7WV3Zl0QPYu6vjzshU0JHBRu+fcitxxxjIaCCoBHFnDk
TJfy+7g/In1NFomTirIGEeqcN0cqk/4SCXYlpwRCKC42M9Xk4Mi+w0LkjkCPkLsG
kQqn1OqQjQ1lisbNHs31O9skFts8z8ZJg4eT8cb5a7PsA+G+Hs5DjRrX7GievF+p
SsTsISt6POyljG042KrkY4NkPsx15mBvnyo1wsO6C9iqFqtLp1fhVi724ZfVnP5T
qjhubDLeGueG8PEgXYrRBylwqM98egD08Lh5bahe6yX8Uy2r1+8=
=1VZt
-----END PGP SIGNATURE-----

--Apple-Mail=_EA280E78-9C45-4A7A-90D0-1B183DD9B940--
