Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122E2C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 16:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5FD218DE
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 16:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="DwU7ZRzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfAYQrL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:47:11 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37811 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfAYQrK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 11:47:10 -0500
Received: by mail-vk1-f196.google.com with SMTP id 197so2270889vkf.4
        for <linux-block@vger.kernel.org>; Fri, 25 Jan 2019 08:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HDQYxvCGxCoS3mMMAWo0vZC88Y0/bUwNu1M/umTwRmQ=;
        b=DwU7ZRzcu4SO1wsgayzewUc5Kkg5UuXp7tGc4HqPtwU/7D93VOFsGJesZYXmqlyErI
         ymmxD09JB3VocJPEEQoqjpT/jVdW0zzmeYvgXb1W+IxxFDQLqzifw6MrPcyqevSabGv/
         4JtE5z3MoJ4CwGqrieKn6FiO4C9cLOJ/c4RN1rcS6LDrInSRA1Tuja5h4oxpRr6mHu1S
         Vzvog67Wr5XaoQRai7G+9JL/aVkKjN09zF1r0RJpY4Nn5P1zJOUXmaHlKQdGKLBRkWD3
         Ro5u/+cjHGPK6+y8H9yFhJwLDuXw6kiPoaeb6RlOltDGNPOZuYx3SC3f2NCP2bcwKg97
         iIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HDQYxvCGxCoS3mMMAWo0vZC88Y0/bUwNu1M/umTwRmQ=;
        b=QLnXUq3T0mszp2WrI4ArUEDBWpyAEF6o3vdvTHQDuvhrqHuGqoPOp5/P9y7hIrXLuM
         W9NDVaN9dNtPnpVlal8JVbMfayoL+eDGZ6HwQhDDzqUo9VA8quKFSS8qnk7hD3bKDXzt
         nv+R7kq7b2nbbcT+4v/4suLUWiZYy/I7TMIM9alJa2Vsbyuuz+DOuy0IoDW273bkL9gm
         BkP6/BMy01z5UB4hx4I5usMRAFgijWuTQCqlBtpA65Tr6L5qOgoZH+1/BDMfBQRj95k6
         ZdqpTArSoTpIPf/cBfg7CrJ8nhNSwdijUasQWK/5GvisJ55kgfPb7ix6pklpTFLNl6o1
         jLWA==
X-Gm-Message-State: AJcUukdph9UVdiLrBdmVvHn+MO+KzPKh945zvU/ZT9mQvXOgkSlxjUZU
        SrQ81gMyxpy+tOP8tIPLqgOMwheCpDhNRqEXrWKzJA==
X-Google-Smtp-Source: ALg8bN6GYPgKBqNeHoZ4RkcYgf20/Eeryrx/KSlpu44sFAhlnaqWcznugNrEyLuOEC5/KzmnZyIWclpWDmMJs1pDAqs=
X-Received: by 2002:a1f:8b48:: with SMTP id n69mr4620078vkd.12.1548434829364;
 Fri, 25 Jan 2019 08:47:09 -0800 (PST)
MIME-Version: 1.0
References: <1548359553-11356-1-git-send-email-zjwu@marvell.com>
 <CANr-nt3_8YftCP6Oqgnp39YzeF5qpUCBKLPUZ5=TBqP9MFw25g@mail.gmail.com>
 <CDB99159-EAC8-410A-A556-E412DB2829A1@javigon.com> <CANr-nt0sA0DH-hjfGKSq+88R7GXypVKmSf+Z+Tgy+duMegVE3Q@mail.gmail.com>
 <8C200D38-729F-407B-B2F8-48AEA7F0FF08@javigon.com> <CANr-nt1aS1DxfC42bX2DfVg3xo5Kkc_YJOe_CBK9k-NATh3ezQ@mail.gmail.com>
 <089cd48a-37f0-59e1-ac5f-78dd9cebba05@lightnvm.io>
In-Reply-To: <089cd48a-37f0-59e1-ac5f-78dd9cebba05@lightnvm.io>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Fri, 25 Jan 2019 17:46:58 +0100
Message-ID: <CANr-nt1BTrJZbGB307tHFqxLDx1QRc99PQTL8YgidGu18Bju-g@mail.gmail.com>
Subject: Re: [PATCH v3] lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced
To:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Zhoujie Wu <zjwu@marvell.com>, linux-block@vger.kernel.org,
        hongd@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 25, 2019 at 3:35 PM Matias Bj=C3=B8rling <mb@lightnvm.io> wrote=
:
>
> On 1/25/19 3:21 PM, Hans Holmberg wrote:
> > On Fri, Jan 25, 2019 at 2:33 PM Javier Gonz=C3=A1lez <javier@javigon.co=
m> wrote:
> >>
> >>
> >>> On 25 Jan 2019, at 13.59, Hans Holmberg <hans.ml.holmberg@owltronix.c=
om> wrote:
> >>>
> >>> On Fri, Jan 25, 2019 at 10:41 AM Javier Gonz=C3=A1lez <javier@javigon=
.com> wrote:
> >>>>> On 25 Jan 2019, at 09.47, Hans Holmberg <hans.ml.holmberg@owltronix=
.com> wrote:
> >>>>>
> >>>>> On Thu, Jan 24, 2019 at 8:51 PM Zhoujie Wu <zjwu@marvell.com> wrote=
:
> >>>>>> The write pointer of the bad block could be 0 or undefined, ignore
> >>>>>> the checking of the bad block wp for pblk_line_wp_is_unbalanced to
> >>>>>> avoid fake warning.
> >>>>>
> >>>>> fake -> spurious?
> >>>>>
> >>>>>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> >>>>>> ---
> >>>>>> v3: return in case bit >=3D lm->blk_per_line.
> >>>>>> v2: changed according to Javier's comments.
> >>>>>>
> >>>>>> drivers/lightnvm/pblk-recovery.c | 12 +++++++++---
> >>>>>> 1 file changed, 9 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/p=
blk-recovery.c
> >>>>>> index 6761d2a..02d466e 100644
> >>>>>> --- a/drivers/lightnvm/pblk-recovery.c
> >>>>>> +++ b/drivers/lightnvm/pblk-recovery.c
> >>>>>> @@ -312,21 +312,27 @@ static int pblk_line_wp_is_unbalanced(struct=
 pblk *pblk,
> >>>>>>        struct nvm_chk_meta *chunk;
> >>>>>>        struct ppa_addr ppa;
> >>>>>>        u64 line_wp;
> >>>>>> -       int pos, i;
> >>>>>> +       int pos, i, bit;
> >>>>>
> >>>>> We don't need both bit and i, one of them is enough.
> >>>>>
> >>>>>> -       rlun =3D &pblk->luns[0];
> >>>>>> +       bit =3D find_first_zero_bit(line->blk_bitmap, lm->blk_per_=
line);
> >>>>>> +       if (bit >=3D lm->blk_per_line)
> >>>>>> +               return 0;
> >>>>>
> >>>>> If there is only one non-offline chunk in the line, the wp can't be=
 unbalanced,
> >>>>> so it should be safe to return 0 here if bit >=3D lm->blk_per_line =
- 1
> >>>>>
> >>>>> If you change this please document why using a comment, as it might
> >>>>> not be obvious
> >>>>>
> >>>>>> +       rlun =3D &pblk->luns[bit];
> >>>>>>        ppa =3D rlun->bppa;
> >>>>>>        pos =3D pblk_ppa_to_pos(geo, ppa);
> >>>>>>        chunk =3D &line->chks[pos];
> >>>>>
> >>>>>>        line_wp =3D chunk->wp;
> >>>>>>
> >>>>>> -       for (i =3D 1; i < lm->blk_per_line; i++) {
> >>>>>> +       for (i =3D bit + 1; i < lm->blk_per_line; i++) {
> >>>>>
> >>>>>>                rlun =3D &pblk->luns[i];
> >>>>>>                ppa =3D rlun->bppa;
> >>>>>>                pos =3D pblk_ppa_to_pos(geo, ppa);
> >>>>>>                chunk =3D &line->chks[pos];
> >>>>>
> >>>>> This code is a copy of the code above, it'd be nice to refactor it
> >>>>> into a helper function or just do the chunk lookups in one place.
> >>>>>
> >>>>>> +               if (chunk->state & NVM_CHK_ST_OFFLINE)
> >>>>>> +                       continue;
> >>>>>> +
> >>>>>
> >>>>> Since we rely on the block bitmap anyway, we might as well just
> >>>>> iterate over the zeroes in the block bitmap using find_next_zero_bi=
t
> >>>>> instead.
> >>>>> We do this in lots of other places, see: git grep -n
> >>>>> find_next_zero_bit -- drivers/lightnvm
> >>>>
> >>>> Hans, I proposed him to use the chunk->state instead. I think it is =
way
> >>>> more robust. We introduced the block bitmap for OCSSD 1.2, because t=
here
> >>>> was no state. Now that we have state, it is better to use it instead=
. In
> >>>> fact, we should remove the bock bitmap as we have to check for the s=
tate
> >>>> either way - note that this aligns also very well with you patches
> >>>> removing the other bitmaps.
> >>>
> >>> These are just nitpicks.
> >>>
> >>> Relying on two data structures(chunks, block bitmap) to be in sync in
> >>> this function in stead of one does not make it more robust imho.
> >>> Either or (checking chunks or the block bitmap) is fine by me.
> >>> Searching the bitmap is more efficient, so that is what I proposed.
> >>
> >> chunk log page is the ground truth, so it is more robust.
> >>
> >> Also, pblk has a long way to start seeing bitmap search vs. integer
> >> comparisons in profiling.
> >
> > Hehe, yeah, but it does not hurt to use the better alternative when ava=
ilable.
> >
> >>>
> >>> If we want to remove the block bitmap, we can do that as a separate p=
atch(set)
> >>> I do agree, having two copies of the chunk state is something worth
> >>> getting rid of :)
> >>>
> >>
> >> A good start is not adding code using what we want to remove.
> >
> > Well, I think it's very confusing to use both copies in the same functi=
on.
> >
> > Now we're nitpicking nitpicks :)
> >
>
> I look forward to a patch. Will one of you volunteer a patch?

Sure! It'd be easier to Illustrate what I mean with a patch.
