Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90EBC433FF
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 14:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6465C20693
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 14:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="xG0GYs/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfGaOAc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:00:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45703 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfGaOAc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 10:00:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so65645493lje.12
        for <linux-block@vger.kernel.org>; Wed, 31 Jul 2019 07:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=AeV5y/7YBAzauJ9CVUGWrPfn2zkUpRwL++Z4I//XVkE=;
        b=xG0GYs/9AY+AfUaDlbO1ElJJ7rh8GhV1FOevcba29M4K73Q11ogJdSBcPkJzj637Ct
         uDlercjZnQfrSSl54toQ6XMOoGz68/ZcYWxwb4y4VKQK2dFEVT5HeNkWJfJhNplolu4r
         8+YlYtvv994M/ZNyRcaCi7EMvLVmDi1VotFAof3R1pc12nmS25l/WRTEMtQ/tZqHv8j5
         LxxRL4Y/3Zz/iW+VnMLgpwuPXEfNC37hUyb436ixBZcn7HOHqUzlLR5sgjVSPw0K3drv
         6PRY0HC4vQQmDMrDLDZ8hbMq89LCBi3rBcTkmjLPhgADTw6JKbwgXUC1z/cSOw2lmceX
         3WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=AeV5y/7YBAzauJ9CVUGWrPfn2zkUpRwL++Z4I//XVkE=;
        b=KpnlYQ4q5E0fwnUCG7ixE/HBFDU5lPdiIjg5q5Pg+q5rHz3wdQUEeE1sMdbWDSZWQW
         CaoyLoPOuQxfKE8Y8sd3ArLuOimoK//5uFqMBOf850Ps/BrLeaGyaVsYw0iUVE7ZQINM
         sRG3zyx+8dXSYOp2aptlUjKSYBEgdyTp/U8Wj5tGGCE+16ij35R38UENSDagujPnpJJW
         iDTDlfY1z1XeSwffpI3KyJ4foHmKwEY/KC6o0Wj6mqHo3JIO2PNPJpfbBdDoQbNWBIuw
         DWD9n/PK6pEN6msZ5Vl8cabneahVZGl2s0qQPjTKB5R65Xxt4X9dzyuu9wPLbA+OnYfr
         8mVw==
X-Gm-Message-State: APjAAAXXQMpXmR9uwOZB0ciuno0C5nnIvtCyqBlgat1Eox6m73n6xaMm
        wuEKzzeBlyrM9aaMtgrfQUU=
X-Google-Smtp-Source: APXvYqy8fdmmdAPM+l8TKnTqCVnzZd8UpK4K4eaT+cd+spJRryTiEanq++W2ZeB2FnK904DWa3w2+Q==
X-Received: by 2002:a2e:2bd3:: with SMTP id r80mr65679932ljr.23.1564581630216;
        Wed, 31 Jul 2019 07:00:30 -0700 (PDT)
Received: from [172.20.10.13] (212.27.19.10.bredband.3.dk. [212.27.19.10])
        by smtp.gmail.com with ESMTPSA id b25sm11830812lfq.11.2019.07.31.07.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 07:00:29 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <AC013EF0-BA7D-40B0-AE0D-BC533494E01F@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_59644D71-A35A-4BDE-90ED-960C50DA39B9";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 3/4] lightnvm: pblk: use kvmalloc for metadata
Date:   Wed, 31 Jul 2019 16:00:27 +0200
In-Reply-To: <1564566096-28756-4-git-send-email-hans@owltronix.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Hans Holmberg <hans@owltronix.com>
References: <1564566096-28756-1-git-send-email-hans@owltronix.com>
 <1564566096-28756-4-git-send-email-hans@owltronix.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_59644D71-A35A-4BDE-90ED-960C50DA39B9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 31 Jul 2019, at 11.41, Hans Holmberg <hans@owltronix.com> wrote:
>=20
> There is no reason now not to use kvmalloc, so
> so replace the internal metadata allocation scheme.

2 x so

>=20
> Signed-off-by: Hans Holmberg <hans@owltronix.com>
> ---
> drivers/lightnvm/pblk-core.c |  3 +--
> drivers/lightnvm/pblk-gc.c   | 19 ++++++++-----------
> drivers/lightnvm/pblk-init.c | 38 =
++++++++++----------------------------
> drivers/lightnvm/pblk.h      | 23 -----------------------
> 4 files changed, 19 insertions(+), 64 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index a58d3c84a3f2..b413bafe93fd 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1839,8 +1839,7 @@ static void pblk_save_lba_list(struct pblk =
*pblk, struct pblk_line *line)
> 	struct pblk_w_err_gc *w_err_gc =3D line->w_err_gc;
> 	struct pblk_emeta *emeta =3D line->emeta;
>=20
> -	w_err_gc->lba_list =3D pblk_malloc(lba_list_size,
> -					 l_mg->emeta_alloc_type, =
GFP_KERNEL);
> +	w_err_gc->lba_list =3D kvmalloc(lba_list_size, GFP_KERNEL);
> 	memcpy(w_err_gc->lba_list, emeta_to_lbas(pblk, emeta->buf),
> 				lba_list_size);
> }
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 63ee205b41c4..2581eebcfc41 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -132,14 +132,12 @@ static __le64 *get_lba_list_from_emeta(struct =
pblk *pblk,
> 				       struct pblk_line *line)
> {
> 	struct line_emeta *emeta_buf;
> -	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	unsigned int lba_list_size =3D lm->emeta_len[2];
> 	__le64 *lba_list;
> 	int ret;
>=20
> -	emeta_buf =3D pblk_malloc(lm->emeta_len[0],
> -				l_mg->emeta_alloc_type, GFP_KERNEL);
> +	emeta_buf =3D kvmalloc(lm->emeta_len[0], GFP_KERNEL);
> 	if (!emeta_buf)
> 		return NULL;
>=20
> @@ -147,7 +145,7 @@ static __le64 *get_lba_list_from_emeta(struct pblk =
*pblk,
> 	if (ret) {
> 		pblk_err(pblk, "line %d read emeta failed (%d)\n",
> 				line->id, ret);
> -		pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
> +		kvfree(emeta_buf);
> 		return NULL;
> 	}
>=20
> @@ -161,16 +159,16 @@ static __le64 *get_lba_list_from_emeta(struct =
pblk *pblk,
> 	if (ret) {
> 		pblk_err(pblk, "inconsistent emeta (line %d)\n",
> 				line->id);
> -		pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
> +		kvfree(emeta_buf);
> 		return NULL;
> 	}
>=20
> -	lba_list =3D pblk_malloc(lba_list_size,
> -			       l_mg->emeta_alloc_type, GFP_KERNEL);
> +	lba_list =3D kvmalloc(lba_list_size, GFP_KERNEL);
> +
> 	if (lba_list)
> 		memcpy(lba_list, emeta_to_lbas(pblk, emeta_buf), =
lba_list_size);
>=20
> -	pblk_mfree(emeta_buf, l_mg->emeta_alloc_type);
> +	kvfree(emeta_buf);
>=20
> 	return lba_list;
> }
> @@ -181,7 +179,6 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
> 									=
ws);
> 	struct pblk *pblk =3D line_ws->pblk;
> 	struct pblk_line *line =3D line_ws->line;
> -	struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
> 	struct pblk_line_meta *lm =3D &pblk->lm;
> 	struct nvm_tgt_dev *dev =3D pblk->dev;
> 	struct nvm_geo *geo =3D &dev->geo;
> @@ -272,7 +269,7 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
> 		goto next_rq;
>=20
> out:
> -	pblk_mfree(lba_list, l_mg->emeta_alloc_type);
> +	kvfree(lba_list);
> 	kfree(line_ws);
> 	kfree(invalid_bitmap);
>=20
> @@ -286,7 +283,7 @@ static void pblk_gc_line_prepare_ws(struct =
work_struct *work)
> fail_free_gc_rq:
> 	kfree(gc_rq);
> fail_free_lba_list:
> -	pblk_mfree(lba_list, l_mg->emeta_alloc_type);
> +	kvfree(lba_list);
> fail_free_invalid_bitmap:
> 	kfree(invalid_bitmap);
> fail_free_ws:
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index b351c7f002de..9a967a2e83dd 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -543,7 +543,7 @@ static void pblk_line_mg_free(struct pblk *pblk)
>=20
> 	for (i =3D 0; i < PBLK_DATA_LINES; i++) {
> 		kfree(l_mg->sline_meta[i]);
> -		pblk_mfree(l_mg->eline_meta[i]->buf, =
l_mg->emeta_alloc_type);
> +		kvfree(l_mg->eline_meta[i]->buf);
> 		kfree(l_mg->eline_meta[i]);
> 	}
>=20
> @@ -560,7 +560,7 @@ static void pblk_line_meta_free(struct =
pblk_line_mgmt *l_mg,
> 	kfree(line->erase_bitmap);
> 	kfree(line->chks);
>=20
> -	pblk_mfree(w_err_gc->lba_list, l_mg->emeta_alloc_type);
> +	kvfree(w_err_gc->lba_list);
> 	kfree(w_err_gc);
> }
>=20
> @@ -890,29 +890,14 @@ static int pblk_line_mg_init(struct pblk *pblk)
> 		if (!emeta)
> 			goto fail_free_emeta;
>=20
> -		if (lm->emeta_len[0] > KMALLOC_MAX_CACHE_SIZE) {
> -			l_mg->emeta_alloc_type =3D PBLK_VMALLOC_META;
> -
> -			emeta->buf =3D vmalloc(lm->emeta_len[0]);
> -			if (!emeta->buf) {
> -				kfree(emeta);
> -				goto fail_free_emeta;
> -			}
> -
> -			emeta->nr_entries =3D lm->emeta_sec[0];
> -			l_mg->eline_meta[i] =3D emeta;
> -		} else {
> -			l_mg->emeta_alloc_type =3D PBLK_KMALLOC_META;
> -
> -			emeta->buf =3D kmalloc(lm->emeta_len[0], =
GFP_KERNEL);
> -			if (!emeta->buf) {
> -				kfree(emeta);
> -				goto fail_free_emeta;
> -			}
> -
> -			emeta->nr_entries =3D lm->emeta_sec[0];
> -			l_mg->eline_meta[i] =3D emeta;
> +		emeta->buf =3D kvmalloc(lm->emeta_len[0], GFP_KERNEL);
> +		if (!emeta->buf) {
> +			kfree(emeta);
> +			goto fail_free_emeta;
> 		}
> +
> +		emeta->nr_entries =3D lm->emeta_sec[0];
> +		l_mg->eline_meta[i] =3D emeta;
> 	}
>=20
> 	for (i =3D 0; i < l_mg->nr_lines; i++)
> @@ -926,10 +911,7 @@ static int pblk_line_mg_init(struct pblk *pblk)
>=20
> fail_free_emeta:
> 	while (--i >=3D 0) {
> -		if (l_mg->emeta_alloc_type =3D=3D PBLK_VMALLOC_META)
> -			vfree(l_mg->eline_meta[i]->buf);
> -		else
> -			kfree(l_mg->eline_meta[i]->buf);
> +		kvfree(l_mg->eline_meta[i]->buf);
> 		kfree(l_mg->eline_meta[i]);
> 	}
>=20
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index d515d3409a74..86ffa875bfe1 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -482,11 +482,6 @@ struct pblk_line {
> #define PBLK_DATA_LINES 4
>=20
> enum {
> -	PBLK_KMALLOC_META =3D 1,
> -	PBLK_VMALLOC_META =3D 2,
> -};
> -
> -enum {
> 	PBLK_EMETA_TYPE_HEADER =3D 1,	/* struct line_emeta first =
sector */
> 	PBLK_EMETA_TYPE_LLBA =3D 2,	/* lba list - type: __le64 */
> 	PBLK_EMETA_TYPE_VSC =3D 3,	/* vsc list - type: __le32 */
> @@ -521,9 +516,6 @@ struct pblk_line_mgmt {
>=20
> 	__le32 *vsc_list;		/* Valid sector counts for all =
lines */
>=20
> -	/* Metadata allocation type: VMALLOC | KMALLOC */
> -	int emeta_alloc_type;
> -
> 	/* Pre-allocated metadata for data lines */
> 	struct pblk_smeta *sline_meta[PBLK_DATA_LINES];
> 	struct pblk_emeta *eline_meta[PBLK_DATA_LINES];
> @@ -934,21 +926,6 @@ void pblk_rl_werr_line_out(struct pblk_rl *rl);
> int pblk_sysfs_init(struct gendisk *tdisk);
> void pblk_sysfs_exit(struct gendisk *tdisk);
>=20
> -static inline void *pblk_malloc(size_t size, int type, gfp_t flags)
> -{
> -	if (type =3D=3D PBLK_KMALLOC_META)
> -		return kmalloc(size, flags);
> -	return vmalloc(size);
> -}
> -
> -static inline void pblk_mfree(void *ptr, int type)
> -{
> -	if (type =3D=3D PBLK_KMALLOC_META)
> -		kfree(ptr);
> -	else
> -		vfree(ptr);
> -}
> -
> static inline struct nvm_rq *nvm_rq_from_c_ctx(void *c_ctx)
> {
> 	return c_ctx - sizeof(struct nvm_rq);
> --
> 2.7.4

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>




--Apple-Mail=_59644D71-A35A-4BDE-90ED-960C50DA39B9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAl1BnvsACgkQPEYBfS0l
eOBJaQ/6Al8WuAZAGY23iYGwA6vJVrO1UGp+CHzs9uqmQ1svg4OfckPRbwLkjctN
5WCadZtI2aid3J5o/Ikg3VDkLcES5n32plBrlBjsvXHkWutwqCtR2tYzNuvq4Aih
34Y+mZJI5gmzRPAtRYyik2ao08eD5kmc9OMQyS6fQ3ZoZRP7oTtpUHblZ03eLOwG
jurmsluDg8aE12bTIZdOPfhciUlQbr3Hjr6C0lx+ywE5De9IGWT+5baNaD0Sd5j7
jFBi+IA7lFW2/au5IrtqsfH8npAY5Z2yk+1F9BKVCEuGFPNw0sa9b53hfKfw3TTv
iva/RDzhizhgk+/U8GEm7LK1gupStwBek1hLHG8LFR2YTBQh75yhdUlY8Erveomz
3+XGNMjo7oENQ1aKvjRAiuH96bIdawf6b6NHZJTonqmSithZ2EXGqn3QsmAlsyCB
3CZoAk3TeI+RLn5UEG+gKsJx6WSoOhrbyGpwXBcs+mAXYlLAiESlZK1Hca4MxRWe
IeBKJYpWeKK23VNRWOE/NKwgA9dfWOtsFD3Z3n9eXZ/v+AcMFeDhxUBJn2XRIYVf
GytRcIliIHDnOF0SR5I6xWk7IDDstUjSq3XZGz8hemlIT3q2vyIkgGi37lJPSLzS
hSjR88u4ITmeoKFsj2Q2qs1or+yJqw7exdDJ2dlmdz6JV3HT/vM=
=5P2q
-----END PGP SIGNATURE-----

--Apple-Mail=_59644D71-A35A-4BDE-90ED-960C50DA39B9--
