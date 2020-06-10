Return-Path: <SRS0=qLys=7X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A99C433E1
	for <linux-block@archiver.kernel.org>; Wed, 10 Jun 2020 17:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46982072E
	for <linux-block@archiver.kernel.org>; Wed, 10 Jun 2020 17:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbro13WW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgFJRdu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgFJRdu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jun 2020 13:33:50 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62228C03E96B;
        Wed, 10 Jun 2020 10:33:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so3502402ljh.13;
        Wed, 10 Jun 2020 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PsWz3Kzzab46qx3onkQFKgH83NJFRs0Wzw42VhTXFgQ=;
        b=rbro13WWD8hxWSxH64bIu9g0y+p9UijRN1aCyeHu94o6qRvVVp+f+RgnUS+S4/tmz+
         5qEFC0QaFZlLVS9ihygGymaUpUOwRGJX5noGlZFToJv+Stqvz0T8kMt5a4K23X1cI8qY
         80JREjPMkpL5jQ2Xi25TvD/r60++vJKjsjebxNfdWed/XGSdqUTt8wUygh9hZAfOfh/h
         3IKO8nbIWzpp1uijno1iCHmiZLZleQUwBOPMMf0RpkgXgBvQVoPjoI8OcC0PL3PdYWYc
         frPUQ4AETdzZmSAUO6XP4cof6yFhAHYQC+Pgo634BB9gRv4XAidKPx5+ahKhLD7KNnY9
         ZxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsWz3Kzzab46qx3onkQFKgH83NJFRs0Wzw42VhTXFgQ=;
        b=KhgvfIuB6mJu+47gE5VrrPLUhBrWLG+iBtq3wWVt89BKS5kYvdlSPq2p9WTy/Ix8HC
         lLtf1FiWMwhLCwpugz2xKp0Z1CmHlCWYrV2iP/aSxFP4Vikt0dkwh49DlcDBIqby6Hjz
         +qLEj36ZgGcgvCercPoGGIx5qWEqElL9FywIvaWgYnXKpQqqs/ojp3k8u4pqPe9Tf3AS
         2YJKSDg6s00dz+U+wpuArBDcfQCwYWN6M0+eRq6bQ/D+dSQCYo/a5LoKcBR8P5EaxF6u
         m1KLuwDAQrqnRbxYK2wUG0Vvm28ItoGEYSjIbqKFFOpkxYhRXAgHCYDTe2dK1k29AhUN
         3x0g==
X-Gm-Message-State: AOAM530D7T1m36OVSjs4iHhT06ES+DNYcfCioau+4rN800mxM2Q3q984
        WUdWuiAPlizSqTcXOKj3cZZ5sDE9LB+fb4o1n0b+95SYUdo=
X-Google-Smtp-Source: ABdhPJzGNXDX3o1AcABLRVRmoybCavPSQ9yrAf2np88UTcWSvE/lhONOdQYhxC8zwSobesUTHpqf4WTEOsvu0o15j3o=
X-Received: by 2002:a2e:8e94:: with SMTP id z20mr2114433ljk.21.1591810427683;
 Wed, 10 Jun 2020 10:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <fb0340aaf273be84e915214a3d8bae4ac85d7c0b.camel@ew.tq-group.com> <CAPDyKFq+RiwbDj+58+W5GTcT7=ZOpZFmc02+FxjRGYwbBgA8oQ@mail.gmail.com>
In-Reply-To: <CAPDyKFq+RiwbDj+58+W5GTcT7=ZOpZFmc02+FxjRGYwbBgA8oQ@mail.gmail.com>
From:   Roger Heflin <rogerheflin@gmail.com>
Date:   Wed, 10 Jun 2020 12:33:36 -0500
Message-ID: <CAAMCDef2g8t5u1GuVH7p4bM1C7UMsC=fV4RKGU9jSG1rScPc9g@mail.gmail.com>
Subject: Re: Consistent block device references for root= cmdline
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No idea if this would still work, but back before label/uuid and lvm
in initird I had a staticly linked "C" program that ran inside initrd,
it searched for likely places a boot device could be (mounted them and
looked for a file to confirm it was the right device, then unmounted
it), and when it found the right one, it then echo's is major/minor
numbers into /proc/sys/kernel/real-root-dev and that is used for root=
without it being on the command line.  Assuming you could get
something similar started by sytemd and/or udev inside the initrd it
might still work.

On Wed, Jun 10, 2020 at 11:51 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 10 Jun 2020 at 15:15, Matthias Schiffer
> <matthias.schiffer@ew.tq-group.com> wrote:
> >
> > Hello all,
> >
> > there have been numerous attempts to make the numbering of mmcblk
> > devices consistent, mostly by using aliases from the DTS ([1], [2],
> > [3]), but all have been (rightfully) rejected. Unless I have overlooked
> > a more recent development, no attempts for a different solution were
> > made.
>
> According to aliases attempts, I think those have failed, mainly
> because of two reasons.
>
> 1. Arguments stating that LABELs/UUIDs are variable alternatives. This
> isn't the case, which I think was also concluded from the several
> earlier discussions.
> 2. Patches that tried adding support for mmc aliases, were not
> correctly coded. More precisely, what needs to be addressed is that
> the mmc core also preserves the same ids to be set for the host class
> as the block device, mmc[n] must correspond to mmcblk[n].
>
> >
> > As far as I can tell, the core of the issue seems to be the following:
> >
> > The existing solutions like LABELs and UUIDs are viable alternatives in
> > many cases, but in particular on embedded systems, this is not quite
> > sufficient: In addition to the problem that more knowledge about the
> > system to boot is required in the bootloader, this approach fails
> > completely when the same firmware image exists on multiple devices, for
> > example on an eMMC and an SD card - not an entirely uncommon situation
> > during the development of embedded systems.
> >
> > With udev, I can refer to a specific partition using a path like
> > /dev/disk/by-path/platform-2194000.usdhc-part2. In [4] it was proposed
> > to add a way to refer to a device path/phandle from the kernel command
> > line. Has there been any progress on this proposal?
>
> Lots of time during the years I have been approached, both publicly
> and offlist, about whether it would be possible to add support for
> "consistent" mmcblk devices. To me, I am fine with the aliases
> approach, as long as it gets implemented correctly.
>
> >
> > Kind regards,
> > Matthias
> >
> >
> > [1] https://patchwork.kernel.org/patch/8685711/
> > [2] https://lore.kernel.org/patchwork/cover/674381/
> > [3] https://www.spinics.net/lists/linux-mmc/msg26586.html
> > [4] https://www.spinics.net/lists/linux-mmc/msg26708.html
> >
>
> Kind regards
> Uffe
