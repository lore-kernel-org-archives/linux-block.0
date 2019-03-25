Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2A5C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 06:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F0E2075E
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 06:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="R+vygkp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfCYGSz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:18:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40530 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbfCYGSy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 02:18:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id h22so6434332edw.7
        for <linux-block@vger.kernel.org>; Sun, 24 Mar 2019 23:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=J8vWZV1sj0udrWFN/jdloh2DqlmF0WWcAxo/duIwbAc=;
        b=R+vygkp0tJbMq2t6o/X95u2yMA0S8aSIMf9CA7Qtj0L1ttMtFWvufrxJHvsADCqub3
         0TM41299W6hOpWj7uOQv+GSB9Fjf5WpbvzGVqryBKGYiorajvCdXEYow4U88L26cjZQ+
         ZKAIbiQQEDbeQD2l0yn+vMiclZa+3Sv5dno0suc4QsHUYoDfsKeZ4buVPolRKtfZdcQt
         /dbBTOqKYKW7v9iOxrkWHExgXTtYt6FmdXC1dBrIw4ZOZsnS9K+lQqPSYNQuVeyICrnT
         VVEAaK1lnldlUcfWqXkktrsS/dfTcH4edeio7HHU2BV3OqgBBQcq5T6iWojHaUQXF0CI
         uSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=J8vWZV1sj0udrWFN/jdloh2DqlmF0WWcAxo/duIwbAc=;
        b=Ip6diTYWZwTWZ+riKg3cJ3mojFvQuYsquNjQ3xAljAgSFobpwrtZVn+gFCFe16d+9G
         p8c+9hnIMclo3lyJiCf7FJVAVclHHh5ibz62bAnlB4ZjcQFGfQfPL52YHjjTyxKZjQcm
         s1h24wtJTfivGH8oj2Zoz412Lr8vudDExsAebAoK16gkI3N8YsE0FBWhnU/ioEkSJmna
         dEmtG8+wyv6VILSmwwc3SX+exDnVgsJtDTMWfvnoTDN+oqnZV7BdeW4iOoozrmNIY5EU
         6uOaVc1OezeoerJwyldAZh31q0PqRcoqB+8fgTdnWmITmeiyJJtn6G+XriQnTHJsZAcX
         3t3g==
X-Gm-Message-State: APjAAAXMtp3b1hhky93j6Wjn9AxTK0Trj8gVyNoNA9Xxmt1qZsmv+DU4
        ZZdsTOOIo8iI/EG1c4TZ8zVa/w==
X-Google-Smtp-Source: APXvYqwfWUObGACEOG6MdhYTWLBdo6PF4Aeb+dHtuV82tBSfwERVlKpiSHvBmo6QOIj21e+TQbrkTQ==
X-Received: by 2002:a17:906:d20e:: with SMTP id w14mr12764636ejz.160.1553494732442;
        Sun, 24 Mar 2019 23:18:52 -0700 (PDT)
Received: from [172.30.99.70] ([37.120.153.227])
        by smtp.gmail.com with ESMTPSA id g4sm3236851ejd.74.2019.03.24.23.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 23:18:51 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <759E29D3-9FEA-4A9B-875A-360DB96335C9@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4BB74FA8-E999-4D9E-8A84-C35F7393A80F";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 07/16] lightnvm: pblk: wait for inflight IOs in
 recovery
Date:   Mon, 25 Mar 2019 14:18:46 +0800
In-Reply-To: <20190322144843.9602-8-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
 <20190322144843.9602-8-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_4BB74FA8-E999-4D9E-8A84-C35F7393A80F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On 22 Mar 2019, at 22.48, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> This patch changes the behaviour of recovery padding in order to
> support a case, when some IOs were already submitted to the drive and
> some next one are not submitted due to error returned.
>=20
> Currently in case of errors we simply exit the pad function without
> waiting for inflight IOs, which leads to panic on inflight IOs
> completion.
>=20
> After the changes we always wait for all the inflight IOs before
> exiting the function.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-recovery.c | 25 ++++++++++++-------------
> 1 file changed, 12 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
> index b2267bd..f7e383e 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -200,7 +200,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, =
struct pblk_line *line,
> 	rq_ppas =3D pblk_calc_secs(pblk, left_ppas, 0, false);
> 	if (rq_ppas < pblk->min_write_pgs) {
> 		pblk_err(pblk, "corrupted pad line %d\n", line->id);
> -		goto fail_free_pad;
> +		goto fail_complete;
> 	}
>=20
> 	rq_len =3D rq_ppas * geo->csecs;
> @@ -209,7 +209,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, =
struct pblk_line *line,
> 						PBLK_VMALLOC_META, =
GFP_KERNEL);
> 	if (IS_ERR(bio)) {
> 		ret =3D PTR_ERR(bio);
> -		goto fail_free_pad;
> +		goto fail_complete;
> 	}
>=20
> 	bio->bi_iter.bi_sector =3D 0; /* internal bio */
> @@ -218,8 +218,11 @@ static int pblk_recov_pad_line(struct pblk *pblk, =
struct pblk_line *line,
> 	rqd =3D pblk_alloc_rqd(pblk, PBLK_WRITE_INT);
>=20
> 	ret =3D pblk_alloc_rqd_meta(pblk, rqd);
> -	if (ret)
> -		goto fail_free_rqd;
> +	if (ret) {
> +		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
> +		bio_put(bio);
> +		goto fail_complete;
> +	}
>=20
> 	rqd->bio =3D bio;
> 	rqd->opcode =3D NVM_OP_PWRITE;
> @@ -266,7 +269,10 @@ static int pblk_recov_pad_line(struct pblk *pblk, =
struct pblk_line *line,
> 	if (ret) {
> 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
> 		pblk_up_chunk(pblk, rqd->ppa_list[0]);
> -		goto fail_free_rqd;
> +		kref_put(&pad_rq->ref, pblk_recov_complete);

Are you sure you need this? You are putting the reference on
fail_complete: already.

> +		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
> +		bio_put(bio);
> +		goto fail_complete;
> 	}
>=20
> 	left_line_ppas -=3D rq_ppas;
> @@ -274,6 +280,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, =
struct pblk_line *line,
> 	if (left_ppas && left_line_ppas)
> 		goto next_pad_rq;
>=20
> +fail_complete:
> 	kref_put(&pad_rq->ref, pblk_recov_complete);
>=20
> 	if (!wait_for_completion_io_timeout(&pad_rq->wait,
> @@ -289,14 +296,6 @@ static int pblk_recov_pad_line(struct pblk *pblk, =
struct pblk_line *line,
> free_rq:
> 	kfree(pad_rq);
> 	return ret;
> -
> -fail_free_rqd:
> -	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
> -	bio_put(bio);
> -fail_free_pad:
> -	kfree(pad_rq);
> -	vfree(data);
> -	return ret;
> }
>=20
> static int pblk_pad_distance(struct pblk *pblk, struct pblk_line =
*line)
> --
> 2.9.5

Rest looks good


--Apple-Mail=_4BB74FA8-E999-4D9E-8A84-C35F7393A80F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyYcsYACgkQPEYBfS0l
eODh9A/+LNJQI6hTq20JL0i+xf+t4LGYZ8ok/fnMNztNulv4B2aRAeH6JhJhDRSf
O/NPG0kalMbxnuGgZiv/JNpRuXDlLNNpzn4EElVTQOeTK8jJJ5qeEobB0YpkLL9a
Pgreys5xbDtJqPAfOFwUW9IqYaa5WHMff+C6GgB+ISPO/xN1BZ8rjomZcKW1A+uZ
7wZy+Pt489TeBK0Sv/vlbyBRJjQUyc1/TKN25FOw/vkCkRJgkBrEY4l/QmTX8H2S
TP6bdqKuHb3gk9p2mMGk2g2VhYZdG9+jZb+hP+wRCy2jZw7JjxGYuVOM4/nwpb2R
sIoyMT8EsQp35vJpUeNZYnPTBdB6zX3XFiGmeqYFDLbbTbxZT3/Gj/HD2iTZHI9A
RQjH0xH/UT9NfYBPzyySqUcEg/cINS4qQ4ee+wJmrqNs1NJxSYUKhLVKcx5K0IiF
jhJgJSD0/WWh3YHjhUQ5mailnUw9mms2Qt79fttGzCrbjhaL/4g4GXHZD1IPj4YU
6U0rq6HuSHSRdPsGu6SejHnJjH11SQ0hHArTHL5YDoLTkDEkOaexOZXPEQt2bGbt
rUSRVRWC39Eh1Ie+xxnX/8sSTyBeo24SHeJsJ+ezrdgyCUKKBNuPlG1n3d2EEX1H
p3Y2jTrMsUkobogNVN/wshlxPjDooW7DzFvTp3G55OjKhWt7Qzs=
=RHLm
-----END PGP SIGNATURE-----

--Apple-Mail=_4BB74FA8-E999-4D9E-8A84-C35F7393A80F--
