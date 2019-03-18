Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BD1C43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221B220989
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 19:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="yucbZqBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfCRT0B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:26:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38675 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCRT0B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 15:26:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id e10so10643676edy.5
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 12:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=LOvzCaM07nxNH/GWKGxJ+XLUInCpAL6uN5T0lsAS9jc=;
        b=yucbZqBppEcrm01Du18m9vxvhwqdvK1D59XHyChg/iimYLj10GiUKhpg97FbXPGQjz
         //851Tg1RvyJXBQJFAhWhMpyehiRQLH+HwPeawA6NjNtzOJfBpWVyADH/Qqa12VaZgSQ
         Y7E0MGSkwm8PMH/CxsEp/7SryEwWXkKV3tajSiylX2Nknse8NleUQwVpXTEZdLwSFZCb
         sYFpIOF/xCX9C3XkghjiBFGIjuonEUwW74vsbSmA2Mwi6ReNH5hzIMzR5XQxYn9RS0GB
         xjGRTBJnh3zGl7mPqOjVAxe74gHbM7/a/U6BtrcAMqaP3ccnCppo0f0g9WR/FdBiSBMd
         r3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=LOvzCaM07nxNH/GWKGxJ+XLUInCpAL6uN5T0lsAS9jc=;
        b=KvVsfdVgRFyOIgejM+5IQwyt2+cIon1SN3lo14TwGo5A4Tyu7em9vKKCWwrc++TQc6
         bmr9g3BrX1TgSycQgQ2KSIYoeaQs2fLoapNlHIpXw4zx48L62yaRNlY6s6SkPJ8KQPKk
         zh/OeVr4E9LuBVREMaZV6mt8lXdSatn4P9niYAI/7qGCqMzCecGujpWyWOBCx0amyj9W
         9NtnzPu3nSCnZbRyYlkNUCBTei/3FYwySXEBO0Xs6G/uxUP9svMHMbN965k/PwOSLl3a
         Y58gboNiVjHis9cZsX9RKAreYr84nfoimOV8vdzO6Mi5h3n6AX6oL4AvJtKBrYg2qTq9
         71zQ==
X-Gm-Message-State: APjAAAVdkor0txBnQlwZLNyTGFXFvGcCaE69dsM05uRGHKMpcvNS+90Q
        vwcejbMmZ4G4lSM5G1PjPWIznQ==
X-Google-Smtp-Source: APXvYqyLEfppJB03AUxjfwX16D8XiZHjHWHIVs7qbJCXtQKKV3kBAuBKRxoHxfOEh5NPNL/9T4X4Bw==
X-Received: by 2002:a50:9271:: with SMTP id j46mr11509922eda.184.1552937159837;
        Mon, 18 Mar 2019 12:25:59 -0700 (PDT)
Received: from [192.168.1.119] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id oq22sm2619223ejb.68.2019.03.18.12.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 12:25:59 -0700 (PDT)
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Message-Id: <8B030876-9A5C-474E-9985-F578B95B6ECC@javigon.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C51467E9-5E54-47CC-9707-EF578B3ADDE3";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 04/18] lightnvm: pblk: OOB recovery for closed chunks fix
Date:   Mon, 18 Mar 2019 20:25:58 +0100
In-Reply-To: <88dc0cd0-d863-3129-3cae-5d6e133820cf@intel.com>
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
To:     "Konopko, Igor J" <igor.j.konopko@intel.com>
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-5-igor.j.konopko@intel.com>
 <F7A12A66-ADBD-4B24-9FD0-B02031E2FACB@javigon.com>
 <5d997ae1-ec1f-6a78-6a93-f15fab542859@lightnvm.io>
 <88dc0cd0-d863-3129-3cae-5d6e133820cf@intel.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--Apple-Mail=_C51467E9-5E54-47CC-9707-EF578B3ADDE3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 18 Mar 2019, at 13.50, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>=20
>=20
>=20
> On 17.03.2019 20:24, Matias Bj=C3=B8rling wrote:
>> On 3/16/19 3:43 PM, Javier Gonz=C3=A1lez wrote:
>>>> On 14 Mar 2019, at 09.04, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>>>>=20
>>>> In case of OOB recovery, when some of the chunks are in closed =
state,
>>>> we are calculating number of written sectors in line incorrectly,
>>>> because we are always counting chunk WP, which for closed chunks
>>>> does not longer reflects written sectors in particular chunks. This
>>>> patch for such a chunks takes clba field instead.
>>>>=20
>>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>>> ---
>>>> drivers/lightnvm/pblk-recovery.c | 8 +++++++-
>>>> 1 file changed, 7 insertions(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
>>>> index 83b467b..bcd3633 100644
>>>> --- a/drivers/lightnvm/pblk-recovery.c
>>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>>> @@ -101,6 +101,8 @@ static void pblk_update_line_wp(struct pblk =
*pblk, struct pblk_line *line,
>>>>=20
>>>> static u64 pblk_sec_in_open_line(struct pblk *pblk, struct =
pblk_line *line)
>>>> {
>>>> +    struct nvm_tgt_dev *dev =3D pblk->dev;
>>>> +    struct nvm_geo *geo =3D &dev->geo;
>>>>     struct pblk_line_meta *lm =3D &pblk->lm;
>>>>     int nr_bb =3D bitmap_weight(line->blk_bitmap, =
lm->blk_per_line);
>>>>     u64 written_secs =3D 0;
>>>> @@ -113,7 +115,11 @@ static u64 pblk_sec_in_open_line(struct pblk =
*pblk, struct pblk_line *line)
>>>>         if (chunk->state & NVM_CHK_ST_OFFLINE)
>>>>             continue;
>>>>=20
>>>> -        written_secs +=3D chunk->wp;
>>>> +        if (chunk->state & NVM_CHK_ST_OPEN)
>>>> +            written_secs +=3D chunk->wp;
>>>> +        else if (chunk->state & NVM_CHK_ST_CLOSED)
>>>> +            written_secs +=3D geo->clba;
>>>> +
>>>>         valid_chunks++;
>>>>     }
>>>>=20
>>>> --
>>>> 2.9.5
>>>=20
>>> Mmmm. The change is correct, but can you develop on why the WP does =
not
>>> reflect the written sectors in a closed chunk? As I understand it, =
the
>>> WP reflects the last written sector; if it happens to be WP =3D=3D =
clba, then
>>> the chunk state machine transitions to closed, but the WP remains
>>> untouched. It is only when we reset the chunk that the WP comes back =
to
>>> 0. Am I missing something?
>> I agree with Javier. In OCSSD, the write pointer shall always be =
valid.
>=20
> So based on OCSSD 2.0 spec "If WP =3D SLBA + NLB, the chunk is closed" =
(also on "Figure 5: Chunk State Diagram in spec": WP =3D SLBA + NLB for =
closed chunk), my understanding it that the WP is not valid for that =
particular use case, since in written_secs we want to obtain NLB field =
(relative within chunk, without starting LBA value). So that's why I =
used fixed CLBA here, since it WP pointer for closed chunk is absolute =
value instead of relative one.
> Did I misunderstood sth in the spec?

I see where the confusion comes from. I have always understood it in the
way that WP points to the next available sector in the chunk. When WP =3D
SLBA + NLB, then the WP remains in the last valid sector (as there are
no more available sectors).

Both polk and QEMU are implemented this way, but it might be worth a
clarification in the spec (to be one way or the other)? Matias?


--Apple-Mail=_C51467E9-5E54-47CC-9707-EF578B3ADDE3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEU1dMZpvMIkj0jATvPEYBfS0leOAFAlyP8MYACgkQPEYBfS0l
eOAPwBAAp6GLrjrQ1ewOMANEfiiUDN3wBZykV3e/oUIwrepeMWdhGm6fyF0Gvr6n
PSkeNWooH8G+RTV81azRvNb69c1XqSTw0gZKNa2ctt6uIBXN6a1U7lpIrz++oyDo
QS0OVymE5ffsgpIVSV1j2G/SngT8gdvaF87e+HZAQ+4RWTZcswsHHLOGVZq/ySuy
KuLShg8a8LaYmhlgB8/2e39cDmMW01axTczMQ6Ly7z2BpnZ41dkusle1d9aHZQnS
H/elsE79/du/riGyKj1lngJneVzTppg/y+Gfj4DyKxfmaek6Kb7dq1tHzmKphrbk
9g24rf/a8EagFy3HcqTz0//r1RxFipCj7JRT53sZlaA2UeWdIx98JfCddqzth+j3
vJsc8DBlUWKRWIeonJH+MvuKKOkWCwaaWGVj3HJjxQ/UJYFxUqXJSNstv7gCQ9p2
YOBXUq5UZ4toJE0GJ76OLOKcmgqdfn/hg6gEdIOoqAAtninDEqE20I4spmogKWPY
DJQJr54iSDRTzjo4/J2jVbL8YiaUWnHult3VRhWHDkATOz2QumoYmp0jQDycUzGQ
/Rg4kInVNaHL11T9BNVKAq7PLswaWFwZj7YQ8DY8rXRwoR4CvZlAXhwE92KZUxOq
GCtkx1O3rGQp3te72IvQ+/nMyH1MrxB93Uh2ni0E/i/8Wgiui3M=
=FvES
-----END PGP SIGNATURE-----

--Apple-Mail=_C51467E9-5E54-47CC-9707-EF578B3ADDE3--
