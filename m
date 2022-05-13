Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBB9C433EF
	for <linux-block@archiver.kernel.org>; Fri, 13 May 2022 02:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376612AbiEMC4n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 May 2022 22:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376610AbiEMC4f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 May 2022 22:56:35 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B36E24969
        for <linux-block@vger.kernel.org>; Thu, 12 May 2022 19:56:33 -0700 (PDT)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 11E5C3F1EC
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 02:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1652410591;
        bh=rF63nrgHe2cIWk7sqY1Jv0XZG3knafOJHCDaTqNMlvM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=U7KowGIG4s7z5FG0WOqTY/eK9wmuEnpsB2PFxDxPPyr4e1M1zHDP8JSrCwLUBaCYP
         j5on83bV4UEsnsf1EbLFjQU6SdJeWrLPidvoyCYeLbJ7hGJl7kYUDhuFwvgC2GKqIT
         eUs5UEle2gslIGlADDUVXA3zidIc4eXk0qF+oehgS2WdSPLwroyY7nMYoP1pu/FWOF
         xsEtWAYZUZ5mAMnzDVwyLU5kKi5UiqNrQTzj188ZiGLJn0TeAJ5mxjjyIh9JxdTSX9
         d7CzkUGB6irM976tohb6FQl2YuU+DDx5areRZ56ElOrVMjb/PCJv6f/WzWHiQ9KYXI
         R/tK/GNLgXWhA==
Received: by mail-pj1-f71.google.com with SMTP id o16-20020a17090ab89000b001d84104fc2cso3312300pjr.1
        for <linux-block@vger.kernel.org>; Thu, 12 May 2022 19:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rF63nrgHe2cIWk7sqY1Jv0XZG3knafOJHCDaTqNMlvM=;
        b=EXPPFk9TEJHY3FA47HB8y56i7JgpY4Xnge/si1RMBThgOyJ5VBWj04Z6as1Adbi/Gb
         Jh81xYoVomsiP2ss/INawqS5UsiRar30pSKkOcj3aFAGQcVtIg5j2w7x4Mjq80Mv+b68
         uFwFFHyYTN7eIacI4E6mg/fh4Ei68HTGC/GVb2atZFofaWqDM0DAC65SYQ7aaAxfmRl5
         ZGujKFCB+LJMziwSsFC5+imKIVv9ybrEYsw1fKePChdJ2d16wOTi4e7HtgjMEiJNhyXM
         j+mV/j3rRPxmWCtTZaDS6HSjc/TIkgbUGhVk43RkSwUvRJ4GPkTQzqNP1/OVuSQHQtKg
         J1eQ==
X-Gm-Message-State: AOAM5336fMlkKvYByfBlIbPEJWwSHOEo0++lx32gEeS5QaLt3WoOAi8U
        dHh7cCUY9Db9Ckmbp0Wllb9+6YZh8uBpeaG1u9lsNrHAlm6KswIUAeJ6na8on32/cV5FakeglMq
        8S1HpcrXA6/XPXNqiKryDSjkYU5qH5IPrQDRQeT1VOpZ0dn0c7cIIxzzk
X-Received: by 2002:a05:6a00:14ce:b0:50f:ac00:2a8b with SMTP id w14-20020a056a0014ce00b0050fac002a8bmr2515925pfu.36.1652410589569;
        Thu, 12 May 2022 19:56:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzF07aqxQuyHQBnn1dyRbK0T+OdhcKZA2/h0j3IrKXjFeE5mXIWYnicu3Vjp1wRI+BJrCi2u/Pe5db7SXi1Biw=
X-Received: by 2002:a05:6a00:14ce:b0:50f:ac00:2a8b with SMTP id
 w14-20020a056a0014ce00b0050fac002a8bmr2515909pfu.36.1652410589312; Thu, 12
 May 2022 19:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220422054224.19527-1-matthew.ruffell@canonical.com>
 <CAEzrpqe=LD3DQcEeLXmmFuq7cX_dAQ6DOCuJYWBoZWKKTmoTzA@mail.gmail.com> <CAKAwkKt3yMOOW3NXcE91WkGr+8xj050CYP2pLoQVHt_2wXq=-w@mail.gmail.com>
In-Reply-To: <CAKAwkKt3yMOOW3NXcE91WkGr+8xj050CYP2pLoQVHt_2wXq=-w@mail.gmail.com>
From:   Matthew Ruffell <matthew.ruffell@canonical.com>
Date:   Fri, 13 May 2022 14:56:18 +1200
Message-ID: <CAKAwkKvfFn18RjupuqGpx4QeAiMYKSq7QUTd3wEL=pkZ+BENpQ@mail.gmail.com>
Subject: Re: [PROBLEM] nbd requests become stuck when devices watched by
 inotify emit udev uevent changes
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        nbd <nbd@other.debian.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Josef,

Just a friendly ping, I am more than happy to test a patch, if you send it
inline in the email, since the pastebin you used expired after 1 day, and I
couldn't access it.

I came across and tested Yu Kuai's patches [1][2] which are for the same issue,
and they indeed fix the hang. Thank you Yu.

[1] nbd: don't clear 'NBD_CMD_INFLIGHT' flag if request is not completed
https://lists.debian.org/nbd/2022/04/msg00212.html

[2] nbd: fix io hung while disconnecting device
https://lists.debian.org/nbd/2022/04/msg00207.html

I am also happy to test any patches to fix the I/O errors.

Thanks,
Matthew

On Tue, Apr 26, 2022 at 9:47 AM Matthew Ruffell
<matthew.ruffell@canonical.com> wrote:
>
> Hi Josef,
>
> The pastebin has expired the link, and I can't access your patch.
> Seems to default to 1 day deletion.
>
> Could you please create a new paste or send the patch inline in this
> email thread?
>
> I am more than happy to try the patch out.
>
> Thank you for your analysis.
> Matthew
>
> On Sat, Apr 23, 2022 at 3:24 AM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Fri, Apr 22, 2022 at 1:42 AM Matthew Ruffell
> > <matthew.ruffell@canonical.com> wrote:
> > >
> > > Dear maintainers of the nbd subsystem,
> > >
> > > A user has come across an issue which causes the nbd module to hang after a
> > > disconnect where a write has been made to a qemu qcow image file, with qemu-nbd
> > > being the server.
> > >
> >
> > Ok there's two problems here, but I want to make sure I have the right
> > fix for the hang first.  Can you apply this patch
> >
> > https://paste.centos.org/view/b1a2d01a
> >
> > and make sure the hang goes away?  Once that part is fixed I'll fix
> > the IO errors, this is just us racing with systemd while we teardown
> > the device and then we're triggering a partition read while the device
> > is going down and it's complaining loudly.  Before we would
> > set_capacity to 0 whenever we disconnected, but that causes problems
> > with file systems that may still have the device open.  However now we
> > only do this if the server does the CLEAR_SOCK ioctl, which clearly
> > can race with systemd poking the device, so I need to make it
> > set_capacity(0) when the last opener closes the device to prevent this
> > style of race.
> >
> > Let me know if that patch fixes the hang, and then I'll work up
> > something for the capacity problem.  Thanks,
> >
> > Josef
