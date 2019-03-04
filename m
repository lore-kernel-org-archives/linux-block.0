Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91775C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D4F20835
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Y498nBC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfCDNVP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:21:15 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36034 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfCDNVP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 08:21:15 -0500
Received: by mail-ed1-f67.google.com with SMTP id g9so4220217eds.3
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 05:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=pOYOZbCe9R4x7RBrkZuj7+v5rrBFw3OLNiuU8ihX5X8=;
        b=Y498nBC0i7HuhV2iNE2yI3WWEYTP0Z64RCf+ZBQ1prnGQElOuLHX370C+s5zbA1jlk
         31F/c1I6yfKruFgUgyRxvhe5BV0O6cIqmFlONlhPuQVCHkhohscSUFVJdgjX1fxGJ80W
         G2OCxAo4ec8/x5DP6ncKOdlN+HkjQrGyvtgQ67qgeksEFNIlwSMLJsflA6FHXA7RDdLi
         WdK5YO7nwl7Et6wzJoR5NZEYYqOZXyVktwWtGRtyQksXZfiRdbEFlmwoKmbyr3BNspS0
         VVWEDLT1+waFapf/m0mYDnf+A0eOfFvj5qU+4/96d22X/bW2DzJETwSJXmyH/2I96uA1
         nGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=pOYOZbCe9R4x7RBrkZuj7+v5rrBFw3OLNiuU8ihX5X8=;
        b=YAMs6q3zE6Nx/V0266ASCEj6dHKKmF6553lBULtiXVUdkD9fE+JD5dl+a7QPAKYVVx
         BtRfm5T7ui+hmSctZKuDBwlHGjpmbe3+x/oHr3C6QwP7QfmwGILj3aFLhJOYdSUhaZmp
         288d2DNgJOBhdf++ghkje5G0eF4ZrFEnUnJyda7ShOWTBEv1JZtEN/aSCsdTREF+dm1F
         lABWP5c0Hm6o0IL060qmXtix483NfrmL/dSgFTmR0zpXlZ8u8Y/L3Ih1Vrb21bkzpC2v
         e+U4MuCZ8oTenUOXXQOh+d2DYzaWwtg5HO3PU4GDCCCJD2G35r5UykpsjWnr1Vni1+3B
         BRnw==
X-Gm-Message-State: APjAAAXqa6tfOkr7iB7LxrtgdgJWJbnIF669plAvaGsA9/1Z4BXcPAWn
        HpMbRjPMVhim0H2NpY+bFdiCoA==
X-Google-Smtp-Source: APXvYqxqWI9+R8Ueos5uDOWnGca0rJrOJHpKbKI8EAnOK4NLH5OKsCuv0hxHY/8f0iW345nQHsSbUA==
X-Received: by 2002:a50:95ee:: with SMTP id x43mr15456898eda.288.1551705672845;
        Mon, 04 Mar 2019 05:21:12 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id e14sm2130578edd.9.2019.03.04.05.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:21:12 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <9F6289B5-B5D2-4F4D-81B1-2ADAD22CDC85@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_444DDC0F-2631-44D3-98D7-E4AB21FF4931";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 08/13] lightnvm: pblk: Set proper read stutus in bio
Date:   Mon, 4 Mar 2019 14:21:11 +0100
In-Reply-To: <c261bdbf-cac3-faa0-34a6-e51981f4698d@lightnvm.io>
Cc:     Hans Holmberg <hans.ml.holmberg@owltronix.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-9-igor.j.konopko@intel.com>
 <007EC669-9C50-4B29-9522-CE73CD3CE47F@javigon.com>
 <CANr-nt1o4ZyRW-MwwXHQ7aXTmOr8PsqRzhR3643iddh9H2kjjg@mail.gmail.com>
 <9076DF06-7B01-44DA-BA5F-9C784D56134E@javigon.com>
 <c261bdbf-cac3-faa0-34a6-e51981f4698d@lightnvm.io>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_444DDC0F-2631-44D3-98D7-E4AB21FF4931
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 4 Mar 2019, at 14.04, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 3/4/19 10:48 AM, Javier Gonz=C3=A1lez wrote:
>>> On 4 Mar 2019, at 10.35, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>>>=20
>>> On Mon, Mar 4, 2019 at 9:03 AM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>>>>>=20
>>>>> Currently in case of read errors, bi_status is not
>>>>> set properly which leads to returning inproper data
>>>>> to higher layer. This patch fix that by setting proper
>>>>> status in case of read errors
>>>>>=20
>>>>> Patch also removes unnecessary warn_once(), which does
>>>>> not make sense in that place, since user bio is not used
>>>>> for interation with drive and thus bi_status will not be
>>>>> set here.
>>>>>=20
>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>> ---
>>>>> drivers/lightnvm/pblk-read.c | 11 +++++------
>>>>> 1 file changed, 5 insertions(+), 6 deletions(-)
>>>>>=20
>>>>> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
>>>>> index 3789185144da..39c1d6ccaedb 100644
>>>>> --- a/drivers/lightnvm/pblk-read.c
>>>>> +++ b/drivers/lightnvm/pblk-read.c
>>>>> @@ -175,11 +175,10 @@ static void pblk_read_check_rand(struct pblk =
*pblk, struct nvm_rq *rqd,
>>>>>      WARN_ONCE(j !=3D rqd->nr_ppas, "pblk: corrupted random =
request\n");
>>>>> }
>>>>>=20
>>>>> -static void pblk_end_user_read(struct bio *bio)
>>>>> +static void pblk_end_user_read(struct bio *bio, int error)
>>>>> {
>>>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>>>> -     WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
>>>>> -#endif
>>>>> +     if (error && error !=3D NVM_RSP_WARN_HIGHECC)
>>>>> +             bio_io_error(bio);
>>>>>      bio_endio(bio);
>>>>> }
>>>>>=20
>>>>> @@ -219,7 +218,7 @@ static void pblk_end_io_read(struct nvm_rq =
*rqd)
>>>>>      struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
>>>>>      struct bio *bio =3D (struct bio *)r_ctx->private;
>>>>>=20
>>>>> -     pblk_end_user_read(bio);
>>>>> +     pblk_end_user_read(bio, rqd->error);
>>>>>      __pblk_end_io_read(pblk, rqd, true);
>>>>> }
>>>>>=20
>>>>> @@ -292,7 +291,7 @@ static void pblk_end_partial_read(struct =
nvm_rq *rqd)
>>>>>      rqd->bio =3D NULL;
>>>>>      rqd->nr_ppas =3D nr_secs;
>>>>>=20
>>>>> -     bio_endio(bio);
>>>>> +     pblk_end_user_read(bio, rqd->error);
>>>>>      __pblk_end_io_read(pblk, rqd, false);
>>>>> }
>>>>>=20
>>>>> --
>>>>> 2.17.1
>>>>=20
>>>> This is by design. We do not report the read errors as in any other
>>>> block device - this is why we clone the read bio.
>>>=20
>>> Could you elaborate on why not reporting read errors is a good thing =
in pblk?
>> Normal block devices do not report read errors on the completion path
>> unless it is a fatal error. This is actually not well understood by =
the
>> upper layers, which tend to assume that the device is completely =
broken.
>> This is a challenge for OCSSD / Denali / Zone devices as there are =
cases
>> where reads can fail. Unfortunately at this point, we need to mask =
these
>> errors and deal with them in the different layers.
>=20
> Please don't include zone devices in that list. ZAC/ZBC are
> well-behaved, and an error is a real error.

They have worked around this for years. AFAIK the read path still
returns predefined data, not an error. So, as I see it is the same

Javier


--Apple-Mail=_444DDC0F-2631-44D3-98D7-E4AB21FF4931
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx9JkcACgkQPEYBfS0l
eOCxihAAzmROrMq+oEt1VMX5HibX4U2RNdzM/9kwjcVQsIoJDSqa3/bEoO1NuXhU
KP9MraSRTcsoDatyP4/rcNuoeLr7ovq3LRRz+Y/zC8qrTlm1VpYhgi7UMwuYTBG3
i1vYB31HtNzlbFssSZ58eCMnRIS6MVKOlCbFFXAJFITbClx81kugYprgWiEoawUy
N4Male9R9EbjBoU51Z5zSqO/cwinet4xgGF3jTbL48adrVwpOZOOZW1JqVj3Tw0E
bhbD99ZFvqwWHq/VU6BulVFVFRJ9hX89qJXjlBrcaVRwHomlyInZTgg0AvXseIxN
0qDzMThdW61Ig6TawxlMDOwripkj7osYky3ZQnGvAQpvTmMp8co9UjA819Swx66C
477mLBYVPTk2XpeLOAd93kmk9UBhiABQHBkACJNp5SxanFgLcyl1K6eOgVUqMkAT
fuTvy853eWJe21EwXyjZ1NywDglhHahFzFkKfMQUqQpX5f9zeShVQWNMcaXLGG/l
Efh8iiMGs+0wsKx3cnqvQYsOHPeAXy54nGCy3gNn2W002o6af5tm4IDpsybGopz8
KTejSDpbDPGI94v0sb6h5Az/1W9HybMtVr11c4jOhYdMf6MA84o/kB2nvr6vuKfV
pCgnnBdV7uOuMhLL5pa7z8BCBZ3838F+sHE7Hy6ZKlJUXRKyGv8=
=8A73
-----END PGP SIGNATURE-----

--Apple-Mail=_444DDC0F-2631-44D3-98D7-E4AB21FF4931--
