Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF9BC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DC12075B
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Nb8RJJtN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfCDNps (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:45:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36212 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfCDNpr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 08:45:47 -0500
Received: by mail-ed1-f66.google.com with SMTP id g9so4283542eds.3
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 05:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ZM/u2+8ZjqsoQVt02AB35CamHT68HC5i31J/LT7+eXk=;
        b=Nb8RJJtN9JKJnGTlPesNpTNPEddSIBaNsvXYppeJqGbuPKfD1vEEeHW/NgHkBYUGCe
         tmkCEMM0CboURaYwC7E+HGjd3H8XiqOC6zvxJUKCCu4YdXmoE/Vy7dCR7np0UgjzAwcx
         MMUjXpd7HnOHOhCnSUb6+JVbUaVnVec1wQsphul1WI6Oe09WaXZzyDear9/MNucBR10a
         yf/q2LuGI8f0zUhxD25+QYfKOJyz/pm/rlYRKvTM9jLrQb0+kJaA2bTSFsGXB4E+YnqR
         buo7gLIgvG2DV1+hC1Gb2NIMIUKycyj/OnwSH5WeQ2VZMDW7TBYrrCP/1/NYs09yqgs3
         mzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ZM/u2+8ZjqsoQVt02AB35CamHT68HC5i31J/LT7+eXk=;
        b=kjn8Q3DppfwdYxcA9Dv/wqpR1KyqOuJuBy4Vyquw2O1MQultbdjehsoBVbALMxI3Pj
         hDm4m/pDuQGAzC639DxeokV1a2SJdiLDSk1h2tAELzspVATXhXxvwr1ElT39p0osFGRt
         bLJEdPS2DB9iAQJp1cIpc/6ZjFgUu8qC+9OBMI0IQQ1Q8VT1ENNNI+Aya3C8dZ12a6jl
         AA6TxNYluXgu/MN+6HAbvoRSXqsrofWXW7pswxciSD02frWUN9OX3xmpb/5To/cjkKOO
         uB9kjf0dNfFxOze5ZG1f9YRgs6CfeViJyAtPiB1qet0nnpGodDy6UCamS0qETqli9gtY
         vkKw==
X-Gm-Message-State: APjAAAVrX782fco1bhB8P1Uc+iyx+snJalHmDmw3c4iO+64DllsCiBPm
        d35OZ/c15wnrML/tAlz2MJXv1NgKDX8=
X-Google-Smtp-Source: APXvYqyx57FDS+xNvHBdELdwlxlVHpryVd69MzxiO+pbb+Z7GaIGE/6Ilk0crJTZTypN0Rr1jMhHOA==
X-Received: by 2002:a17:906:1c4b:: with SMTP id l11mr12553144ejg.20.1551707145215;
        Mon, 04 Mar 2019 05:45:45 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id 20sm1213155ejy.68.2019.03.04.05.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:45:44 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <8A1CEAAD-601B-4AC8-81DC-C7A5CB24001D@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C60699E7-C293-4DDB-A2E2-2B58E550EB11";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 08/13] lightnvm: pblk: Set proper read stutus in bio
Date:   Mon, 4 Mar 2019 14:45:43 +0100
In-Reply-To: <4b92af86-c5ba-aa09-f39e-86975fd35460@lightnvm.io>
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
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_C60699E7-C293-4DDB-A2E2-2B58E550EB11
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 4 Mar 2019, at 14.08, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 3/4/19 1:51 PM, Igor Konopko wrote:
>> On 04.03.2019 13:14, Hans Holmberg wrote:
>>> On Mon, Mar 4, 2019 at 10:48 AM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>>>> On 4 Mar 2019, at 10.35, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>>>>>=20
>>>>> On Mon, Mar 4, 2019 at 9:03 AM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>>>>>> On 27 Feb 2019, at 18.14, Igor Konopko =
<igor.j.konopko@intel.com> wrote:
>>>>>>>=20
>>>>>>> Currently in case of read errors, bi_status is not
>>>>>>> set properly which leads to returning inproper data
>>>>>>> to higher layer. This patch fix that by setting proper
>>>>>>> status in case of read errors
>>>>>>>=20
>>>>>>> Patch also removes unnecessary warn_once(), which does
>>>>>>> not make sense in that place, since user bio is not used
>>>>>>> for interation with drive and thus bi_status will not be
>>>>>>> set here.
>>>>>>>=20
>>>>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>>>>> ---
>>>>>>> drivers/lightnvm/pblk-read.c | 11 +++++------
>>>>>>> 1 file changed, 5 insertions(+), 6 deletions(-)
>>>>>>>=20
>>>>>>> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
>>>>>>> index 3789185144da..39c1d6ccaedb 100644
>>>>>>> --- a/drivers/lightnvm/pblk-read.c
>>>>>>> +++ b/drivers/lightnvm/pblk-read.c
>>>>>>> @@ -175,11 +175,10 @@ static void pblk_read_check_rand(struct =
pblk *pblk, struct nvm_rq *rqd,
>>>>>>>       WARN_ONCE(j !=3D rqd->nr_ppas, "pblk: corrupted random =
request\n");
>>>>>>> }
>>>>>>>=20
>>>>>>> -static void pblk_end_user_read(struct bio *bio)
>>>>>>> +static void pblk_end_user_read(struct bio *bio, int error)
>>>>>>> {
>>>>>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>>>>>> -     WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
>>>>>>> -#endif
>>>>>>> +     if (error && error !=3D NVM_RSP_WARN_HIGHECC)
>>>>>>> +             bio_io_error(bio);
>>>>>>>       bio_endio(bio);
>>>>>>> }
>>>>>>>=20
>>>>>>> @@ -219,7 +218,7 @@ static void pblk_end_io_read(struct nvm_rq =
*rqd)
>>>>>>>       struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
>>>>>>>       struct bio *bio =3D (struct bio *)r_ctx->private;
>>>>>>>=20
>>>>>>> -     pblk_end_user_read(bio);
>>>>>>> +     pblk_end_user_read(bio, rqd->error);
>>>>>>>       __pblk_end_io_read(pblk, rqd, true);
>>>>>>> }
>>>>>>>=20
>>>>>>> @@ -292,7 +291,7 @@ static void pblk_end_partial_read(struct =
nvm_rq *rqd)
>>>>>>>       rqd->bio =3D NULL;
>>>>>>>       rqd->nr_ppas =3D nr_secs;
>>>>>>>=20
>>>>>>> -     bio_endio(bio);
>>>>>>> +     pblk_end_user_read(bio, rqd->error);
>>>>>>>       __pblk_end_io_read(pblk, rqd, false);
>>>>>>> }
>>>>>>>=20
>>>>>>> --
>>>>>>> 2.17.1
>>>>>>=20
>>>>>> This is by design. We do not report the read errors as in any =
other
>>>>>> block device - this is why we clone the read bio.
>>>>>=20
>>>>> Could you elaborate on why not reporting read errors is a good =
thing in pblk?
>>>>=20
>>>> Normal block devices do not report read errors on the completion =
path
>>>> unless it is a fatal error. This is actually not well understood by =
the
>>>> upper layers, which tend to assume that the device is completely =
broken.
>>>=20
>>> So returning bogus data without even a warning is a preferred
>>> solution? You want to force "the upper layers" to do checksumming?
>>>=20
>>> It's fine to mask out NVM_RSP_WARN_HIGHECC, since that is just a
>>> warning that OCSSD 2.0 adds. The data should still be good.
>>> All other errors (see 4.6.1.2.1 in the NVMe 1.3 spec), indicates =
that
>>> the command did not complete (As far as I can tell)
>> My approach was exactly like that. In all cases other than =
WARN_HIGHECC we don't have a valid data. Without setting a =
bio_io_error() we are creating the impression for other layers, that we =
read the data correctly, what is not a case then.
>> I'm also seeing that this patch is not the only user of =
bio_io_error() API, also other drivers such as md uses is commonly.
>=20
> Yes agree. This is an actual error in pblk that lets it return bogus =
data.

I am not against returning an error, I am just saying that this is not
normal behavior on the read path.

The problem is that the upper layers might interpret that the device is
broken completely, which is not true for a spa failing. Think for
example of a host reading under mw_cunits - in reality this is not even
a device problem but a host bug that might result in a fatal error.

Matias: I am surprised to see you answer this way - when I tried to
define a sane read error path with meaningful errors starting in the
spec and all the way up the stack you were the first one to argue for
reads to always succeed no matter what. In fact, using ZBC/ZAC as an
example...

Javier

--Apple-Mail=_C60699E7-C293-4DDB-A2E2-2B58E550EB11
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx9LAcACgkQPEYBfS0l
eOA1vQ//SEmZulpBVl8+gh42a+5uWH/q5SkiX9KjOyaUHEGtLl2rSYZknq1mox2r
O+IIvRVQTTr3gJuHAwKkgrfS6RJdJZBXVzaxny/xKsuYeXzfQjSX9pGW793N+Nuy
4ujvPmCrCzkTRP6hA1+TDMXgFSzGW+XpQ4NmR/i+l+yTPDGYxtRo0qvqxas6gvxd
jCg4kWWNg7nn8V/ee+B7pFP7HBp2ZW7E1cGK6EFIrPaHajJ7yFwGlObWFeBWLxjY
eL9pLE6Upa7Q8d8Fr58HSRrrlsaen0VROXOCCfBQ+N669tLl3wQwEZE3S82jMOcK
vYcW8f/WAFfjFKRpUnT2bsJWgHJCabSGTH9U4oq2T2X0fMtT1TE++4XIluVeLya8
rEUfULDksUdeaoAO7MK5cCxr0s9IujxFqc36arO9ySmVi+EPS/OKDyOjFdtxZceN
9tXT6pCKO3/mGDqBWv+O49s0v2PymAZPTHeS8kDAB75y8EqF1uoap+6mGE2GlIfh
Z6XMcVoxPcWw18e0IyqhfeYHXFsx+ERWk5DsL3LZZZhA0OOD1NdGELfMUqt7gake
DrLcmXmINVn70u6iyrBS9vaWd/VSfX5/6sKmi9edMK/LhTZhhUAHzMfcIf8Qc9ct
s3Tyw7R6/ChVJVvyIQqhmnU/pF7uFBljH1xapfHOpdFfESDoFUc=
=B3EZ
-----END PGP SIGNATURE-----

--Apple-Mail=_C60699E7-C293-4DDB-A2E2-2B58E550EB11--
