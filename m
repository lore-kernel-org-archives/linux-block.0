Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:52073 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbdJCKi0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:38:26 -0400
Received: by mail-wm0-f54.google.com with SMTP id f4so7806738wme.0
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:38:26 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <D02F472F-B94F-4577-A92C-9B3470753B15@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_49BF0623-2443-4D8F-B00C-6CD753D20DE7";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 5/9] lightnvm: pblk: consider bad sectors in emeta during
 recovery
Date: Tue, 3 Oct 2017 12:38:23 +0200
In-Reply-To: <1507025113-13351-6-git-send-email-hans.ml.holmberg@owltronix.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1507025113-13351-6-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_49BF0623-2443-4D8F-B00C-6CD753D20DE7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Oct 2017, at 12.05, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> When recovering lines we need to consider that bad blocks in a line
> affects the emeta area size.
>=20
> Previously it was assumed that the emeta area would grow by the
> number of sectors per page * number of bad blocks in the line.
>=20
> This assumtion not correct - the number of "extra" pages that are
> consumed could be both smaller (depending on emeta size) and bigger
> (depending on the placement of the bad blocks).

This assumption is not correct >> missing _is_

>=20
> Fix this by calculating the emeta start by iterating backwards
> through the line, skipping ppas that map to bad blocks.
>=20
> Also fix the data types used for ppa indices/counts in
> pblk_recov_l2p_from_emeta - we should use u64.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-recovery.c | 44 =
+++++++++++++++++++++++++++-------------
> 1 file changed, 30 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 74b3b86..b5a2275 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -133,16 +133,16 @@ static int pblk_recov_l2p_from_emeta(struct pblk =
*pblk, struct pblk_line *line)
> 	struct pblk_emeta *emeta =3D line->emeta;
> 	struct line_emeta *emeta_buf =3D emeta->buf;
> 	__le64 *lba_list;
> -	int data_start, data_end;
> -	int nr_valid_lbas, nr_lbas =3D 0;
> -	int i;
> +	u64 data_start, data_end;
> +	u64 nr_valid_lbas, nr_lbas =3D 0;
> +	u64 i;
>=20
> 	lba_list =3D pblk_recov_get_lba_list(pblk, emeta_buf);
> 	if (!lba_list)
> 		return 1;
>=20
> 	data_start =3D pblk_line_smeta_start(pblk, line) + =
lm->smeta_sec;
> -	data_end =3D lm->sec_per_line - lm->emeta_sec[0];
> +	data_end =3D line->emeta_ssec;
> 	nr_valid_lbas =3D le64_to_cpu(emeta_buf->nr_valid_lbas);
>=20
> 	for (i =3D data_start; i < data_end; i++) {
> @@ -172,8 +172,8 @@ static int pblk_recov_l2p_from_emeta(struct pblk =
*pblk, struct pblk_line *line)
> 	}
>=20
> 	if (nr_valid_lbas !=3D nr_lbas)
> -		pr_err("pblk: line %d - inconsistent lba =
list(%llu/%d)\n",
> -				line->id, emeta_buf->nr_valid_lbas, =
nr_lbas);
> +		pr_err("pblk: line %d - inconsistent lba =
list(%llu/%llu)\n",
> +				line->id, nr_valid_lbas, nr_lbas);
>=20
> 	line->left_msecs =3D 0;
>=20
> @@ -827,11 +827,33 @@ static void pblk_recov_line_add_ordered(struct =
list_head *head,
> 	__list_add(&line->list, t->list.prev, &t->list);
> }
>=20
> -struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
> +static u64 pblk_line_emeta_start(struct pblk *pblk, struct pblk_line =
*line)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> +	unsigned int emeta_secs;
> +	u64 emeta_start;
> +	struct ppa_addr ppa;
> +	int pos;
> +
> +	emeta_secs =3D lm->emeta_sec[0];
> +	emeta_start =3D lm->sec_per_line;
> +
> +	while (emeta_secs) {
> +		emeta_start--;
> +		ppa =3D addr_to_pblk_ppa(pblk, emeta_start, line->id);
> +		pos =3D pblk_ppa_to_pos(geo, ppa);
> +		if (!test_bit(pos, line->blk_bitmap))
> +			emeta_secs--;
> +	}
> +
> +	return emeta_start;
> +}
> +
> +struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
> +{
> +	struct pblk_line_meta *lm =3D &pblk->lm;
> 	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct pblk_line *line, *tline, *data_line =3D NULL;
> 	struct pblk_smeta *smeta;
> @@ -930,15 +952,9 @@ struct pblk_line *pblk_recov_l2p(struct pblk =
*pblk)
>=20
> 	/* Verify closed blocks and recover this portion of L2P table*/
> 	list_for_each_entry_safe(line, tline, &recov_list, list) {
> -		int off, nr_bb;
> -
> 		recovered_lines++;
> -		/* Calculate where emeta starts based on the line bb */
> -		off =3D lm->sec_per_line - lm->emeta_sec[0];
> -		nr_bb =3D bitmap_weight(line->blk_bitmap, =
lm->blk_per_line);
> -		off -=3D nr_bb * geo->sec_per_pl;
>=20
> -		line->emeta_ssec =3D off;
> +		line->emeta_ssec =3D pblk_line_emeta_start(pblk, line);
> 		line->emeta =3D emeta;
> 		memset(line->emeta->buf, 0, lm->emeta_len[0]);
>=20
> --
> 2.7.4

Apart from the commit message, it looks good.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>

--Apple-Mail=_49BF0623-2443-4D8F-B00C-6CD753D20DE7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnTaJ8ACgkQYx8FO3WZ
GMp/8Q//XHeMu604p/XpWdW1/7BHu+N0XUqrpDWZedskCANsy6wyUwmWKxI1O5WL
Aj2PP1PYtlcoSSJYJggyLbFXIb7xuD8sVhpgNbLB3i7de3CaaYH7mjFBMBV+DX5I
qJLP4iaq4lfqcl7f0I/2fzxLKIUwa6t1uxAKLqgztYuc545KN3MU4JLsrligdAYx
O4/ngpnxYIkTKxQjMoi+JXQYt0IzMxo0ZGwXEb8N+t4te3dPVNkKFY/wrDcJOxt5
6+rUquTqpJVNljL7IIx4rmWZZLMXhLDA4NfhpgYFSgK3KMVxdyLWFhBCYpGhncls
ZZp7JBXwsC0EBbOy9HUIvIjdJL9cQaCtWV2g1xg4nc9N/N4lW35zK+ilkem0guLS
iq6eO1O2Ur+8FJ+SEapOohlYoUYO2J3PzdphKdMK5VGdkB8rzQuxcsz5uB2D5BBm
20XjCjpNGnL1/fyQCW4Yqd+21YhVLg1Tz3h1vEHmzB2vNFXAI/D8iLIL2aNWHcNQ
BHeVj8vY1W0Qir5MnuTwhqxioEVBbHo7NnV4GAVB8k8o2WJRcrNpF16k7y7VRYeA
wp98j2b7Ae9onj+JCdKp6Mvok3kN8elRHdrQ0aTiBKfgC+7iDyMrUfiHhGZBt1sA
BeUm7ozfsa6mauBBuyh9eu9aJM1c4SUEqKSLkBMyodvRkqGEhig=
=AHs8
-----END PGP SIGNATURE-----

--Apple-Mail=_49BF0623-2443-4D8F-B00C-6CD753D20DE7--
