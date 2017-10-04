Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:45844 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdJDLYj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Oct 2017 07:24:39 -0400
Received: by mail-wm0-f41.google.com with SMTP id q124so22202193wmb.0
        for <linux-block@vger.kernel.org>; Wed, 04 Oct 2017 04:24:38 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <C20A9FCC-5BBB-423C-91CF-EA4A71E3C155@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_444E760B-2C87-42AB-9DF1-C209D412C5BF";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/6] lightnvm: pblk: protect line bitmap while submitting
 meta io
Date: Wed, 4 Oct 2017 13:24:34 +0200
In-Reply-To: <20170921112620.GA28524@dhcp-216.srv.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20170921112620.GA28524@dhcp-216.srv.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_444E760B-2C87-42AB-9DF1-C209D412C5BF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 21 Sep 2017, at 13.26, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> It seems pblk_dealloc_page would race against pblk_alloc_pages for
> line bitmap for sector allocation.  The chances are very low but might
> as well protect the bitmap properly.  It's not even in fast path.
>=20
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
> drivers/lightnvm/pblk-core.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index a230125..b92eabc 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -502,12 +502,14 @@ void pblk_dealloc_page(struct pblk *pblk, struct =
pblk_line *line, int nr_secs)
> 	u64 addr;
> 	int i;
>=20
> +	spin_lock(&line->lock);
> 	addr =3D find_next_zero_bit(line->map_bitmap,
> 					pblk->lm.sec_per_line, =
line->cur_sec);
> 	line->cur_sec =3D addr - nr_secs;
>=20
> 	for (i =3D 0; i < nr_secs; i++, line->cur_sec--)
> 		WARN_ON(!test_and_clear_bit(line->cur_sec, =
line->map_bitmap));
> +	spin_lock(&line->lock);

Changed this to spin_unlock() when picking it up.

Javier.

--Apple-Mail=_444E760B-2C87-42AB-9DF1-C209D412C5BF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnUxPIACgkQYx8FO3WZ
GMra6A//djLN1Q8IMCmLyL2bMFk2NY/cRCFh/ayJIrgFQOv3fji9JzlfT/wIVcuf
LgzMstO0iAOk4Tww8Z4l502m81De2wT1UkeaqbqX17RaJ2QAjKFiIa9jO31Gq5W+
BUONh6Wj6pEDyCIbBEGRpPgR/bAjVqLFI5bI4TtbSjSeC0/jMwF22YB8mttbl3y0
+97jTZ7jcB1xyMPNZSyhjNFUz25QuYZW5mamqq8n+A5nUz6idlSUeV6VePAQQTlK
W/N2xN7gIn2WuqMoAHfdUtV2b5tgUZ+e9S0FPYztDbCHKUl7g6Urw9ZFnttdK+9x
aEgcHp3v1MM34bwrqIBsuZ0qhLRi2J+XsUOiF+9Sv96q6VNWDoZHCAAAeQkRVqjB
Wmh6EY/+78znmIQSzWiBRCrAdn8KWlZn8pjsDPB8OkWn4lfN1d1fdq9STmv+J54k
wn94/VZ9k4zS+5Cl5DEe7SH6e9l+8/hdysxQTOAYKWguhJ+CZt/CGYpw8JxG9NAC
N1rW9xIJXf5Gls6FCMHmYvcg98Kwkoecn2FWgd6HLuyLwata4yepr0CKeCko9YsM
HuzhzgzYam1VMZb7Oi4iOmMf/DCUzaUXCeEkA5anJtLfJWq9GX9NT37ZlEcOGIvL
JoElwo8yQ9i4iH57PLX8gDuABvqit51vJWwtN/IV/M21opOROOo=
=Km52
-----END PGP SIGNATURE-----

--Apple-Mail=_444E760B-2C87-42AB-9DF1-C209D412C5BF--
