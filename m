Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:54498 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbdJBL1q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Oct 2017 07:27:46 -0400
Received: by mail-wm0-f44.google.com with SMTP id i124so9897811wmf.3
        for <linux-block@vger.kernel.org>; Mon, 02 Oct 2017 04:27:45 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <5656C93D-F3DF-4054-906C-C27542D265CA@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3EA5960D-1B20-4EB0-B7E8-E83B5C4ADB8F";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] lightnvm: pblk: fix changing GC group list for a line
Date: Mon, 2 Oct 2017 13:27:42 +0200
In-Reply-To: <20170928143828.GA7645@hercules.tuxera.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rakesh Pandit <rakesh@tuxera.com>
References: <20170928143828.GA7645@hercules.tuxera.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_3EA5960D-1B20-4EB0-B7E8-E83B5C4ADB8F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 28 Sep 2017, at 16.40, Rakesh Pandit <rakesh@tuxera.com> wrote:
>=20
> pblk_line_gc_list seems to had a bug since the introduction of pblk in
> getting GC list for a line.  In b20ba1bc7 while redesigning GC
> algorithm it was not fixed correctly.  The problem is that even if
> valid sector count (vsc) is less that mid_thrs (threshold for GC mid
> list) it would always satisfy 'vsc < high_thrs' as high_thrs >
> mid_thrs always.
>=20
> Fixes: a4bd217b4("lightnvm: physical block device (pblk) target")
> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
> ---
> drivers/lightnvm/pblk-core.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 8150164..93a58ed 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -295,16 +295,16 @@ struct list_head *pblk_line_gc_list(struct pblk =
*pblk, struct pblk_line *line)
> 			line->gc_group =3D PBLK_LINEGC_FULL;
> 			move_list =3D &l_mg->gc_full_list;
> 		}
> -	} else if (vsc < lm->high_thrs) {
> -		if (line->gc_group !=3D PBLK_LINEGC_HIGH) {
> -			line->gc_group =3D PBLK_LINEGC_HIGH;
> -			move_list =3D &l_mg->gc_high_list;
> -		}
> 	} else if (vsc < lm->mid_thrs) {
> 		if (line->gc_group !=3D PBLK_LINEGC_MID) {
> 			line->gc_group =3D PBLK_LINEGC_MID;
> 			move_list =3D &l_mg->gc_mid_list;
> 		}
> +	} else if (vsc < lm->high_thrs) {
> +		if (line->gc_group !=3D PBLK_LINEGC_HIGH) {
> +			line->gc_group =3D PBLK_LINEGC_HIGH;
> +			move_list =3D &l_mg->gc_high_list;
> +		}
> 	} else if (vsc < line->sec_in_line) {
> 		if (line->gc_group !=3D PBLK_LINEGC_LOW) {
> 			line->gc_group =3D PBLK_LINEGC_LOW;
> --
> 2.9.3

You're right that the naming for high/mid/low was not updated when
aligning vsc with GC thresholds. But the fix should be making high,
being high, instead of reordering when moving into the GC bucket.

Does it make sense to you?

diff --git i/drivers/lightnvm/pblk-init.c w/drivers/lightnvm/pblk-init.c
index 7cf4b536d899..bc5c6cc12ad5 100644
--- i/drivers/lightnvm/pblk-init.c
+++ w/drivers/lightnvm/pblk-init.c
@@ -675,8 +675,8 @@ static int pblk_lines_init(struct pblk *pblk)
        lm->blk_bitmap_len =3D BITS_TO_LONGS(geo->nr_luns) * =
sizeof(long);
        lm->sec_bitmap_len =3D BITS_TO_LONGS(lm->sec_per_line) * =
sizeof(long);
        lm->lun_bitmap_len =3D BITS_TO_LONGS(geo->nr_luns) * =
sizeof(long);
-       lm->high_thrs =3D lm->sec_per_line / 2;
-       lm->mid_thrs =3D lm->sec_per_line / 4;
+       lm->high_thrs =3D lm->sec_per_line / 4;
+       lm->mid_thrs =3D lm->sec_per_line / 2;
        lm->meta_distance =3D (geo->nr_luns / 2) * pblk->min_write_pgs;

        /* Calculate necessary pages for smeta. See comment over struct

--Apple-Mail=_3EA5960D-1B20-4EB0-B7E8-E83B5C4ADB8F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnSIq4ACgkQYx8FO3WZ
GMo6Og//UIEjQGgxNm5Ewi/eA+vmBixWmrLsr20CiNsB1H/85Q5Lh9aEZDlThxyz
HAq6DTwbEMZ13MceF9ZaFG+/3q2F4emR4VvVBsPN4iqRhAsinh+4arxUCDef+442
pTdpKik4H6cZCDXc3T3/rvi503Fq5PzgXRuoaRqDPZYCrAIJ1XRx7DT2GSNzaL2I
PRh7hBfzrO7Q4M0jLkOYgX6ylUTN4qD1hLQITv9QEbr1rXNL6QPf6zmOYnN62iH9
yHuAnEp8bSUTdSeqI8iJHEIh0gj/tbsXBmY80IsnqpIwAyCCs9mZz59QQikCAzAK
uWBNzQ02b8M9JlDyuMzvfkG2Em5UvNDalBmRIHFGeqMYg6O1jYJBsOm9Q9RAxgLo
A5HlY7pO/FgqDTE8hN4fS1NTOs0EWi2+ox3Y1iCFRm8CasLpsJdPAHr1Ey1h8Baq
//AfXoQ5+Y3mcQJlGsmDygU33B5iui+Njw34MOCmF4vZCiKr+Ln3wz7rB9Q1y3kD
cGQA1cJAf+Trtn4Oq9ZITwB/dPVqR8qFT46xXbDBkAL72FuhFH9nqIDqOTTSnAUp
aj4M3fAzK8O/mYsEhnO7zJndG/lgVlG4xQ/fkWt/QTxUdt+9tPC8CeVyMPxwRout
/ZYcmk4To+KmebTIRZqIEt1hrxPg3SluI/hpvx0g3iWFsrYIWKE=
=N/fi
-----END PGP SIGNATURE-----

--Apple-Mail=_3EA5960D-1B20-4EB0-B7E8-E83B5C4ADB8F--
