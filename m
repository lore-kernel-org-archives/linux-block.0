Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E95C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 18:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F512133F
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 18:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="lgif1LCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfCRS0Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:26:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36738 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfCRS0Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 14:26:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id e4so14413271edi.3
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=DzlV896w5ZwKxQ54muTqXlZ3iJSY4Lpwi9Ou+yENLVg=;
        b=lgif1LCkScJN0shk4bp0oF3OUSnxUAqlpS+xgHaw58fX6+cH6hzT7i8qSZhcZ20vgz
         t3MfEKgmYhM4XZ6bBgygvNauawdLnpqIfiQWJuKGR7W6Q18Y2YKsUVWW+/iO1gqTSpgZ
         jUv7+RPxEAQQ5hfrUtjH4/0G1Kgk7YZpz6w/5zagJ78cmmJU2f3HH82vnyAl+lzaT5YJ
         TPia1rXaiIH1yr/wVb3bk2Z1pYBOk3s16H2VIKv2YwDXvr9RpThZ/84UVG9ajS0cIZWP
         NqsSkWqKaEV9OoVFFQsV1TIzRL52Zf2FaKKdhOkrGmUT7MYbvao03mquFQNf0Ju83lM3
         hBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=DzlV896w5ZwKxQ54muTqXlZ3iJSY4Lpwi9Ou+yENLVg=;
        b=W+dB3wQGCiNVmzDjwK1Fne/2zBuIQPK2T6j+g/i4jvKYtpDCJXN0rm2Nd2fJTLQhNT
         wQb1kT2Y8P43HmZkfDGwu99394QFgiYnc92hmnuKnjUGFCScqeQzYPZgN8tzIW/Um/1m
         6TPAquWAI5KevKjB0A9/RVcm5d5Sz2ejy3vx0dL4841jomOgH6L8oFFgBWVZbBcOr7px
         0gnNjFMngPv8rWdhuB/ie61332P7JXDxsfZqxy/c9ip3wqOOHmbIK4P8nW/0HN5DPfgo
         uRTK9kBvxP8Lp1QC/sW7b7SgWneA/R+pnDqjhN8M2/PgzHhChDEIbB67JHnH0pkfFjKS
         ZX9g==
X-Gm-Message-State: APjAAAXQEds0pxFiGE4j2zefavv6xzQj01Floo8XoHOwX1PA515N3TOX
        MHqK9sfHBdc8xw3Jgl6aUfV7yg==
X-Google-Smtp-Source: APXvYqzmDyhAtJORNDDUd1WnkqLO17RF+8GGFvJqGHq+xT4azhGi+ruuseYHuSMme6krHwNYWIselg==
X-Received: by 2002:a17:906:6ad7:: with SMTP id q23mr11325129ejs.210.1552933583441;
        Mon, 18 Mar 2019 11:26:23 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id b26sm1477187ejv.21.2019.03.18.11.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 11:26:22 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <23A8B9B8-21F8-4A8D-BBEE-EC4286AB4B13@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_2105043B-66BB-4411-86E6-9FF4332DAF78";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 10/18] lightnvm: pblk: ensure that emeta is written
Date:   Mon, 18 Mar 2019 19:26:21 +0100
In-Reply-To: <5d8dc4e4-c1a4-88ea-9006-47c3c492ea2c@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-11-igor.j.konopko@intel.com>
 <6766e0ae-ec44-3ebd-0015-aeb7cb9029e5@lightnvm.io>
 <5d8dc4e4-c1a4-88ea-9006-47c3c492ea2c@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_2105043B-66BB-4411-86E6-9FF4332DAF78
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 18 Mar 2019, at 14.02, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
>=20
>=20
> On 17.03.2019 20:44, Matias Bj=C3=B8rling wrote:
>> On 3/14/19 9:04 AM, Igor Konopko wrote:
>>> When we are trying to switch to the new line, we need to ensure that
>>> emeta for n-2 line is already written. In other case we can end with
>>> deadlock scenario, when the writer has no more requests to write and
>>> thus there is no way to trigger emeta writes from writer thread. =
This
>>> is a corner case scenario which occurs in a case of multiple writes
>>> error and thus kind of early line close due to lack of line space.
>>>=20
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>>   drivers/lightnvm/pblk-core.c  |  2 ++
>>>   drivers/lightnvm/pblk-write.c | 24 ++++++++++++++++++++++++
>>>   drivers/lightnvm/pblk.h       |  1 +
>>>   3 files changed, 27 insertions(+)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>>> index 38e26fe..a683d1f 100644
>>> --- a/drivers/lightnvm/pblk-core.c
>>> +++ b/drivers/lightnvm/pblk-core.c
>>> @@ -1001,6 +1001,7 @@ static void pblk_line_setup_metadata(struct =
pblk_line *line,
>>>                        struct pblk_line_mgmt *l_mg,
>>>                        struct pblk_line_meta *lm)
>>>   {
>>> +    struct pblk *pblk =3D container_of(l_mg, struct pblk, l_mg);
>>>       int meta_line;
>>>       lockdep_assert_held(&l_mg->free_lock);
>>> @@ -1009,6 +1010,7 @@ static void pblk_line_setup_metadata(struct =
pblk_line *line,
>>>       meta_line =3D find_first_zero_bit(&l_mg->meta_bitmap, =
PBLK_DATA_LINES);
>>>       if (meta_line =3D=3D PBLK_DATA_LINES) {
>>>           spin_unlock(&l_mg->free_lock);
>>> +        pblk_write_emeta_force(pblk);
>>>           io_schedule();
>>>           spin_lock(&l_mg->free_lock);
>>>           goto retry_meta;
>>> diff --git a/drivers/lightnvm/pblk-write.c =
b/drivers/lightnvm/pblk-write.c
>>> index 4e63f9b..4fbb9b2 100644
>>> --- a/drivers/lightnvm/pblk-write.c
>>> +++ b/drivers/lightnvm/pblk-write.c
>>> @@ -505,6 +505,30 @@ static struct pblk_line =
*pblk_should_submit_meta_io(struct pblk *pblk,
>>>       return meta_line;
>>>   }
>>> +void pblk_write_emeta_force(struct pblk *pblk)
>>> +{
>>> +    struct pblk_line_meta *lm =3D &pblk->lm;
>>> +    struct pblk_line_mgmt *l_mg =3D &pblk->l_mg;
>>> +    struct pblk_line *meta_line;
>>> +
>>> +    while (true) {
>>> +        spin_lock(&l_mg->close_lock);
>>> +        if (list_empty(&l_mg->emeta_list)) {
>>> +            spin_unlock(&l_mg->close_lock);
>>> +            break;
>>> +        }
>>> +        meta_line =3D list_first_entry(&l_mg->emeta_list,
>>> +                        struct pblk_line, list);
>>> +        if (meta_line->emeta->mem >=3D lm->emeta_len[0]) {
>>> +            spin_unlock(&l_mg->close_lock);
>>> +            io_schedule();
>>> +            continue;
>>> +        }
>>> +        spin_unlock(&l_mg->close_lock);
>>> +        pblk_submit_meta_io(pblk, meta_line);
>>> +    }
>>> +}
>>> +
>>>   static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq =
*rqd)
>>>   {
>>>       struct ppa_addr erase_ppa;
>>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>>> index 0a85990..a42bbfb 100644
>>> --- a/drivers/lightnvm/pblk.h
>>> +++ b/drivers/lightnvm/pblk.h
>>> @@ -877,6 +877,7 @@ int pblk_write_ts(void *data);
>>>   void pblk_write_timer_fn(struct timer_list *t);
>>>   void pblk_write_should_kick(struct pblk *pblk);
>>>   void pblk_write_kick(struct pblk *pblk);
>>> +void pblk_write_emeta_force(struct pblk *pblk);
>>>   /*
>>>    * pblk read path
>> Hi Igor,
>> Is this an error that qemu can force pblk to expose? Can you provide =
a specific example on what is needed to force the error?
>=20
> So I hit this error on PBLKs with low number of LUNs and multiple
> write IO errors (should be reproducible with error injection). Then
> pblk_map_remaining() quickly mapped all the sectors in line and thus
> writer thread was not able to issue all the necessary emeta IO writes,
> so it stucks when trying to replace line to new one. So this is
> definitely an error/corner case scenario.

If the cause if emeta writes, then there is a bug in
pblk_line_close_meta(), as the logic to prevent this case is in place.


--Apple-Mail=_2105043B-66BB-4411-86E6-9FF4332DAF78
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyP4s0ACgkQPEYBfS0l
eOD6Hw/9FKEbayXWPsKeZrxMdLIH1Y7q/zU27gAEn4H+E+lx5KFz/Bv/E9KdpBgd
eTkdfoz/M42pBiGM6F/khB4TE0YHzmatupgA5LCzYfxbCKa5KC2zvselbQvwvaoa
cKtZ5WVYYlaXlMOWjnfIsFm2bIrijQmXNu1WuKYQwF27XKwhO+JiMAc/5Eq/mtm1
Hw9Ap7iqlZLzU3pCJFp/Fbjwgz7TTErwi7peA1bcMenRpCac/XWTy22CkgBQtmxU
qbGsOb9NQ0TS8A56EM4Gp4YiJNmLra047Mpunm14w91XrUCeB2DFK+B5AIAHHAla
X5kUVth0U/ffy4drNj681edi3QLPuUF7I1CdHmnVJKFjTUavieN+wFQdRgTOzcbZ
8OgKqSQcvjFRWp0X0SBuOXuoPoRg4SEaECUR1Qrz5/QmoF42BCLZ7Ka6Q64PYQQd
ePqN5dVsPfWr50gmzKJ4Y+Af3H63RUgGTHtYkZdhIgYOTUY4FGb8vDFlq7f00GgS
YhOzTGgySPCsFRd2BdglrGPYQt/5Hz3ivj0cIWVFZT3/Yd7thS37rAoWoBNx4dU4
aMxVCBkXjPqYoK4p7E+ox8zK++Jd+hCLYbiUWVI5eE2zMYSKLNv1ZA/Q2EV80zH1
g0WexXR6zDsAEWmNuBpERZIxztq2lyTQYKagjWwGeJUgcJdoF3U=
=emJy
-----END PGP SIGNATURE-----

--Apple-Mail=_2105043B-66BB-4411-86E6-9FF4332DAF78--
