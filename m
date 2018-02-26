Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0087.outbound.protection.outlook.com ([104.47.32.87]:29472
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751328AbeBZT6T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Feb 2018 14:58:19 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: Heiner Litz <hlitz@ucsc.edu>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
Subject: Re: [PATCH] lightnvm: Avoid validation of default op value Avoid
 validation of default op value, if default value is given. In preparation of
 using the rsvd field of the extended config for additional paramters while
 using default op.
Date: Mon, 26 Feb 2018 19:58:15 +0000
Message-ID: <B4976FCA-8823-46F0-9725-041EAE85AC0F@cnexlabs.com>
References: <20180226194557.12226-1-hlitz@ucsc.edu>
In-Reply-To: <20180226194557.12226-1-hlitz@ucsc.edu>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1F040DCA-9454-4FAA-84EC-9A10C44734CC";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_1F040DCA-9454-4FAA-84EC-9A10C44734CC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 26 Feb 2018, at 20.45, Heiner Litz <hlitz@ucsc.edu> wrote:
>=20
> Fixes: 38401d231de65 ("lightnvm: set target over-provision on create =
ioctl")
>=20
> Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> ---
> drivers/lightnvm/core.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index dcc9e621e651..4e6095e2af06 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -304,10 +304,9 @@ static int __nvm_config_extended(struct nvm_dev =
*dev,
> 	}
>=20
> 	/* op not set falls into target's default */
> -	if (e->op =3D=3D 0xFFFF)
> +	if (e->op =3D=3D 0xFFFF) {
> 		e->op =3D NVM_TARGET_DEFAULT_OP;
> -
> -	if (e->op < NVM_TARGET_MIN_OP ||
> +	} else if (e->op < NVM_TARGET_MIN_OP ||
> 	    e->op > NVM_TARGET_MAX_OP) {

While you are at it, can you fix this and put it in a single line - not
sure why this ended up this way...

> 		pr_err("nvm: invalid over provisioning value\n");
> 		return -EINVAL;
> --
> 2.14.1

Apart from the comment, the patch looks good. However, the description
went over to the subject. I guess Matias can fix this when picking it
up.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_1F040DCA-9454-4FAA-84EC-9A10C44734CC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqUZtQACgkQIX4xUKFR
nnRLKhAAr6pcrCWAv/PbkTu0ttScySn5TZzckViIz4EGSeuXEuuSOCeIK5pp7UK2
HlG/9RMPnaFltySJTVi7mR12qJ6G6M1DsjDNF28NY2Q7StrQk4JJIYiqjkaz2AxG
fyOyyfrx8wew4Z1be0sW7M5wLOXR7U00aQsHyQmhtuIZozPBaJ1Q4qS9Z60f/SM3
e2GuNZfv94je1Ug+/GK0N+e17TuFdQtZD7qlErpbNU9xzigYMsg8SUWNVLGUiXwG
3jbYShTRQwdvt6JIwGdUi2EJPVifL5O16TXrCBACnlaxNDXE96hT172r/lMbz3O6
belOGKg5QFIvXrgDMOyRt0E1hZUn8Oe072ubMrgYvs5Xz6E2UkdA1npVRnZPlspx
dHBE8FoeN4Zr36uxJea6iI7nO6Q1IlBMc7NyAmops9yXXgNiYkp97G2vEsiHA37M
Eimq16dYog0ftkewDPAZ98KF3zqIvjkVurqYUBrkWATHYarNiqwiNojwj4u/icWj
zPgaGWJaSvUK3SeNMfm3Ht18tHmP/612sTijU0Irr5Kv5DYL+KjIuuzEzGZKNiPT
e3ASTmu2GxQo5Hb1MqnypRNoU5ozRqgatj8y1BLWpEjjdIdcIuO+oYaQo/btfPj6
YQlxruAtz7v7zt3C1L1bc2R857KuoFx+vjM/TJCaUJB3UhGWrP8=
=dYyV
-----END PGP SIGNATURE-----

--Apple-Mail=_1F040DCA-9454-4FAA-84EC-9A10C44734CC--
