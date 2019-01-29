Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AC0C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D873320880
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 11:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="MxE3nnrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfA2LTj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:19:39 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:47007 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfA2LTi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 06:19:38 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so15602068edt.13
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 03:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=9i9eAUgWflppVTmiDfndhnzBZxiyuF1nqA+hUre2yK8=;
        b=MxE3nnrTH2+f2qZP6YSSdPN38irnOzDa0WHF0XbxO6LqiMPqNzJyD4V9nhc5ZcOR3q
         UxiLuBJtNc5M6Vp6vUeBgTGKgKS7d4tFniXnVfQmdB0nQlBWJHfl03jVD2r7N3Fhd6Kg
         XXJSkJCE5QMCTjQ/uwn2Zz/VqOpTygaZVMF1nIoc0VQDSo0ba9hrjVY2WXMCE0Y03MPi
         m7JJk//rqPEWp5xZd22vlDJfEoW7AWN6C9rIKp37W4SzwPA/jDe2bNh8uTTDX6jIC789
         +0lLcRil+BObZkxGChcqUfy2xTXuMYwjaiPO7DOpgf9RGjbl4y1m0QAfKAJC8X87Y/sJ
         MMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=9i9eAUgWflppVTmiDfndhnzBZxiyuF1nqA+hUre2yK8=;
        b=JXSzfY4f/bVwSI/aU9l+PmgM1ym1Ib234yWyFFR+m7yBbDqHXdIjKt8aU+EwQd5ACP
         tozOrxZq4IyD0X/XbEiRg1lu9yjvhpzmOTnyuxabABtrU5di8YiiKnJcjrMqIGGAMsfo
         pip4fF5gramaoUApcufR7sAxXymxD25OQL+zmsI9KqSe15uOS41oNhKS0Eo/M1jHkpen
         AGFH4fwm0HgLxyk22aJP0tsTvia5PrE1Vb3oUzYBFa1M2a16MQNJWCtY+b6FQtf4R663
         658YmhBPmqZgtSjSoz0mbVJO5kzMWiMu4lnuNIgaLrn48hfgwtDntpfONzdRo2Fw8Bif
         nYKg==
X-Gm-Message-State: AJcUukd8J1Ymoy7D5FSm1DErf+wx9QfjnuBUDIQjtQ4wziULPwx7gTRD
        d3dnqLuThT+BfoKCgfMAC+Ux9w==
X-Google-Smtp-Source: ALg8bN7SzyMAJ2AEsRtMB8fMU/QhvFx36zLx8m2TyXOgtM5VNPfRnZWKYWHKTRaFvwrCdc1yp0mrOQ==
X-Received: by 2002:a17:906:3b09:: with SMTP id g9mr20865299ejf.166.1548760776648;
        Tue, 29 Jan 2019 03:19:36 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id w24-v6sm8203745eja.71.2019.01.29.03.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 03:19:35 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <FDFE70E2-CA70-456F-8507-94BF822BF9A7@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_66F76678-C49B-4C9F-AD43-A7FC3EC594B6";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: extend line wp balance check
Date:   Tue, 29 Jan 2019 12:19:34 +0100
In-Reply-To: <20190129084737.718-1-hans@owltronix.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Zhoujie Wu <zjwu@marvell.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
To:     Hans Holmberg <hans@owltronix.com>
References: <20190129084737.718-1-hans@owltronix.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_66F76678-C49B-4C9F-AD43-A7FC3EC594B6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On 29 Jan 2019, at 09.47, hans@owltronix.com wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> pblk stripes writes of minimal write size across all non-offline =
chunks
> in a line, which means that the maximum write pointer delta should not
> exceed the minimal write size. Extend the line write pointer balance =
check
> to cover this case.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
>=20
> This patch applies on top of Zhoujie's V3 of
> "lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced
>=20
> drivers/lightnvm/pblk-recovery.c | 60 ++++++++++++++++++++------------
> 1 file changed, 37 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 02d466e6925e..d86f580036d3 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -302,41 +302,55 @@ static int pblk_pad_distance(struct pblk *pblk, =
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
> -	int pos, i, bit;
> +	int pos;
>=20
> -	bit =3D find_first_zero_bit(line->blk_bitmap, lm->blk_per_line);
> -	if (bit >=3D lm->blk_per_line)
> -		return 0;
> -	rlun =3D &pblk->luns[bit];
> +	rlun =3D &pblk->luns[index];
> 	ppa =3D rlun->bppa;
> 	pos =3D pblk_ppa_to_pos(geo, ppa);
> -	chunk =3D &line->chks[pos];
>=20
> -	line_wp =3D chunk->wp;
> +	return &line->chks[pos];
> +}
>=20
> -	for (i =3D bit + 1; i < lm->blk_per_line; i++) {
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
>=20
> -		if (chunk->state & NVM_CHK_ST_OFFLINE)
> -			continue;
> +	i =3D find_first_zero_bit(line->blk_bitmap, blk_in_line);
> +
> +	/* If there is one or zero good chunks in the line,
> +	 * the write pointers can't be unbalanced.
> +	 */
> +	if (i >=3D (blk_in_line - 1))
> +		return 0;
>=20
> -		if (chunk->wp > line_wp)
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
> @@ -362,7 +376,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, =
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

If I am understanding correctly, you want to protect against the case
where a pfail has broken the ws_min partition of a chunk, right? I say
this because there is a guarantee that the minimal write size and pblk's
write size align with ws_min and ws_opt. Even if we have grown bad
blocks on pfail for the current line (which is a bigger problem because
we have potentially lost data), this guarantee would remain.

If this is the case, my first reaction would be to say that the
controller is responsible for guaranteeing atomicity for both scalar and
vector I/Os. If this is not guaranteed, we have bigger problems than
this (e.g., for the write error recovery path).

Are you thinking of a different case?

Javier


--Apple-Mail=_66F76678-C49B-4C9F-AD43-A7FC3EC594B6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxQNsYACgkQPEYBfS0l
eOAHKA//ZdwEi6/OmPUsioc86jsAt5LJ9SPUNVONqsVFu+cdPIs4kDBEHxycgSad
faqaCQ47i/+83G5DMeQ9fDr6C1v3JjmVht78nWQgH+Tw8RUwX2+ALPpBaA6nxcM5
rkJsNtJE0X0/btK2EN2dAgjq7XDQ5WhjWCPTXRziXNhkLLFB5v72TnVKi+gcFF2Y
bYsqjaDS49FhJ4C7Wr0jPG65RcMls7M7IA3ODObUPNvs5zV3LlsEiW7rk4UACLvM
QsYvrCVqrTEXPxf+ld+KlEtSqwSLeyv/WiBwQcPRVIXEvluEL5C1M2rtwPL8niTu
mrRYdYpu0g4d26P1E8RS4ZhPSESk60bEX70mOJ3w0FwP0BFhPSOEcC5SYIwGxu+8
iRBh4B71Rr6yxCewfSqPdP33t4uQqaroPMZ8zCR/49Ysp25/f64Qh4ltknJWIQcl
hxKhMTfP5kZKP5I9K67vlY30YTwM70DXZCR56uo+W3Dywex7rOwF3f8CNrT8Q4Dw
LbTov3rcNLVr1Kjakj6nZg8HQ+tcCHiv5ulLLvgnRilE4xp/SWhS46WXaGdhrayn
zygAvJ7xLVB/U+Ep8tAo379DC8hA/BtzoUSncpv5tXxLWc/aauK6H1KXJsYi6dIm
F1OSoRtiZzHYytDNjGNabahSKQfiSxuqLJ6k6Ag66aFvnErXnW8=
=HHKe
-----END PGP SIGNATURE-----

--Apple-Mail=_66F76678-C49B-4C9F-AD43-A7FC3EC594B6--
