Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:49371 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdJCK20 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 06:28:26 -0400
Received: by mail-wm0-f52.google.com with SMTP id b189so11789406wmd.4
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 03:28:25 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Message-Id: <CB6F0310-6061-474C-A0D7-7A314366AFEA@lightnvm.io>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_029A6F12-9F0C-43D4-8D77-AFFA38EB7695";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/9] lightnvm: pblk: recover partially written lines
 correctly
Date: Tue, 3 Oct 2017 12:28:23 +0200
In-Reply-To: <1507025113-13351-3-git-send-email-hans.ml.holmberg@owltronix.com>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1507025113-13351-3-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


--Apple-Mail=_029A6F12-9F0C-43D4-8D77-AFFA38EB7695
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 3 Oct 2017, at 12.05, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> When recovering partially written lines, the valid sector
> count must be decreased by the number of padded sectors
> in the line.
>=20
> Update line recovery to take all ADDR_EMPTY(padded) sectors
> into account.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-recovery.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 1869eef..74b3b86 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -133,8 +133,8 @@ static int pblk_recov_l2p_from_emeta(struct pblk =
*pblk, struct pblk_line *line)
> 	struct pblk_emeta *emeta =3D line->emeta;
> 	struct line_emeta *emeta_buf =3D emeta->buf;
> 	__le64 *lba_list;
> -	int data_start;
> -	int nr_data_lbas, nr_valid_lbas, nr_lbas =3D 0;
> +	int data_start, data_end;
> +	int nr_valid_lbas, nr_lbas =3D 0;
> 	int i;
>=20
> 	lba_list =3D pblk_recov_get_lba_list(pblk, emeta_buf);
> @@ -142,10 +142,10 @@ static int pblk_recov_l2p_from_emeta(struct pblk =
*pblk, struct pblk_line *line)
> 		return 1;
>=20
> 	data_start =3D pblk_line_smeta_start(pblk, line) + =
lm->smeta_sec;
> -	nr_data_lbas =3D lm->sec_per_line - lm->emeta_sec[0];
> +	data_end =3D lm->sec_per_line - lm->emeta_sec[0];
> 	nr_valid_lbas =3D le64_to_cpu(emeta_buf->nr_valid_lbas);
>=20
> -	for (i =3D data_start; i < nr_data_lbas && nr_lbas < =
nr_valid_lbas; i++) {
> +	for (i =3D data_start; i < data_end; i++) {
> 		struct ppa_addr ppa;
> 		int pos;
>=20
> --
> 2.7.4

LGTM.

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_029A6F12-9F0C-43D4-8D77-AFFA38EB7695
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEm1mT7zen+vs9+T8kYx8FO3WZGMoFAlnTZkcACgkQYx8FO3WZ
GMoF6Q/+P38JVzgFfVearNnkEOw5DOPcOmV2bTU+/IbX3kUoOugRAYsKUxlWCL8T
XcBa+Nws8q/R4VLhG/QqOUhPDmCTOb/w/OveZjV7rCICLhIYTgdrPxOf6P3pauWT
jSJIdkGK1GZ0LpMzkokbEr6d8TxP1jVMed2+PrMg2hbf1KTpxp4dZtMol5tSS3aD
gUvGNvZo11TLAVovXioiLYLvWYQ6VDWCXCVnw2Cfh79ISN23cIP5TueFSZDPaq8k
0X1zM74CODcmb+70ruZtI/6CUSEw0F5NAA/2im2qx8f0MZVulCs0H6hVgVhtWYFa
BqpODrZSmTWOmCfRmhWkMSsj5V69JyPDkhF9hkY3UBCo8yoVRSMyYwsACSwifmSn
YaJAGFApEZ2UpNox+6ljWA65KeTOmmhYIRZZc2BvHyhEyNAI4xqc+DvhFtAUHUi3
pMKSVXOwmfZB37QrnMWDTFcgZd7zQHCXO7nxzq7jFpOA4nCLbtQeDe7IpXVTjj+H
tykTOLrOlLutwnPGTYVThJG0eRAXgMKoRCdARxgJlPt4Pqg5uArcW+pWHMzd1h10
PTPBlWwv+Pu1y/CJijTk8iF0ClS5u9JlU/9oGiPverh1GVD9Ya6wyphwfRLJBBoH
r3JfpnLZuP3m8oArNGwxGbVLCceNnxI+m3ECJFz+51Q5sWzUzgQ=
=b+Oh
-----END PGP SIGNATURE-----

--Apple-Mail=_029A6F12-9F0C-43D4-8D77-AFFA38EB7695--
