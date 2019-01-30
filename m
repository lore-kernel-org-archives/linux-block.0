Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C18C282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 09:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4422D20989
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 09:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="HASUNBdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfA3Jix (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:38:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40348 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfA3Jix (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 04:38:53 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so18418940edr.7
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 01:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=VJNp/xpNxVH8NW50U+PdyKGuAzjqzoZm+ySFZy0cAGk=;
        b=HASUNBdLgiPgxXWboHuKB/CV22vcRzGPc+r/2D1CvJx/HkKrUVJn7gtw8mhLBvYP4l
         91sBxbyLS0s7Wj2Pnm9337lenybwmc8Efp9674SCY9B/+l/X+Z+P37bu9jLJVvLqKSlL
         vnTJ/T1t1eF5Tg2PYUakTZOJDAfV0q7WUudzrqqAf/IYZrCQQgqK/U51I5hSVbaB+lqU
         jHJW8WRKbJdOonTpx6o2d9p/m6or5xCkjiyxqzYkbQIqhAm+Agg6KMGdXa49+gPykhGd
         psa4PS6/Gp26bwIPIAMitK+G1oRFNt+jjzCdm1BSrjcCMuZzuZPePYyrLWro1ficVZ6Y
         sFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=VJNp/xpNxVH8NW50U+PdyKGuAzjqzoZm+ySFZy0cAGk=;
        b=E0vrw1AEkBDE2cpoUnleiaf1dtKd0KooEFpb67vfWzTEBQfxKlniad8yKI59Ao3Pqw
         +fdeKsdXTNH3ZeBizv5EALRp3wkSYxQ8I9Hwr8nuveBNBL3tjsnMZGvE7evAUyLWrY3W
         5VepoCcPiINCziQ1B6y6RPs5n27+1nscm9LmIuN+RvBYi2sNAcXuD3OZSMN0p706JbMJ
         AEBNij6wXIeXP003hs5GewtUF3lbsKUcNOlWLwhVcv6A4siUCSwvge289Ukly92XWM8M
         JGk7q9jYIYZU4OYFY91zvGm4JJN2QqgO4quHl0xJyVpWZ679vNRVeoqwpQFBov0UWRgl
         wc4Q==
X-Gm-Message-State: AJcUukdpBEnHEIOP2dTVWBaPbnYl4SRWQGfOcSbKSEYDjtSFBvVxeBnt
        qk0eRTvc2FI9IjFpcE2b/8gi/etxEWlUlQ==
X-Google-Smtp-Source: ALg8bN7St6jiPPe+RTnxRDms43ciTN/Pwlp4W+K4G+uHtMmvaPQK0Q61U/3Ck6xPlyqgYKpc9yH5Iw==
X-Received: by 2002:aa7:d1d7:: with SMTP id g23mr24805379edp.217.1548841131109;
        Wed, 30 Jan 2019 01:38:51 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id n22-v6sm226062ejk.75.2019.01.30.01.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:38:50 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <2608BA38-98D6-487C-BC50-45799D5DEE18@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_165EB6B1-9671-4854-A327-36E52B3F4BB7";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH V2] lightnvm: pblk: extend line wp balance check
Date:   Wed, 30 Jan 2019 10:38:49 +0100
In-Reply-To: <20190130081857.6779-1-hans@owltronix.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Zhoujie Wu <zjwu@marvell.com>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To:     Hans Holmberg <hans@owltronix.com>
References: <20190130081857.6779-1-hans@owltronix.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_165EB6B1-9671-4854-A327-36E52B3F4BB7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 30 Jan 2019, at 09.18, hans@owltronix.com wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> pblk stripes writes of minimal write size across all non-offline =
chunks
> in a line, which means that the maximum write pointer delta should not
> exceed the minimal write size.
>=20
> Extend the line write pointer balance check to cover this case, and
> ignore the offline chunk wps.
>=20
> This will render us a warning during recovery if something unexpected
> has happened to the chunk write pointers (i.e. powerloss,  a spurious
> chunk reset, ..).
>=20
> Reported-by: Zhoujie Wu <zjwu@marvell.com>
> Tested-by: Zhoujie Wu <zjwu@marvell.com>
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
>=20
> Changes since V1:
>=20
> 	* Squashed with Zhoujie's:
> 	 "lightnvm: pblk: ignore bad block wp for =
pblk_line_wp_is_unbalanced"
> 	* Clarified commit message based on Javier's comments.
>=20
>=20
> drivers/lightnvm/pblk-recovery.c | 56 ++++++++++++++++++++++----------
> 1 file changed, 38 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 6761d2afa4d0..d86f580036d3 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -302,35 +302,55 @@ static int pblk_pad_distance(struct pblk *pblk, =
struct pblk_line *line)
> 	return (distance > line->left_msecs) ? line->left_msecs : =
distance;
> }
>=20
> -static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
> -				      struct pblk_line *line)
> +/* Return a chunk belonging to a line by stripe(write order) index */
> +static struct nvm_chk_meta *pblk_get_stripe_chunk(struct pblk *pblk,
> +						  struct pblk_line =
*line,
> +						  int index)
> {
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> -	struct pblk_line_meta *lm =3D &pblk->lm;
> 	struct pblk_lun *rlun;
> -	struct nvm_chk_meta *chunk;
> 	struct ppa_addr ppa;
> -	u64 line_wp;
> -	int pos, i;
> +	int pos;
>=20
> -	rlun =3D &pblk->luns[0];
> +	rlun =3D &pblk->luns[index];
> 	ppa =3D rlun->bppa;
> 	pos =3D pblk_ppa_to_pos(geo, ppa);
> -	chunk =3D &line->chks[pos];
>=20
> -	line_wp =3D chunk->wp;
> +	return &line->chks[pos];
> +}
>=20
> -	for (i =3D 1; i < lm->blk_per_line; i++) {
> -		rlun =3D &pblk->luns[i];
> -		ppa =3D rlun->bppa;
> -		pos =3D pblk_ppa_to_pos(geo, ppa);
> -		chunk =3D &line->chks[pos];
> +static int pblk_line_wps_are_unbalanced(struct pblk *pblk,
> +				      struct pblk_line *line)
> +{
> +	struct pblk_line_meta *lm =3D &pblk->lm;
> +	int blk_in_line =3D lm->blk_per_line;
> +	struct nvm_chk_meta *chunk;
> +	u64 max_wp, min_wp;
> +	int i;
> +
> +	i =3D find_first_zero_bit(line->blk_bitmap, blk_in_line);
>=20
> -		if (chunk->wp > line_wp)
> +	/* If there is one or zero good chunks in the line,
> +	 * the write pointers can't be unbalanced.
> +	 */
> +	if (i >=3D (blk_in_line - 1))
> +		return 0;
> +
> +	chunk =3D pblk_get_stripe_chunk(pblk, line, i);
> +	max_wp =3D chunk->wp;
> +	if (max_wp > pblk->max_write_pgs)
> +		min_wp =3D max_wp - pblk->max_write_pgs;
> +	else
> +		min_wp =3D 0;
> +
> +	i =3D find_next_zero_bit(line->blk_bitmap, blk_in_line, i + 1);
> +	while (i < blk_in_line) {
> +		chunk =3D pblk_get_stripe_chunk(pblk, line, i);
> +		if (chunk->wp > max_wp || chunk->wp < min_wp)
> 			return 1;
> -		else if (chunk->wp < line_wp)
> -			line_wp =3D chunk->wp;
> +
> +		i =3D find_next_zero_bit(line->blk_bitmap, blk_in_line, =
i + 1);
> 	}
>=20
> 	return 0;
> @@ -356,7 +376,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
struct pblk_line *line,
> 	int ret;
> 	u64 left_ppas =3D pblk_sec_in_open_line(pblk, line) - =
lm->smeta_sec;
>=20
> -	if (pblk_line_wp_is_unbalanced(pblk, line))
> +	if (pblk_line_wps_are_unbalanced(pblk, line))
> 		pblk_warn(pblk, "recovering unbalanced line (%d)\n", =
line->id);
>=20
> 	ppa_list =3D p.ppa_list;
> --
> 2.17.1

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>


--Apple-Mail=_165EB6B1-9671-4854-A327-36E52B3F4BB7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxRcKkACgkQPEYBfS0l
eOAL/BAAj2R0Yi9ZJblEwPClw02i8i9h5daXnvo7yP1nedA7Hvsf5sQbSV40BfqV
3XvcqPHru6zTXAr9pVYDmuIQInyOKfbvAteYUqlPbUwaHvLqsu89PvU/qgqJHHoO
VpuggEhC74ICe/H3bTs0lU3JJ0m1vk01sH2N3eq3rm4OEdMaL7x6hdDNPhcPkmmv
Myo5DKRRX7wUp8WnwrKBrQW7IgGpsmdbzEUPKwccBwZjDS7y89urLVCQL4WrQVLJ
KKv8d3/s/5wgovx+zWbfzJs6NS+sv/X8acAmt5K06R6tV/GDWk5t2KzUCfg4+P1S
Z9AVHezb/zvW+EpA+AojRaj9moxYAVpeiTzCOuCCmC0AKFTO7mFBi5KY4xw6LfJa
twNgTQsDGdPK7uaKQ2TgvQTPpfAYstr83/cx6YaoON4snwwcN5BOkdoqwxYNw9Sf
ZxkqmwZ6JoO3eXumXltSQqN/i3WrYI7kPYS7HHmm0dSAA1kHqALr9fJLoJ7tQUl+
xBQev3C8VFEgdS94Tomlu6iMYl2Ug0DryEvEdK0WoakYGost8NycuHXO+2HO9TLd
cLQ98NgSYJVWB0EgycbxH5/75orItLP9E6bmiaPYY2EW5Cm6s671aBbt7aE10PZD
uEFg4Uw5g36lLI8FFZvGlzWlWk8noFHAuRbz49O5Mq97ogerScQ=
=SqVq
-----END PGP SIGNATURE-----

--Apple-Mail=_165EB6B1-9671-4854-A327-36E52B3F4BB7--
