Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1DBC282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFB3218B0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Bg9rlfei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfAYJl2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:41:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42534 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfAYJl2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 04:41:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id y20so6857272edw.9
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 01:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=UCT+jEdOTIs5VInzxkIi1lAixTxWC5dNmgiuWHtGqHE=;
        b=Bg9rlfeitvvLlBxunw36tao6AHH1WVUzlhupJh4Q60ocsT7qToP0BDHZcolaXjqNOr
         tvUjIKWKPP1c/tKkDZOJ0dtkxmDAmW1hMVWTMOf8tp8cmQ13VZ81TpL2h9sMChO3S1g6
         6tQU2j6o7n6TCIO7G/phxt33pLCZHNpuAHU6y7LvryOfvE0eW4E5PCdbrkDw3V54ANRk
         Eg6yR3z/N2BRAnnqPOtkrlzSA3TKKBUsYV139ft63F5BxgYrxcaDYhjxX6zgXu2AEQg5
         vPI7ZjbI428dPFA8wUrjJOZye82SAu2o206V3oeAU79GNO/iIG3wZpN0OIcUyRWIY23l
         yS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=UCT+jEdOTIs5VInzxkIi1lAixTxWC5dNmgiuWHtGqHE=;
        b=btLQoh3PDSQ1vxEAuFGRC7s5D7FKKvNmpeoPi1PBDvCXZ1kebB+UTNrPqg7YkbS8/g
         +dsQs3wnaMgABy3aO3gJM0Eln4lBuXdJGfBM+9FYti3BLy5ZNVhIp5dUE4jJmeAqNxsV
         09cKA8v1hnYljo+zvY1USAEI5nfvVr0lgDH8UGTFj/m9JbPZ+MFYFt4Hg2g9giCheaQj
         hNgxvkjUOUqkse6af8d5f0knPSz6s9NR4kh7HbmW9Ptdd/qM9CpaDBkOOlL4xebuIy1f
         xlIpCOV/HqY+0vwufGeJilvhODpIOeWl0775rvchLcqDoYVgqxlH3UCdjGwRBg/yXSu5
         Du/w==
X-Gm-Message-State: AJcUukeA9RNTuxRYy7r70JCubreoy77faDoBxOAxgtTvHv9Vh8yQbUd/
        fACLXJiEWql9z9yBRyJxsa/G7Q==
X-Google-Smtp-Source: ALg8bN7ezUpf4JsXAbmb+OfFSUCeuAMwgE0wHOz5Bqel9TBy1fpfP1XlX+VGDBcBBObs7HTOuUyxCw==
X-Received: by 2002:a17:906:4d1a:: with SMTP id r26mr9110689eju.32.1548409286360;
        Fri, 25 Jan 2019 01:41:26 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id g37sm12054201edb.85.2019.01.25.01.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 01:41:25 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <CDB99159-EAC8-410A-A556-E412DB2829A1@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_21B4590E-DCDA-4CA9-A4F9-5FBF5DCE758E";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3] lightnvm: pblk: ignore bad block wp for
 pblk_line_wp_is_unbalanced
Date:   Fri, 25 Jan 2019 10:41:24 +0100
In-Reply-To: <CANr-nt3_8YftCP6Oqgnp39YzeF5qpUCBKLPUZ5=TBqP9MFw25g@mail.gmail.com>
Cc:     Zhoujie Wu <zjwu@marvell.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, hongd@marvell.com
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <1548359553-11356-1-git-send-email-zjwu@marvell.com>
 <CANr-nt3_8YftCP6Oqgnp39YzeF5qpUCBKLPUZ5=TBqP9MFw25g@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_21B4590E-DCDA-4CA9-A4F9-5FBF5DCE758E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On 25 Jan 2019, at 09.47, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> On Thu, Jan 24, 2019 at 8:51 PM Zhoujie Wu <zjwu@marvell.com> wrote:
>> The write pointer of the bad block could be 0 or undefined, ignore
>> the checking of the bad block wp for pblk_line_wp_is_unbalanced to
>> avoid fake warning.
>=20
> fake -> spurious?
>=20
>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
>> ---
>> v3: return in case bit >=3D lm->blk_per_line.
>> v2: changed according to Javier's comments.
>>=20
>> drivers/lightnvm/pblk-recovery.c | 12 +++++++++---
>> 1 file changed, 9 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
>> index 6761d2a..02d466e 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -312,21 +312,27 @@ static int pblk_line_wp_is_unbalanced(struct =
pblk *pblk,
>>        struct nvm_chk_meta *chunk;
>>        struct ppa_addr ppa;
>>        u64 line_wp;
>> -       int pos, i;
>> +       int pos, i, bit;
>=20
> We don't need both bit and i, one of them is enough.
>=20
>> -       rlun =3D &pblk->luns[0];
>> +       bit =3D find_first_zero_bit(line->blk_bitmap, =
lm->blk_per_line);
>> +       if (bit >=3D lm->blk_per_line)
>> +               return 0;
>=20
> If there is only one non-offline chunk in the line, the wp can't be =
unbalanced,
> so it should be safe to return 0 here if bit >=3D lm->blk_per_line - 1
>=20
> If you change this please document why using a comment, as it might
> not be obvious
>=20
>> +       rlun =3D &pblk->luns[bit];
>>        ppa =3D rlun->bppa;
>>        pos =3D pblk_ppa_to_pos(geo, ppa);
>>        chunk =3D &line->chks[pos];
>=20
>>        line_wp =3D chunk->wp;
>>=20
>> -       for (i =3D 1; i < lm->blk_per_line; i++) {
>> +       for (i =3D bit + 1; i < lm->blk_per_line; i++) {
>=20
>>                rlun =3D &pblk->luns[i];
>>                ppa =3D rlun->bppa;
>>                pos =3D pblk_ppa_to_pos(geo, ppa);
>>                chunk =3D &line->chks[pos];
>=20
> This code is a copy of the code above, it'd be nice to refactor it
> into a helper function or just do the chunk lookups in one place.
>=20
>> +               if (chunk->state & NVM_CHK_ST_OFFLINE)
>> +                       continue;
>> +
>=20
> Since we rely on the block bitmap anyway, we might as well just
> iterate over the zeroes in the block bitmap using find_next_zero_bit
> instead.
> We do this in lots of other places, see: git grep -n
> find_next_zero_bit -- drivers/lightnvm
>=20

Hans, I proposed him to use the chunk->state instead. I think it is way
more robust. We introduced the block bitmap for OCSSD 1.2, because there
was no state. Now that we have state, it is better to use it instead. In
fact, we should remove the bock bitmap as we have to check for the state
either way - note that this aligns also very well with you patches
removing the other bitmaps.

Javier

--Apple-Mail=_21B4590E-DCDA-4CA9-A4F9-5FBF5DCE758E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxK2cQACgkQPEYBfS0l
eOBjrBAAxC6UmlQG6a60ji1jQ6k3zbbdbD+DfQsKGIH/d4sWw5n0/WZwgvLeohYW
3+XX4jMtgid07Lr5fx2Mjr3gnor9DjanyHI6P57ltIwDtAn0e0qHISK5kHtHE04w
hxwLkt5KlvD2oU1AuYImpdx4FlnUw0hAAtmd4Flysq6GE1ZvXorFPArr2HWL0vnj
8bRzx9dD0S6zjnUPfcFM0yR5MwpoNGWZg/fpWP1OegmoHbtfgz6dFaXyQdcbao2h
rqTzWEKGD+CxxwndMPeRUy9LRnwDpk0eZNSj0aszouJo78L0oAZoXi0Ef2zu81VU
/4TX15+zeuIicEbZrJC1UMXlNq2yPNG513VyOKyvqWKrqnb3lgx2bYndat48dDBw
XY45/HbBC/e2V28oNSJ7uMf1KRh2iH6XeaAKyZb2A/dTunmK/rOjRpcWiV1dfg+Y
0BQSO7GbGqK/70EkxIcqeFybfENNVDljOM3h+gzxWn5IskxAw5oQi6szGZfO09yY
3fPHH/wJIm9jGnodnfhKp2ZDM/31i8t8tXK/HCdSamGLKctGnY+JJkxiL6axW7Dv
jJ0bizKusj//zhbxn6gmRCqd+NcMmCIOmFiFEgpUxGbJpdbFPsc3UjMdVympwGme
SzzaqWDu/nP1CRRue0bGgQxdLJVyZ3m5fJirXI4AYOp0X6vCNbs=
=Kezw
-----END PGP SIGNATURE-----

--Apple-Mail=_21B4590E-DCDA-4CA9-A4F9-5FBF5DCE758E--
