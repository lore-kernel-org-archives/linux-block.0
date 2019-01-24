Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33049C282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 09:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73AA2184C
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 09:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="zfA2fezv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfAXJR4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:17:56 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33716 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfAXJR4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 04:17:56 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so4008333eds.0
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 01:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=WQAXujFX9P4yfQ+Qf+0VXnRlRRfGEdObIY3/Frgu7pg=;
        b=zfA2fezvarUi74zXhU0ImZd5Q0erEPAQgAHYyKUoczohcmWOQifhptS2+cGDugBNmj
         ZowVwVsfkmTaafP/xbEandustrW8CCL3MBOAOPMrfwm766HnF6Wk3mViGGtT1BebOgZR
         9kUQKLExRKBH+kZVbSR6mZMkpmPb61e0w0HJ/us6KRHYqycpLA70650sLHYnn2yPPBZj
         x9ih+8JRVsXdDUDzFUKeHKT9umW0MwAC4Tm+5o+f+AC8tpc1J9yHP6MAx374VPb5BJPa
         GymFTOU9E/Dt+JZN91sprTaxqp5vozn7rbCxUvpQwW51tZmC9d1mYqRtidyv3WGFu0q5
         kbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=WQAXujFX9P4yfQ+Qf+0VXnRlRRfGEdObIY3/Frgu7pg=;
        b=iKqrNIT6Gu7lOD4pO4q1kKKDivm7VfrsKWOWOqiL7V62yeDtG2y0N6CvE/eiEDjd8+
         VBU/Qxt9Wc1JInK+0TqvLnD3gYUCInMe/llCo9v6PlpMG3ODPhu8Q3gZ9NcoONFCPFCH
         1XICF3kv9UH5HORqez2ZVvhqTlalk2qW/WHRI6ayaH349/cF+OGoXwhQ0wItTLcSXpya
         Ee/Vwile0EmrtVnZUbPzooPbsaUkFokH0KLVjhG1nRG3kDVpofJxnSeXFlhjpilcehWB
         snAoJUdWE7acoXySZcCNu2K/ESq5/KDIR4vWzeAQYb+lqO2xCtAj5oHaLQAk/QdjCKlU
         MqYA==
X-Gm-Message-State: AJcUukdRGzBUaXFy+cXYCx4qJ96/zRI4nsOvhEAQPV2+ifxWW/pJXRNv
        ie7VugL0w7LT7Tw1+g6Yu/+UD/fJ03ulwg==
X-Google-Smtp-Source: ALg8bN4dgw2p19nGpzN3bX6VrMFXOFaGqVVd6NnU46uUwfPo30GiYPU24Zewhnol7By9faud5vBUxw==
X-Received: by 2002:a50:d84d:: with SMTP id v13mr5863581edj.103.1548321474294;
        Thu, 24 Jan 2019 01:17:54 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id z39sm11066730edb.81.2019.01.24.01.17.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 01:17:53 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <88593F4C-6D36-4455-B934-3A3F5293B213@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_97AC6610-7D1B-4697-9948-9206D4831853";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: ignore bad block wp for
 pblk_line_wp_is_unbalanced
Date:   Thu, 24 Jan 2019 10:17:52 +0100
In-Reply-To: <1548291314-27225-1-git-send-email-zjwu@marvell.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>, hongd@marvell.com
To:     Zhoujie Wu <zjwu@marvell.com>
References: <1548291314-27225-1-git-send-email-zjwu@marvell.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_97AC6610-7D1B-4697-9948-9206D4831853
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 24 Jan 2019, at 01.55, Zhoujie Wu <zjwu@marvell.com> wrote:
>=20
> The write pointer of the bad block could be 0 or undefined, ignore
> the checking of the bad block wp for pblk_line_wp_is_unbalanced to
> avoid fake warning.
>=20
> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> ---
> drivers/lightnvm/pblk-recovery.c | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index 5ee20da..e1fba98 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -312,21 +312,27 @@ static int pblk_line_wp_is_unbalanced(struct =
pblk *pblk,
> 	struct nvm_chk_meta *chunk;
> 	struct ppa_addr ppa;
> 	u64 line_wp;
> -	int pos, i;
> +	int pos, i, v_blk;
>=20

v_blk is a bit confusing as it looks like the virtual block abstraction
we use in liblightnvm. In other places we call this simply 'bit'.

> -	rlun =3D &pblk->luns[0];
> +	v_blk =3D find_first_zero_bit(line->blk_bitmap, =
lm->blk_per_line);
> +	if (v_blk > lm->blk_per_line)
> +		return 0;
> +	rlun =3D &pblk->luns[v_blk];
> 	ppa =3D rlun->bppa;
> 	pos =3D pblk_ppa_to_pos(geo, ppa);
> 	chunk =3D &line->chks[pos];
>=20
> 	line_wp =3D chunk->wp;
>=20
> -	for (i =3D 1; i < lm->blk_per_line; i++) {
> +	for (i =3D v_blk + 1; i < lm->blk_per_line; i++) {
> 		rlun =3D &pblk->luns[i];
> 		ppa =3D rlun->bppa;
> 		pos =3D pblk_ppa_to_pos(geo, ppa);
> 		chunk =3D &line->chks[pos];
>=20
> +		if (test_bit(pos, line->blk_bitmap))
> +			continue;
> +

Instead, why not simply check for chunk->state in the loop? This is in
the end the ground truth for a bad chunk.

> 		if (chunk->wp > line_wp)
> 			return 1;
> 		else if (chunk->wp < line_wp)
> --
> 1.9.1

Javier

--Apple-Mail=_97AC6610-7D1B-4697-9948-9206D4831853
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxJgsAACgkQPEYBfS0l
eOBxUhAAvpHrlY01j8BFIj1y9kqPpa986f8z59QHjjoTuDO0fqP44rqQ99uTTee1
42Nj/rs7ZCj3z0nVeNBSXwIAwIlW39kC8h1B3BVxV36E5f7t24g0kjYkplo49XkL
TLhYAMYx3G/mrDy7gTYotQReSgpFvNtwv2pcbn6SKJp6KfKh4F6nLcp9pENavwUg
ysQCN89rFtlA4FjPIhWvJQMPXOgicbC1kbq1Xu5dVobTHnamNo+KvOtWVLBsrWJS
+xDaK06VKvzVZk5uuomRTsT9rq5/aGK9NXy0Ya/M+/w0QyQvn3Ux7ldV+gdLBUd7
XbkPURNKnONyv1YjcHewtw8ke8ZS+f5qgrwbk3YSF1mKZDOS9R+cLztOkNFLRQGP
Dc+WbHJ9VX9aYSUPzKgsygI1RmfDwF6x6ayriuFFgqAf0ZlThMw6amUKAXTWNuwG
pv8lzO8IslOhppINCODN7mcDDhe/QOvsMwDol0F0aPeFH6f/Qp7akNosU14LJ+M8
PiMpHCtNn3UAIWZW3dpx4pKIAA8pPFfyK7N11dA/v1335wxtr5QflazyxJCLn0Gn
DFq8VwzDRaWYFsRt1qeRfdQa3fldZiNhNqqJCA7ffSvLIoL6VCNVMyZ6+/6ThNHa
E2NdnW3/8MVu2dtTXS24/EDNE9jBRu4LQb6YtLcvR4LdontRNsk=
=zJ/x
-----END PGP SIGNATURE-----

--Apple-Mail=_97AC6610-7D1B-4697-9948-9206D4831853--
