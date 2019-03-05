Return-Path: <SRS0=rLai=RI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C793C43381
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 06:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE482075B
	for <linux-block@archiver.kernel.org>; Tue,  5 Mar 2019 06:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Lhh07LtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbfCEGoA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Mar 2019 01:44:00 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39447 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfCEGn7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Mar 2019 01:43:59 -0500
Received: by mail-ed1-f67.google.com with SMTP id p27so6260077edc.6
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 22:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=roJJTBCftbU9Pa237a3D19BPlCJuE2AG6Pk3HAl2AWE=;
        b=Lhh07LtDznqnSdkJhO/AQj22J27AFNor0mkAWr9ut/L3v1pCDpis//V4pMAAuznqKI
         Ui7CVZd6eVdWp6C0kl5RFMua2VbS1+6PQTJszVPhatMrcUag3YO+i510KL4P2yWEXA0q
         5i6VG7EP+V9yDZ9ErsXKYuGKQwStg0Vi7l+C8HftbWb0MzoANuJWdv4+wvDWxKyetU9V
         eSLZsxvo510uYoHB7etSXx0VXuxQcjSlqXEZLwj5r1ARzN/3lccaB3WZb93215eJaiab
         yVqNMJYfoqFfA14NW0yqZ9tW1b94q2dti32crWBzmVhfSWhldWk2Xa7rd+dbn8O2INLV
         Ah7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=roJJTBCftbU9Pa237a3D19BPlCJuE2AG6Pk3HAl2AWE=;
        b=H+K73gDAj7e5d8AOUSMmKsU5aab+FFM2uAr8qOOhEhHjLcDn5WshX0FjlHgxtObsrG
         wStqn08SyKnfDdUqmebE8v4w7fmJzMfdPhDc5KEHAQtrbHA18xGmACKG/j8NYn0jIl4P
         8xWejRJ8yJHrCAgUxoC3JTRoNLOH6iH0+sbAyYvSYC59rT8Zork3gayQ9ph6/trw1DGk
         bcO1ujWF5jcGM0ktW6EXQNLM7J0uJp9LO6PpdpWZ7t2wiF1NHaVYi+7Ujd2Q0n8SMpjx
         koUZ+29Y5kDCp2AgNXlj7QT6doGiZXvyY6rihyWvM+18muWSJXvcSMd+faFFu5zSKrs1
         wdSg==
X-Gm-Message-State: APjAAAUBBIbxg6enuOYLJ48u++Y/O/DgogyP/POXnO84WtNAeHlNDyxE
        1yjGNOTqLGW7HeQM97lWcZtyyd2ar2o=
X-Google-Smtp-Source: APXvYqwMhl6hPqq7PFpq9uVuOt/meeIFVpyApYYsRvlnbj3TWC0eTGBPRJQvPczKScn3fGCzBj1kew==
X-Received: by 2002:a50:82c7:: with SMTP id 65mr18491125edg.7.1551768236751;
        Mon, 04 Mar 2019 22:43:56 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id z42sm2784824edd.29.2019.03.04.22.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 22:43:56 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <908ED41A-B313-4F61-985D-69A2B630FC85@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_58F91552-EBFA-48D8-961F-48B6469FDF76";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 08/13] lightnvm: pblk: Set proper read stutus in bio
Date:   Tue, 5 Mar 2019 07:43:55 +0100
In-Reply-To: <afb2814c-dbda-1c4f-b30c-d7bda9c7bb29@lightnvm.io>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Hans Holmberg <hans@owltronix.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-9-igor.j.konopko@intel.com>
 <007EC669-9C50-4B29-9522-CE73CD3CE47F@javigon.com>
 <CANr-nt1o4ZyRW-MwwXHQ7aXTmOr8PsqRzhR3643iddh9H2kjjg@mail.gmail.com>
 <9076DF06-7B01-44DA-BA5F-9C784D56134E@javigon.com>
 <CANr-nt0HeMvSgBOdbSaL+6tadEn9_K6LThaHfGpib+4vc6xthg@mail.gmail.com>
 <9c5a361b-d7f2-08be-7b3d-6eae68594e1d@intel.com>
 <4b92af86-c5ba-aa09-f39e-86975fd35460@lightnvm.io>
 <8A1CEAAD-601B-4AC8-81DC-C7A5CB24001D@javigon.com>
 <afb2814c-dbda-1c4f-b30c-d7bda9c7bb29@lightnvm.io>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_58F91552-EBFA-48D8-961F-48B6469FDF76
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 4 Mar 2019, at 16.12, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 3/4/19 2:45 PM, Javier Gonz=C3=A1lez wrote:
>>> On 4 Mar 2019, at 14.08, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 3/4/19 1:51 PM, Igor Konopko wrote:
>>>> On 04.03.2019 13:14, Hans Holmberg wrote:
>>>>> On Mon, Mar 4, 2019 at 10:48 AM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>>>>>> On 4 Mar 2019, at 10.35, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>>>>>>>=20
>>>>>>> On Mon, Mar 4, 2019 at 9:03 AM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>>>>>>>> On 27 Feb 2019, at 18.14, Igor Konopko =
<igor.j.konopko@intel.com> wrote:
>>>>>>>>>=20
>>>>>>>>> Currently in case of read errors, bi_status is not
>>>>>>>>> set properly which leads to returning inproper data
>>>>>>>>> to higher layer. This patch fix that by setting proper
>>>>>>>>> status in case of read errors
>>>>>>>>>=20
>>>>>>>>> Patch also removes unnecessary warn_once(), which does
>>>>>>>>> not make sense in that place, since user bio is not used
>>>>>>>>> for interation with drive and thus bi_status will not be
>>>>>>>>> set here.
>>>>>>>>>=20
>>>>>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>>>>>> ---
>>>>>>>>> drivers/lightnvm/pblk-read.c | 11 +++++------
>>>>>>>>> 1 file changed, 5 insertions(+), 6 deletions(-)
>>>>>>>>>=20
>>>>>>>>> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
>>>>>>>>> index 3789185144da..39c1d6ccaedb 100644
>>>>>>>>> --- a/drivers/lightnvm/pblk-read.c
>>>>>>>>> +++ b/drivers/lightnvm/pblk-read.c
>>>>>>>>> @@ -175,11 +175,10 @@ static void pblk_read_check_rand(struct =
pblk *pblk, struct nvm_rq *rqd,
>>>>>>>>>       WARN_ONCE(j !=3D rqd->nr_ppas, "pblk: corrupted random =
request\n");
>>>>>>>>> }
>>>>>>>>>=20
>>>>>>>>> -static void pblk_end_user_read(struct bio *bio)
>>>>>>>>> +static void pblk_end_user_read(struct bio *bio, int error)
>>>>>>>>> {
>>>>>>>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>>>>>>>> -     WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
>>>>>>>>> -#endif
>>>>>>>>> +     if (error && error !=3D NVM_RSP_WARN_HIGHECC)
>>>>>>>>> +             bio_io_error(bio);
>>>>>>>>>       bio_endio(bio);
>>>>>>>>> }
>>>>>>>>>=20
>>>>>>>>> @@ -219,7 +218,7 @@ static void pblk_end_io_read(struct nvm_rq =
*rqd)
>>>>>>>>>       struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
>>>>>>>>>       struct bio *bio =3D (struct bio *)r_ctx->private;
>>>>>>>>>=20
>>>>>>>>> -     pblk_end_user_read(bio);
>>>>>>>>> +     pblk_end_user_read(bio, rqd->error);
>>>>>>>>>       __pblk_end_io_read(pblk, rqd, true);
>>>>>>>>> }
>>>>>>>>>=20
>>>>>>>>> @@ -292,7 +291,7 @@ static void pblk_end_partial_read(struct =
nvm_rq *rqd)
>>>>>>>>>       rqd->bio =3D NULL;
>>>>>>>>>       rqd->nr_ppas =3D nr_secs;
>>>>>>>>>=20
>>>>>>>>> -     bio_endio(bio);
>>>>>>>>> +     pblk_end_user_read(bio, rqd->error);
>>>>>>>>>       __pblk_end_io_read(pblk, rqd, false);
>>>>>>>>> }
>>>>>>>>>=20
>>>>>>>>> --
>>>>>>>>> 2.17.1
>>>>>>>>=20
>>>>>>>> This is by design. We do not report the read errors as in any =
other
>>>>>>>> block device - this is why we clone the read bio.
>>>>>>>=20
>>>>>>> Could you elaborate on why not reporting read errors is a good =
thing in pblk?
>>>>>>=20
>>>>>> Normal block devices do not report read errors on the completion =
path
>>>>>> unless it is a fatal error. This is actually not well understood =
by the
>>>>>> upper layers, which tend to assume that the device is completely =
broken.
>>>>>=20
>>>>> So returning bogus data without even a warning is a preferred
>>>>> solution? You want to force "the upper layers" to do checksumming?
>>>>>=20
>>>>> It's fine to mask out NVM_RSP_WARN_HIGHECC, since that is just a
>>>>> warning that OCSSD 2.0 adds. The data should still be good.
>>>>> All other errors (see 4.6.1.2.1 in the NVMe 1.3 spec), indicates =
that
>>>>> the command did not complete (As far as I can tell)
>>>> My approach was exactly like that. In all cases other than =
WARN_HIGHECC we don't have a valid data. Without setting a =
bio_io_error() we are creating the impression for other layers, that we =
read the data correctly, what is not a case then.
>>>> I'm also seeing that this patch is not the only user of =
bio_io_error() API, also other drivers such as md uses is commonly.
>>>=20
>>> Yes agree. This is an actual error in pblk that lets it return bogus =
data.
>> I am not against returning an error, I am just saying that this is =
not
>> normal behavior on the read path.
>> The problem is that the upper layers might interpret that the device =
is
>> broken completely, which is not true for a spa failing. Think for
>> example of a host reading under mw_cunits - in reality this is not =
even
>> a device problem but a host bug that might result in a fatal error.
>=20
> Agree, and the host should manage it. The drive shall return a fatal =
error when it is asked to return invalid data. E.g., mw_cunits.
>=20
>> Matias: I am surprised to see you answer this way - when I tried to
>> define a sane read error path with meaningful errors starting in the
>> spec and all the way up the stack you were the first one to argue for
>> reads to always succeed no matter what. In fact, using ZBC/ZAC as an
>> example...
>=20
> What I objected against was having error messages for each type of
> error that could happen. Instead of a single or few error types (that
> triggers the same set of recovery procedure at the host-side).

Ok. So just to agree on a good way to move forward: do you think it is a
good idea for the LightNVM subsystem to propagate errors for the read
path moving forward? This would include reading ahead the write pointer,
which _does not_ report errors in ZAC/ZBC either. Here, note that
currently in pblk, we do not prevent a read to go to the device in any
case, and it is the device=E2=80=99s responsibility to return an error. =
However,
since OCSSD 2.0 does not define a rich error model many errors are
masked under generic buckets.

If so, we need to define which errors are propagated and which are not.
Can you share some insights, using OCSSD 2.0 as a base?

Javier

--Apple-Mail=_58F91552-EBFA-48D8-961F-48B6469FDF76
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx+GqsACgkQPEYBfS0l
eOAWjhAAu3BkA7Z0xGttLrplJ+j/bKTOYWd4QYsH0ahbV/8T9AL4qppDIOesWz8W
3OVqET/arlNPubSUl+zVlsZxuSCmAp4rxXrSZnjus2CTdbjXtO2h/C21CTzp7J3M
Ownk8L7djCzvv3i9A8qxprB+1jKa4VH1qR2vPpJ5NF3FdaCk99VOmTnUDT+0ugzK
TwDwUwFDckkOXVi/k+e1n0xMZ0F2xVyvwm+rehFISsEReVCvxSYTVd8FJVZnzscW
+LAV2i8nSXUhJ7nuUfMdNjwwPUN3XygRbIGlnEfPIreYG4y6uVk15c9vB4sd6h2J
AKUcFoNGO10dkoRIxDyOnIE1HOfaCDSYRz5puHfNChvhfLloFLGMtvr/XH8HaAgi
8FzMZV3KmVtKujiYBkY10XeK0St83oaUAl3iCFkb1FN/8kmqfkng0gOitnCMLF38
Q4kQD2pRem3MeI7mXQg1Gly+gVGnilZITpnFywM6ZBMI9N+jnIJS2n5h6FoEF9cj
8m7haLQXf9G4Xe9CDeNldI4gPPi2Urwh7Zflee0Byn1/bGhA5Z2u18jqGXBWsr8/
S9Mx7SpjesKl3vOZCbSSvByEa2S8bddg/wgDaJRjLrAx+voNoNA+hwlE8BxAixr8
N5JlkCrk8eyb0kt32H5oDCEmyQoX2r7+pw30A1cCA52v9YxZeGQ=
=mU2c
-----END PGP SIGNATURE-----

--Apple-Mail=_58F91552-EBFA-48D8-961F-48B6469FDF76--
