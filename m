Return-Path: <SRS0=uopx=OM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817FBC04EB9
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 08:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470492145D
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 08:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="uLdJVyCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470492145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbeLCIwQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:52:16 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45130 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeLCIwQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 03:52:16 -0500
Received: by mail-vs1-f67.google.com with SMTP id v10so6995192vsv.12
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 00:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYfdKfrfBvP7/WIcwpKCuI4vF//h63LhWY4XV20mz88=;
        b=uLdJVyCtcOEBVpk9C7RxDrwU8XhduCp6djUXigJoSfyAayWBZoRsaTQwTNzk236vOT
         P6UYtWZvGtUnuiZ89WpaY3myXCKp+EaoUeX4zLDRgFRBUvxRu9JVfnUEFt/VLdoi8EXj
         jr9xbhEFJi+MBDTGRPpsqj9FdWsfoOckubTWdKL/XtVmf2jXeN9US7OJ/ttdhc4IpQlY
         2I3KUficKkZD+NX9P3fKJzkn/GJ8AW7iDuzlqu3Pqj4THiTHYsb6V/D6r9QzFKXmd/cI
         xtwV4Lluh4AdBjjbTeoNJ9RdHyULkpuip81FuTqiHtTHY4iFKTQrMe0CfzW21+zTOQky
         G3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYfdKfrfBvP7/WIcwpKCuI4vF//h63LhWY4XV20mz88=;
        b=INMwnAs/O0TvdfAK1SJlU4Q3ErtC2Y73gnNC2UJyhLT5cG4cmjUEyvYNcTCp86q2R5
         ZxhKtoSdMwUzrpuZA+r0safuxyefkjjH+xII1n28v9HTJdltNWEaJV6Sni1Dv5K2K6SZ
         9hVCXolclzLUfjgUZ/AnUVLmsYFh+ojrRwdqXYkVbw32iRXXrjLXcaHjkRpzcqEKvPNP
         QMOyd4VcVDRM1/8Q1lFXI8OmTeEWTBSNWzR6rrtpXqFOodNMKw1i5SoWO//ooZ8zG1yt
         K5CyFN6/z8UwRxaD4+0FW6NTpj1Smb/mmad8CeldwICNGKhWg8Cy0fMFE2gtQJfahYBi
         H0tg==
X-Gm-Message-State: AA+aEWZiSlslDmFQedh6SPXLmGJwkR48zLasC/v4T3JQZ3rPIR3dy4m9
        mgz3o0J4TPN5zdtErBpI02EQiP8bTmXXzyl/hahKcklMQsM=
X-Google-Smtp-Source: AFSGD/U7aisI56uvRjD8YPqIiSxma9oi+Cuj+HGd424XIhH7YCgyrrVPj5ezrs3aja5OP9uDyA6Xl93aHZWywt7Etwc=
X-Received: by 2002:a67:24c6:: with SMTP id k189mr6456401vsk.16.1543827129853;
 Mon, 03 Dec 2018 00:52:09 -0800 (PST)
MIME-Version: 1.0
References: <20181130114402.43793-1-igor.j.konopko@intel.com> <CANr-nt33vO=egptfmCxDEdom5CKEEQ=NA1R5_z0Pe951-cPmSw@mail.gmail.com>
In-Reply-To: <CANr-nt33vO=egptfmCxDEdom5CKEEQ=NA1R5_z0Pe951-cPmSw@mail.gmail.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Mon, 3 Dec 2018 09:51:59 +0100
Message-ID: <CANr-nt0NV61Rq9B19qeOHDN6gRGc76hdcxqQcgAVpysTBBEB8w@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] lightnvm: Flexible metadata
To:     igor.j.konopko@intel.com
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Javier Gonzalez <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Great! The tests(rocksdb, pblk recovery and the generic xfs suite)
completed successfully on one of our disks, so feel free to add:

Tested-by: Hans Holmberg <hans.holmberg@cnexlabs.com>

Thanks,
Hans
On Fri, Nov 30, 2018 at 2:03 PM Hans Holmberg
<hans.ml.holmberg@owltronix.com> wrote:
>
> I just started a regression test on this patch set that'll run over
> the weekend. I'll add a tested-by if everything checks out.
>
> All the best,
> Hans
> On Fri, Nov 30, 2018 at 12:49 PM Igor Konopko <igor.j.konopko@intel.com> wrote:
> >
> > This series of patches extends the way how pblk can
> > store L2P sector metadata. After this set of changes
> > any size of NVMe metadata is supported in pblk.
> > Also there is an support for case without NVMe metadata.
> >
> > Changes v4 --> v5:
> > -rebase on top of ocssd/for-4.21/core
> >
> > Changes v3 --> v4:
> > -rename nvm_alloc_dma_pool() to nvm_create_dma_pool()
> > -split pblk_get_meta() calls and lba setting into
> > two operations for better core readability
> > -fixing compilation with CONFIG_NVM disabled
> > -getting rid of unnecessary memcpy for packed metadata
> > on write path
> > -support for drives with oob size >0 and <16B in packed
> > metadata mode
> > -minor commit message updates
> >
> > Changes v2 --> v3:
> > -Rebase on top of ocssd/for-4.21/core
> > -get/set_meta_lba helpers were removed
> > -dma reallocation was replaced with single allocation
> > -oob metadata size was added to pblk structure
> > -proper checks on pblk creation were added
> >
> > Changes v1 --> v2:
> > -Revert sector meta size back to 16b for pblk
> > -Dma pool for larger oob meta are handled in core instead of pblk
> > -Pblk oob meta helpers uses __le64 as input outpu instead of u64
> > -Other minor fixes based on v1 patch review
> >
> > Igor Konopko (5):
> >   lightnvm: pblk: Move lba list to partial read context
> >   lightnvm: pblk: Helpers for OOB metadata
> >   lightnvm: Flexible DMA pool entry size
> >   lightnvm: Disable interleaved metadata
> >   lightnvm: pblk: Support for packed metadata
> >
> >  drivers/lightnvm/core.c          |  9 ++++--
> >  drivers/lightnvm/pblk-core.c     | 61 +++++++++++++++++++++++++++++++------
> >  drivers/lightnvm/pblk-init.c     | 44 +++++++++++++++++++++++++--
> >  drivers/lightnvm/pblk-map.c      | 20 +++++++-----
> >  drivers/lightnvm/pblk-rb.c       |  3 ++
> >  drivers/lightnvm/pblk-read.c     | 66 +++++++++++++++++++++++-----------------
> >  drivers/lightnvm/pblk-recovery.c | 25 +++++++++------
> >  drivers/lightnvm/pblk-sysfs.c    |  7 +++++
> >  drivers/lightnvm/pblk-write.c    |  9 +++---
> >  drivers/lightnvm/pblk.h          | 24 +++++++++++++--
> >  drivers/nvme/host/lightnvm.c     |  6 ++--
> >  include/linux/lightnvm.h         |  3 +-
> >  12 files changed, 209 insertions(+), 68 deletions(-)
> >
> > --
> > 2.14.5
> >
