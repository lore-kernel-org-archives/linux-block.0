Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:50921 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751877AbdIRH4J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Sep 2017 03:56:09 -0400
Received: by mail-wm0-f41.google.com with SMTP id v142so126479wmv.5
        for <linux-block@vger.kernel.org>; Mon, 18 Sep 2017 00:56:08 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <C22FF934-D7A2-4B1F-8172-011E596A5EE8@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_AF9FF8B4-AB76-4A0B-B2C1-5D47CF40EA29";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] lightnvm: remove already calculated nr_chnls
Date: Mon, 18 Sep 2017 09:56:06 +0200
In-Reply-To: <20170917210412.GA2879@hercules.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20170917210412.GA2879@hercules.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_AF9FF8B4-AB76-4A0B-B2C1-5D47CF40EA29
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Sep 2017, at 23.04, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> Remove repeated calculation for number of channels while creating a
> target device.
>=20
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
>=20
> This is also a trivial change I found while investigating/working on
> other issue.
>=20
> drivers/lightnvm/core.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index 1b8338d..01536b8 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -139,7 +139,6 @@ static struct nvm_tgt_dev =
*nvm_create_tgt_dev(struct nvm_dev *dev,
> 	int prev_nr_luns;
> 	int i, j;
>=20
> -	nr_chnls =3D nr_luns / dev->geo.luns_per_chnl;
> 	nr_chnls =3D (nr_chnls_mod =3D=3D 0) ? nr_chnls : nr_chnls + 1;
>=20
> 	dev_map =3D kmalloc(sizeof(struct nvm_dev_map), GFP_KERNEL);
> --
> 2.7.4

We wanted to make sure that nr_chnls was really, really set :)

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_AF9FF8B4-AB76-4A0B-B2C1-5D47CF40EA29
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZv3wWAAoJEGMfBTt1mRjKuDUQAOQhlpDlWu+5U/e0ZBtbjKcq
GiFSHWd5zGkJ8TgWuXE6dcI8Qyhxe+SVQ0TkDYerh+QWbRJiLmAv8Az0v8D/0mhb
L8jua3/mpCfFKOYgnyvLwWsCRFrYx+w7iLuSQIjNborqRVDvbPQ/FLF/jjlq4qNH
hyTUuERL5fofyH3jhAiJFKK6ZLDLPtr3xdXbo8yl6yyTukvCrikhCVJSBhOBr/fS
LHWPoG/udX1Oeq7mlbIrthTtk8SZnFONSUbFb/8uMFdGl9irbrsJV/4Cq19rDmRS
Xh0Ap4XTEHnrB7YT4nrbOATNC2Odo1J6XjkXjwwNErlxffvN0r9qoJHyfsH+9J1p
GFrbD3x4hMUOj9oZnUq8d9ZYgMfiPfLcGfSQ648ay3uiG2bg6Wszn696uCwlmxaP
CD4HwNNACR6D9lxzbDubcrWHJXnuKuFCpgg1AzmwEF/STcCa5fpN/H0ncwoz2PiK
dQJjVEmA3Wf4s27kZgFtZzd9UcsVgbEk7+0Ng+jyYQb2o/0amnfD5TcuYv4UzBky
BOyv4SHXXBp96QHpQl+QzAvJQLaU4V38DFq9SGnfAGnPslzOOR8eUZh8xFiwLyEl
yf131c3uvBkHikT32cgwP3tj2CGoKYa2PcitqvPlclDxTEJw29LIcKzIEGDf5BoM
X7caogWm1Nbk0BlMk6oy
=YctC
-----END PGP SIGNATURE-----

--Apple-Mail=_AF9FF8B4-AB76-4A0B-B2C1-5D47CF40EA29--
