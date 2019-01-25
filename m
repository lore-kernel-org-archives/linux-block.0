Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44A7C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 13:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9848C218CD
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 13:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="0UtD5+s2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfAYNdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:33:38 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40272 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfAYNdh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 08:33:37 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so7385409edr.7
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 05:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=vm4dOblR803lam2cOcstVjN9CzpT0/0jTJUEghzvZX8=;
        b=0UtD5+s2555Tn5bJrwywrB+fw6M2ALDD+j3H8OBAOmvLcBCahrDndkKTqBnflXk1mP
         HlIIzpOOuahAuVXXRlwTFcQxxJTadXEgtwzj4dOpRX+QcX0e1iAstSJK/xM3a4zYaK9g
         p6U5XTTY/MqafVSKDe3MDz6omgMc6G/m8/bYvGsJwr3FsUKzGFOAtxoZRl7oY2WTvQc0
         uqAx0O7s6GaJLCCL0M2eN9aEkDqJpJJrFK+/7tO3qpQwjCKziBXc9GTR48a7CZhBeELc
         wQzbvxGVz44GmH2QZw6KNVE0rN0RuDKmAgPnWIKNIpER52qKgcvFvUXRObISMg8NWKqP
         z6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=vm4dOblR803lam2cOcstVjN9CzpT0/0jTJUEghzvZX8=;
        b=Jo4lDtjBEH7IkSX3N9Ag9Nv1aW0J/io4t3rOdQjL6C7RZy+mnKOTpHdWhdUPByouuZ
         ODM16AcybCveuXj68APr24TQ1iBP7b3aZBeFpfQu1mcy3aUJWG7iA5cpdTLjNbSnhZNa
         3qhJDivk5kUw9gp0RcMfYVJEh6DzPVj8GhZ0w9r79DEC5Lh1SPH9anHEM9e5jcnihh/G
         xY4QWW5yRNFdRH9C2MABYRDAzTc2X9btIalF2lObAYwOqpwMb+oFVXVpwKMw2PBIUV/U
         OS6DknKZ3yQ/M0iWxdRXaA5UxqBbXcofMcw10L10hrsbihLkODvBxqr3OeZjBOBrm5sX
         GAXQ==
X-Gm-Message-State: AJcUukdXUZfqfSUdCM0DsZKSwgeGBfCEC/wT/qMzNU0tKMZwmftMtpmK
        H5/BRrp/UhMRStVduPxilaqu7g==
X-Google-Smtp-Source: ALg8bN56ZAgRGmn1De/Uv1vwbe8EbIqPG551VJwow4VFGNgudQQKKpee2mCC3gz6yOpxwW+hbWzrLw==
X-Received: by 2002:a50:93c5:: with SMTP id o63mr10620466eda.20.1548423215835;
        Fri, 25 Jan 2019 05:33:35 -0800 (PST)
Received: from [192.168.1.85] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id y53sm11909257edd.84.2019.01.25.05.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 05:33:35 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <8C200D38-729F-407B-B2F8-48AEA7F0FF08@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_749AD0B9-63BB-4FEC-9FF9-C613C0A4E5F5";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v3] lightnvm: pblk: ignore bad block wp for
 pblk_line_wp_is_unbalanced
Date:   Fri, 25 Jan 2019 14:33:33 +0100
In-Reply-To: <CANr-nt0sA0DH-hjfGKSq+88R7GXypVKmSf+Z+Tgy+duMegVE3Q@mail.gmail.com>
Cc:     Zhoujie Wu <zjwu@marvell.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, hongd@marvell.com
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <1548359553-11356-1-git-send-email-zjwu@marvell.com>
 <CANr-nt3_8YftCP6Oqgnp39YzeF5qpUCBKLPUZ5=TBqP9MFw25g@mail.gmail.com>
 <CDB99159-EAC8-410A-A556-E412DB2829A1@javigon.com>
 <CANr-nt0sA0DH-hjfGKSq+88R7GXypVKmSf+Z+Tgy+duMegVE3Q@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_749AD0B9-63BB-4FEC-9FF9-C613C0A4E5F5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 25 Jan 2019, at 13.59, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> On Fri, Jan 25, 2019 at 10:41 AM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>> On 25 Jan 2019, at 09.47, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>>>=20
>>> On Thu, Jan 24, 2019 at 8:51 PM Zhoujie Wu <zjwu@marvell.com> wrote:
>>>> The write pointer of the bad block could be 0 or undefined, ignore
>>>> the checking of the bad block wp for pblk_line_wp_is_unbalanced to
>>>> avoid fake warning.
>>>=20
>>> fake -> spurious?
>>>=20
>>>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
>>>> ---
>>>> v3: return in case bit >=3D lm->blk_per_line.
>>>> v2: changed according to Javier's comments.
>>>>=20
>>>> drivers/lightnvm/pblk-recovery.c | 12 +++++++++---
>>>> 1 file changed, 9 insertions(+), 3 deletions(-)
>>>>=20
>>>> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
>>>> index 6761d2a..02d466e 100644
>>>> --- a/drivers/lightnvm/pblk-recovery.c
>>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>>> @@ -312,21 +312,27 @@ static int pblk_line_wp_is_unbalanced(struct =
pblk *pblk,
>>>>       struct nvm_chk_meta *chunk;
>>>>       struct ppa_addr ppa;
>>>>       u64 line_wp;
>>>> -       int pos, i;
>>>> +       int pos, i, bit;
>>>=20
>>> We don't need both bit and i, one of them is enough.
>>>=20
>>>> -       rlun =3D &pblk->luns[0];
>>>> +       bit =3D find_first_zero_bit(line->blk_bitmap, =
lm->blk_per_line);
>>>> +       if (bit >=3D lm->blk_per_line)
>>>> +               return 0;
>>>=20
>>> If there is only one non-offline chunk in the line, the wp can't be =
unbalanced,
>>> so it should be safe to return 0 here if bit >=3D lm->blk_per_line - =
1
>>>=20
>>> If you change this please document why using a comment, as it might
>>> not be obvious
>>>=20
>>>> +       rlun =3D &pblk->luns[bit];
>>>>       ppa =3D rlun->bppa;
>>>>       pos =3D pblk_ppa_to_pos(geo, ppa);
>>>>       chunk =3D &line->chks[pos];
>>>=20
>>>>       line_wp =3D chunk->wp;
>>>>=20
>>>> -       for (i =3D 1; i < lm->blk_per_line; i++) {
>>>> +       for (i =3D bit + 1; i < lm->blk_per_line; i++) {
>>>=20
>>>>               rlun =3D &pblk->luns[i];
>>>>               ppa =3D rlun->bppa;
>>>>               pos =3D pblk_ppa_to_pos(geo, ppa);
>>>>               chunk =3D &line->chks[pos];
>>>=20
>>> This code is a copy of the code above, it'd be nice to refactor it
>>> into a helper function or just do the chunk lookups in one place.
>>>=20
>>>> +               if (chunk->state & NVM_CHK_ST_OFFLINE)
>>>> +                       continue;
>>>> +
>>>=20
>>> Since we rely on the block bitmap anyway, we might as well just
>>> iterate over the zeroes in the block bitmap using find_next_zero_bit
>>> instead.
>>> We do this in lots of other places, see: git grep -n
>>> find_next_zero_bit -- drivers/lightnvm
>>=20
>> Hans, I proposed him to use the chunk->state instead. I think it is =
way
>> more robust. We introduced the block bitmap for OCSSD 1.2, because =
there
>> was no state. Now that we have state, it is better to use it instead. =
In
>> fact, we should remove the bock bitmap as we have to check for the =
state
>> either way - note that this aligns also very well with you patches
>> removing the other bitmaps.
>=20
> These are just nitpicks.
>=20
> Relying on two data structures(chunks, block bitmap) to be in sync in
> this function in stead of one does not make it more robust imho.
> Either or (checking chunks or the block bitmap) is fine by me.
> Searching the bitmap is more efficient, so that is what I proposed.

chunk log page is the ground truth, so it is more robust.

Also, pblk has a long way to start seeing bitmap search vs. integer
comparisons in profiling.

>=20
> If we want to remove the block bitmap, we can do that as a separate =
patch(set)
> I do agree, having two copies of the chunk state is something worth
> getting rid of :)
>=20

A good start is not adding code using what we want to remove.

Javier

--Apple-Mail=_749AD0B9-63BB-4FEC-9FF9-C613C0A4E5F5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlxLEC0ACgkQPEYBfS0l
eOC8Ag//UM8kbOg8FIsXiZcGi8zOhJeXLuIKNNvjFrfUgL4wp+cmbVMhQsdZZruP
up1BV2pzJJqIuTVLYklr/SRBAFNrFD65OJgVgvKmlRzkVKoNJQuSvH1DbWR+OOCc
mzhqgNYOgHfVsO+zhXJTpBeL75MiBHhUP3p2he0yhElhThjwUnCs1KU1rAt3Gl6r
GIE4W19HPsqUAmOCn4T0a+3GH16vUtU3estmATpS1N9RfJ48m0l9znYjsiBcspXD
8bTv4UWkCYdf+D4GNpyI9a/u8PvciL6tSppyGZQnr1XINgFRbj2Zz5BKfTE9m1Gz
Phwuacqkg0v69EUXGeq6Q8rEvLcy0nEO7xZwZcvuXzaQLIe3CXEw79Rhbn2rATXL
dGQgsWBOzqtplcfU7ljqm1EYhTqlYez8G2Gd58tUkm42i+RHDE1mP0Mhrzjdzy6n
NnjgWgf0wI0dzVIPmmq4VCD239az++2ejtFcNPMiex/npavLgZ6C+i56qvnQRPb8
uZxNBj4lbCZBbsuia3zv3St1txn/UsHhlHxKAy560AqeUIP3y0VqkI9q298JDFyb
rwmLjBRGFLY5uvBA7kcLFpp1piIdMLANxFKkKy7x/aU436JiGKdFbAtinJV+aLoo
5cV82GBCZL79wzxMQ09E8qsIZ3FU/rN8+yjxr1ZIy4U06s3GU50=
=sjJj
-----END PGP SIGNATURE-----

--Apple-Mail=_749AD0B9-63BB-4FEC-9FF9-C613C0A4E5F5--
