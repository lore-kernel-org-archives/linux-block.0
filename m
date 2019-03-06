Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86711C43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549C920675
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="edaY2xjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfCFIAj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:00:39 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42447 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFIAj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 03:00:39 -0500
Received: by mail-ed1-f66.google.com with SMTP id j89so9502460edb.9
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2019 00:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=a4mUEUqfazPW6IQc5sLYiTpxFamtoGBrwVT7w1cGvhk=;
        b=edaY2xjJWHplnrGVZyPn0pGuSioBs4g3KhbZ6DnDGtornwsuNzVBn2xOxOd8cAFt8k
         XPZdaTYgaSLBg6QPBwy7zyWhpG9kF4XBbjvpJn+rB68p77D8Xf2nMod0rk9jONCiD7k0
         VtCWcC1h5wG6Lq3cYczN4EfRe33EDk8cL4YMmg60c7CV++IG1hfHC4lekKGB8mqt1mH0
         IOp4dJMV+hK9+rE3ETMk2H3y7/JkPPNZv1bgDGJ0LdJjLTdZhD1FdOBfp37NucH52tTX
         33AjhQTaRks27oewUCKqdCeD5yJjQKUBecmZxalUfK5foomi5ixgFH6OBI9eLMN7dikG
         duoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=a4mUEUqfazPW6IQc5sLYiTpxFamtoGBrwVT7w1cGvhk=;
        b=jD2SLBpIsZv/06mDVUog2MJyB7z7QNPg52jzjW9pPmSXxSxoK2RGAZxUgJIjXG9Cym
         uKIOG6mhH0fswE9vq4NNFOgb5sw/P3Q/2dc6wmC+mlzWtNuswjIRJdlXBX8wkgKVRsyu
         RrRyKvomRF/TdgG1Z+zPnZcIoF5y4+CZhGqUK94/SFRCVmsts+M5FHGL+Gtrtt0pHiUi
         r41nlMppOxYVBy015elv1v+O7tTGGq8kuQFSfnrQqS68JY+QMq7rG1ZzNny3ozOR9fjZ
         CKZp61jcx/hnZMDZFpyLSy4sUVwZyhs3xLHg+8r29aXF0DFcLG0S7iFqGfxjZ3kAPN+/
         lHmA==
X-Gm-Message-State: APjAAAU0JlpGIBKE3Xl0RrxeBz3VZ71TNnMJQ1M0A10YDVa8If+gZkdn
        ZWlrs7YpJN7zoyL6r5eR0mc5fA==
X-Google-Smtp-Source: APXvYqzBbnkne1ZitLTrx/DsiNtfuCWrKqA9Y1HbrhQ7WPUItFPDcbJKy73l8nvWRH78kyehuExGOQ==
X-Received: by 2002:a17:906:3546:: with SMTP id s6mr3045696eja.192.1551859237479;
        Wed, 06 Mar 2019 00:00:37 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id j54sm254647eda.38.2019.03.06.00.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 00:00:36 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <06448C88-ADF4-41E5-BF5E-BF29C95B60A2@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_41FA0B1C-73A9-4075-9EBA-6BA481DC9784";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 6/8] lightnvm: pblk: Set proper read stutus in bio
Date:   Wed, 6 Mar 2019 09:00:35 +0100
In-Reply-To: <20190305135120.29284-7-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190305135120.29284-1-igor.j.konopko@intel.com>
 <20190305135120.29284-7-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_41FA0B1C-73A9-4075-9EBA-6BA481DC9784
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 5 Mar 2019, at 14.51, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Currently in case of read errors, bi_status is not set properly which
> leads to returning inproper data to higher layer. This patch fix that
> by setting proper status in case of read errors
>=20
> Patch also removes unnecessary warn_once(), which does not make sense
> in that place, since user bio is not used for interation with drive
> and thus bi_status will not be set here.
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-read.c | 11 +++++------
> 1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
> index 1f9b319..6569746 100644
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
> 2.9.5

I still believe that we should work out the error model before.

Let me give an example. In the OCSSD 2.0 spec, we use the NVMe DULBE
bit. If the device does not report read errors, then invalid reads
(let=E2=80=99s pick a read ahead of the WP as an example) will return =
success +
predefined data. In this case, pblk would catch this in the read
integrity checks. Should pblk return an error in this case? I see the
point of catching this at the driver level and passing the error, but
the behavior is inconsistent as the same read issued outside of pblk
will succeed.

When I implemented the read integrity checks I considered to plug it
into the block layer Integrity framework (CONFIG_BLK_DEV_INTEGRITY), but
since we do not follow any PI standard I thought it was difficult to
argue for it. It is maybe time to revisit this approach.

This said, if you want it in to help debugging, I will not oppose to it.
I guess it is the same to fix it one way or the other when we
implement proper error handling.

Javier

--Apple-Mail=_41FA0B1C-73A9-4075-9EBA-6BA481DC9784
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx/fiMACgkQPEYBfS0l
eOC0txAA2IyTKGt4IAiYQVF5pqIyttwnXbv5MwVd9I/7Qn/pvtOLyb7XOMpksAIu
ZSjZOlPpyqbr5wr6fU1kPoFOCB3mvu5xxj81Ksjo4w/lxVxN4RvaVSloOxnLKEkM
Hs7baoeEtsnZ3nvJ5REa0wK3x8hQ0RwHD6uHlH59kl8fEKv9mv1XMrknxsJx3NZW
8Yedd81di8MnLMqfK4mtfLMWDircn1UKYodzkpSMSRkcx+xx88nCqzPQtTsiOt/b
cMhPBXHPVSvAs2ujVJ+Rrsib+RL0ScrvQJU7t+4eXQBrsk2OuuQiqmd5HDyg3hmL
sN+5/DktoBqbMLxQYFIY1qVKQqhNTOpLYOCp+Ue+fdgVKDYyhBF+96F/bCxQgGh2
6lM9pxK+/7dRLSvh8zqVccccgOyCsJFxFWvxiMbyWp1NNQ+VVWXBzNHlCAWQ6odV
8mANcOrdqzDi2L1bJZmVQucsh1XHVL0WuI9UHP65K3g1vhzu61amNy+qUDvqHm0c
Zf1V3n9s6PA8j/Caa7wAN+DDrbTR1Br3x2TbMWRKbXO2qf8sWodVhc8wl/Ngzs/p
ZjGP78CXpmhYDMmNKhE7Mv4zilEuWdPK+dW04lDZtIddzqRkg2wFF3r5nBOJrZRF
MTbN+NRlR2xZHOd02ZDnvf1vwUhCEdjNZqwAO6wKmtwgShybDgU=
=X3TG
-----END PGP SIGNATURE-----

--Apple-Mail=_41FA0B1C-73A9-4075-9EBA-6BA481DC9784--
