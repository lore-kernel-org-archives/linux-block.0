Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:50484 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdIVIzh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 04:55:37 -0400
Received: by mail-wm0-f48.google.com with SMTP id b195so1873837wmb.5
        for <linux-block@vger.kernel.org>; Fri, 22 Sep 2017 01:55:37 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <F526444E-C13D-439A-BC00-34D7A3F6C8FF@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6A57DC6E-D8F7-40D9-9C9E-9B99905305A0";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 4/6] lightnvm: pblk: improve error message if down_timeout
 fails
Date: Fri, 22 Sep 2017 10:55:34 +0200
In-Reply-To: <20170921112729.GA28553@dhcp-216.srv.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20170921112729.GA28553@dhcp-216.srv.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_6A57DC6E-D8F7-40D9-9C9E-9B99905305A0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 21 Sep 2017, at 13.27, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> The two pr_err messages are useless as they don't even differentiate
> error code.
>=20
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
> drivers/lightnvm/pblk-core.c | 12 ++----------
> 1 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index b92eabc..74ddb30 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1734,16 +1734,8 @@ static void __pblk_down_page(struct pblk *pblk, =
struct ppa_addr *ppa_list,
> #endif
>=20
> 	ret =3D down_timeout(&rlun->wr_sem, msecs_to_jiffies(30000));
> -	if (ret) {
> -		switch (ret) {
> -		case -ETIME:
> -			pr_err("pblk: lun semaphore timed out\n");
> -			break;
> -		case -EINTR:
> -			pr_err("pblk: lun semaphore timed out\n");
> -			break;
> -		}
> -	}
> +	if (ret =3D=3D -ETIME || ret =3D=3D -EINTR)
> +		pr_err("pblk: taking lun semaphore timed out: err %d\n", =
-ret);
> }
>=20
> void pblk_down_page(struct pblk *pblk, struct ppa_addr *ppa_list, int =
nr_ppas)
> --
> 2.5.0

Looks good.


Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_6A57DC6E-D8F7-40D9-9C9E-9B99905305A0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZxNAGAAoJEGMfBTt1mRjKuVUQAJSYCyILnFa8nF//WFHkEOXQ
rmSHIRGLezyoGJFMG+5QRHtj0a0peVJTClkErlVRbzHEUZIPFj3tw06Uyj5NWKmc
+aZ3PYigb+xU40IspS3QiLBn0GQgKzJYgJ41EY5JS0t3vvqTaV21OL/74xKDIhxE
nH9LENevzpmzzqgcmjxLsxt4hse+/oK9vtBbA/aDWNtxmoOOPUIMkHur0hGxxg0R
HG5Yf29mT9i2mKDLCBq2W061Fg6jhVd93e0XjXdSdtUYYqkJ7Oc7J8PyIp80/bRC
bBujMMtVZKN8HOjgu8DcCteBiE1PMqWcQu5SctiKl+lLNg12GwdPO4TjAPJOnheJ
Xn6TQ8Em1lqpiZ25rKB/VM+S5LJbTZMVkkCxJ5TyUZVJK+PfiRzRpY4L4iOCA/l5
Zwky95rWkzwZw0vttUmlINYca9ewICqCc1A2TwN6HyGfEztSXH6+wcT42IxjDAnj
d68AmfObYU/oSidbiWNWx5txiCo5FZ96JBtqCpqZkvEUm6wyTtrb8kGsJDR59m8x
xzac7ZdTgO0dMJRFtZSnlFcp7P7rwTLTA8eDuHdC/msjxnRyZCoun4t41w8fBDww
EcHSjqsa6m2dWbSdAMkvGH1nOfZmgE8C5P5/ftSa3rzq9uXWOJ9naN1we4vQO7Uk
vNbhLDft4AGRlNAmVQBm
=RhK6
-----END PGP SIGNATURE-----

--Apple-Mail=_6A57DC6E-D8F7-40D9-9C9E-9B99905305A0--
