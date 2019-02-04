Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCF3C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 08:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986AB21848
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 08:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="WNYE4lZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfBDITx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:19:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37660 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfBDITx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 03:19:53 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so10475382edb.4
        for <linux-block@vger.kernel.org>; Mon, 04 Feb 2019 00:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=nHec5SK0EMzPFzroIEZ1dXfgrw2W8X4CTy0fmcpPth4=;
        b=WNYE4lZPkmFMy3HDXIMrWaE0Je0p56veKleyQSbSu8VW292ATcUUL8KGo0Y3lGoTYV
         B/qLdXRREhcy5Y6LuqzkKqRzQDlowg0D9u13EQH58AYNuHc4+NGHVxChW8nsq5dVa3yV
         VbJVKenJnrB3H/yGVGoU5tZZxDuRKz5wpXu1KCoYwIw12z839MJZEvrkpZUPEwoKve7i
         sYs4iXxOlrn6tuqYg0RJ+IU1fS2xxQ+7NDp3ap8rq7TiU48cUJaf2PR09KtoURy87+OX
         dFEegCFjHkddXHqbT7/f+flRBMAwFWq/Xljj1Ibwr5N7YJdm5PFmSOtq69wjFriZnhfD
         eOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=nHec5SK0EMzPFzroIEZ1dXfgrw2W8X4CTy0fmcpPth4=;
        b=c/4pIrCzHqV4GmjuPgLzYkfUdfAX2RaemzqHGkG+W/iihO+MSvHLaJPmlx8/VQkfnm
         DO8gPPyITYBWet6/i9DetpTnBwpAFi1URnTFlC6QUkbmvqIHtB5JMZ5v9JCKyTcqBT8R
         rmjby8bp2OAPiwhup9e5dLx8IGCfEIM7zHPUf56MOZ2tz8thKDUBcQnoih6kwDbqjv3o
         gTiJdUUc+QLu0WAy8jFiUROgtsXgqQac36qdwxrQVbAvIJdoH+68Ir78Ic7XxB8CIWUu
         96KK7jHY3FQZ3k27yYxovtqYsAbx8C+jTXtpzYxpN0fsSh/+33tbnFb/f4y7fhToQKTi
         94JA==
X-Gm-Message-State: AJcUukf9nA2TWesch4QOVTVcHZgLFzK0fcNBpcHiXpZyLbS88fsXF7Im
        n4Bh0J8AZl6P3vmgVD8EzmYB2w==
X-Google-Smtp-Source: ALg8bN5xLHVdpyFGIljFrUT7wP56apIMFIyMzgfyPCkfSYCmm6n7dSDFarXsRoBJM0k31/GIFkSAjw==
X-Received: by 2002:a17:906:4a0c:: with SMTP id w12mr40512169eju.240.1549268391054;
        Mon, 04 Feb 2019 00:19:51 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id t26sm4104066eda.22.2019.02.04.00.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 00:19:50 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <7BC68605-5E76-4E0D-8C3E-29B2CB329FEB@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_7C00D2F4-F263-40EF-918A-C83E1B352671";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH V2] lightnvm: pblk: fix race condition on GC
Date:   Mon, 4 Feb 2019 09:19:49 +0100
In-Reply-To: <20190201023806.39895-1-hlitz@ucsc.edu>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Heiner Litz <hlitz@ucsc.edu>
References: <20190201023806.39895-1-hlitz@ucsc.edu>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_7C00D2F4-F263-40EF-918A-C83E1B352671
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 1 Feb 2019, at 03.38, Heiner Litz <hlitz@ucsc.edu> wrote:
>=20
> This patch fixes a race condition where a write is mapped to the last
> sectors of a line. The write is synced to the device but the L2P is =
not
> updated yet. When the line is garbage collected before the L2P update =
is
> performed, the sectors are ignored by the GC logic and the line is =
freed
> before all sectors are moved. When the L2P is finally updated, it =
contains
> a mapping to a freed line, subsequent reads of the corresponding LBAs =
fail.
>=20
> This patch introduces a per line counter specifying the number of =
sectors
> that are synced to the device but have not been updated in the L2P. =
Lines
> with a counter of greater than zero will not be selected for GC.
>=20
> Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> ---
>=20
> v2: changed according to Javier's comment. Instead of performing check
> while holding the trans_lock, add an atomic per line counter
>=20
> drivers/lightnvm/pblk-core.c  |  1 +
> drivers/lightnvm/pblk-gc.c    | 20 +++++++++++++-------
> drivers/lightnvm/pblk-map.c   |  1 +
> drivers/lightnvm/pblk-rb.c    |  1 +
> drivers/lightnvm/pblk-write.c |  1 +
> drivers/lightnvm/pblk.h       |  1 +
> 6 files changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index eabcbc119681..b7ed0502abef 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1278,6 +1278,7 @@ static int pblk_line_prepare(struct pblk *pblk, =
struct pblk_line *line)
> 	spin_unlock(&line->lock);
>=20
> 	kref_init(&line->ref);
> +	atomic_set(&line->sec_to_update, 0);
>=20
> 	return 0;
> }
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 2fa118c8eb71..26a52ea7ec45 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -365,16 +365,22 @@ static struct pblk_line =
*pblk_gc_get_victim_line(struct pblk *pblk,
> 						 struct list_head =
*group_list)
> {
> 	struct pblk_line *line, *victim;
> -	int line_vsc, victim_vsc;
> +	unsigned int line_vsc =3D ~0x0L, victim_vsc =3D ~0x0L;
>=20
> 	victim =3D list_first_entry(group_list, struct pblk_line, list);
> +
> 	list_for_each_entry(line, group_list, list) {
> -		line_vsc =3D le32_to_cpu(*line->vsc);
> -		victim_vsc =3D le32_to_cpu(*victim->vsc);
> -		if (line_vsc < victim_vsc)
> +		if (!atomic_read(&line->sec_to_update))
> +			line_vsc =3D le32_to_cpu(*line->vsc);
> +		if (line_vsc < victim_vsc) {
> 			victim =3D line;
> +			victim_vsc =3D le32_to_cpu(*victim->vsc);
> +		}
> 	}
>=20
> +	if (victim_vsc =3D=3D ~0x0)
> +		return NULL;
> +
> 	return victim;
> }
>=20
> @@ -448,13 +454,13 @@ static void pblk_gc_run(struct pblk *pblk)
>=20
> 	do {
> 		spin_lock(&l_mg->gc_lock);
> -		if (list_empty(group_list)) {
> +
> +		line =3D pblk_gc_get_victim_line(pblk, group_list);
> +		if (!line) {
> 			spin_unlock(&l_mg->gc_lock);
> 			break;
> 		}
>=20
> -		line =3D pblk_gc_get_victim_line(pblk, group_list);
> -
> 		spin_lock(&line->lock);
> 		WARN_ON(line->state !=3D PBLK_LINESTATE_CLOSED);
> 		line->state =3D PBLK_LINESTATE_GC;
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index 79df583ea709..7fbc99b60cac 100644
> --- a/drivers/lightnvm/pblk-map.c
> +++ b/drivers/lightnvm/pblk-map.c
> @@ -73,6 +73,7 @@ static int pblk_map_page_data(struct pblk *pblk, =
unsigned int sentry,
> 		 */
> 		if (i < valid_secs) {
> 			kref_get(&line->ref);
> +			atomic_inc(&line->sec_to_update);
> 			w_ctx =3D pblk_rb_w_ctx(&pblk->rwb, sentry + i);
> 			w_ctx->ppa =3D ppa_list[i];
> 			meta->lba =3D cpu_to_le64(w_ctx->lba);
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index a6133b50ed9c..03c241b340ea 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -260,6 +260,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb =
*rb, unsigned int to_update)
> 							=
entry->cacheline);
>=20
> 		line =3D pblk_ppa_to_line(pblk, w_ctx->ppa);
> +		atomic_dec(&line->sec_to_update);
> 		kref_put(&line->ref, pblk_line_put);
> 		clean_wctx(w_ctx);
> 		rb->l2p_update =3D pblk_rb_ptr_wrap(rb, rb->l2p_update, =
1);
> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
> index 06d56deb645d..6593deab52da 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -177,6 +177,7 @@ static void pblk_prepare_resubmit(struct pblk =
*pblk, unsigned int sentry,
> 		 * re-map these entries
> 		 */
> 		line =3D pblk_ppa_to_line(pblk, w_ctx->ppa);
> +		atomic_dec(&line->sec_to_update);
> 		kref_put(&line->ref, pblk_line_put);
> 	}
> 	spin_unlock(&pblk->trans_lock);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index a6386d5acd73..ac3ab778e976 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -487,6 +487,7 @@ struct pblk_line {
> 	__le32 *vsc;			/* Valid sector count in line */
>=20
> 	struct kref ref;		/* Write buffer L2P references =
*/
> +	atomic_t sec_to_update;         /* Outstanding L2P updates to =
ppa */
>=20
> 	struct pblk_w_err_gc *w_err_gc;	/* Write error gc recovery =
metadata */
>=20
> --
> 2.17.1


Looks good to me. Again, good marathon-catch! :)

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>



--Apple-Mail=_7C00D2F4-F263-40EF-918A-C83E1B352671
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxX9aUACgkQPEYBfS0l
eODG7RAAtHaqR9m/wxWpOBX6vpqQ8m2aj4Nzx8v5uPqCWjxSzJBHBs5t+Mf8JwjE
lJvglilekEe6QtsY7aJ4+/VScibFwgsxQBBjeCIjkmO2Mbyomn/Zwg9KwNpstfDq
qMvUiqNwYqe2YOWOXqo4tSsoTc7lq+t1Fz/O8diCDNPp+0fXYJ+izrHCDGQHkOXb
E3Gz4MXsC5QwVXS6JpgpEqWT6PH+8USr5yErxPMs2RzRoCcpiOVbmIVruBk4bTUm
G8JBE1hbsxytzKzVEPj5vLG+liqlZwd4DlfNVpYPdExqqWHn8KXoD+SqfwM4xxRg
+OMrpT6bS5ObUPcGQx/ncHT32+TDaGlTM2XMPw27FjakwuuD9SiBSYwdsncvwB5G
ndRz8EgXKOO+1cKiiWT5XgkwNvnWODdYQjjGn7i9JeLTyZ8o0bHGDVQvfbFiwwzi
L9oMbPCcFRi13OXy6BIqk6I3PO/OvMnNByA9sztTX8lEcSE08XCw3xqOb3GKzJBA
kU+i81QAsaWPJ0bbbkhJCXasn1NYNyRWKgAL1Tai0Moi0BCaDZ7BO55wDcDQ0x0Y
XH54MsOUkJIOmNpIhvEcuxyGjuoz+dDptKylBYvGUsZoRG8/VYkVKpxVH7iDHeec
gFj+KQ1jFBh2ahSvV4EtIGhy06r4nkUlY9V8mponk5x5LrUv6bY=
=0nLF
-----END PGP SIGNATURE-----

--Apple-Mail=_7C00D2F4-F263-40EF-918A-C83E1B352671--
