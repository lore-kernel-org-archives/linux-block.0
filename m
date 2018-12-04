Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A00AC07E85
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 12:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358932146D
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 12:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="D+YOncRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358932146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeLDMSp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:18:45 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45000 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeLDMSp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 07:18:45 -0500
Received: by mail-vs1-f66.google.com with SMTP id g68so9638742vsd.11
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 04:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=353G8MWTRkXIVSdX/AUYyNj9SmJ3sdpN1yQswp+xXOk=;
        b=D+YOncRHwNGdfIy7sacqdwuU6/aVduu83EfZsCBZC0baHWAaraIBGzOfJj/L1ejBgW
         0Tw7W3k+wKEuh1ZS/JHv5/VpE3YIq4VqkAbaZ7KbIXw/rFWbfUP8/64SH4dP+iJqJZui
         Z3RWh5iYdSo5R/fOzfGyICpV9kJv/ZwgMCAlCM40i/Jkq6zUc8BU2mUh9Ql5jXPjrC9+
         cHnWHDk/lmHMH+yjJOdqWB+lnN9uzm51zv7fCISSv+jHUoGzuoxWBEsRjAZ7NsYsiUDZ
         5HQ7W0s5vgweGTIAwjyf4XjwNsUnc3nPt6mdonxTKNrP6BVSuIxCWLSu9w+rgwvAtiDx
         vPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=353G8MWTRkXIVSdX/AUYyNj9SmJ3sdpN1yQswp+xXOk=;
        b=OwJbavyTHPJJZG8GDYfc4HoZ2Jh+f6DGnUYyI5B/jDq1CPYRlrRwRw2QrzFPfs3APR
         bNbDhcSQU6FSo4+XzrRBXYVwkyidK1TfnOq7xd3u0QJSk0uPq1nBaaLlDIilNsUBwgr7
         P1oJnEiAXtjiciRa1yXu9WfNhce/Jv/R1QpZwrGacJUWZB+8FQMmqGHWmNJxumvgUaGQ
         F0xk+tT0ZYGmZ5HgZCql0Por7C2eI7OYnHqWXj7J/ADWCwMuYUCGy7QptUwJbr1wQ6gJ
         Ct3yOLZM/1F14p52YeuRK6RM4PgK36ou13Kxgcff9Cj1VwPOUmiKGoXsVz7xBJvNbdnh
         Zmsg==
X-Gm-Message-State: AA+aEWaFiHZwLsr1A2Apt1+HbY5XD4wxR1Ild/BTNHvYXmuUJNFOGKRq
        VGDPco73W7+zJbo+CVhdZMbxSB0BDUn5TXPl59P5pQ==
X-Google-Smtp-Source: AFSGD/W1oRX9P4uUsicmPIf3FGyvVvE7i4dsBDTnmm2a4ezRRMdX09MBODDRiuw1sP1j9k3IUWa7KZAIFFpLoW6NMs0=
X-Received: by 2002:a67:1106:: with SMTP id 6mr8709186vsr.213.1543925923791;
 Tue, 04 Dec 2018 04:18:43 -0800 (PST)
MIME-Version: 1.0
References: <20181130114402.43793-1-igor.j.konopko@intel.com>
 <CANr-nt33vO=egptfmCxDEdom5CKEEQ=NA1R5_z0Pe951-cPmSw@mail.gmail.com> <CANr-nt0NV61Rq9B19qeOHDN6gRGc76hdcxqQcgAVpysTBBEB8w@mail.gmail.com>
In-Reply-To: <CANr-nt0NV61Rq9B19qeOHDN6gRGc76hdcxqQcgAVpysTBBEB8w@mail.gmail.com>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Tue, 4 Dec 2018 13:18:32 +0100
Message-ID: <CANr-nt0wuRNt0=iAVxZD1O2bs03XSrewsS_5jZkFZ0iycf1O6w@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] lightnvm: Flexible metadata
To:     igor.j.konopko@intel.com, Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, Javier Gonzalez <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 3, 2018 at 9:51 AM Hans Holmberg
<hans.ml.holmberg@owltronix.com> wrote:
>
> Great! The tests(rocksdb, pblk recovery and the generic xfs suite)
> completed successfully on one of our disks, so feel free to add:
>
> Tested-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>

The tests completed fine on our hardware (which has metadata support),
but fails when I run the code on a qemu disk without metadata support.
I started to look into what goes wrong, and it seems the ppa list gets
corrupted during smeta and padding writes.

Building the kernel with CONFIG_NVM_PBLK_DEBUG, i see these errors:
[  159.735409] pblk =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD: ppa: (boundary: 1=
) cache line: 9223372036854775807

I also got this during recovery:

[ 5384.511939] BUG: KASAN: use-after-free in pblk_get_packed_meta+0x5e/0x15=
1
[ 5384.513036] Read of size 8 at addr ffff8881edc220e0 by task nvme/9147

There might of course be something very wrong with my qemu setup, but
it it looks more like something went wrong in the later revisions of
the patch set (i tested the one of the first versions and did not see
these issues then).

Igor: If you want it, I can share my qemu environment, more debugging
info and a couple of fixups i've done while looking into this.

Thanks,
Hans

> Thanks,
> Hans
> On Fri, Nov 30, 2018 at 2:03 PM Hans Holmberg
> <hans.ml.holmberg@owltronix.com> wrote:
> >
> > I just started a regression test on this patch set that'll run over
> > the weekend. I'll add a tested-by if everything checks out.
> >
> > All the best,
> > Hans
> > On Fri, Nov 30, 2018 at 12:49 PM Igor Konopko <igor.j.konopko@intel.com=
> wrote:
> > >
> > > This series of patches extends the way how pblk can
> > > store L2P sector metadata. After this set of changes
> > > any size of NVMe metadata is supported in pblk.
> > > Also there is an support for case without NVMe metadata.
> > >
> > > Changes v4 --> v5:
> > > -rebase on top of ocssd/for-4.21/core
> > >
> > > Changes v3 --> v4:
> > > -rename nvm_alloc_dma_pool() to nvm_create_dma_pool()
> > > -split pblk_get_meta() calls and lba setting into
> > > two operations for better core readability
> > > -fixing compilation with CONFIG_NVM disabled
> > > -getting rid of unnecessary memcpy for packed metadata
> > > on write path
> > > -support for drives with oob size >0 and <16B in packed
> > > metadata mode
> > > -minor commit message updates
> > >
> > > Changes v2 --> v3:
> > > -Rebase on top of ocssd/for-4.21/core
> > > -get/set_meta_lba helpers were removed
> > > -dma reallocation was replaced with single allocation
> > > -oob metadata size was added to pblk structure
> > > -proper checks on pblk creation were added
> > >
> > > Changes v1 --> v2:
> > > -Revert sector meta size back to 16b for pblk
> > > -Dma pool for larger oob meta are handled in core instead of pblk
> > > -Pblk oob meta helpers uses __le64 as input outpu instead of u64
> > > -Other minor fixes based on v1 patch review
> > >
> > > Igor Konopko (5):
> > >   lightnvm: pblk: Move lba list to partial read context
> > >   lightnvm: pblk: Helpers for OOB metadata
> > >   lightnvm: Flexible DMA pool entry size
> > >   lightnvm: Disable interleaved metadata
> > >   lightnvm: pblk: Support for packed metadata
> > >
> > >  drivers/lightnvm/core.c          |  9 ++++--
> > >  drivers/lightnvm/pblk-core.c     | 61 ++++++++++++++++++++++++++++++=
+------
> > >  drivers/lightnvm/pblk-init.c     | 44 +++++++++++++++++++++++++--
> > >  drivers/lightnvm/pblk-map.c      | 20 +++++++-----
> > >  drivers/lightnvm/pblk-rb.c       |  3 ++
> > >  drivers/lightnvm/pblk-read.c     | 66 +++++++++++++++++++++++-------=
----------
> > >  drivers/lightnvm/pblk-recovery.c | 25 +++++++++------
> > >  drivers/lightnvm/pblk-sysfs.c    |  7 +++++
> > >  drivers/lightnvm/pblk-write.c    |  9 +++---
> > >  drivers/lightnvm/pblk.h          | 24 +++++++++++++--
> > >  drivers/nvme/host/lightnvm.c     |  6 ++--
> > >  include/linux/lightnvm.h         |  3 +-
> > >  12 files changed, 209 insertions(+), 68 deletions(-)
> > >
> > > --
> > > 2.14.5
> > >
