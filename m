Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7391C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 20:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817AF218B0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 20:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="HX5sbDKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfAYUUR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:20:17 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:44832 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfAYUUR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 15:20:17 -0500
Received: by mail-ua1-f68.google.com with SMTP id d19so3671193uaq.11
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 12:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TL5pamslAETBC+9vxY0hxmDuBk9n9anDo4gxQKZi7xg=;
        b=HX5sbDKQiIr1YOzaBv86O8LL7O+J21nXS6BzRfuHcQiU/pxpg9E+fG+2my8KFHu4/Y
         fhyBbn/MOgJ3Z4PfG/3dwGg89nSigzTcOmO5VZp4Hx1YTcxN718+/Y8YnqH3OYrUpJNH
         KIuWJWQJUmfGyyvQlb0YnsVanIT4yABSonobilWmhtGmNxO0QYDCcpB5EfswoFcOIjpc
         xPObPGSOsQDAHSj5uNWZpKzZQJeymI8Ro8cgoYqjwX04STR+dcJ++1+lyzZsaTkZ/gtv
         HOyxC+2Hq6NBqAHE4viN3oAzDYSXDX50YEMAkojSlkfXpUw0oKehq0gC9BZhQ4VN4A95
         rCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TL5pamslAETBC+9vxY0hxmDuBk9n9anDo4gxQKZi7xg=;
        b=VSnVa79lYkEkPhF7MHm9zx+DJyuO8G2y6TS6+NuR91UwSx9fas5hu9VtqVSQGPQF2w
         THOcJ1Od5hzmVdBODyHpgkXIlsY1OOD3XbpEh9sxdOJW0um9w8UYN26S0F+p/vvMfu1v
         5bNH+KHb6RFnid7dHtxM1FumJhbHL9aedh513O2NIXNoqI9JMUO3rIFFAzZZzXE1bTnQ
         JKRxrRff7trpKJEX0gtKFTBQ4QEWQ58v75+YIE21bathMeznoOFDhzizk9tQ7/Y+bf4D
         wOFCGLClg3pDrRC2T9kigcIS8TNTSqEzwLaU50k1h8wHKYCNTn4l9hKCw1vvyyHCDI9h
         +3Tg==
X-Gm-Message-State: AJcUukdpUecppcotlLLZKiq9T0v8rYPqZ7SYVEf69BC1/pg9yKef3cKt
        u212+C6SPdRdyZr9IIiJGksKcYvocfzePRgIXA+hCQ==
X-Google-Smtp-Source: ALg8bN60qydMaxFrj7MQnop/oJvEofHeo/7e9jr2xyM2a3d0WqYIVbR2mBVHzeFSTg1EIodVWtDpb2zxHWPU1OahkU4=
X-Received: by 2002:ab0:77c4:: with SMTP id y4mr5320923uar.45.1548447616184;
 Fri, 25 Jan 2019 12:20:16 -0800 (PST)
MIME-Version: 1.0
References: <1548359553-11356-1-git-send-email-zjwu@marvell.com>
 <CANr-nt3_8YftCP6Oqgnp39YzeF5qpUCBKLPUZ5=TBqP9MFw25g@mail.gmail.com>
 <CDB99159-EAC8-410A-A556-E412DB2829A1@javigon.com> <CANr-nt0sA0DH-hjfGKSq+88R7GXypVKmSf+Z+Tgy+duMegVE3Q@mail.gmail.com>
 <8C200D38-729F-407B-B2F8-48AEA7F0FF08@javigon.com> <CANr-nt1aS1DxfC42bX2DfVg3xo5Kkc_YJOe_CBK9k-NATh3ezQ@mail.gmail.com>
 <089cd48a-37f0-59e1-ac5f-78dd9cebba05@lightnvm.io> <CANr-nt1BTrJZbGB307tHFqxLDx1QRc99PQTL8YgidGu18Bju-g@mail.gmail.com>
 <30EEFAA1-11C3-49F0-93CC-76F985FEC226@javigon.com>
In-Reply-To: <30EEFAA1-11C3-49F0-93CC-76F985FEC226@javigon.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Fri, 25 Jan 2019 21:20:05 +0100
Message-ID: <CANr-nt1crBDMwTsxR8VhcOMiK8wSdn4cA6jFtgtOLbUpWyit+g@mail.gmail.com>
Subject: Re: [PATCH v3] lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        Zhoujie Wu <zjwu@marvell.com>, linux-block@vger.kernel.org,
        hongd@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 25, 2019 at 7:33 PM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
>
>
>
> > On 25 Jan 2019, at 17.46, Hans Holmberg <hans.ml.holmberg@owltronix.com=
> wrote:
> >
> >> On Fri, Jan 25, 2019 at 3:35 PM Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
> >>
> >>> On 1/25/19 3:21 PM, Hans Holmberg wrote:
> >>>> On Fri, Jan 25, 2019 at 2:33 PM Javier Gonz=C3=A1lez <javier@javigon=
.com> wrote:
> >>>>
> >>>>
> >>>>> On 25 Jan 2019, at 13.59, Hans Holmberg <hans.ml.holmberg@owltronix=
.com> wrote:
> >>>>>
> >>>>> On Fri, Jan 25, 2019 at 10:41 AM Javier Gonz=C3=A1lez <javier@javig=
on.com> wrote:
> >>>>>>> On 25 Jan 2019, at 09.47, Hans Holmberg <hans.ml.holmberg@owltron=
ix.com> wrote:
> >>>>>>>
> >>>>>>> On Thu, Jan 24, 2019 at 8:51 PM Zhoujie Wu <zjwu@marvell.com> wro=
te:
> >>>>>>>> The write pointer of the bad block could be 0 or undefined, igno=
re
> >>>>>>>> the checking of the bad block wp for pblk_line_wp_is_unbalanced =
to
> >>>>>>>> avoid fake warning.
> >>>>>>>
> >>>>>>> fake -> spurious?
> >>>>>>>
> >>>>>>>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> >>>>>>>> ---
> >>>>>>>> v3: return in case bit >=3D lm->blk_per_line.
> >>>>>>>> v2: changed according to Javier's comments.
> >>>>>>>>
> >>>>>>>> drivers/lightnvm/pblk-recovery.c | 12 +++++++++---
> >>>>>>>> 1 file changed, 9 insertions(+), 3 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm=
/pblk-recovery.c
> >>>>>>>> index 6761d2a..02d466e 100644
> >>>>>>>> --- a/drivers/lightnvm/pblk-recovery.c
> >>>>>>>> +++ b/drivers/lightnvm/pblk-recovery.c
> >>>>>>>> @@ -312,21 +312,27 @@ static int pblk_line_wp_is_unbalanced(stru=
ct pblk *pblk,
> >>>>>>>>       struct nvm_chk_meta *chunk;
> >>>>>>>>       struct ppa_addr ppa;
> >>>>>>>>       u64 line_wp;
> >>>>>>>> -       int pos, i;
> >>>>>>>> +       int pos, i, bit;
> >>>>>>>
> >>>>>>> We don't need both bit and i, one of them is enough.
> >>>>>>>
> >>>>>>>> -       rlun =3D &pblk->luns[0];
> >>>>>>>> +       bit =3D find_first_zero_bit(line->blk_bitmap, lm->blk_pe=
r_line);
> >>>>>>>> +       if (bit >=3D lm->blk_per_line)
> >>>>>>>> +               return 0;
> >>>>>>>
> >>>>>>> If there is only one non-offline chunk in the line, the wp can't =
be unbalanced,
> >>>>>>> so it should be safe to return 0 here if bit >=3D lm->blk_per_lin=
e - 1
> >>>>>>>
> >>>>>>> If you change this please document why using a comment, as it mig=
ht
> >>>>>>> not be obvious
> >>>>>>>
> >>>>>>>> +       rlun =3D &pblk->luns[bit];
> >>>>>>>>       ppa =3D rlun->bppa;
> >>>>>>>>       pos =3D pblk_ppa_to_pos(geo, ppa);
> >>>>>>>>       chunk =3D &line->chks[pos];
> >>>>>>>
> >>>>>>>>       line_wp =3D chunk->wp;
> >>>>>>>>
> >>>>>>>> -       for (i =3D 1; i < lm->blk_per_line; i++) {
> >>>>>>>> +       for (i =3D bit + 1; i < lm->blk_per_line; i++) {
> >>>>>>>
> >>>>>>>>               rlun =3D &pblk->luns[i];
> >>>>>>>>               ppa =3D rlun->bppa;
> >>>>>>>>               pos =3D pblk_ppa_to_pos(geo, ppa);
> >>>>>>>>               chunk =3D &line->chks[pos];
> >>>>>>>
> >>>>>>> This code is a copy of the code above, it'd be nice to refactor i=
t
> >>>>>>> into a helper function or just do the chunk lookups in one place.
> >>>>>>>
> >>>>>>>> +               if (chunk->state & NVM_CHK_ST_OFFLINE)
> >>>>>>>> +                       continue;
> >>>>>>>> +
> >>>>>>>
> >>>>>>> Since we rely on the block bitmap anyway, we might as well just
> >>>>>>> iterate over the zeroes in the block bitmap using find_next_zero_=
bit
> >>>>>>> instead.
> >>>>>>> We do this in lots of other places, see: git grep -n
> >>>>>>> find_next_zero_bit -- drivers/lightnvm
> >>>>>>
> >>>>>> Hans, I proposed him to use the chunk->state instead. I think it i=
s way
> >>>>>> more robust. We introduced the block bitmap for OCSSD 1.2, because=
 there
> >>>>>> was no state. Now that we have state, it is better to use it inste=
ad. In
> >>>>>> fact, we should remove the bock bitmap as we have to check for the=
 state
> >>>>>> either way - note that this aligns also very well with you patches
> >>>>>> removing the other bitmaps.
> >>>>>
> >>>>> These are just nitpicks.
> >>>>>
> >>>>> Relying on two data structures(chunks, block bitmap) to be in sync =
in
> >>>>> this function in stead of one does not make it more robust imho.
> >>>>> Either or (checking chunks or the block bitmap) is fine by me.
> >>>>> Searching the bitmap is more efficient, so that is what I proposed.
> >>>>
> >>>> chunk log page is the ground truth, so it is more robust.
> >>>>
> >>>> Also, pblk has a long way to start seeing bitmap search vs. integer
> >>>> comparisons in profiling.
> >>>
> >>> Hehe, yeah, but it does not hurt to use the better alternative when a=
vailable.
> >>>
> >>>>>
> >>>>> If we want to remove the block bitmap, we can do that as a separate=
 patch(set)
> >>>>> I do agree, having two copies of the chunk state is something worth
> >>>>> getting rid of :)
> >>>>>
> >>>>
> >>>> A good start is not adding code using what we want to remove.
> >>>
> >>> Well, I think it's very confusing to use both copies in the same func=
tion.
> >>>
> >>> Now we're nitpicking nitpicks :)
> >>>
> >>
> >> I look forward to a patch. Will one of you volunteer a patch?
> >
> > Sure! It'd be easier to Illustrate what I mean with a patch.
>
> Cool. Go ahead - you will see how much cleaner it is using the chunk info=
.
>
> Matias : In any case Zhoujie=E2=80=99s fix is orthogonal to this discussi=
on and I think you should pick it up - in one form of bb iteration or anoth=
er - as it fixes a real issue.

Second that! I feel bad about the fix not making it in just because of
this squabbling.

> Javier.
