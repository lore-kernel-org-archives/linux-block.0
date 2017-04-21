Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:38769 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1042809AbdDUWdK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 18:33:10 -0400
Received: by mail-it0-f41.google.com with SMTP id e132so2206727ite.1
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2017 15:33:10 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <428E1814-31B8-42A5-9A55-879E3A51E482@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5EE4027E-A540-4FAB-8392-D45351020874";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] lightnvm: don't print a warning for ADDR_EMPTY
Date: Sat, 22 Apr 2017 00:33:04 +0200
In-Reply-To: <20170421205437.fom72nbe3rfngdra@mwanda>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20170421205437.fom72nbe3rfngdra@mwanda>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_5EE4027E-A540-4FAB-8392-D45351020874
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 21 Apr 2017, at 22.54, Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
>=20
> Reading from ADDR_EMPTY is out of bounds.  The current code generates =
a
> static checker warning because we check for out of bounds "lba" before
> we check for ADDR_EMPTY, so the second check is always false.  It =
looks
> like we intended ADDR_EMPTY to be a no-op without printing a warning.
>=20
> Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index c9daa33e8d9c..4a12f14d78c6 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -410,15 +410,15 @@ static int read_rq_gc(struct pblk *pblk, struct =
nvm_rq *rqd,
> 	struct ppa_addr ppa;
> 	int valid_secs =3D 0;
>=20
> +	if (lba =3D=3D ADDR_EMPTY)
> +		goto out;
> +
> 	/* logic error: lba out-of-bounds */
> 	if (lba >=3D pblk->rl.nr_secs) {
> 		WARN(1, "pblk: read lba out of bounds\n");
> 		goto out;
> 	}
>=20
> -	if (lba =3D=3D ADDR_EMPTY)
> -		goto out;
> -
> 	spin_lock(&pblk->trans_lock);
> 	ppa =3D pblk_trans_map_get(pblk, lba);
> 	spin_unlock(&pblk->trans_lock);

Thanks Dan.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>



--Apple-Mail=_5EE4027E-A540-4FAB-8392-D45351020874
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJY+oihAAoJEGMfBTt1mRjKFWUP/R0DmN/pBHlow6I0G0u/AFbl
Q6MkeIGljYqPz44J5ds5nTi8MFDcRT4H9Yo9a110FZt0Npdjh3z0Ynff7rWI+2+Q
1HZ3JFfeyljUaWRXLFzLDJ2fzyJiQZBPh5vfGqUD8YjjREmQmxPeNfgnMiqKOrhR
r3aJBW47NNLh4Wc082bu8FbS76eIP+3tv3NLwycCogATOjcC+SJy0EVDkYLewuao
9+3wey1iBYk+ik24fKXmTv0/Qh/4uL74E4WsV0TWytVFjTmnlvVf6cN48znv0s3p
xlkvzelB2xrEiVCDMSxh/skqj4xBr6iep5bzd9y+smhk+tLfV7cyNj7S2CPXQhIn
PK9I5EbQcrSDWOpFM8dEKHd7ycZNMABGo6VecVzPhZy/UGWtyZ1nLbjA3I3U5DM2
2XGWh+ddM4DrOEb1X+yecFVpjNKfb55WHYP//UvmDh07U3pjqa+ISG+9+TD3wZMz
Go0zmYeGuGf/5ZGh9i0EYLRZ1Lu5vm4TuUxC2FaQNaHrtEj+SwlN86uBgEgjkqNb
ikJ0xsEdPKmz1wA0UjY2lYfUFM2ldfdue5igIyrXIT2rYmLbQtbRQuCS6xSHKchS
WAlftIm1yY9vDf2x7XleoKp5qQVwXdjRomDA9LvZQllQwt1CRnyOVF3RoIhXc2O+
VMoSqA/Y4MkAvl4Z9ym2
=P76P
-----END PGP SIGNATURE-----

--Apple-Mail=_5EE4027E-A540-4FAB-8392-D45351020874--
