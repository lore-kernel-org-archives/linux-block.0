Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED453C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5CD20863
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 09:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="gldlmBuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfCDJXh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:23:37 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41875 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfCDJXh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 04:23:37 -0500
Received: by mail-ed1-f65.google.com with SMTP id x7so3625781eds.8
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 01:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=CuKRlIGYCiE4YpFjec3rG6SOtwBtu0qwhk+mXFT5r0E=;
        b=gldlmBuTJri/Wc3CD8ZmzoUYu/kEJZGbsfX7ERIOYA3Usl/E6+gFZpTMnHtRcUlB82
         bYIum468peMdbLsIl9pRTC5qLVGWlQVGj0GQrDiwF/mYWF94c0P9vmbsvqcMR1UVWBuJ
         kOYkZLFzrj9UiFUpstVkh8uXZ7L5oSwn76jRZJYY1wp9o/5pyK2bjqWzyzcR7ESebvDr
         YIW3SeDn5+Ybss+ZB3WQNqg0yezxgZZJy3QrNfsKSnCoZQDBQ6E3RRzohA0PNXtbqbD9
         QBEI3g1fR/tq+uzHnQ2UG1zz3MKT4K1onBJsv4OEEPLkVxd1Bo5sfLT0hyXOtWZ1CzpP
         GyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=CuKRlIGYCiE4YpFjec3rG6SOtwBtu0qwhk+mXFT5r0E=;
        b=b2QxdWAFiXhA3UNZW62WOY4a+TB1wNzoh8pvd3wH4yOugJyFoZh3duPc62HQn6B442
         0R7plauj5UnUkoRFmvAkifB69gY0GKyht5YYGzrM5GVnZcG7PxrdSGyXJlMRhG2t9W/a
         ibAp6V/O/oag1+Fpq6tZatoR6XNLdBwIxl2FQ8abHHjSsNQ1cormgkMiCPbq12gUte39
         VJ/4iQWBL5TBiVVukoQdkbpqBIHaLfv+j3bRvHPI5++JaVxBW5GcJ7jzHqmKXkNHkdcT
         eeBgBe+T5CWQzj4U6R+2dOxUS8lgI+rLW2M1Dhe46ayeJOZ4uuIKVW0HybO5T9cywuAx
         uN9w==
X-Gm-Message-State: APjAAAWSrT1WwVY8x0LLh4PRgbOfWnFNqlr/zKoszF2JX9mChnXJlp97
        CXTD8cKT62/7oVp+ZbGnbxFZdw==
X-Google-Smtp-Source: APXvYqw2TkJnGKknzWfhYXqHym/Ct6/qb0rDgBiWThbfVw+7nui1F7OjkqkxFNnu2KuZ3PlZ1PxPnw==
X-Received: by 2002:a17:906:4952:: with SMTP id f18mr11634544ejt.189.1551691414816;
        Mon, 04 Mar 2019 01:23:34 -0800 (PST)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id e27sm1939173eda.52.2019.03.04.01.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 01:23:34 -0800 (PST)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <3E70BD55-1CBF-4695-ADA5-91C342E40F6C@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_97D42698-9A93-42E7-979C-D3CF878FE8FF";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 05/13] lightnvm: pblk: Count all read errors in stats
Date:   Mon, 4 Mar 2019 10:23:33 +0100
In-Reply-To: <CANr-nt3rzEGw0wNdOmm3ba9Oz10BLh_dbHoCECobMr2cfakLhQ@mail.gmail.com>
Cc:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-6-igor.j.konopko@intel.com>
 <BAC8CFE4-5D1E-4FA0-80DF-9BA655D458D1@javigon.com>
 <CANr-nt3rzEGw0wNdOmm3ba9Oz10BLh_dbHoCECobMr2cfakLhQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_97D42698-9A93-42E7-979C-D3CF878FE8FF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 4 Mar 2019, at 10.02, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> Igor: Have you seen this happening in real life?
>=20
> I think it would be better to count all expected errors and put them
> in the right bucket (without spamming dmesg). If we need a new bucket
> for i.e. vendor-specific-errors, let's do that instead.
>=20
> Someone wiser than me told me that every error print in the log is a
> potential customer call.
>=20
> Javier: Yeah, I think S.M.A.R.T is the way to deliver this
> information. Why can't we let the drives expose this info and remove
> this from pblk? What's blocking that?

Until now the spec. We added some new log information in Denali exactly
for this. But since pblk supports OCSSD 1.2 and 2.0 I think it is needed =
to
have it here, at least for debugging.

>=20
> Thanks,
> Hans
>=20
> On Mon, Mar 4, 2019 at 8:42 AM Javier Gonz=C3=A1lez =
<javier@javigon.com> wrote:
>>> On 27 Feb 2019, at 18.14, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>>>=20
>>> Currently when unknown error occurs on read path
>>> there is only dmesg information about it, but it
>>> is not counted in sysfs statistics. Since this is
>>> still an error we should also count it there.
>>>=20
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>> drivers/lightnvm/pblk-core.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>> index eabcbc119681..a98b2255f963 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -493,6 +493,7 @@ void pblk_log_read_err(struct pblk *pblk, struct =
nvm_rq *rqd)
>>>              atomic_long_inc(&pblk->read_failed);
>>>              break;
>>>      default:
>>> +             atomic_long_inc(&pblk->read_failed);
>>>              pblk_err(pblk, "unknown read error:%d\n", rqd->error);
>>>      }
>>> #ifdef CONFIG_NVM_PBLK_DEBUG
>>> --
>>> 2.17.1
>>=20
>> I left this out intentionally  so that we could correlate the logs =
from
>> the controller and the errors in the read path. Since we do not have =
an
>> standard way to correlate this on SMART yet, let=E2=80=99s add this =
now (I
>> assume that you are using it for something?) and we can separate the
>> error stats in the future.
>>=20
>> Reviewed-by: Javier Gonz=C3=A1lez <javier@javigon.com>

--Apple-Mail=_97D42698-9A93-42E7-979C-D3CF878FE8FF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlx87pUACgkQPEYBfS0l
eOB9IBAAvFmP/Wiz7bqFJdgdyHR7HjmeCGy/nUdeVluarMopi5oghz/BeIUBPgjl
2K1xTkQZTp6D2Dnw2UQiFfA3FN6nfQ1R0Kfj6cdpI4EW48LsIroK5A8DgB8Qmar5
EiXzpYXhbXrX4sdQHyfn3tJIUOuN2wuXVP6mnlPOImYzY52bFHCyIL/SIsCd2C1W
ULXnE2yYl0VMUkuH/MSf3esWSekCjcknW7Atq92BFTVl3D56CEWCpboaeX8vH4lZ
20bOGFMrPaL18pL6/ES064HLv4Azp0ocmT8X3kP+m1U2Q8oa0U7rGRCt6Ucl2t7/
7YCY9E+64QCORXCQRtrQ/CabEQlYqdy6UGbgoytHCGRNFETdm297g9a9qoy3oO68
CEiSAQiGUbRDWWRnQ6qfd6bw7F6jjdymzk57W8ES4t2hR44nsGkS/JjBiDVEgI4Y
tEq8fHabexqIs8V7+oo6GMXGAVh2FXMTfiUoza61kbKOWxJhA9ZI9rQEr/Wio1wr
JHoDlChn6Mf8vXGK5NIy4xIp58sXlOlybebHTYidfZlaLHBqZoXbo1571ERtzZ7L
V1/oqFhtJuNxAAGH7QiTtnOrKHXLfYFGVGlA+zqdRoBry85uRpTht2lg2shy7OXz
chyttChHyqH3TKdaspKNwEvaCzQd+y6hnxj6s6DStgw6g9YrKdI=
=GUGe
-----END PGP SIGNATURE-----

--Apple-Mail=_97D42698-9A93-42E7-979C-D3CF878FE8FF--
