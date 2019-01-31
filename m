Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F855C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 20:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA13218F0
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 20:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="RdtnElps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfAaUKk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:10:40 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:32974 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfAaUKk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 15:10:40 -0500
Received: by mail-ua1-f65.google.com with SMTP id t8so1505086uap.0
        for <linux-block@vger.kernel.org>; Thu, 31 Jan 2019 12:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aOGJwv3IorkEUNZYPde5gjPu7QMUgO0IOMwLaxZlq94=;
        b=RdtnElpsGWeN4U2czem3PoUU9WhCaOaFtOcu5+eYmu5+RXUW5636Tn1+rouXDSwmkQ
         5vBHiRB7XMENuA7EXUG3jJiYWmPk6YAxx5V4jtTXvjOTthxQ+SjmdonlSnPOLGBWQ3wr
         nfvFYJn46DsAh5LbeLhZz1qInOpVLieVz9ADJHPXwZo8cX1fjzjara7TRZpGQyaso6YW
         ALAjJP/PeQyK3oDrvF3p2zFEuuuD2fcw/LiAkoUdLVJ4al4PNIXrj5I2hGyS1z4rEY/i
         qW+eGCfy0nbnSyLSrLVKXaY0YZoGQS113TRQo4FubiiZsuvlaFk0rFhWqOCcMC+kqXrt
         7YCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aOGJwv3IorkEUNZYPde5gjPu7QMUgO0IOMwLaxZlq94=;
        b=MLR5Cp39OF9GTpz2nFqMFUpx5hHbIKqRBq8YSzo6KkLAsCNo0pFMPaP/EAAy1AFXf3
         IgoqWe5rKaX7iNiwhNYuu344FtaRegAIWcKLsQDsJhyfHqTa8DOy4K947JVYfz8dt4jA
         76cCGdmoNajvraGndI2sFB5ah1GItY5UEEIyiIYUNoBh6K+auHorltNuqA2EFjtYRCJo
         wYfJuFkr30corsvoEB5L7FMZigMJXOv5wlDUmBWvRfFkP8BAka7uOxhmql/5hZRPOYsv
         AOqMTVSAUMKPOe9utyBIdSPdNVm9LWPNHwnCUzCTxQOdLi/rP1zmKGwMoSk2stvIUlHw
         4JGA==
X-Gm-Message-State: AJcUukeg1/HdmEE/DmoBk5ZSRoIucKmfZf8o9GLEe828zAnst6OZL1Kr
        +AMQ2ZhPY1/zeMKKTOFuHT8rrj+u8RIs1lTrSmRQPQ==
X-Google-Smtp-Source: ALg8bN69b4UwAlb43biFl8Lc9GfXU53LPdzDDvNPQz98Uft74tSS7e1ykpp7Okub/Sz70+V1MpQbRrAw3lAKWT2c3Vw=
X-Received: by 2002:ab0:49ee:: with SMTP id f43mr14140388uad.29.1548965438680;
 Thu, 31 Jan 2019 12:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20190130102604.14496-1-javier@javigon.com> <CANr-nt27moc9eLMgXkoXQGR7GA=uRpg2u+v7aJxzNB_AGbw5hQ@mail.gmail.com>
 <E4DF0FFC-5A45-405D-A942-DD8572CC1BD1@javigon.com>
In-Reply-To: <E4DF0FFC-5A45-405D-A942-DD8572CC1BD1@javigon.com>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Thu, 31 Jan 2019 21:10:27 +0100
Message-ID: <CANr-nt0FWrzsCmv=X8oqCSOBYTO7nZi5gtKJN13setFQ8MFjRg@mail.gmail.com>
Subject: Re: [PATCH V2] lightnvm: pblk: prevent stall due to wb threshold
To:     =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Cc:     Matias Bjorling <mb@lightnvm.io>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 31, 2019 at 5:33 PM Javier Gonz=C3=A1lez <javier@javigon.com> w=
rote:
>
>
>
> > On 31 Jan 2019, at 11.41, Hans Holmberg <hans@owltronix.com> wrote:
> >
> > Hi Javier!
> >
> > How did you test this? I'm trying to add a test case to our testing fra=
mework.
> >
> > This is what i ran in qemu, and I got a hang (with this version of the =
patch)
> >
> > nvme lnvm create -d nvme0n1 -t pblk -n pblk0 -f -b 0 -e 0
>
> I run several low configurations without problem. Can you share the qemu =
configuration and version?
>

Of course!

qemu remote: https://github.com/CNEX-Labs/qemu-nvme.git
branch: master (cb200e3ccf9c1ff21f6275c6cb68b2801135a640)

My geometry:
parallel units: 8, secs per chk: 768, meta size 16, ws min 12, ws opt
24, cunits=3D0

> I=E2=80=99m on travel until Friday - I=E2=80=99ll come back to you over t=
he weekend.

Oh, no worries. This patch did not introduce the issue, so it's not a
regression, but it looks like the same type of hang as the patch
addresses.
I might have stumbled across another bug.

One thing I noticed was that the dd write block size that triggered
the hang is >=3D write buffer. (128 entries * 4k)

Safe travels!

>
> >
> > kernel log: [  116.381799] pblk pblk0: luns:1, lines:280, secs:212736,
> > buf entries:128
> >
> > # dd if=3D/dev/zero of=3D/dev/pblk0 oflag=3Ddirect bs=3D4k count=3D1
> > 1+0 records in
> > 1+0 records out
> > 4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000480941 s, 8.5 MB/s
> > # dd if=3D/dev/zero of=3D/dev/pblk0 oflag=3Ddirect bs=3D64k count=3D1
> > 1+0 records in
> > 1+0 records out
> > 65536 bytes (66 kB, 64 KiB) copied, 0.000477373 s, 137 MB/s
> > # dd if=3D/dev/zero of=3D/dev/pblk0 oflag=3Ddirect bs=3D128k count=3D1
> > 1+0 records in
> > 1+0 records out
> > 131072 bytes (131 kB, 128 KiB) copied, 0.000548722 s, 239 MB/s
> > # dd if=3D/dev/zero of=3D/dev/pblk0 oflag=3Ddirect bs=3D256k count=3D1
> > 1+0 records in
> > 1+0 records out
> > 262144 bytes (262 kB, 256 KiB) copied, 0.000718515 s, 365 MB/s
> > # dd if=3D/dev/zero of=3D/dev/pblk0 oflag=3Ddirect bs=3D512k count=3D1
> > <HANG>
>
>
> >
> >
> >> On Wed, Jan 30, 2019 at 11:28 AM Javier Gonz=C3=A1lez <javier@javigon.=
com> wrote:
> >>
> >> In order to respect mw_cuinits, pblk's write buffer maintains a
> >> backpointer to protect data not yet persisted; when writing to the wri=
te
> >> buffer, this backpointer defines a threshold that pblk's rate-limiter
> >> enforces.
> >>
> >> On small PU configurations, the following scenarios might take place: =
(i)
> >> the threshold is larger than the write buffer and (ii) the threshold i=
s
> >> smaller than the write buffer, but larger than the maximun allowed
> >> split bio - 256KB at this moment (Note that writes are not always
> >> split - we only do this when we the size of the buffer is smaller
> >> than the buffer). In both cases, pblk's rate-limiter prevents the I/O =
to
> >> be written to the buffer, thus stalling.
> >>
> >> This patch fixes the original backpointer implementation by considerin=
g
> >> the threshold both on buffer creation and on the rate-limiters path,
> >> when bio_split is triggered (case (ii) above).
> >>
> >> Fixes: 766c8ceb16fc ("lightnvm: pblk: guarantee that backpointer is re=
spected on writer stall")
> >> Signed-off-by: Javier Gonz=C3=A1lez <javier@javigon.com>
> >> ---
> >>
> >>  Changes since V1:
> >>    - Fix a bad arithmetinc on the rate-limiter max_io calculation (fro=
m
> >>      Hans)
> >>
> >> drivers/lightnvm/pblk-rb.c | 25 +++++++++++++++++++------
> >> drivers/lightnvm/pblk-rl.c |  5 ++---
> >> drivers/lightnvm/pblk.h    |  2 +-
> >> 3 files changed, 22 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> >> index d4ca8c64ee0f..a6133b50ed9c 100644
> >> --- a/drivers/lightnvm/pblk-rb.c
> >> +++ b/drivers/lightnvm/pblk-rb.c
> >> @@ -45,10 +45,23 @@ void pblk_rb_free(struct pblk_rb *rb)
> >> /*
> >>  * pblk_rb_calculate_size -- calculate the size of the write buffer
> >>  */
> >> -static unsigned int pblk_rb_calculate_size(unsigned int nr_entries)
> >> +static unsigned int pblk_rb_calculate_size(unsigned int nr_entries,
> >> +                                          unsigned int threshold)
> >> {
> >> -       /* Alloc a write buffer that can at least fit 128 entries */
> >> -       return (1 << max(get_count_order(nr_entries), 7));
> >> +       unsigned int thr_sz =3D 1 << (get_count_order(threshold + NVM_=
MAX_VLBA));
> >> +       unsigned int max_sz =3D max(thr_sz, nr_entries);
> >> +       unsigned int max_io;
> >> +
> >> +       /* Alloc a write buffer that can (i) fit at least two split bi=
os
> >> +        * (considering max I/O size NVM_MAX_VLBA, and (ii) guarantee =
that the
> >> +        * threshold will be respected
> >> +        */
> >> +       max_io =3D (1 << max((int)(get_count_order(max_sz)),
> >> +                               (int)(get_count_order(NVM_MAX_VLBA << =
1))));
> >> +       if ((threshold + NVM_MAX_VLBA) >=3D max_io)
> >> +               max_io <<=3D 1;
> >> +
> >> +       return max_io;
> >> }
> >>
> >> /*
> >> @@ -67,12 +80,12 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int =
size, unsigned int threshold,
> >>        unsigned int alloc_order, order, iter;
> >>        unsigned int nr_entries;
> >>
> >> -       nr_entries =3D pblk_rb_calculate_size(size);
> >> +       nr_entries =3D pblk_rb_calculate_size(size, threshold);
> >>        entries =3D vzalloc(array_size(nr_entries, sizeof(struct pblk_r=
b_entry)));
> >>        if (!entries)
> >>                return -ENOMEM;
> >>
> >> -       power_size =3D get_count_order(size);
> >> +       power_size =3D get_count_order(nr_entries);
> >>        power_seg_sz =3D get_count_order(seg_size);
> >>
> >>        down_write(&pblk_rb_lock);
> >> @@ -149,7 +162,7 @@ int pblk_rb_init(struct pblk_rb *rb, unsigned int =
size, unsigned int threshold,
> >>         * Initialize rate-limiter, which controls access to the write =
buffer
> >>         * by user and GC I/O
> >>         */
> >> -       pblk_rl_init(&pblk->rl, rb->nr_entries);
> >> +       pblk_rl_init(&pblk->rl, rb->nr_entries, threshold);
> >>
> >>        return 0;
> >> }
> >> diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
> >> index 76116d5f78e4..e9e0af0df165 100644
> >> --- a/drivers/lightnvm/pblk-rl.c
> >> +++ b/drivers/lightnvm/pblk-rl.c
> >> @@ -207,7 +207,7 @@ void pblk_rl_free(struct pblk_rl *rl)
> >>        del_timer(&rl->u_timer);
> >> }
> >>
> >> -void pblk_rl_init(struct pblk_rl *rl, int budget)
> >> +void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold)
> >> {
> >>        struct pblk *pblk =3D container_of(rl, struct pblk, rl);
> >>        struct nvm_tgt_dev *dev =3D pblk->dev;
> >> @@ -217,7 +217,6 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
> >>        int sec_meta, blk_meta;
> >>        unsigned int rb_windows;
> >>
> >> -
> >>        /* Consider sectors used for metadata */
> >>        sec_meta =3D (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free=
_lines;
> >>        blk_meta =3D DIV_ROUND_UP(sec_meta, geo->clba);
> >> @@ -234,7 +233,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
> >>        /* To start with, all buffer is available to user I/O writers *=
/
> >>        rl->rb_budget =3D budget;
> >>        rl->rb_user_max =3D budget;
> >> -       rl->rb_max_io =3D budget >> 1;
> >> +       rl->rb_max_io =3D budget - threshold;
> >>        rl->rb_gc_max =3D 0;
> >>        rl->rb_state =3D PBLK_RL_HIGH;
> >>
> >> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> >> index 72ae8755764e..a6386d5acd73 100644
> >> --- a/drivers/lightnvm/pblk.h
> >> +++ b/drivers/lightnvm/pblk.h
> >> @@ -924,7 +924,7 @@ int pblk_gc_sysfs_force(struct pblk *pblk, int for=
ce);
> >> /*
> >>  * pblk rate limiter
> >>  */
> >> -void pblk_rl_init(struct pblk_rl *rl, int budget);
> >> +void pblk_rl_init(struct pblk_rl *rl, int budget, int threshold);
> >> void pblk_rl_free(struct pblk_rl *rl);
> >> void pblk_rl_update_rates(struct pblk_rl *rl);
> >> int pblk_rl_high_thrs(struct pblk_rl *rl);
> >> --
> >> 2.17.1
> >>
