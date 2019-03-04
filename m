Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05562C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 08:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F5F20823
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 08:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="jNeF5GKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfCDIVF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:21:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36372 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDIVF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 03:21:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id g9so3485892eds.3
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 00:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=dl2lrVSR941IjsEPFuD8y4eiX0rkgjR4mRDxpo748A4=;
        b=jNeF5GKdXZXnvJMkG5a1FqRJKWU65M1in4eRgXbYoBC2b5lBGSxO2foKdTUTOtrUru
         dU/kRnrBLWsZ015Xkub1CX75V93eqI4uuYakQzAd0rUJy6ZlfTBvGiy+WW9R2oV5JilF
         vYXuEUdZpjPiXX73Vchj1F+rsOFQs+NZ8Mp6MrNZjQD1MpK87mjTOaDOFeyqddWYUIAS
         dVggHKRe2CdaquOAnCCtwxj49UjhpJ4OvldK4FJtrTLO3Nvs47skEsnbo2t95Do1kJVN
         SUKy1BQSlX8vLFWGVHAuJSBXP9pp9yG8Z0IQ13I0ENtanKQFCxBoxW1g6SYUae/7xFkM
         S0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=dl2lrVSR941IjsEPFuD8y4eiX0rkgjR4mRDxpo748A4=;
        b=XqMzz5D/We3ACmoHrpSnGzfRWMdL5iXAeocOnvPRz6ooxVJTu9bnb5l73FHpw+aFw2
         Xo/g1fKJelXTW49+e2T5TijertZHTNiTw7OdRpAwFqYewe1oDQjWljflA5nA9ThzqNFM
         oJz42+4y+bC27hB8Uvtyy9nSezzlHxaxq2cDyZxUvFzUpXeCJ9bUMpp0O3XoWVE2HkF+
         CcICfYXfJFWBbNSOwsUtQeMy2p1GEUt1lVllMkPwfDJZ1124qrOpAIN2DiokO7XmOoYA
         AFPOvoX9VE0JtsAgzyJxTOBmgU4IHVP8n0z4XIWMuTCctaqVvjVtuhADxmvDjjeoeZJB
         Skhg==
X-Gm-Message-State: APjAAAVDIRUXPcwuaZCKBtBzEBq3RclTuCboU6pF78OtMGkwTecD7p+o
        sp6FIhSvBnZ4BtOkAM9OAKxzxZ/Ljpo=
X-Google-Smtp-Source: APXvYqzY+TsCzcQSWbiMQlkjg5ZOXwAuvCcldz+/vXBDJnotLo2ZFVTbWA+/knOLo+ChtRecPRFx2Q==
X-Received: by 2002:a50:a5f6:: with SMTP id b51mr14643720edc.9.1551687663730;
        Mon, 04 Mar 2019 00:21:03 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id x16sm1874023edx.89.2019.03.04.00.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 00:21:03 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <598BE9AB-6D64-43A4-A4BA-4B74EA8C4EEB@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_9B4BCB9F-E8D7-4DCE-B7F8-96B1C01DF2F0";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 11/13] lightnvm: pblk: Remove unused smeta_ssec field
Date:   Mon, 4 Mar 2019 09:21:02 +0100
In-Reply-To: <20190227171442.11853-12-igor.j.konopko@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-12-igor.j.konopko@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_9B4BCB9F-E8D7-4DCE-B7F8-96B1C01DF2F0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
> Smeta_ssec field in pblk_line is set once and
> never used, since it was replaced by function
> pblk_line_smeta_start(). This patch removes
> this no longer needed field
>=20
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
> drivers/lightnvm/pblk-core.c | 1 -
> drivers/lightnvm/pblk.h      | 1 -
> 2 files changed, 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 2e424c0275c1..fa4dc05608ff 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1165,7 +1165,6 @@ static int pblk_line_init_bb(struct pblk *pblk, =
struct pblk_line *line,
> 	off =3D bit * geo->ws_opt;
> 	bitmap_set(line->map_bitmap, off, lm->smeta_sec);
> 	line->sec_in_line -=3D lm->smeta_sec;
> -	line->smeta_ssec =3D off;
> 	line->cur_sec =3D off + lm->smeta_sec;
>=20
> 	if (init && pblk_line_smeta_write(pblk, line, off)) {
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index a92377530930..b266563508e6 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -464,7 +464,6 @@ struct pblk_line {
> 	int meta_line;			/* Metadata line id */
> 	int meta_distance;		/* Distance between data and =
metadata */
>=20
> -	u64 smeta_ssec;			/* Sector where smeta starts */
> 	u64 emeta_ssec;			/* Sector where emeta starts */
>=20
> 	unsigned int sec_in_line;	/* Number of usable secs in line =
*/
> --
> 2.17.1

Looks good to me.

Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

--Apple-Mail=_9B4BCB9F-E8D7-4DCE-B7F8-96B1C01DF2F0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx83+4ACgkQPEYBfS0l
eOAZNQ//abplOhmP0ItosR9UjlTE02iiJjSSUDvBZA7mwnZGKVvPnqGiuYdQemDR
w7aF+H50nOgyX5YiTlWdBwPI9d6v9cBjo1lcT2H18V4YxTFpeDEYaBltTIjOR+ka
CLBT8pPkXnfB0uYI/oL+NSEQICao1sHt+sNJcWe/6xRmxEIAnCH/edpWo0Pzygq2
vhpoAgeunuA3ZUogb6O7gVKvxSKANcJxRyK/cap52HRkIVZXa6rOCAw9Jsajn/sr
wMTsSaU899TfU4bo39fpNozlecWsjjh5B51OQbO36K287fag/1ipooUcUNnJqTL0
EzYPrasHaFTV+kGecbXvG1AplnjcX20lU/yfdu0uiSL7Tbv0UicHNlOCMMDBHQu4
CnxUJt8wDkMBKObAB0UAXDuFDsUZiKYmXeVPXXQjZFIy9Lfg4ppa/J7sufK0Seg3
iPlLPzqUzLVhKoXwkm795RG6c5buj4wyEpG1K/C3hIalAC/Q0Tcp8WyFAz4pSx1+
hvrTuU/hvHTV9kGvu1iAGiBuCUe1vr0q/NqsatQa3KROYk1tg2CI+iBK6fKN7Fbu
nSoGGXYB3QxhBEJSo3h0b0xWsyJVOzOx3kG4RZrbdKeSHNj6pvpng4fGaABx1s3Y
dbwDLFctc0Ox3LsmSyFluYxPsE71nMiecMWDK0aE/xc+V+dRJ0I=
=njm6
-----END PGP SIGNATURE-----

--Apple-Mail=_9B4BCB9F-E8D7-4DCE-B7F8-96B1C01DF2F0--
