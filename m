Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0124CC282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 21:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E42217D4
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 21:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="YljEeew5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfAYVaI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:30:08 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39021 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbfAYVaI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 16:30:08 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so8456637edt.6
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 13:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=37f6ZrPWeRWOoqrvzmw3bzLJxFSgqwVg1qtDAfVpYXY=;
        b=YljEeew5efCNaEM1lW8oZMV1TdqUrVrTdEq9b+Qzh+mGu0TKWtHVx5sKFIBBIzVSM6
         n1kJs30ZsSc1Cp+rReUyI76z8CP67UJ4IetH00uHmAAmApZjppt/oAHQq7pfc80tR9sA
         3wDAT74hih2640yHIXgiG//RSicEZ/+gWcujylt7UHqYRDmM/4ggBnUTuikbfVum9jwP
         6U7Kc1zrjagrixfknJG4P0TKyIa74SVO0uOX/S8/dvYV5wfSqSFihI8+jICokfY/n0Rk
         0V9eplphxLb+GXpCL47xj3dpv/Gwz+SJsNK5NpoDg/dxGWvKh+W/BoIKUjCaUtVSTqLz
         v/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=37f6ZrPWeRWOoqrvzmw3bzLJxFSgqwVg1qtDAfVpYXY=;
        b=SzHJhhf4dbYiUSv/KOejzI1ifGODXFYKkK41/OGBOKukWMn1vM/7DySxacjL9Sthih
         g0hBXfV64aV88RuSiZLQCGnofwTa+ST9dzgGbTf6FEuxyU2fuhpeZpVdpjoL+b54KK60
         AN2fkgOqE41FixESr+Yc+oGrJXk/EkeudMfDzSjMmbFgUFtZDeZ6+ogbVjQnARkzhVKq
         pA+LOPuSlnnbfVKhtHlMgTBcEML8nEUcwohZxS9urARPrYSe/sYg6EJ+98hwJ8qAUiSI
         2gKQ7+xvrgazYN0yhi9KW5EM7I/AeZrhpLkY0A6Ttl+gjSXQf+VdIaTCTDw3haQGLxBO
         8Vog==
X-Gm-Message-State: AJcUukdWxKVtJ0o9FOLRPdaS9FG563pZXoTP6iuN63CnrDE1/FYW5i6G
        802MGoYV99oY2HNFF67keLAhO1s2cgM=
X-Google-Smtp-Source: ALg8bN7tkxneZBhLSkh5rmXyUSeOV3a0ZRIk7Pot4j1vhbUgMg+2GTMeoMLhR41rtmvioDrMKt1wYQ==
X-Received: by 2002:a17:906:914:: with SMTP id i20-v6mr11035540ejd.225.1548451806079;
        Fri, 25 Jan 2019 13:30:06 -0800 (PST)
Received: from [192.168.1.134] (ip-5-186-122-168.cgn.fibianet.dk. [5.186.122.168])
        by smtp.gmail.com with ESMTPSA id b9sm14303318ede.12.2019.01.25.13.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 13:30:05 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <CANr-nt1crBDMwTsxR8VhcOMiK8wSdn4cA6jFtgtOLbUpWyit+g@mail.gmail.com>
Date:   Fri, 25 Jan 2019 22:30:04 +0100
Cc:     =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Zhoujie Wu <zjwu@marvell.com>, linux-block@vger.kernel.org,
        hongd@marvell.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8A1B32B3-6699-44D4-902F-DA8168852FCB@javigon.com>
References: <1548359553-11356-1-git-send-email-zjwu@marvell.com> <CANr-nt3_8YftCP6Oqgnp39YzeF5qpUCBKLPUZ5=TBqP9MFw25g@mail.gmail.com> <CDB99159-EAC8-410A-A556-E412DB2829A1@javigon.com> <CANr-nt0sA0DH-hjfGKSq+88R7GXypVKmSf+Z+Tgy+duMegVE3Q@mail.gmail.com> <8C200D38-729F-407B-B2F8-48AEA7F0FF08@javigon.com> <CANr-nt1aS1DxfC42bX2DfVg3xo5Kkc_YJOe_CBK9k-NATh3ezQ@mail.gmail.com> <089cd48a-37f0-59e1-ac5f-78dd9cebba05@lightnvm.io> <CANr-nt1BTrJZbGB307tHFqxLDx1QRc99PQTL8YgidGu18Bju-g@mail.gmail.com> <30EEFAA1-11C3-49F0-93CC-76F985FEC226@javigon.com> <CANr-nt1crBDMwTsxR8VhcOMiK8wSdn4cA6jFtgtOLbUpWyit+g@mail.gmail.com>
To:     Hans Holmberg <hans.ml.holmberg@owltronix.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On 25 Jan 2019, at 21.20, Hans Holmberg <hans.ml.holmberg@owltronix.com> w=
rote:
>=20
>> On Fri, Jan 25, 2019 at 7:33 PM Javier Gonz=C3=A1lez <javier@javigon.com>=
 wrote:
>>=20
>>=20
>>=20
>>>> On 25 Jan 2019, at 17.46, Hans Holmberg <hans.ml.holmberg@owltronix.com=
> wrote:
>>>>=20
>>>>> On Fri, Jan 25, 2019 at 3:35 PM Matias Bj=C3=B8rling <mb@lightnvm.io> w=
rote:
>>>>>=20
>>>>>> On 1/25/19 3:21 PM, Hans Holmberg wrote:
>>>>>> On Fri, Jan 25, 2019 at 2:33 PM Javier Gonz=C3=A1lez <javier@javigon.=
com> wrote:
>>>>>>=20
>>>>>>=20
>>>>>>> On 25 Jan 2019, at 13.59, Hans Holmberg <hans.ml.holmberg@owltronix.=
com> wrote:
>>>>>>>=20
>>>>>>> On Fri, Jan 25, 2019 at 10:41 AM Javier Gonz=C3=A1lez <javier@javigo=
n.com> wrote:
>>>>>>>>> On 25 Jan 2019, at 09.47, Hans Holmberg <hans.ml.holmberg@owltroni=
x.com> wrote:
>>>>>>>>>=20
>>>>>>>>> On Thu, Jan 24, 2019 at 8:51 PM Zhoujie Wu <zjwu@marvell.com> wrot=
e:
>>>>>>>>>> The write pointer of the bad block could be 0 or undefined, ignor=
e
>>>>>>>>>> the checking of the bad block wp for pblk_line_wp_is_unbalanced t=
o
>>>>>>>>>> avoid fake warning.
>>>>>>>>>=20
>>>>>>>>> fake -> spurious?
>>>>>>>>>=20
>>>>>>>>>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
>>>>>>>>>> ---
>>>>>>>>>> v3: return in case bit >=3D lm->blk_per_line.
>>>>>>>>>> v2: changed according to Javier's comments.
>>>>>>>>>>=20
>>>>>>>>>> drivers/lightnvm/pblk-recovery.c | 12 +++++++++---
>>>>>>>>>> 1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>>>>>>=20
>>>>>>>>>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/=
pblk-recovery.c
>>>>>>>>>> index 6761d2a..02d466e 100644
>>>>>>>>>> --- a/drivers/lightnvm/pblk-recovery.c
>>>>>>>>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>>>>>>>>> @@ -312,21 +312,27 @@ static int pblk_line_wp_is_unbalanced(struc=
t pblk *pblk,
>>>>>>>>>>      struct nvm_chk_meta *chunk;
>>>>>>>>>>      struct ppa_addr ppa;
>>>>>>>>>>      u64 line_wp;
>>>>>>>>>> -       int pos, i;
>>>>>>>>>> +       int pos, i, bit;
>>>>>>>>>=20
>>>>>>>>> We don't need both bit and i, one of them is enough.
>>>>>>>>>=20
>>>>>>>>>> -       rlun =3D &pblk->luns[0];
>>>>>>>>>> +       bit =3D find_first_zero_bit(line->blk_bitmap, lm->blk_per=
_line);
>>>>>>>>>> +       if (bit >=3D lm->blk_per_line)
>>>>>>>>>> +               return 0;
>>>>>>>>>=20
>>>>>>>>> If there is only one non-offline chunk in the line, the wp can't b=
e unbalanced,
>>>>>>>>> so it should be safe to return 0 here if bit >=3D lm->blk_per_line=
 - 1
>>>>>>>>>=20
>>>>>>>>> If you change this please document why using a comment, as it migh=
t
>>>>>>>>> not be obvious
>>>>>>>>>=20
>>>>>>>>>> +       rlun =3D &pblk->luns[bit];
>>>>>>>>>>      ppa =3D rlun->bppa;
>>>>>>>>>>      pos =3D pblk_ppa_to_pos(geo, ppa);
>>>>>>>>>>      chunk =3D &line->chks[pos];
>>>>>>>>>=20
>>>>>>>>>>      line_wp =3D chunk->wp;
>>>>>>>>>>=20
>>>>>>>>>> -       for (i =3D 1; i < lm->blk_per_line; i++) {
>>>>>>>>>> +       for (i =3D bit + 1; i < lm->blk_per_line; i++) {
>>>>>>>>>=20
>>>>>>>>>>              rlun =3D &pblk->luns[i];
>>>>>>>>>>              ppa =3D rlun->bppa;
>>>>>>>>>>              pos =3D pblk_ppa_to_pos(geo, ppa);
>>>>>>>>>>              chunk =3D &line->chks[pos];
>>>>>>>>>=20
>>>>>>>>> This code is a copy of the code above, it'd be nice to refactor it=

>>>>>>>>> into a helper function or just do the chunk lookups in one place.
>>>>>>>>>=20
>>>>>>>>>> +               if (chunk->state & NVM_CHK_ST_OFFLINE)
>>>>>>>>>> +                       continue;
>>>>>>>>>> +
>>>>>>>>>=20
>>>>>>>>> Since we rely on the block bitmap anyway, we might as well just
>>>>>>>>> iterate over the zeroes in the block bitmap using find_next_zero_b=
it
>>>>>>>>> instead.
>>>>>>>>> We do this in lots of other places, see: git grep -n
>>>>>>>>> find_next_zero_bit -- drivers/lightnvm
>>>>>>>>=20
>>>>>>>> Hans, I proposed him to use the chunk->state instead. I think it is=
 way
>>>>>>>> more robust. We introduced the block bitmap for OCSSD 1.2, because t=
here
>>>>>>>> was no state. Now that we have state, it is better to use it instea=
d. In
>>>>>>>> fact, we should remove the bock bitmap as we have to check for the s=
tate
>>>>>>>> either way - note that this aligns also very well with you patches
>>>>>>>> removing the other bitmaps.
>>>>>>>=20
>>>>>>> These are just nitpicks.
>>>>>>>=20
>>>>>>> Relying on two data structures(chunks, block bitmap) to be in sync i=
n
>>>>>>> this function in stead of one does not make it more robust imho.
>>>>>>> Either or (checking chunks or the block bitmap) is fine by me.
>>>>>>> Searching the bitmap is more efficient, so that is what I proposed.
>>>>>>=20
>>>>>> chunk log page is the ground truth, so it is more robust.
>>>>>>=20
>>>>>> Also, pblk has a long way to start seeing bitmap search vs. integer
>>>>>> comparisons in profiling.
>>>>>=20
>>>>> Hehe, yeah, but it does not hurt to use the better alternative when av=
ailable.
>>>>>=20
>>>>>>>=20
>>>>>>> If we want to remove the block bitmap, we can do that as a separate p=
atch(set)
>>>>>>> I do agree, having two copies of the chunk state is something worth
>>>>>>> getting rid of :)
>>>>>>>=20
>>>>>>=20
>>>>>> A good start is not adding code using what we want to remove.
>>>>>=20
>>>>> Well, I think it's very confusing to use both copies in the same funct=
ion.
>>>>>=20
>>>>> Now we're nitpicking nitpicks :)
>>>>>=20
>>>>=20
>>>> I look forward to a patch. Will one of you volunteer a patch?
>>>=20
>>> Sure! It'd be easier to Illustrate what I mean with a patch.
>>=20
>> Cool. Go ahead - you will see how much cleaner it is using the chunk info=
.
>>=20
>> Matias : In any case Zhoujie=E2=80=99s fix is orthogonal to this discussi=
on and I think you should pick it up - in one form of bb iteration or anothe=
r - as it fixes a real issue.
>=20
> Second that! I feel bad about the fix not making it in just because of
> this squabbling.

No squabbling :) We both care about pblk and want to get the code right.=20

If you give that first pass to that patch, it would be great. We can take it=
 from there.=20

Nos enjoy the weekend!

Javier. =20=
