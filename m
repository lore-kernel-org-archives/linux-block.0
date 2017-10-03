Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:47600 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbdJCKjt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:39:49 -0400
Received: by mail-wm0-f46.google.com with SMTP id t69so15718161wmt.2
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:39:48 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <28EFC5BD-92BF-404D-BEEB-3EE11DAE11FE@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1DBFE71E-2A46-4A1E-9BF7-7911FA765A0F";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 7/9] lightnvm: pblk: add l2p crc debug printouts
Date: Tue, 3 Oct 2017 12:39:46 +0200
In-Reply-To: <1507025113-13351-8-git-send-email-hans.ml.holmberg@owltronix.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1507025113-13351-8-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_1DBFE71E-2A46-4A1E-9BF7-7911FA765A0F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Oct 2017, at 12.05, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> Print the CRC of the logical-to-physical mapping during exit and
> after recovering the L2P table to facilitate detection of meta
> data corruption/recovery issues.
>=20
> The CRC printed after recovery should match the CRC printed during
> the previous exit - if it doesn't this indicates that either the meta
> data written to the disk is corrupt or recovery failed.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-init.c | 39 =
++++++++++++++++++++++++++++++++++-----
> 1 file changed, 34 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index fb41182..c452478 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -76,6 +76,28 @@ static blk_qc_t pblk_make_rq(struct request_queue =
*q, struct bio *bio)
> 	return BLK_QC_T_NONE;
> }
>=20
> +static size_t pblk_trans_map_size(struct pblk *pblk)
> +{
> +	int entry_size =3D 8;
> +
> +	if (pblk->ppaf_bitsize < 32)
> +		entry_size =3D 4;
> +
> +	return entry_size * pblk->rl.nr_secs;
> +}
> +
> +#ifdef CONFIG_NVM_DEBUG
> +static u32 pblk_l2p_crc(struct pblk *pblk)
> +{
> +	size_t map_size;
> +	u32 crc =3D ~(u32)0;
> +
> +	map_size =3D pblk_trans_map_size(pblk);
> +	crc =3D crc32_le(crc, pblk->trans_map, map_size);
> +	return crc;
> +}
> +#endif
> +
> static void pblk_l2p_free(struct pblk *pblk)
> {
> 	vfree(pblk->trans_map);
> @@ -85,12 +107,10 @@ static int pblk_l2p_init(struct pblk *pblk)
> {
> 	sector_t i;
> 	struct ppa_addr ppa;
> -	int entry_size =3D 8;
> -
> -	if (pblk->ppaf_bitsize < 32)
> -		entry_size =3D 4;
> +	size_t map_size;
>=20
> -	pblk->trans_map =3D vmalloc(entry_size * pblk->rl.nr_secs);
> +	map_size =3D pblk_trans_map_size(pblk);
> +	pblk->trans_map =3D vmalloc(map_size);
> 	if (!pblk->trans_map)
> 		return -ENOMEM;
>=20
> @@ -508,6 +528,10 @@ static int pblk_lines_configure(struct pblk =
*pblk, int flags)
> 		}
> 	}
>=20
> +#ifdef CONFIG_NVM_DEBUG
> +	pr_info("pblk init: L2P CRC: %x\n", pblk_l2p_crc(pblk));
> +#endif
> +
> 	/* Free full lines directly as GC has not been started yet */
> 	pblk_gc_free_full_lines(pblk);
>=20
> @@ -898,6 +922,11 @@ static void pblk_exit(void *private)
> 	down_write(&pblk_lock);
> 	pblk_gc_exit(pblk);
> 	pblk_tear_down(pblk);
> +
> +#ifdef CONFIG_NVM_DEBUG
> +	pr_info("pblk exit: L2P CRC: %x\n", pblk_l2p_crc(pblk));
> +#endif
> +
> 	pblk_free(pblk);
> 	up_write(&pblk_lock);
> }
> --
> 2.7.4

LGTM.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>

--Apple-Mail=_1DBFE71E-2A46-4A1E-9BF7-7911FA765A0F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnTaPIACgkQYx8FO3WZ
GMrX4w//TynTIxewDm6x/kMhYBwQmF79JsMdHeTGBnCCMlV7CPcwoot0DB/EVUAs
MRDCV+m5JuA2q58+Xok37s50ZtMSNOpRFWn0eor9YfmYEbV3CAJhTtp5vydKllF0
meEnl7U+EHfk2W0IAPyhH4VxQW6RnLMCGuFlMao4NtWU/dEwIiNjUx1YZCb8wnap
ieM8WatR+UO44MekePSZA8iWpVV1IaWw/VXhPAeRZYcyne70OzHilwNr+/2dszh8
IH4imQLkOGdAAohcfHMkuR5Vy62DK8z967hOil8rCk1Pp9kDbiM/cMCbGstjMqIL
AJN6mesQ4JngL+zU51sZQJ5G1scRP7myACCUrTdzsG1xI4ErLi3QyvX0Vy53jPRJ
0VS0JGkk4cXGVG6KeDaKAN72U6BeMm7w9VgrfzfB406HP4/XBsTT8fIivOUOTrPC
HrObQLZAwq2qmKuEzy26xPlH7H1Tw3wv16z5nUW4I80DE3uSBeDq8doUa1Fjkn0a
a2oC0rob5f02aVRuA9UIfod+fwgVhUR6W6hAYMYoTA02GO7yOqzuY9228aJZ47ld
T4KDSHFKSWA+510VoGsgiiy1wucUx8hII3jtI9XOSkSqQfNQJhi+WkYqo7QHUGWV
0aPjx5CkfwCp8kavs2lqGk6Xhrn6d6TCxGqBHb4kx7OLbjg+b/4=
=Rc2V
-----END PGP SIGNATURE-----

--Apple-Mail=_1DBFE71E-2A46-4A1E-9BF7-7911FA765A0F--
