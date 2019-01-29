Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB70C3E8A4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB882175B
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="puNvNeck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfA2INO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:13:14 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35141 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfA2INK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 03:13:10 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so15273775edx.2
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 00:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=f/tZUUThlJr1yTNoJR/qpu3sQRcnidvLeVHHov8bumE=;
        b=puNvNecknf3HStXmm0j1iO3DsLhOAwTW+Z84emFHRKjHhrXTPaR2AMd4jERO2S9ox7
         PRzJrdHQeJPJf4+XEWSs9ectjhDW1mH5BvPlYeaglVk0/xDJ/ylJlhVHy4qCOXzfcIcP
         G2FmHPrirgO3JsurI8eBGFGS8+NckfH5wPUWPSmyq4dMLRjCCf7HHw7IaDuWUGBZvDiz
         hu392D89qWc6QWSezVTql5awVJBFzuYHocwVbvxBKT83d/odTARZNxfXw0YNSk6uPbrW
         Tj6Q8utl7y49VL64iV0ovxfaugZkBr2XECm6WUcMXxP6kiP0ouB3XsmPHLA9UzKx/ffC
         YUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=f/tZUUThlJr1yTNoJR/qpu3sQRcnidvLeVHHov8bumE=;
        b=qOxDxZFDH9O9eT7lk7nlxN1up9BYoztgD7aeg3B1wNVR84feGUYSSJKfrHFKazVDHD
         UfjDj0Y4fGE9+psWlhI8f3fKVEzz62WBdt0r/IbNqH8Ug6tMUcqJNZSQs94H6F9g8TYd
         CWNYWRwEY4SdcR02B31+t/N96q+rud/MzoTrSFmw2l4AdQvdduZ6yrg92BC+bA8wc+U7
         1FnzNXkEeAxuf/NTvOhys3RH4lFSmU/0x0XN/LDNruBoiw+UjODyPgUykLaf81FkkHMg
         sGSM74gkzZgleY0LTs56Uno7c3bNs5BSMnIYWV+IKDw3+YGW+YT/LrbJdVZsrHZ1ZcoH
         n43w==
X-Gm-Message-State: AJcUukceCZJnrRJs1wHOYYF4PFUqr2Dr+/zzhZckevGaERDqEEqpeu5M
        4c/fAZPXDe1v10JIgXXxBC7M1Q==
X-Google-Smtp-Source: ALg8bN6Na2KGL1dQOs/s5xqeNkbKp/IlTDkc+kUo+RYFzLnIx546WFWKTv39+M0TMw6CkVz8LYojOw==
X-Received: by 2002:a50:9226:: with SMTP id i35mr25142989eda.8.1548749588027;
        Tue, 29 Jan 2019 00:13:08 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id t15-v6sm7972969ejt.0.2019.01.29.00.13.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 00:13:07 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <9E81CD34-5291-40B8-93EE-00BABAC7C0DC@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_B2FB69B3-A04E-4BD0-8000-459B75E5478A";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] lightnvm: pblk: fix race condition on GC
Date:   Tue, 29 Jan 2019 09:13:06 +0100
In-Reply-To: <20190127065421.10662-1-hlitz@ucsc.edu>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Heiner Litz <hlitz@ucsc.edu>
References: <20190127065421.10662-1-hlitz@ucsc.edu>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_B2FB69B3-A04E-4BD0-8000-459B75E5478A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 27 Jan 2019, at 07.54, Heiner Litz <hlitz@ucsc.edu> wrote:
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

Hi Heiner,

This has been an interesting issue to debug - good catch!

>=20
> Note that looking up the L2P and checking the ppa in the write buffer =
needs
> to be performed atomically, hence the refactor of =
pblk_lookup_l2p_rand.
>=20
> Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> ---
> drivers/lightnvm/pblk-read.c | 27 +++++++++++++++++++++++++--
> 1 file changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 3789185144da..7c556b2218e4 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -529,13 +529,35 @@ static int read_ppalist_rq_gc(struct pblk *pblk, =
struct nvm_rq *rqd,
> 	int valid_secs =3D 0;
> 	int i;
>=20
> -	pblk_lookup_l2p_rand(pblk, ppa_list_l2p, lba_list, nr_secs);
> -
> +	spin_lock(&pblk->trans_lock);
> 	for (i =3D 0; i < nr_secs; i++) {
> 		if (lba_list[i] =3D=3D ADDR_EMPTY)
> 			continue;
>=20
> +		ppa_list_l2p[i] =3D pblk_trans_map_get(pblk, =
lba_list[i]);
> 		ppa_gc =3D addr_to_gen_ppa(pblk, paddr_list_gc[i], =
line->id);
> +
> +		/* Obtain ppa from cache if the sector has been synced =
to the
> +		   device but the L2P has not been updated yet */
> +		if(pblk_addr_in_cache(ppa_list_l2p[i])) {
> +			struct pblk_rb *rb =3D &pblk->rwb;
> +			struct pblk_rb_entry *entry;
> +			struct pblk_w_ctx *w_ctx;
> +			u64 pos =3D =
pblk_addr_to_cacheline(ppa_list_l2p[i]);
> +
> +#ifdef CONFIG_NVM_PBLK_DEBUG
> +			/* Ensure that the access will not cause an =
overflow */
> +			BUG_ON(pos >=3D rb->nr_entries);
> +#endif
> +
> +			entry =3D &rb->entries[pos];
> +			w_ctx =3D &entry->w_ctx;
> +			if (pblk_ppa_comp(w_ctx->ppa, ppa_gc)) {
> +				rqd->ppa_list[valid_secs++] =3D ppa_gc;
> +				continue;
> +			}
> +		}
> +
> 		if (!pblk_ppa_comp(ppa_list_l2p[i], ppa_gc)) {
> 			paddr_list_gc[i] =3D lba_list[i] =3D ADDR_EMPTY;
> 			continue;
> @@ -543,6 +565,7 @@ static int read_ppalist_rq_gc(struct pblk *pblk, =
struct nvm_rq *rqd,
>=20
> 		rqd->ppa_list[valid_secs++] =3D ppa_list_l2p[i];
> 	}
> +	spin_unlock(&pblk->trans_lock);
>=20
> #ifdef CONFIG_NVM_PBLK_DEBUG
> 	atomic_long_add(valid_secs, &pblk->inflight_reads);
> --
> 2.17.1


Here is a suggestion: Why not add an atomic counter to the
line stating the sectors that are synced in the L2P table and then
loosely wait (i.e., check and sleep / schedule) until the counter
reaches 0 on pblk_line_close_ws()? This way you guarantee that the line
does not close - and therefore never reaches the GC lists - before all
the L2P entries for that line point to the media. Any other form of
synchronization that puts the burden at pblk_line_close_ws() would also
work for me.

In essence, I would rather pay the price on a per-line basis than
blocking the trans_lock longer for each I/O.

Thoughts?

Javier


--Apple-Mail=_B2FB69B3-A04E-4BD0-8000-459B75E5478A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxQCxIACgkQPEYBfS0l
eOCqKhAA1Vt7rIWaid80/N1f5DKSLXneS63sa9+N89STDm1PR3ep1PmkpiBv3lEV
pqssIYM1WdsVggRyylPk0jfObFTZmSDpVICyMe0THIrvYdoG2omQTubuZS+PtyKO
kqYGb+a49pcwCt2ZL+YKtEHcrefrVq3Wj7wq5qLtW6mNrodU62kRiN5u+CoKHHfd
7a0+HLOWpTl9IuhEcLsXBoIsJXmEuRj97o/zDsoX/n9rk+4lXKUHqOrCRCKdDH9q
lGjCmBvBWA26w6A/8sGUpjfD2t4hNpR14KG3BWeL6f2kE8VUeSx5DYN1bOBN+gTV
RclMR5iYsrZ4bNkKrLLyRTuf+xGlpcKFSRMd4d6qMN+/uNboq4GlpmSqOmAxuaNa
BNH8J/7PYxFZrPgWOW4E3lef/suD6oIgH9nTOW8nBxOSxow9mw746xpFQJAVTaGJ
ElpS6tfbstAzgRdnZYCFD+5H3/eWHtu4SWI4W7KhsUKTkZ7HXsRaTwJvTcQ4X7bf
7z7iZn/snrBK59JwzwgkLut7UG5nWdrxeh7Q7MKAuWnsDnGSA4aczzsuSGpSrKZz
gWrc6ssc86l8S/Fz4aUgwatCQ/AgikpRCiwFVHjt7Cd0NlPwuLhT16UvEFn5/sXP
Vhr9t1AtLWBPNMxRQjYWy3ItetnZDWTiiZHC9xBgLC8KZfsw3l8=
=jTbF
-----END PGP SIGNATURE-----

--Apple-Mail=_B2FB69B3-A04E-4BD0-8000-459B75E5478A--
