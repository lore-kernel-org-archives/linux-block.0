Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AD6C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 08:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413D62082F
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 08:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="HsM5xT6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfCDID6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:03:58 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45776 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfCDID6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 03:03:58 -0500
Received: by mail-ed1-f66.google.com with SMTP id f19so3428230eds.12
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 00:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=6aSDduZwaD2iFm1bI4yopQpqB8k/oOKPWgEhPs1oh+4=;
        b=HsM5xT6FnYEEMsgp6+ovNKPnLzQkwONvm1rNT9Q7qYbc9b1JUtjnkg+nrqQurZyErt
         xDhiKFeJNf4yT4cU7dt3TjSB+2fvjey0ERaUSF2dgaBpFS2LC5LnPKG1Dv+DkcLC3oh+
         sTA2Fmp3Gt4PbrDdIsjMS720mg4NcJWFUdWCWRrFxTbvVeXSgn6Mzma8gEohXtVCm3Ez
         NcffC4qfYDWeuoZnY4+YoJpkUA6HGLdzeyOaLgS53p9TWzapBQcOmkI0R7HCONokPHiD
         3tTmefQLbo6xZP9SE5cTu4mgsninvbZt1KOt7qSnQwjjqij+cNw1uEIJ0VHx007AGEuw
         kIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=6aSDduZwaD2iFm1bI4yopQpqB8k/oOKPWgEhPs1oh+4=;
        b=kwsigkgTIWeq9CSTirI/jfxWbRsedVtV66LcUVYYfkyztXqKncYLirSLhUjuKWnNjJ
         AcruoZzuCJC/VihakB+Gs9uebMu+ecESWYw1INRDPubad+r8bMoMVzu+b0iTSTaNQjpY
         VaaKYNi3afV1rePYE/grTpJxYMh3kZAI+zGudZjzwmVPFl2a9rxtUAsY98hnJLDe+aoN
         F2FcqWYhZcvPiDPWwvo1PhOmyY0pj2GtfAgboDptQCtXYHHK6O2qInBRP5ZySRiShqcx
         VXxbtFrettOr67T8o0588XVxF86Xxq/F1tSz7eUf2ZzlGOx5qFi7+zVE2NPEiz81J/O1
         gyFg==
X-Gm-Message-State: APjAAAW0mxiVukp2ALphkFW58utnQgvIlj89b4h13XacI//7f90VgdG9
        ufwcny7R6XbfyFbUSLShjfCi5A==
X-Google-Smtp-Source: APXvYqzW3f+p1eVEmqAvrfWIasasL6LDGP2Y8rWobrPvE47PU6HgIkfX8iTSNrDpqQlKx/GPUmroew==
X-Received: by 2002:a50:9964:: with SMTP id l33mr14228102edb.115.1551686635435;
        Mon, 04 Mar 2019 00:03:55 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id h1sm1043978ejx.41.2019.03.04.00.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 00:03:54 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <007EC669-9C50-4B29-9522-CE73CD3CE47F@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_F4F78B03-C79A-4227-BBDB-7E3A3402D330";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 08/13] lightnvm: pblk: Set proper read stutus in bio
Date:   Mon, 4 Mar 2019 09:03:53 +0100
In-Reply-To: <20190227171442.11853-9-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-9-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_F4F78B03-C79A-4227-BBDB-7E3A3402D330
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently in case of read errors, bi_status is not
> set properly which leads to returning inproper data
> to higher layer. This patch fix that by setting proper
> status in case of read errors
>=20
> Patch also removes unnecessary warn_once(), which does
> not make sense in that place, since user bio is not used
> for interation with drive and thus bi_status will not be
> set here.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-read.c | 11 +++++------
> 1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 3789185144da..39c1d6ccaedb 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -175,11 +175,10 @@ static void pblk_read_check_rand(struct pblk =
*pblk, struct nvm_rq *rqd,
> 	WARN_ONCE(j !=3D rqd->nr_ppas, "pblk: corrupted random =
request\n");
> }
>=20
> -static void pblk_end_user_read(struct bio *bio)
> +static void pblk_end_user_read(struct bio *bio, int error)
> {
> -#ifdef CONFIG_NVM_PBLK_DEBUG
> -	WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
> -#endif
> +	if (error && error !=3D NVM_RSP_WARN_HIGHECC)
> +		bio_io_error(bio);
> 	bio_endio(bio);
> }
>=20
> @@ -219,7 +218,7 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
> 	struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
> 	struct bio *bio =3D (struct bio *)r_ctx->private;
>=20
> -	pblk_end_user_read(bio);
> +	pblk_end_user_read(bio, rqd->error);
> 	__pblk_end_io_read(pblk, rqd, true);
> }
>=20
> @@ -292,7 +291,7 @@ static void pblk_end_partial_read(struct nvm_rq =
*rqd)
> 	rqd->bio =3D NULL;
> 	rqd->nr_ppas =3D nr_secs;
>=20
> -	bio_endio(bio);
> +	pblk_end_user_read(bio, rqd->error);
> 	__pblk_end_io_read(pblk, rqd, false);
> }
>=20
> --
> 2.17.1

This is by design. We do not report the read errors as in any other
block device - this is why we clone the read bio.

If you want to remove the WARN_ONCE, it is fine by me - it helped in the
past to debug the read path as when one read failed we go a storm of
them. Now we have better controller tools to debug this, so if nobody
else wants it there, let=E2=80=99s remove it.

Javier

--Apple-Mail=_F4F78B03-C79A-4227-BBDB-7E3A3402D330
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx82+kACgkQPEYBfS0l
eOAbPw/+LRwCGZ93p7yfXWFQnx4o63/BQ4z5aDeEbZ+CE16fdP/5SMMYcWrHvwBm
kdxJBJC7Y6IuM1ElMl7EQXoJlyauoklclaZXCQQS/uinDVL/thE45GA8UjBV9q21
zgi53FOzb7SxejaTphpNXwb65S5318g6xQmzL9mD8ICf+eYdt78S2K3NE3nMxN92
tFdWaAcZLIkc1DxPLe3JPxU0jaysdxfh5LqUVYjcoetQNpn8KbSM+gI9RIXg+MRo
4J0tju68cN/be0VhhLZ9LaWbrYaefXp8W7YPR1uzCx2FqgTRCpGe6wzXM3kga4Qk
Yn6Vfk7V8Ow215SQcYkUwR/kLysLZEZbeTfyRP70LiZVGeuRUIpMm2SKdi/UVp9z
f7Iin3KjfbQlgZnCPYd7zmAJde1q3Z1NaxI1Vvf2Cy5f0+8SwduTbG4NJ9uT1LQC
r/8zar1aB+CtVvhApFk7PsmEDVTpyW1bAwCoBhjs7mZNWGzlFZNVMQcWSFbMjGgt
ZW1zN83v0Ajf1wMukxKgpOeCQqWY6lWxI0MBJ821CZqtRE5JlYCHaK1iYutaGWxl
SRECjUXaFHRReINKfpztDm9IxrxD3B9bHyBOHWG2uRVtIJVjgvGOGolYooEjSnOX
ZLYSaHbPNqtqRof0XR7rNThcGhTtc4RR4dYFG5kVWVM3MOxwRZU=
=/td1
-----END PGP SIGNATURE-----

--Apple-Mail=_F4F78B03-C79A-4227-BBDB-7E3A3402D330--
