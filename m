Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44654 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731091AbeISNfU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Sep 2018 09:35:20 -0400
Received: by mail-lf1-f67.google.com with SMTP id g24-v6so4257132lfb.11
        for <linux-block@vger.kernel.org>; Wed, 19 Sep 2018 00:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180917052939.4776-1-hlitz@ucsc.edu> <CANr-nt2UHA-7oXJCdE+X7MD8U-N1zBUhSsYW-EC6HonDvM3Vgg@mail.gmail.com>
 <CAJbgVnVE58DUiW_QV8CbCrt6_Kxdtp8GqtRBPDBPSh=mopWZRQ@mail.gmail.com>
In-Reply-To: <CAJbgVnVE58DUiW_QV8CbCrt6_Kxdtp8GqtRBPDBPSh=mopWZRQ@mail.gmail.com>
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date: Wed, 19 Sep 2018 09:58:21 +0200
Message-ID: <CANr-nt0Wg==Ak_AJQqRKT_CV6EiJjy6mAD8jLhRwuYYVrJCGqw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] lightnvm: pblk: Introduce RAIL to enforce low
 tail read latency
To: hlitz@ucsc.edu
Cc: linux-block@vger.kernel.org, Javier Gonzalez <javier@cnexlabs.com>,
        Matias Bjorling <mb@lightnvm.io>, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 18, 2018 at 6:13 PM Heiner Litz <hlitz@ucsc.edu> wrote:
>
> Hi Hans,
> thanks a lot for your comments! I will send you a git repo to test. I
> have a patch which enables/disables RAIL via ioctl and will send that
> as well.

Great!

Once I have the code in a branch i can start creating test cases for
bad-block corner cases, recovery and write error handling.

Thanks,
Hans

>
> Heiner
> On Tue, Sep 18, 2018 at 4:46 AM Hans Holmberg
> <hans.ml.holmberg@owltronix.com> wrote:
> >
> > On Mon, Sep 17, 2018 at 7:29 AM Heiner Litz <hlitz@ucsc.edu> wrote:
> > >
> > > Hi All,
> > > this patchset introduces RAIL, a mechanism to enforce low tail read latency for
> > > lightnvm OCSSD devices. RAIL leverages redundancy to guarantee that reads are
> > > always served from LUNs that do not serve a high latency operation such as a
> > > write or erase. This avoids that reads become serialized behind these operations
> > > reducing tail latency by ~10x. In particular, in the absence of ECC read errors,
> > > it provides 99.99 percentile read latencies of below 500us. RAIL introduces
> > > capacity overheads (7%-25%) due to RAID-5 like striping (providing fault
> > > tolerance) and reduces the maximum write bandwidth to 110K IOPS on CNEX SSD.
> > >
> > > This patch is based on pblk/core and requires two additional patches from Javier
> > > to be applicable (let me know if you want me to rebase):
> >
> > As the patches do not apply, could you make a branch available so I
> > can get hold of the code in it's present state?
> > That would make reviewing and testing so much easier.
> >
> > I have some concerns regarding recovery and write error handling, but
> > I have not found anything that can't be fixed.
> > I also believe that rail/on off and stride width should not be
> > configured at build-time, but instead be part of the create IOCTL.
> >
> > See my comments on the individual patches for details.
> >
> > >
> > > The 1st patch exposes some existing APIs so they can be used by RAIL
> > > The 2nd patch introduces a configurable sector mapping function
> > > The 3rd patch refactors the write path so the end_io_fn can be specified when
> > > setting up the request
> > > The 4th patch adds a new submit io function that acquires the write semaphore
> > > The 5th patch introduces the RAIL feature and its API
> > > The 6th patch integrates RAIL into pblk's read and write path
> > >
> > >
