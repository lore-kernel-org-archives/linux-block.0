Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com ([104.47.32.41]:23008
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932905AbeFLOhn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jun 2018 10:37:43 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
        "Hans Holmberg" <hans.holmberg@cnexlabs.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] lightnvm: pblk: enable line minor version detection
Date: Tue, 12 Jun 2018 14:37:41 +0000
Message-ID: <EB675E5E-C873-438F-B695-0ABA580BCF77@cnexlabs.com>
References: <20180612112918.25795-1-mb@lightnvm.io>
 <20180612112918.25795-2-mb@lightnvm.io>
In-Reply-To: <20180612112918.25795-2-mb@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5F2131E0-A488-4EAF-B69B-1AF187F4E7B0";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_5F2131E0-A488-4EAF-B69B-1AF187F4E7B0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 12 Jun 2018, at 04.29, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> When recovering a line, an extra check was added when debugging was
> active, such that minor version where also checked. Unfortunately,
> this used the ifdef NVM_DEBUG, which is not correct.
>=20
> Instead use the proper DEBUG def, and now that it compiles, also fix
> the variable.
>=20
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> Fixes: d0ab0b1ab991f ("lightnvm: pblk: check data lines version on =
recovery")
> ---
> drivers/lightnvm/pblk-recovery.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 598342833d0d..b1a91cb3ca4d 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -742,9 +742,10 @@ static int pblk_recov_check_line_version(struct =
pblk *pblk,
> 		return 1;
> 	}
>=20
> -#ifdef NVM_DEBUG
> +#ifdef CONFIG_NVM_PBLK_DEBUG
> 	if (header->version_minor > EMETA_VERSION_MINOR)
> -		pr_info("pblk: newer line minor version found: %d\n", =
line_v);
> +		pr_info("pblk: newer line minor version found: %d\n",
> +				header->version_minor);
> #endif
>=20
> 	return 0;
> --
> 2.11.0

Good catch.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_5F2131E0-A488-4EAF-B69B-1AF187F4E7B0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlsf2rIACgkQIX4xUKFR
nnQ3Xw//Qbf2YhZcGXAU1rBzHloXlvozISBkSPFUgHhca33ZJ62jAYRMksjPU1J5
dUrqJ5TLuo7v0tdMtZASFha/q7W5VO3HZ18vStcaNIOPRFLlC1U6sj9NMw5tZ2Nl
WLIKhQNzgk67ayeVEUPNLL3BiiazoXJ7dOkPPHwwBgCRymcuHE8isNe7PjyDHxxd
YKC1tJZ9fG1GTv2azrWIM+zQ2WWT/8XACr73QfC6ifrxQVgHf5/RNbZLTCWJe0Tl
aYk2g4X6ZhoDveRUO0e9dvkDB6N9dXlCiaCGYTqi/T+ItGIefv27OAqmPpBlefHo
jTztn56hFBcVSp5ISX0ZU7ZS3rxL9WWUwgDrBO8RCeoKXVOGWe80FAXf2WX29oDi
v8OMCkXqlzVq8vMF9mVW/zg6lbj+5hvZsDF027JYBU3UsCAoc5lK+p8LsnORzxQ0
tX0ai2TGHRWi/Akr+yClIVeuY+5MEa8DvmYZ/kRbi/19lW8rsrNRUDSAJZpBw6RZ
vI0Fj5oj29N/RGshERwnqLw4hTiV+igpReu1VJ61FSnbg4f+g1SjWMmb3pBWGBFD
67OhIEus4fsj/BvpGl4SLOrvw9dvd0TDaWfcDvxP54xQ2+AF+umqPj6IuLVwTX9s
PtuV+A7GXDfKAnhbtR2EKss+YtFKi3kfe3bjVubutDJeGgBPoxU=
=/TSD
-----END PGP SIGNATURE-----

--Apple-Mail=_5F2131E0-A488-4EAF-B69B-1AF187F4E7B0--
