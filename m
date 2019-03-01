Return-Path: <SRS0=BuC1=RE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B722FC43381
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 10:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0552087E
	for <linux-block@archiver.kernel.org>; Fri,  1 Mar 2019 10:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="XMQLcg2a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfCAKXh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Mar 2019 05:23:37 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:41771 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfCAKXh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Mar 2019 05:23:37 -0500
Received: by mail-vk1-f195.google.com with SMTP id b6so5498072vkf.8
        for <linux-block@vger.kernel.org>; Fri, 01 Mar 2019 02:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TLnHmJH3ROjBKEJnDCLe2IjsgPdxIy1WOnqX0xqTZwQ=;
        b=XMQLcg2a44CaEqYV4X5L+QG469x2yvHF8Vox4CMq7VRa0BDbxBpBbAo6MYqd3ELjz2
         ikyU6fzesj7JT99BD8J9ML5EdT8uEj0R2aVnZOnXMPMqFqaEiNQyG2YVsy2F1UBSWHdW
         8QtI/uHHcpz8rwwqMC6mPeg+eRiMaYlbeyeIDeT8qjdz7Q8KHemVpHPxOCMaryQps0v9
         owedQajJQDMX8cDcZSBGP4XQuLMT2swIbr3pttPYnDnJEbz/f1h9rmkT2OZTrmD4n98K
         UOQ68vUd6no6VPHBULUbCVI+wTCo0pdnZUglQMLuXFZTJgIn1oMc46+tZR+CD/xO2jZu
         Eweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TLnHmJH3ROjBKEJnDCLe2IjsgPdxIy1WOnqX0xqTZwQ=;
        b=SP4hMFlxSnnOxbEteKm2sEY8QFbXlcfpUaUwbw9asidmUvBWkGoO+1XMmCrxtUaL1F
         T/05Vba/s3itZF9QlJNaB1sCO7CvrbF5Rz+thP+K7awoWBs/0xAA25zBSV1CGE+klgBR
         OGVLRe5ZeVeYbAUnsmGl5rOgHOrWqRWkfWZI0VJcMoYvAB5sjpfFff5YHgZt7Z1AvmLU
         rSjrG2EzF83mHmqu8N4Y7gXtFIqzpGtiJA+nAB5g9gO5Qn4kxucIT/AlQQPqx9odcQqW
         H5/KVceMfg/CV6zx0pPXh0iS/BmlVT/arx6nRZoH9WgCFHqc78k52FAYI7Zo/w387pKX
         Si6g==
X-Gm-Message-State: APjAAAWDpYkaKlWCWHn+yIV8QlKLjwKX5YJQr/JOaD6xRWETdiJZD/CJ
        8vng3l7zIIcgnMKSWyOyPYmirEtb1Wi9Cb8Jb9lnhNCiWgY=
X-Google-Smtp-Source: APXvYqxGfPIBNxkOydIoyMCqwq/p4a7oHaVNZpVwxFkEbLBDZI4seHSQsPBBVLnZ+WAcjhoTIhnNteGed8DIatxT3i0=
X-Received: by 2002:a1f:b483:: with SMTP id d125mr2332922vkf.51.1551435816285;
 Fri, 01 Mar 2019 02:23:36 -0800 (PST)
MIME-Version: 1.0
References: <20190227171442.11853-1-igor.j.konopko@intel.com> <18ac8f7c-4990-073e-0fa7-b73315238bf3@lightnvm.io>
In-Reply-To: <18ac8f7c-4990-073e-0fa7-b73315238bf3@lightnvm.io>
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date:   Fri, 1 Mar 2019 05:23:25 -0500
Message-ID: <CANr-nt1GJ_ZH=NFpapTeKHA+rEwjCr6txRx0YyaEK_qvknNSWQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] lightnvm: bugfixes and improvements
To:     =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc:     Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Good stuff Igor!

The jetlag from vault is wearing off now, so I'll start looking at the
patches today.

Thanks,
Hans

On Thu, Feb 28, 2019 at 11:36 AM Matias Bj=C3=B8rling <mb@lightnvm.io> wrot=
e:
>
> On 2/27/19 6:14 PM, Igor Konopko wrote:
> > This series provides a group of the bugfixes
> > or improvements for lightnvm and pblk device.
> >
> > Most of the patches are rather simple and covers
> > some corner cases scenario, but we were able to hit
> > most of them in some scenarios. Few others close some
> > existing gaps which we were able to found.
> >
> > Fedback is appreciated.
> >
> > Igor Konopko (13):
> >    lightnvm: pblk: Line reference fix in GC
> >    lightnvm: pblk: Gracefully handle GC data malloc fail
> >    lightnvm: pblk: Fix put line back behaviour
> >    lightnvm: pblk: Rollback in gc read
> >    lightnvm: pblk: Count all read errors in stats
> >    lightnvm: pblk: Ensure that erase is chunk aligned
> >    lightnvm: pblk: Cleanly fail when there is not enough memory
> >    lightnvm: pblk: Set proper read stutus in bio
> >    lightnvm: pblk: Kick writer for flush requests
> >    lightnvm: pblk: Reduce L2P DRAM footprint
> >    lightnvm: pblk: Remove unused smeta_ssec field
> >    lightnvm: pblk: close opened chunks
> >    lightnvm: Inherit mdts from the parent nvme device
> >
> >   drivers/lightnvm/core.c          |   9 ++-
> >   drivers/lightnvm/pblk-core.c     | 128 +++++++++++++++++++++++++++++-=
-
> >   drivers/lightnvm/pblk-gc.c       |  47 +++++++-----
> >   drivers/lightnvm/pblk-init.c     |  30 ++++++--
> >   drivers/lightnvm/pblk-map.c      |   2 +
> >   drivers/lightnvm/pblk-read.c     |  13 ++--
> >   drivers/lightnvm/pblk-recovery.c |   2 +-
> >   drivers/lightnvm/pblk.h          |   4 +-
> >   drivers/nvme/host/lightnvm.c     |   1 +
> >   include/linux/lightnvm.h         |   1 +
> >   10 files changed, 193 insertions(+), 44 deletions(-)
> >
>
> Thanks Igor. I'll give Hans et. al. a couple of days to digest the
> changes.
>
