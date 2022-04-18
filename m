Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55B4C433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 22:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiDRWb2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 18:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiDRWb1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 18:31:27 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B6E2AC41
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 15:28:47 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id d4so9404337iln.6
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 15:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itIkb61A0uhHKz3KSV99mn0gfXvfdqD/KDg7R3yigp8=;
        b=gNA8xXQWXq4eMpowurenoEUoHK/SF4Oj7XppYvicCnfbDI8msh8QbJMdVCuBhmeHjt
         0cA4jz3KI1NbVJFaGzcZFU0pdpdaa+4jtQf32yIHN8jVdS4SIGP8i3XPZryVDeKZQ4WO
         0twsqxluKk9uBniV23bYuo/njN0TXbwOGs7x129fHFsHoiZjzOD8Vi3QHceOeWXIcKX2
         VY2IAetXIk+e+KLPhgKpU+aMlmnx2Ut2ZGstsmD7GwuFPLWVYgm2HcpfCakvPucbrGtg
         ah4wcOpn1NNbIQ8XkbBD5alabVMg6o3YB2ANu2vmWnRaLudBFyS2WcT0HeIQTanps4Ho
         hknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itIkb61A0uhHKz3KSV99mn0gfXvfdqD/KDg7R3yigp8=;
        b=znwyBT0WoBHiht3tnlXqojGzLgZRd8iCsObdPAjoh6ugb0owxYJua49iFmXK27Nr2Z
         SfUET3Dv/sO/bdP5TJ3z4vA1ROoPEDz0KNpipqjafQdpLVfBKCbi5o6hMESA1hzCP8vQ
         vzff9W7dIkJD7CF5a2DbHYm+vLzweLtfMTZM3cbmPfVaImIjevaYbujyTEcBORc1+Y+R
         8lTrkCPS9CLBprm5mO99C1zd0+XkqiARR24PowGg9jQLxl4nEaHsU9JejSAp0ZQHMFDW
         bT8/sVFGhShh6lBa2GGhi5+t5uH/HHigL/WbAXEjFl/rTPhv1Q2NrJtqNfopsAStuBqO
         PN0A==
X-Gm-Message-State: AOAM533RDbUKwLjYUABDwuytYlIudJmUN680wsmO9yAuZY+YjPHAUWyJ
        7lO7ysdLsB45uJ78DTkEz1nzIiNMCUr2G3gnHH/0JQ==
X-Google-Smtp-Source: ABdhPJzYWua2g4+qB/VXB8xK2HI6OvGjLT9NGyJoDLmubbEnEfvn8Cwu4Pp+05LsFYV6ttTyiUnFQ6dA5CA7v6UWoBM=
X-Received: by 2002:a05:6e02:17ce:b0:2cc:8c4:2c78 with SMTP id
 z14-20020a056e0217ce00b002cc08c42c78mr5647572ilu.153.1650320926731; Mon, 18
 Apr 2022 15:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <Yl3aQQtPQvkskXcP@localhost.localdomain> <c7f02531-8637-89a2-d8b7-1da03240db73@nvidia.com>
 <b1fcc3dc-71a5-4a07-8f18-75f5e6cd7153@kernel.dk> <827699fb-e21b-2cad-6a6d-0a21c49f444e@nvidia.com>
 <bc93d84b-3c10-07ed-5203-9eba485fb108@kernel.dk>
In-Reply-To: <bc93d84b-3c10-07ed-5203-9eba485fb108@kernel.dk>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 18 Apr 2022 18:28:35 -0400
Message-ID: <CAEzrpqdObTnz2h4w1EwX=vbA_g=D=4pLp+sXvUKSCfCUg-GY2A@mail.gmail.com>
Subject: Re: Nullblk configfs oddities
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 18, 2022 at 6:24 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 4/18/22 4:21 PM, Chaitanya Kulkarni wrote:
> > On 4/18/22 15:14, Jens Axboe wrote:
> >> On 4/18/22 3:54 PM, Chaitanya Kulkarni wrote:
> >>> On 4/18/22 14:38, Josef Bacik wrote:
> >>>> Hello,
> >>>>
> >>>> I'm trying to add a test to fsperf and it requires the use of nullblk.  I'm
> >>>> trying to use the configfs thing, and it's doing some odd things.  My basic
> >>>> reproducer is
> >>>>
> >>>> modprobe null_blk
> >>>> mkdir /sys/kernel/config/nullb/nullb0
> >>>> echo some shit into the config
> >>>> echo 1 > /sys/kernel/config/nullb/nullb0/power
> >>>>
> >>>> Now null_blk apparently defaults to nr_devices == 1, so it creates nullb0 on
> >>>> modprobe.  But this doesn't show up in the configfs directory.  There's no way
> >>>> to find this out until when I try to mkfs my nullb0 and it doesn't work.  The
> >>>> above steps gets my device created at /dev/nullb1, but there's no actual way to
> >>>> figure out that's what happened.  If I do something like
> >>>> /sys/kernel/config/nullb/nullbfsperf I still just get nullb<number>, I don't get
> >>>> my fancy name.
> >>>>
> >>>
> >>> when you load module with default module parameter it will create a
> >>> default device with no memory backed mode, that will not be visible in
> >>> the configfs.
> >>
> >> Right, the problem is really that pre-configured devices (via nr_devices
> >> being bigger than 0, which is the default) don't show up in configfs.
> >> That, to me, is the real issue here, because it means you need to know
> >> which ones are already setup before doing mkdir for a new one.
> >>
> >> On top of that, it's also odd that they don't show up there to begin
> >> with.
> >>
> >
> > it is indeed confusing, maybe we need to find a way to populate the
> > configfs when loading the module? but I'm not sure if that is
> > the right approach since configs ideally should be populated by
> > user.
> >
> > OTOH we can make the memory_backed module param [1] so user can
> > tentatively not use configfs and only rely on default configuration ?
>
> Arguably configfs should just be disabled if loading with nr_devices
> larger than 0, as it's a mess of an API as it stands. But probably too
> late for that. The fact that we also have an option that's specific to
> configfs just makes it even worse.
>
> I don't know much about configfs, but pre-populating with the configured
> devices and options would be ideal and completely solve this. I think
> that would be the best solution given the current situation. Not that
> it's THAT important, null_blk is a developer tool and as such can have
> some sharper and rouger edges. Still would be nice to make it saner,
> though.
>

I'd settle for a sysfs link to the device node that got created, so I
can maybe just do

mdkir nullb/lolmine
dev=$(find nullb/lolmine --maxdepth 1 -type l)
devname=$(basename $dev)

so I know what my device actually got created as.  Thanks,

Josef
