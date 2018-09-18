Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36801 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeIRRSq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 13:18:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id z207-v6so1523125lff.3
        for <linux-block@vger.kernel.org>; Tue, 18 Sep 2018 04:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180917052939.4776-1-hlitz@ucsc.edu>
In-Reply-To: <20180917052939.4776-1-hlitz@ucsc.edu>
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date: Tue, 18 Sep 2018 13:46:20 +0200
Message-ID: <CANr-nt2UHA-7oXJCdE+X7MD8U-N1zBUhSsYW-EC6HonDvM3Vgg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] lightnvm: pblk: Introduce RAIL to enforce low
 tail read latency
To: hlitz@ucsc.edu
Cc: linux-block@vger.kernel.org, Javier Gonzalez <javier@cnexlabs.com>,
        Matias Bjorling <mb@lightnvm.io>, igor.j.konopko@intel.com,
        marcin.dziegielewski@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Sep 17, 2018 at 7:29 AM Heiner Litz <hlitz@ucsc.edu> wrote:
>
> Hi All,
> this patchset introduces RAIL, a mechanism to enforce low tail read latency for
> lightnvm OCSSD devices. RAIL leverages redundancy to guarantee that reads are
> always served from LUNs that do not serve a high latency operation such as a
> write or erase. This avoids that reads become serialized behind these operations
> reducing tail latency by ~10x. In particular, in the absence of ECC read errors,
> it provides 99.99 percentile read latencies of below 500us. RAIL introduces
> capacity overheads (7%-25%) due to RAID-5 like striping (providing fault
> tolerance) and reduces the maximum write bandwidth to 110K IOPS on CNEX SSD.
>
> This patch is based on pblk/core and requires two additional patches from Javier
> to be applicable (let me know if you want me to rebase):

As the patches do not apply, could you make a branch available so I
can get hold of the code in it's present state?
That would make reviewing and testing so much easier.

I have some concerns regarding recovery and write error handling, but
I have not found anything that can't be fixed.
I also believe that rail/on off and stride width should not be
configured at build-time, but instead be part of the create IOCTL.

See my comments on the individual patches for details.

>
> The 1st patch exposes some existing APIs so they can be used by RAIL
> The 2nd patch introduces a configurable sector mapping function
> The 3rd patch refactors the write path so the end_io_fn can be specified when
> setting up the request
> The 4th patch adds a new submit io function that acquires the write semaphore
> The 5th patch introduces the RAIL feature and its API
> The 6th patch integrates RAIL into pblk's read and write path
>
>
