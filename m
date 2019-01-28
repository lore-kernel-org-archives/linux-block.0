Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E6AC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639F621738
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 13:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="dS3jTTbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfA1N54 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:57:56 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34808 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbfA1N54 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 08:57:56 -0500
Received: by mail-vs1-f68.google.com with SMTP id y27so9797408vsi.1
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 05:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lu6fO4bATBGsW/cKqd2c2BuhqDDUpWt6p46Kg109vnM=;
        b=dS3jTTbAatld3rHsCcpXqe9RCnEeEZzbZNkCqkPBFh/JwL6/8uibrmzhZrMT0WOHFN
         v4zV8kcFIIxv9OHuU5DGesShib+2h9o+np30s6gc7A0+wgd92MLkG6qHPUF3/iTVv80l
         Y+gUR8w79Ye9tN3OSFx7TxJE5YXPVt5W0A9UjRdnNf4JqCRcNiae/qCkMtz1jkGSu2gi
         SLEFh9SkZYBpEZwJGDgJgc0Hg6UOvYtZ+UmZt1qDmYZ6qjo2jl8+SxO/G/fLDMe9aTDO
         NXLCZQYjbYZj2D7iOgNdugENp9K0/33btzO4pV7qZC5N5vJMIxX8Uip83lZVd8gBmok6
         TjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lu6fO4bATBGsW/cKqd2c2BuhqDDUpWt6p46Kg109vnM=;
        b=SVo7GbY7PUNNDpYb6W93QVizGnGGfliFAnBAZCPLQfnpRYdrAyxR3Kf1OAL4gsN3bO
         dQjhtYGigStFRW7r7fmeOen9xzFGzUdf1KUPMvyCePc8qdNWr7/CxUaaaKZQEdQmy4Oi
         JjZHkCc0YRveu7J3ez2iZCkxT0ld3HOGYTfnx1E9LrhvdMy4MTEb7NeKHfDdxqB3EHO8
         lB0yngGk1NJW4VKoI4mnm/TnryFYEVNcv1uX54/JXGZu7gC2wM6DpOtZRjodtiIHItJ3
         51s3S6wXVWdvc/QaEe1hvrNv2fID/YWSpttAWugGy24NVU1D8ItmeWo+myOW3uGRWqMv
         vLYQ==
X-Gm-Message-State: AJcUuke4SMfEX7Dyhp+vNzAxjPjjL9XhsZMjuR3dsY5HWOoeL6AHUaiS
        ucx/92P9X88FPdiCV3qACxfziWQHluqBIIx2hLme9w==
X-Google-Smtp-Source: ALg8bN6gXncfYLAhkDZ5Xou3g9RG72ctwfpZ/rlqjC8uVRQgux4asmcdAK10r9uhSpgbmcpftDDYmaj87PTcfJ1Rn/o=
X-Received: by 2002:a67:24c6:: with SMTP id k189mr9290276vsk.16.1548683874929;
 Mon, 28 Jan 2019 05:57:54 -0800 (PST)
MIME-Version: 1.0
References: <1548359553-11356-1-git-send-email-zjwu@marvell.com>
 <CANr-nt3_8YftCP6Oqgnp39YzeF5qpUCBKLPUZ5=TBqP9MFw25g@mail.gmail.com>
 <CDB99159-EAC8-410A-A556-E412DB2829A1@javigon.com> <CANr-nt0sA0DH-hjfGKSq+88R7GXypVKmSf+Z+Tgy+duMegVE3Q@mail.gmail.com>
 <8C200D38-729F-407B-B2F8-48AEA7F0FF08@javigon.com> <CANr-nt1aS1DxfC42bX2DfVg3xo5Kkc_YJOe_CBK9k-NATh3ezQ@mail.gmail.com>
 <089cd48a-37f0-59e1-ac5f-78dd9cebba05@lightnvm.io> <CANr-nt1BTrJZbGB307tHFqxLDx1QRc99PQTL8YgidGu18Bju-g@mail.gmail.com>
 <30EEFAA1-11C3-49F0-93CC-76F985FEC226@javigon.com> <CANr-nt1crBDMwTsxR8VhcOMiK8wSdn4cA6jFtgtOLbUpWyit+g@mail.gmail.com>
 <8A1B32B3-6699-44D4-902F-DA8168852FCB@javigon.com>
In-Reply-To: <8A1B32B3-6699-44D4-902F-DA8168852FCB@javigon.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Mon, 28 Jan 2019 14:57:43 +0100
Message-ID: <CANr-nt1pzkUpCS3=fCdozTJ6koxA-k+RJiacUzrSru9y3AE6vQ@mail.gmail.com>
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

Hi again,

while refactoring the code I realized that there is another case we
are not considering:
if the max and min write pointers across all non-bad chunks are off by
more than the write unit, we will not be able to continue writing to
the line.

I'm adding a check of this in my patch.

All the best,
Hans


On Fri, Jan 25, 2019 at 10:30 PM Javier Gonz=C3=A1lez <javier@javigon.com> =
wrote:
>
>
> > On 25 Jan 2019, at 21.20, Hans Holmberg <hans.ml.holmberg@owltronix.com=
> wrote:
> >
> >> On Fri, Jan 25, 2019 at 7:33 PM Javier Gonz=C3=A1lez <javier@javigon.c=
om> wrote:
> >>
> >>
> >>
> >>>> On 25 Jan 2019, at 17.46, Hans Holmberg <hans.ml.holmberg@owltronix.=
com> wrote:
> >>>>
> >>>>> On Fri, Jan 25, 2019 at 3:35 PM Matias Bj=C3=B8rling <mb@lightnvm.i=
o> wrote:
> >>>>>
> >>>>>> On 1/25/19 3:21 PM, Hans Holmberg wrote:
> >>>>>> On Fri, Jan 25, 2019 at 2:33 PM Javier Gonz=C3=A1lez <javier@javig=
on.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>> On 25 Jan 2019, at 13.59, Hans Holmberg <hans.ml.holmberg@owltron=
ix.com> wrote:
> >>>>>>>
> >>>>>>> On Fri, Jan 25, 2019 at 10:41 AM Javier Gonz=C3=A1lez <javier@jav=
igon.com> wrote:
> >>>>>>>>> On 25 Jan 2019, at 09.47, Hans Holmberg <hans.ml.holmberg@owltr=
onix.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On Thu, Jan 24, 2019 at 8:51 PM Zhoujie Wu <zjwu@marvell.com> w=
rote:
> >>>>>>>>>> The write pointer of the bad block could be 0 or undefined, ig=
nore
> >>>>>>>>>> the checking of the bad block wp for pblk_line_wp_is_unbalance=
d to
> >>>>>>>>>> avoid fake warning.
> >>>>>>>>>
> >>>>>>>>> fake -> spurious?
> >>>>>>>>>
> >>>>>>>>>> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
> >>>>>>>>>> ---
> >>>>>>>>>> v3: return in case bit >=3D lm->blk_per_line.
> >>>>>>>>>> v2: changed according to Javier's comments.
> >>>>>>>>>>
> >>>>>>>>>> drivers/lightnvm/pblk-recovery.c | 12 +++++++++---
> >>>>>>>>>> 1 file changed, 9 insertions(+), 3 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightn=
vm/pblk-recovery.c
> >>>>>>>>>> index 6761d2a..02d466e 100644
> >>>>>>>>>> --- a/drivers/lightnvm/pblk-recovery.c
> >>>>>>>>>> +++ b/drivers/lightnvm/pblk-recovery.c
> >>>>>>>>>> @@ -312,21 +312,27 @@ static int pblk_line_wp_is_unbalanced(st=
ruct pblk *pblk,
> >>>>>>>>>>      struct nvm_chk_meta *chunk;
> >>>>>>>>>>      struct ppa_addr ppa;
> >>>>>>>>>>      u64 line_wp;
> >>>>>>>>>> -       int pos, i;
> >>>>>>>>>> +       int pos, i, bit;
> >>>>>>>>>
> >>>>>>>>> We don't need both bit and i, one of them is enough.
> >>>>>>>>>
> >>>>>>>>>> -       rlun =3D &pblk->luns[0];
> >>>>>>>>>> +       bit =3D find_first_zero_bit(line->blk_bitmap, lm->blk_=
per_line);
> >>>>>>>>>> +       if (bit >=3D lm->blk_per_line)
> >>>>>>>>>> +               return 0;
> >>>>>>>>>
> >>>>>>>>> If there is only one non-offline chunk in the line, the wp can'=
t be unbalanced,
> >>>>>>>>> so it should be safe to return 0 here if bit >=3D lm->blk_per_l=
ine - 1
> >>>>>>>>>
> >>>>>>>>> If you change this please document why using a comment, as it m=
ight
> >>>>>>>>> not be obvious
> >>>>>>>>>
> >>>>>>>>>> +       rlun =3D &pblk->luns[bit];
> >>>>>>>>>>      ppa =3D rlun->bppa;
> >>>>>>>>>>      pos =3D pblk_ppa_to_pos(geo, ppa);
> >>>>>>>>>>      chunk =3D &line->chks[pos];
> >>>>>>>>>
> >>>>>>>>>>      line_wp =3D chunk->wp;
> >>>>>>>>>>
> >>>>>>>>>> -       for (i =3D 1; i < lm->blk_per_line; i++) {
> >>>>>>>>>> +       for (i =3D bit + 1; i < lm->blk_per_line; i++) {
> >>>>>>>>>
> >>>>>>>>>>              rlun =3D &pblk->luns[i];
> >>>>>>>>>>              ppa =3D rlun->bppa;
> >>>>>>>>>>              pos =3D pblk_ppa_to_pos(geo, ppa);
> >>>>>>>>>>              chunk =3D &line->chks[pos];
> >>>>>>>>>
> >>>>>>>>> This code is a copy of the code above, it'd be nice to refactor=
 it
> >>>>>>>>> into a helper function or just do the chunk lookups in one plac=
e.
> >>>>>>>>>
> >>>>>>>>>> +               if (chunk->state & NVM_CHK_ST_OFFLINE)
> >>>>>>>>>> +                       continue;
> >>>>>>>>>> +
> >>>>>>>>>
> >>>>>>>>> Since we rely on the block bitmap anyway, we might as well just
> >>>>>>>>> iterate over the zeroes in the block bitmap using find_next_zer=
o_bit
> >>>>>>>>> instead.
> >>>>>>>>> We do this in lots of other places, see: git grep -n
> >>>>>>>>> find_next_zero_bit -- drivers/lightnvm
> >>>>>>>>
> >>>>>>>> Hans, I proposed him to use the chunk->state instead. I think it=
 is way
> >>>>>>>> more robust. We introduced the block bitmap for OCSSD 1.2, becau=
se there
> >>>>>>>> was no state. Now that we have state, it is better to use it ins=
tead. In
> >>>>>>>> fact, we should remove the bock bitmap as we have to check for t=
he state
> >>>>>>>> either way - note that this aligns also very well with you patch=
es
> >>>>>>>> removing the other bitmaps.
> >>>>>>>
> >>>>>>> These are just nitpicks.
> >>>>>>>
> >>>>>>> Relying on two data structures(chunks, block bitmap) to be in syn=
c in
> >>>>>>> this function in stead of one does not make it more robust imho.
> >>>>>>> Either or (checking chunks or the block bitmap) is fine by me.
> >>>>>>> Searching the bitmap is more efficient, so that is what I propose=
d.
> >>>>>>
> >>>>>> chunk log page is the ground truth, so it is more robust.
> >>>>>>
> >>>>>> Also, pblk has a long way to start seeing bitmap search vs. intege=
r
> >>>>>> comparisons in profiling.
> >>>>>
> >>>>> Hehe, yeah, but it does not hurt to use the better alternative when=
 available.
> >>>>>
> >>>>>>>
> >>>>>>> If we want to remove the block bitmap, we can do that as a separa=
te patch(set)
> >>>>>>> I do agree, having two copies of the chunk state is something wor=
th
> >>>>>>> getting rid of :)
> >>>>>>>
> >>>>>>
> >>>>>> A good start is not adding code using what we want to remove.
> >>>>>
> >>>>> Well, I think it's very confusing to use both copies in the same fu=
nction.
> >>>>>
> >>>>> Now we're nitpicking nitpicks :)
> >>>>>
> >>>>
> >>>> I look forward to a patch. Will one of you volunteer a patch?
> >>>
> >>> Sure! It'd be easier to Illustrate what I mean with a patch.
> >>
> >> Cool. Go ahead - you will see how much cleaner it is using the chunk i=
nfo.
> >>
> >> Matias : In any case Zhoujie=E2=80=99s fix is orthogonal to this discu=
ssion and I think you should pick it up - in one form of bb iteration or an=
other - as it fixes a real issue.
> >
> > Second that! I feel bad about the fix not making it in just because of
> > this squabbling.
>
> No squabbling :) We both care about pblk and want to get the code right.
>
> If you give that first pass to that patch, it would be great. We can take=
 it from there.
>
> Nos enjoy the weekend!
>
> Javier.
