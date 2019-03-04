Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FC4C10F03
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7EE20836
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="GcQfSMHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfCDJst (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:48:49 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46477 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfCDJss (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 04:48:48 -0500
Received: by mail-ed1-f67.google.com with SMTP id f2so3681946edy.13
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 01:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=4xZnnlG1x4FnZBGpI/l+VTH67e6+GvmVm7d/Tbeqx7I=;
        b=GcQfSMHMb+ZJnp7y9tyksGIXWAZ/4kJIQmZhi1bR5gM3/fhkcnYPHtl5pHdaouSIa+
         gpSEHLBK1krCUJWzmevV11F/tLb/rbJS/TQyC6Fl7DCNKm3Uc5jMO7RAaf6g1c6aRLu0
         lOhveuSKHPvUhsU8C2G8PuWEFntds9KExtAT+cJoCiS/LY0H1EEdMd57p1pP9Dborsmv
         +48eMqNP6VwsG2zPKTqenqRXoJfmY7Ivvutp6xS3aDya6YITTturIeskicqsKYlZAh3W
         m4tIMwN21rq5J/jx3BvOCc9R2eIusjrpIgQj+aoXameHBzHhQfzVuFIkXHv2JC52XgJK
         WWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=4xZnnlG1x4FnZBGpI/l+VTH67e6+GvmVm7d/Tbeqx7I=;
        b=VW5cJpZCc90pjhOBAq/cUt0fpVVdgl7+veyV03ewEhIEgMpfL/FCRhzmOzCfvXBUtD
         4KVhW3an5toxYIYd5W5hw51pWPR5XheOetz6/JhGME932dJSEqVLlsXwgzb7G2Ev+rAQ
         X+zP72QJg3iAe1dPBwrYUJaH6kL7RH7Jxs7EiBYGPQE6Nqik+sFlI1SNP0Awk6vtjM5B
         7jIq5jdN7Y/kpWRWiAsSoFBJU9yk8hQWp02yWSkVwNkS1hIObWyOveCCtLw6Z2V10wWy
         SGJqL4zU1nE4TpWxIyaF/ZJ0kgsaOyVnMM5lSSEs3e4yUoPzvYRdqmnUybzeM0pjMNCu
         Lhow==
X-Gm-Message-State: APjAAAWeIHrUa1HUQfTM9ANPxHJf9vwEPeCMxAfRS/yi7eTFxd93UOxF
        jdLeZdkEXZpZZ8YfccctTn6mfA==
X-Google-Smtp-Source: APXvYqwmCgGnZczaemboVeyBYw8ghJKEQ2NSYbwk0gO5nI3YDqpv1aqdnNwXtl+W0IlB2m51cHKgQw==
X-Received: by 2002:a50:9964:: with SMTP id l33mr14546629edb.115.1551692926309;
        Mon, 04 Mar 2019 01:48:46 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id f48sm1944480edd.56.2019.03.04.01.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 01:48:45 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <9076DF06-7B01-44DA-BA5F-9C784D56134E@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_2DE7C11F-A501-4EF3-ACFD-21576935CA78";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 08/13] lightnvm: pblk: Set proper read stutus in bio
Date:   Mon, 4 Mar 2019 10:48:44 +0100
In-Reply-To: <CANr-nt1o4ZyRW-MwwXHQ7aXTmOr8PsqRzhR3643iddh9H2kjjg@mail.gmail.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-9-igor.j.konopko@intel.com>
 <007EC669-9C50-4B29-9522-CE73CD3CE47F@javigon.com>
 <CANr-nt1o4ZyRW-MwwXHQ7aXTmOr8PsqRzhR3643iddh9H2kjjg@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_2DE7C11F-A501-4EF3-ACFD-21576935CA78
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 4 Mar 2019, at 10.35, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> On Mon, Mar 4, 2019 at 9:03 AM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>>>=20
>>> Currently in case of read errors, bi_status is not
>>> set properly which leads to returning inproper data
>>> to higher layer. This patch fix that by setting proper
>>> status in case of read errors
>>>=20
>>> Patch also removes unnecessary warn_once(), which does
>>> not make sense in that place, since user bio is not used
>>> for interation with drive and thus bi_status will not be
>>> set here.
>>>=20
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>> drivers/lightnvm/pblk-read.c | 11 +++++------
>>> 1 file changed, 5 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-read.c =
b/drivers/lightnvm/pblk-read.c
>>> index 3789185144da..39c1d6ccaedb 100644
>>> --- a/drivers/lightnvm/pblk-read.c
>>> +++ b/drivers/lightnvm/pblk-read.c
>>> @@ -175,11 +175,10 @@ static void pblk_read_check_rand(struct pblk =
*pblk, struct nvm_rq *rqd,
>>>      WARN_ONCE(j !=3D rqd->nr_ppas, "pblk: corrupted random =
request\n");
>>> }
>>>=20
>>> -static void pblk_end_user_read(struct bio *bio)
>>> +static void pblk_end_user_read(struct bio *bio, int error)
>>> {
>>> -#ifdef CONFIG_NVM_PBLK_DEBUG
>>> -     WARN_ONCE(bio->bi_status, "pblk: corrupted read bio\n");
>>> -#endif
>>> +     if (error && error !=3D NVM_RSP_WARN_HIGHECC)
>>> +             bio_io_error(bio);
>>>      bio_endio(bio);
>>> }
>>>=20
>>> @@ -219,7 +218,7 @@ static void pblk_end_io_read(struct nvm_rq *rqd)
>>>      struct pblk_g_ctx *r_ctx =3D nvm_rq_to_pdu(rqd);
>>>      struct bio *bio =3D (struct bio *)r_ctx->private;
>>>=20
>>> -     pblk_end_user_read(bio);
>>> +     pblk_end_user_read(bio, rqd->error);
>>>      __pblk_end_io_read(pblk, rqd, true);
>>> }
>>>=20
>>> @@ -292,7 +291,7 @@ static void pblk_end_partial_read(struct nvm_rq =
*rqd)
>>>      rqd->bio =3D NULL;
>>>      rqd->nr_ppas =3D nr_secs;
>>>=20
>>> -     bio_endio(bio);
>>> +     pblk_end_user_read(bio, rqd->error);
>>>      __pblk_end_io_read(pblk, rqd, false);
>>> }
>>>=20
>>> --
>>> 2.17.1
>>=20
>> This is by design. We do not report the read errors as in any other
>> block device - this is why we clone the read bio.
>=20
> Could you elaborate on why not reporting read errors is a good thing =
in pblk?
>=20

Normal block devices do not report read errors on the completion path
unless it is a fatal error. This is actually not well understood by the
upper layers, which tend to assume that the device is completely broken.

This is a challenge for OCSSD / Denali / Zone devices as there are cases
where reads can fail. Unfortunately at this point, we need to mask these
errors and deal with them in the different layers.

For OCSSD currently, we do this in pblk, which I think fits well the
model as we exposed a normal block device.

Javier

--Apple-Mail=_2DE7C11F-A501-4EF3-ACFD-21576935CA78
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx89HwACgkQPEYBfS0l
eOCnRRAAm6A5PYz3MDU+t3lgaW4UKyhYnajJtgOP6EORhmvnbA94JpJj33ZoA7bd
w5fNlGI1wOZGxL5LXTVrZpQg8GxNNhf9U8oZv9TekkR9RwCN85hFGtJfz/ww91Rd
HvozM1V3B+yX0wR47CJjm1BysexthZv95VNnGFMTysKJXIJqEP68p7hUALQkzORq
uZSTt+bLdhpFvrOaFr3SMRNzldDNrTFnRJjUuE7PfDO3HmcMVzXokswrVNLPzF6C
m/ZuA0hgsWrIxDKp8Z5GfVxly3/5GaMSqBe32TTVpLkLCVIb2pJVwuWkA9r3ZjEQ
2kbBRlNIjvwXCKiCX4vraj4AD/JQZF+iefgpL8zG8G/8caWuv5AU/BKogGsS0v2S
O2oAS4S7ZGm+cnzOVKrlCUds1/1cYV1Zwnz0Uz+UlZVnc3k3KpigY1jTpz+/lqYF
C+4kzBKKAQATg1sRfX40DJoBfTF7dYQxlIIHiMu9Q72wL1WAXed6vJGb0bYWDe4q
oBpelxVr5XXN97rtx2Nklxe5KTL2BgtUbvkFdI0ADQkCjKR2qckv0GPMAVp8IHlj
8We6+iYBH2mxzxgedqrqdtxL17z/fHs6+lo4V0coQ6nJm1SmIaj3oUzrMQd/W1i1
/HjZz3JmIbdohwPTmKFqypGy24s2HiJ4L0cgvub27xIGt5GPIGs=
=rDi2
-----END PGP SIGNATURE-----

--Apple-Mail=_2DE7C11F-A501-4EF3-ACFD-21576935CA78--
